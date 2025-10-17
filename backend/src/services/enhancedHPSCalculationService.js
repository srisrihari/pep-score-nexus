const { supabase } = require('../config/supabaseClient');
const { query } = require('../utils/queryWrapper');

class EnhancedHPSCalculationService {
    async calculateStudentHPS(studentId, termId) {
        try {
            // 1. Get all microcompetency scores for the student in interventions
            const { data: microcompScores } = await query(
                supabase
                    .from('microcompetency_scores')
                    .select(`
                        id,
                        microcompetency_id,
                        intervention_id,
                        obtained_score,
                        max_score,
                        term_id,
                        microcompetencies (
                            id,
                            component_id,
                            weightage,
                            components (
                                id,
                                sub_category_id,
                                weightage,
                                sub_categories (
                                    id,
                                    quadrant_id,
                                    weightage
                                )
                            )
                        )
                    `)
                    .eq('student_id', studentId)
                    .eq('term_id', termId)
            );

            // Group scores by microcompetency for averaging
            const microcompAverages = this.calculateMicrocompetencyAverages(microcompScores);

            // Calculate component scores
            const componentScores = this.calculateComponentScores(microcompAverages);

            // Calculate subcategory scores
            const subcategoryScores = this.calculateSubcategoryScores(componentScores);

            // Calculate quadrant scores
            const quadrantScores = this.calculateQuadrantScores(subcategoryScores);

            // Calculate final HPS
            const totalHPS = this.calculateFinalHPS(quadrantScores);

            // Update student_score_summary
            await this.updateStudentScoreSummary(studentId, termId, quadrantScores, totalHPS);

            return {
                totalHPS,
                quadrantScores,
                isPartial: this.checkIfPartialCalculation(microcompScores)
            };
        } catch (error) {
            console.error('Error calculating student HPS:', error);
            throw error;
        }
    }

    calculateMicrocompetencyAverages(scores) {
        const microcompGroups = {};

        // Group scores by microcompetency
        scores.forEach(score => {
            if (!microcompGroups[score.microcompetency_id]) {
                microcompGroups[score.microcompetency_id] = [];
            }
            microcompGroups[score.microcompetency_id].push({
                score: (score.obtained_score / score.max_score) * 100,
                weight: score.microcompetencies.weightage
            });
        });

        // Calculate weighted average for each microcompetency
        const averages = {};
        for (const [microcompId, scores] of Object.entries(microcompGroups)) {
            // If all weights are the same, use simple average
            const weights = scores.map(s => s.weight);
            const allWeightsEqual = weights.every(w => w === weights[0]);

            if (allWeightsEqual) {
                averages[microcompId] = {
                    score: scores.reduce((sum, s) => sum + s.score, 0) / scores.length,
                    metadata: scores[0] // Keep first score's metadata for hierarchy info
                };
            } else {
                // Use weighted average
                const totalWeight = weights.reduce((sum, w) => sum + w, 0);
                averages[microcompId] = {
                    score: scores.reduce((sum, s) => sum + (s.score * s.weight), 0) / totalWeight,
                    metadata: scores[0]
                };
            }
        }

        return averages;
    }

    calculateComponentScores(microcompScores) {
        const componentGroups = {};

        // Group microcompetency scores by component
        Object.entries(microcompScores).forEach(([microcompId, data]) => {
            const componentId = data.metadata.microcompetencies.component_id;
            if (!componentGroups[componentId]) {
                componentGroups[componentId] = [];
            }
            componentGroups[componentId].push({
                score: data.score,
                weight: data.metadata.microcompetencies.weightage
            });
        });

        // Calculate weighted average for each component
        const componentScores = {};
        for (const [componentId, scores] of Object.entries(componentGroups)) {
            const weights = scores.map(s => s.weight);
            const allWeightsEqual = weights.every(w => w === weights[0]);

            if (allWeightsEqual) {
                componentScores[componentId] = {
                    score: scores.reduce((sum, s) => sum + s.score, 0) / scores.length,
                    metadata: scores[0].metadata.microcompetencies.components
                };
            } else {
                const totalWeight = weights.reduce((sum, w) => sum + w, 0);
                componentScores[componentId] = {
                    score: scores.reduce((sum, s) => sum + (s.score * s.weight), 0) / totalWeight,
                    metadata: scores[0].metadata.microcompetencies.components
                };
            }
        }

        return componentScores;
    }

    calculateSubcategoryScores(componentScores) {
        const subcategoryGroups = {};

        // Group component scores by subcategory
        Object.entries(componentScores).forEach(([componentId, data]) => {
            const subcategoryId = data.metadata.sub_category_id;
            if (!subcategoryGroups[subcategoryId]) {
                subcategoryGroups[subcategoryId] = [];
            }
            subcategoryGroups[subcategoryId].push({
                score: data.score,
                weight: data.metadata.weightage
            });
        });

        // Calculate weighted average for each subcategory
        const subcategoryScores = {};
        for (const [subcategoryId, scores] of Object.entries(subcategoryGroups)) {
            const weights = scores.map(s => s.weight);
            const allWeightsEqual = weights.every(w => w === weights[0]);

            if (allWeightsEqual) {
                subcategoryScores[subcategoryId] = {
                    score: scores.reduce((sum, s) => sum + s.score, 0) / scores.length,
                    metadata: scores[0].metadata.sub_categories
                };
            } else {
                const totalWeight = weights.reduce((sum, w) => sum + w, 0);
                subcategoryScores[subcategoryId] = {
                    score: scores.reduce((sum, s) => sum + (s.score * s.weight), 0) / totalWeight,
                    metadata: scores[0].metadata.sub_categories
                };
            }
        }

        return subcategoryScores;
    }

