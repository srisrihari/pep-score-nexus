const cron = require('node-cron');
const { supabase } = require('../config/supabaseClient');
const { query } = require('../utils/queryWrapper');
const enhancedHPSCalculationService = require('./enhancedHPSCalculationService');

class HPSBackgroundService {
    constructor() {
        this.jobs = [];
    }

    initializeScheduler() {
        // Process queue every minute
        this.jobs.push(
            cron.schedule('* * * * *', async () => {
                try {
                    await query(supabase.rpc('process_hps_recalculation_queue'));
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
                const calculatedHPS = await enhancedHPSCalculationService.calculateStudentHPS(
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

    stopScheduler() {
        this.jobs.forEach(job => job.stop());
        this.jobs = [];
        console.log('🛑 HPS background service stopped');
    }
}

module.exports = new HPSBackgroundService();