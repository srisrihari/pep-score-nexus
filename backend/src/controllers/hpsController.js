const enhancedHPSCalculationService = require('../services/enhancedUnifiedScoreCalculationServiceV2');
const { supabase } = require('../config/supabaseClient');
const { query } = require('../utils/queryWrapper');

class HPSController {
    async calculateStudentHPS(req, res) {
        try {
            const { studentId, termId } = req.params;

            const result = await enhancedHPSCalculationService.calculateStudentHPS(studentId, termId);

            // Store in cache if not partial
            if (!result.isPartial) {
                await query(
                    supabase
                        .from('hps_score_cache')
                        .upsert({
                            student_id: studentId,
                            term_id: termId,
                            total_hps: result.totalHPS,
                            quadrant_scores: result.quadrantScores,
                            calculation_version: 3,
                            is_partial: false,
                            expires_at: new Date(Date.now() + 24 * 60 * 60 * 1000) // 24 hours
                        }, { onConflict: 'student_id,term_id' })
                );
            }

            res.json({
                success: true,
                data: result
            });
        } catch (error) {
            console.error('Error in calculateStudentHPS:', error);
            res.status(500).json({
                success: false,
                error: error.message
            });
        }
    }

    async calculateBatchHPS(req, res) {
        try {
            const { termId } = req.params;

            // Get all active students in the term
            const { data: students } = await query(
                supabase
                    .from('student_terms')
                    .select('student_id')
                    .eq('term_id', termId)
                    .eq('enrollment_status', 'Enrolled')
            );

            // Queue calculations
            const queueEntries = students.map(student => ({
                student_id: student.student_id,
                term_id: termId,
                trigger_type: 'batch_calculation',
                priority: 1,
                status: 'pending'
            }));

            await query(
                supabase
                    .from('hps_recalculation_queue')
                    .upsert(queueEntries, { onConflict: 'student_id,term_id,trigger_type' })
            );

            res.json({
                success: true,
                message: `Queued HPS calculation for ${students.length} students`
            });
        } catch (error) {
            console.error('Error in calculateBatchHPS:', error);
            res.status(500).json({
                success: false,
                error: error.message
            });
        }
    }

    async getHPSDetails(req, res) {
        try {
            const { studentId, termId } = req.params;

            // Try to get from cache first
            const { data: cachedScore } = await query(
                supabase
                    .from('hps_score_cache')
                    .select('*')
                    .eq('student_id', studentId)
                    .eq('term_id', termId)
                    .single()
            );

            if (cachedScore && new Date(cachedScore.expires_at) > new Date()) {
                return res.json({
                    success: true,
                    data: {
                        ...cachedScore,
                        source: 'cache'
                    }
                });
            }

            // If not in cache or expired, calculate fresh
            const result = await enhancedHPSCalculationService.calculateStudentHPS(studentId, termId);

            res.json({
                success: true,
                data: {
                    ...result,
                    source: 'calculated'
                }
            });
        } catch (error) {
            console.error('Error in getHPSDetails:', error);
            res.status(500).json({
                success: false,
                error: error.message
            });
        }
    }

    async getHPSHistory(req, res) {
        try {
            const { studentId, termId } = req.params;

            const { data: history } = await query(
                supabase
                    .from('hps_calculation_audit')
                    .select('*')
                    .eq('student_id', studentId)
                    .eq('term_id', termId)
                    .order('calculated_at', { ascending: false })
            );

            res.json({
                success: true,
                data: history
            });
        } catch (error) {
            console.error('Error in getHPSHistory:', error);
            res.status(500).json({
                success: false,
                error: error.message
            });
        }
    }

    async processQueue(req, res) {
        try {
            const result = await query(
                supabase
                    .rpc('process_hps_recalculation_queue')
            );

            res.json({
                success: true,
                data: result
            });
        } catch (error) {
            console.error('Error in processQueue:', error);
            res.status(500).json({
                success: false,
                error: error.message
            });
        }
    }
}

module.exports = new HPSController();