    calculateQuadrantScores(subcategoryScores) {
        const quadrantGroups = {};

        // Group subcategory scores by quadrant
        Object.entries(subcategoryScores).forEach(([subcategoryId, data]) => {
            const quadrantId = data.metadata.quadrant_id;
            if (!quadrantGroups[quadrantId]) {
                quadrantGroups[quadrantId] = [];
            }
            quadrantGroups[quadrantId].push({
                score: data.score,
                weight: data.metadata.weightage
            });
        });

        // Calculate weighted average for each quadrant
        const quadrantScores = {};
        for (const [quadrantId, scores] of Object.entries(quadrantGroups)) {
            const weights = scores.map(s => s.weight);
            const allWeightsEqual = weights.every(w => w === weights[0]);

            if (allWeightsEqual) {
                quadrantScores[quadrantId] = {
                    score: scores.reduce((sum, s) => sum + s.score, 0) / scores.length
                };
            } else {
                const totalWeight = weights.reduce((sum, w) => sum + w, 0);
                quadrantScores[quadrantId] = {
                    score: scores.reduce((sum, s) => sum + (s.score * s.weight), 0) / totalWeight
                };
            }
        }

        return quadrantScores;
    }

    calculateFinalHPS(quadrantScores) {
        // Get quadrant weights
        const weights = {
            'persona': 50,
            'wellness': 30,
            'behavior': 10,
            'discipline': 10
        };

        // Check if all quadrants have equal weights
        const quadrantWeights = Object.values(weights);
        const allWeightsEqual = quadrantWeights.every(w => w === quadrantWeights[0]);

        if (allWeightsEqual) {
            // Use simple average
            const totalScore = Object.values(quadrantScores)
                .reduce((sum, data) => sum + data.score, 0);
            return Math.round((totalScore / Object.keys(quadrantScores).length) * 100) / 100;
        } else {
            // Use weighted average
            let totalWeightedScore = 0;
            let totalWeight = 0;

            for (const [quadrantId, data] of Object.entries(quadrantScores)) {
                const weight = weights[quadrantId.toLowerCase()] || 0;
                totalWeightedScore += data.score * weight;
                totalWeight += weight;
            }

            return Math.round((totalWeightedScore / totalWeight) * 100) / 100;
        }
    }

    async updateStudentScoreSummary(studentId, termId, quadrantScores, totalHPS) {
        try {
            const summaryData = {
                student_id: studentId,
                term_id: termId,
                persona_score: Math.round(quadrantScores['Persona']?.score || 0 * 100) / 100,
                wellness_score: Math.round(quadrantScores['Wellness']?.score || 0 * 100) / 100,
                behavior_score: Math.round(quadrantScores['Behavior']?.score || 0 * 100) / 100,
                discipline_score: Math.round(quadrantScores['Discipline']?.score || 0 * 100) / 100,
                total_hps: totalHPS,
                overall_grade: this.calculateGrade(totalHPS),
                overall_status: this.calculateStatus(totalHPS),
                last_calculated_at: new Date().toISOString(),
                calculation_version: 3
            };

            // Update student_score_summary
            await query(
                supabase
                    .from('student_score_summary')
                    .upsert(summaryData, { onConflict: 'student_id,term_id' })
            );

            // Also update the main students table
            await query(
                supabase
                    .from('students')
                    .update({
                        overall_score: totalHPS,
                        grade: this.calculateGrade(totalHPS),
                        updated_at: new Date().toISOString()
                    })
                    .eq('id', studentId)
            );

            // Log to audit table
            await query(
                supabase
                    .from('hps_calculation_audit')
                    .insert({
                        student_id: studentId,
                        term_id: termId,
                        old_hps: 0, // You might want to fetch the old value first
                        new_hps: totalHPS,
                        trigger_type: 'calculation',
                        metadata: {
                            quadrant_scores: quadrantScores,
                            calculation_version: 3
                        }
                    })
            );

        } catch (error) {
            console.error('Error updating student score summary:', error);
            throw error;
        }
    }

    calculateGrade(score) {
        if (score >= 95) return 'A+';
        if (score >= 90) return 'A';
        if (score >= 80) return 'B';
        if (score >= 70) return 'C';
        if (score >= 60) return 'D';
        if (score >= 40) return 'E';
        return 'IC';
    }

    calculateStatus(score) {
        if (score >= 80) return 'Good';
        if (score >= 60) return 'Progress';
        return 'Deteriorate';
    }

    checkIfPartialCalculation(scores) {
        // Check if we have scores for all required microcompetencies
        // This is a placeholder - you'll need to implement the actual logic
        return scores.length < 10; // Example threshold
    }
}

module.exports = new EnhancedHPSCalculationService();
