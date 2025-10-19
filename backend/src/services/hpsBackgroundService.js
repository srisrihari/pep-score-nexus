const cron = require('node-cron');
const { supabase, query } = require('../config/supabase');
const enhancedHPSCalculationService = require('./enhancedUnifiedScoreCalculationServiceV2');

class HPSBackgroundService {
    constructor() {
        this.jobs = [];
    }

    initializeScheduler() {
        // Process queue every minute
        this.jobs.push(
            cron.schedule('* * * * *', async () => {
                try {
                    await this.processQueue();
                } catch (error) {
                    console.error('Error processing HPS queue:', error);
                }
            })
        );

        // Clean expired cache entries every hour
        this.jobs.push(
            cron.schedule('0 * * * *', async () => {
                try {
                    await query(
                        supabase
                            .from('hps_score_cache')
                            .delete()
                            .lt('expires_at', new Date().toISOString())
                    );
                } catch (error) {
                    console.error('Error cleaning HPS cache:', error);
                }
            })
        );

        // Run consistency check daily at 2 AM
        this.jobs.push(
            cron.schedule('0 2 * * *', async () => {
                try {
                    await this.runConsistencyCheck();
                } catch (error) {
                    console.error('Error in HPS consistency check:', error);
                }
            })
        );

        console.log('🚀 HPS background service initialized');
    }

    async runConsistencyCheck() {
        try {
            // Get all active students and their current terms
            const { data: students } = await query(
                supabase
                    .from('students')
                    .select(`
                        id,
                        current_term_id,
                        overall_score,
                        student_score_summary!inner (
                            total_hps
                        )
                    `)
                    .eq('status', 'Active')
            );

            for (const student of students) {
                const calculatedHPS = await enhancedHPSCalculationService.calculateUnifiedHPS(
                    student.id,
                    student.current_term_id
                );

                // If there's a significant difference, trigger recalculation
                if (Math.abs(calculatedHPS.totalHPS - student.overall_score) > 0.01) {
                    await query(
                        supabase
                            .from('hps_recalculation_queue')
                            .insert({
                                student_id: student.id,
                                term_id: student.current_term_id,
                                trigger_type: 'consistency_check',
                                priority: 2
                            })
                    );
                }
            }
        } catch (error) {
            console.error('Error in HPS consistency check:', error);
            throw error;
        }
    }

    /**
     * Process pending items in the HPS recalculation queue
     */
    async processQueue() {
        try {
            // Get pending queue items (limit to avoid overwhelming)
            const queueResult = await query(
                supabase
                    .from('hps_recalculation_queue')
                    .select('*')
                    .eq('status', 'pending')
                    .order('priority', { ascending: false })
                    .order('created_at', { ascending: true })
                    .limit(5) // Process 5 at a time to avoid overload
            );

            const queueItems = queueResult.data || [];
            
            if (queueItems.length === 0) {
                return; // No items to process
            }

            console.log(`🔄 Processing ${queueItems.length} HPS queue items...`);
            
            for (const item of queueItems) {
                try {
                    // Mark as processing
                    await query(
                        supabase
                            .from('hps_recalculation_queue')
                            .update({ 
                                status: 'processing',
                                last_attempt_at: new Date().toISOString()
                            })
                            .eq('id', item.id)
                    );

                    // Calculate HPS using V2 service
                    const result = await enhancedHPSCalculationService.calculateUnifiedHPS(
                        item.student_id,
                        item.term_id
                    );

                    // Mark as completed and remove from queue
                    await query(
                        supabase
                            .from('hps_recalculation_queue')
                            .delete()
                            .eq('id', item.id)
                    );

                    console.log(`✅ Completed HPS calculation for student ${item.student_id}`);

                } catch (error) {
                    const retryCount = (item.retries || 0) + 1;
                    const maxRetries = 3;

                    if (retryCount >= maxRetries) {
                        // Max retries reached, remove from queue
                        await query(
                            supabase
                                .from('hps_recalculation_queue')
                                .delete()
                                .eq('id', item.id)
                        );
                        console.error(`❌ Removed HPS queue item ${item.id} after ${maxRetries} failed attempts`);
                    } else {
                        // Mark as failed and increment retries
                        await query(
                            supabase
                                .from('hps_recalculation_queue')
                                .update({ 
                                    status: 'pending', // Reset to pending for retry
                                    retries: retryCount,
                                    error_message: error.message,
                                    last_attempt_at: new Date().toISOString()
                                })
                                .eq('id', item.id)
                        );
                        console.error(`⚠️ HPS calculation failed for item ${item.id}, retry ${retryCount}/${maxRetries}:`, error.message);
                    }
                }
            }

        } catch (error) {
            console.error('❌ Error processing HPS recalculation queue:', error);
        }
    }

    stopScheduler() {
        this.jobs.forEach(job => job.stop());
        this.jobs = [];
        console.log('🛑 HPS background service stopped');
    }
}

module.exports = new HPSBackgroundService();