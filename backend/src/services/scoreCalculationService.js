const { supabase, query } = require('../config/supabase');

/**
 * Score Calculation Service
 * Handles calculation of competency and quadrant scores from microcompetency scores
 * Provides real-time score aggregation and caching for performance
 */
class ScoreCalculationService {
  
  /**
   * Calculate competency scores for a student in a specific intervention
   * @param {string} studentId - Student UUID
   * @param {string} interventionId - Intervention UUID
   * @returns {Object} Competency scores with breakdown
   */
  async calculateCompetencyScores(studentId, interventionId) {
    try {
      // Get all microcompetency scores for this student and intervention
      // Order by scored_at DESC to get latest scores first
      const microScoresResult = await query(
        supabase
          .from('microcompetency_scores')
          .select(`
            obtained_score,
            max_score,
            scored_at,
            microcompetency_id,
            microcompetencies:microcompetency_id(
              id,
              name,
              weightage,
              components:component_id(
                id,
                name,
                sub_categories:sub_category_id(
                  id,
                  name,
                  quadrants:quadrant_id(id, name, weightage)
                )
              )
            )
          `)
          .eq('student_id', studentId)
          .eq('intervention_id', interventionId)
          .order('scored_at', { ascending: false })
      );

      // Get intervention microcompetency weightages separately
      const interventionMicrosResult = await query(
        supabase
          .from('intervention_microcompetencies')
          .select('microcompetency_id, weightage')
          .eq('intervention_id', interventionId)
          .eq('is_active', true)
      );

      // Create a map for quick lookup
      const interventionMicrosMap = interventionMicrosResult.rows.reduce((acc, item) => {
        acc[item.microcompetency_id] = item;
        return acc;
      }, {});

      // Filter to get only the latest score for each microcompetency
      const latestScoresMap = {};
      microScoresResult.rows.forEach(score => {
        const microId = score.microcompetency_id;
        if (!latestScoresMap[microId] || new Date(score.scored_at) > new Date(latestScoresMap[microId].scored_at)) {
          latestScoresMap[microId] = score;
        }
      });

      // Group scores by competency using only latest scores
      const competencyScores = {};

      Object.values(latestScoresMap).forEach(score => {
        const micro = score.microcompetencies;
        const component = micro.components;
        const competencyId = component.id;

        if (!competencyScores[competencyId]) {
          competencyScores[competencyId] = {
            competency: {
              id: component.id,
              name: component.name,
              quadrant: component.sub_categories.quadrants
            },
            microcompetencies: [],
            total_obtained: 0,
            total_max: 0,
            weighted_obtained: 0,
            weighted_max: 0
          };
        }

        // Calculate weighted scores based on intervention weightage
        const interventionWeightage = interventionMicrosMap[micro.id]?.weightage || 0;
        const weightedObtained = score.obtained_score * (interventionWeightage / 100);
        const weightedMax = score.max_score * (interventionWeightage / 100);

        competencyScores[competencyId].microcompetencies.push({
          microcompetency: {
            id: micro.id,
            name: micro.name,
            component_weightage: micro.weightage,
            intervention_weightage: interventionWeightage
          },
          obtained_score: score.obtained_score,
          max_score: score.max_score,
          weighted_obtained: weightedObtained,
          weighted_max: weightedMax,
          scored_at: score.scored_at
        });

        competencyScores[competencyId].total_obtained += score.obtained_score;
        competencyScores[competencyId].total_max += score.max_score;
        competencyScores[competencyId].weighted_obtained += weightedObtained;
        competencyScores[competencyId].weighted_max += weightedMax;
      });

      // Calculate percentages
      Object.values(competencyScores).forEach(competency => {
        competency.percentage = competency.total_max > 0 
          ? (competency.total_obtained / competency.total_max) * 100 
          : 0;
        competency.weighted_percentage = competency.weighted_max > 0 
          ? (competency.weighted_obtained / competency.weighted_max) * 100 
          : 0;
        competency.grade = this.calculateGrade(competency.percentage);
      });

      return {
        student_id: studentId,
        intervention_id: interventionId,
        competencies: Object.values(competencyScores),
        calculated_at: new Date().toISOString()
      };
    } catch (error) {
      console.error('❌ Calculate competency scores error:', error);
      throw new Error(`Failed to calculate competency scores: ${error.message}`);
    }
  }

  /**
   * Calculate quadrant scores for a student in a specific intervention
   * @param {string} studentId - Student UUID
   * @param {string} interventionId - Intervention UUID
   * @returns {Object} Quadrant scores with breakdown
   */
  async calculateQuadrantScores(studentId, interventionId) {
    try {
      // First get competency scores
      const competencyData = await this.calculateCompetencyScores(studentId, interventionId);
      
      // Group competencies by quadrant
      const quadrantScores = {};
      
      competencyData.competencies.forEach(competency => {
        const quadrant = competency.competency.quadrant;
        const quadrantId = quadrant.id;
        
        if (!quadrantScores[quadrantId]) {
          quadrantScores[quadrantId] = {
            quadrant: quadrant,
            competencies: [],
            total_obtained: 0,
            total_max: 0,
            weighted_obtained: 0,
            weighted_max: 0
          };
        }
        
        quadrantScores[quadrantId].competencies.push(competency);
        quadrantScores[quadrantId].total_obtained += competency.total_obtained;
        quadrantScores[quadrantId].total_max += competency.total_max;
        quadrantScores[quadrantId].weighted_obtained += competency.weighted_obtained;
        quadrantScores[quadrantId].weighted_max += competency.weighted_max;
      });

      // Calculate quadrant percentages and apply quadrant weightages
      Object.values(quadrantScores).forEach(quadrant => {
        quadrant.percentage = quadrant.total_max > 0 
          ? (quadrant.total_obtained / quadrant.total_max) * 100 
          : 0;
        quadrant.weighted_percentage = quadrant.weighted_max > 0 
          ? (quadrant.weighted_obtained / quadrant.weighted_max) * 100 
          : 0;
        
        // Apply quadrant weightage to get final contribution
        const quadrantWeightage = quadrant.quadrant.weightage || 25; // Default 25% per quadrant
        quadrant.final_contribution = (quadrant.percentage * quadrantWeightage) / 100;
        quadrant.grade = this.calculateGrade(quadrant.percentage);
      });

      return {
        student_id: studentId,
        intervention_id: interventionId,
        quadrants: Object.values(quadrantScores),
        calculated_at: new Date().toISOString()
      };
    } catch (error) {
      console.error('❌ Calculate quadrant scores error:', error);
      throw new Error(`Failed to calculate quadrant scores: ${error.message}`);
    }
  }

  /**
   * Calculate overall intervention score for a student
   * @param {string} studentId - Student UUID
   * @param {string} interventionId - Intervention UUID
   * @returns {Object} Overall intervention score
   */
  async calculateInterventionScore(studentId, interventionId) {
    try {
      // Get quadrant scores
      const quadrantData = await this.calculateQuadrantScores(studentId, interventionId);
      
      // Calculate overall score
      let totalContribution = 0;
      let totalWeightage = 0;
      
      quadrantData.quadrants.forEach(quadrant => {
        totalContribution += quadrant.final_contribution;
        totalWeightage += quadrant.quadrant.weightage || 25;
      });

      const overallPercentage = totalWeightage > 0 ? totalContribution : 0;
      const overallGrade = this.calculateGrade(overallPercentage);

      return {
        student_id: studentId,
        intervention_id: interventionId,
        overall_score: {
          percentage: overallPercentage,
          grade: overallGrade,
          total_contribution: totalContribution,
          total_weightage: totalWeightage
        },
        quadrant_breakdown: quadrantData.quadrants,
        calculated_at: new Date().toISOString()
      };
    } catch (error) {
      console.error('❌ Calculate intervention score error:', error);
      throw new Error(`Failed to calculate intervention score: ${error.message}`);
    }
  }

  /**
   * Recalculate all scores when a microcompetency score changes
   * @param {string} studentId - Student UUID
   * @param {string} interventionId - Intervention UUID
   * @returns {Object} Complete recalculated scores
   */
  async recalculateAllScores(studentId, interventionId) {
    try {
      console.log(`🔄 Recalculating all scores for student ${studentId} in intervention ${interventionId}`);
      
      // Calculate all levels
      const competencyScores = await this.calculateCompetencyScores(studentId, interventionId);
      const quadrantScores = await this.calculateQuadrantScores(studentId, interventionId);
      const interventionScore = await this.calculateInterventionScore(studentId, interventionId);

      // Optionally cache results for performance
      await this.cacheScores(studentId, interventionId, {
        competencies: competencyScores,
        quadrants: quadrantScores,
        intervention: interventionScore
      });

      return {
        student_id: studentId,
        intervention_id: interventionId,
        scores: {
          competencies: competencyScores.competencies,
          quadrants: quadrantScores.quadrants,
          overall: interventionScore.overall_score
        },
        recalculated_at: new Date().toISOString()
      };
    } catch (error) {
      console.error('❌ Recalculate all scores error:', error);
      throw new Error(`Failed to recalculate scores: ${error.message}`);
    }
  }

  /**
   * Cache calculated scores for performance
   * @param {string} studentId - Student UUID
   * @param {string} interventionId - Intervention UUID
   * @param {Object} scores - Calculated scores to cache
   */
  async cacheScores(studentId, interventionId, scores) {
    try {
      // This could be implemented with Redis or database caching
      // For now, we'll use the database views which provide real-time calculation
      console.log(`💾 Caching scores for student ${studentId} in intervention ${interventionId}`);
      
      // Future implementation: Store in cache table or Redis
      // await query(
      //   supabase
      //     .from('score_cache')
      //     .upsert({
      //       student_id: studentId,
      //       intervention_id: interventionId,
      //       cached_scores: scores,
      //       cached_at: new Date().toISOString()
      //     })
      // );
    } catch (error) {
      console.error('❌ Cache scores error:', error);
      // Don't throw error for caching failures
    }
  }

  /**
   * Calculate grade from percentage
   * @param {number} percentage - Score percentage
   * @returns {string} Grade letter
   */
  calculateGrade(percentage) {
    if (percentage >= 90) return 'A+';
    if (percentage >= 80) return 'A';
    if (percentage >= 70) return 'B';
    if (percentage >= 60) return 'C';
    if (percentage >= 50) return 'D';
    if (percentage >= 40) return 'E';
    return 'IC';
  }

  /**
   * Calculate comprehensive HPS (Holistic Performance Score) for a student in a term
   * Integrates both intervention-based scores and traditional component scores
   * @param {string} studentId - Student UUID
   * @param {string} termId - Term UUID
   * @returns {Object} Complete HPS calculation with breakdown
   */
  async calculateStudentHPS(studentId, termId) {
    try {
      console.log(`🔄 Calculating HPS for student ${studentId} in term ${termId}`);

      // Get all interventions for this student in this term
      const interventionsResult = await query(
        supabase
          .from('intervention_enrollments')
          .select(`
            intervention_id,
            interventions:intervention_id(
              id,
              name,
              term_id,
              status
            )
          `)
          .eq('student_id', studentId)
          .eq('enrollment_status', 'Enrolled')
      );

      // Filter interventions by term
      const termInterventions = interventionsResult.rows.filter(
        enrollment => enrollment.interventions?.term_id === termId
      );

      // Calculate intervention scores for each quadrant
      const quadrantInterventionScores = {};
      let totalInterventionContribution = 0;

      for (const enrollment of termInterventions) {
        try {
          const interventionScore = await this.calculateInterventionScore(
            studentId,
            enrollment.intervention_id
          );

          // Add intervention contribution to quadrants
          if (interventionScore.quadrant_breakdown) {
            interventionScore.quadrant_breakdown.forEach(quadrant => {
              if (!quadrantInterventionScores[quadrant.quadrant.id]) {
                quadrantInterventionScores[quadrant.quadrant.id] = {
                  quadrant_name: quadrant.quadrant.name,
                  intervention_contributions: [],
                  total_contribution: 0
                };
              }

              quadrantInterventionScores[quadrant.quadrant.id].intervention_contributions.push({
                intervention_name: enrollment.interventions.name,
                contribution: quadrant.final_contribution
              });

              quadrantInterventionScores[quadrant.quadrant.id].total_contribution += quadrant.final_contribution;
            });
          }

          totalInterventionContribution += interventionScore.overall_score.percentage;
        } catch (error) {
          console.warn(`⚠️ Could not calculate intervention score for ${enrollment.intervention_id}`);
        }
      }

      // Get traditional component scores for this term
      const traditionalScoresResult = await query(
        supabase
          .from('scores')
          .select(`
            obtained_score,
            max_score,
            percentage,
            components:component_id(
              id,
              name,
              weightage,
              sub_categories:sub_category_id(
                quadrant_id,
                quadrants:quadrant_id(
                  id,
                  name,
                  weightage
                )
              )
            )
          `)
          .eq('student_id', studentId)
          .eq('term_id', termId)
      );

      // Calculate traditional scores by quadrant
      const quadrantTraditionalScores = {};
      let totalTraditionalScore = 0;

      traditionalScoresResult.rows.forEach(score => {
        const quadrantId = score.components?.sub_categories?.quadrant_id;
        if (!quadrantId) return;

        if (!quadrantTraditionalScores[quadrantId]) {
          quadrantTraditionalScores[quadrantId] = {
            quadrant_name: score.components.sub_categories.quadrants.name,
            quadrant_weightage: score.components.sub_categories.quadrants.weightage,
            total_obtained: 0,
            total_max: 0,
            components: []
          };
        }

        quadrantTraditionalScores[quadrantId].total_obtained += score.obtained_score || 0;
        quadrantTraditionalScores[quadrantId].total_max += score.max_score || 0;
        quadrantTraditionalScores[quadrantId].components.push({
          name: score.components.name,
          obtained: score.obtained_score || 0,
          max: score.max_score || 0,
          percentage: score.percentage || 0
        });

        totalTraditionalScore += score.obtained_score || 0;
      });

      // Combine intervention and traditional scores by quadrant
      const finalQuadrantScores = {};
      let totalHPS = 0;

      // Get all quadrants
      const quadrantsResult = await query(
        supabase
          .from('quadrants')
          .select('id, name, weightage')
          .eq('is_active', true)
      );

      quadrantsResult.rows.forEach(quadrant => {
        const interventionData = quadrantInterventionScores[quadrant.id] || { total_contribution: 0, intervention_contributions: [] };
        const traditionalData = quadrantTraditionalScores[quadrant.id] || { total_obtained: 0, total_max: 0, components: [] };

        // Calculate combined quadrant score
        const traditionalPercentage = traditionalData.total_max > 0
          ? (traditionalData.total_obtained / traditionalData.total_max) * 100
          : 0;

        const combinedPercentage = traditionalPercentage + interventionData.total_contribution;
        const quadrantWeightage = quadrant.weightage || 25;
        const finalContribution = (combinedPercentage * quadrantWeightage) / 100;

        finalQuadrantScores[quadrant.id] = {
          quadrant: {
            id: quadrant.id,
            name: quadrant.name,
            weightage: quadrantWeightage
          },
          traditional_score: {
            obtained: traditionalData.total_obtained,
            max: traditionalData.total_max,
            percentage: traditionalPercentage,
            components: traditionalData.components
          },
          intervention_score: {
            total_contribution: interventionData.total_contribution,
            contributions: interventionData.intervention_contributions
          },
          combined_percentage: combinedPercentage,
          final_contribution: finalContribution,
          grade: this.calculateGrade(combinedPercentage)
        };

        totalHPS += finalContribution;
      });

      const overallGrade = this.calculateGrade(totalHPS);

      // Update student_terms table with calculated HPS
      await query(
        supabase
          .from('student_terms')
          .upsert({
            student_id: studentId,
            term_id: termId,
            total_score: Math.round(totalHPS * 100) / 100,
            grade: overallGrade,
            overall_status: totalHPS >= 60 ? 'Good' : totalHPS >= 40 ? 'Progress' : 'Deteriorate',
            is_eligible: totalHPS >= 40
          }, { onConflict: 'student_id,term_id' })
      );

      return {
        student_id: studentId,
        term_id: termId,
        hps: {
          total_score: totalHPS,
          grade: overallGrade,
          intervention_contribution: totalInterventionContribution,
          traditional_contribution: totalTraditionalScore
        },
        quadrant_breakdown: Object.values(finalQuadrantScores),
        interventions_included: termInterventions.length,
        calculated_at: new Date().toISOString()
      };

    } catch (error) {
      console.error('❌ Calculate student HPS error:', error);
      throw new Error(`Failed to calculate student HPS: ${error.message}`);
    }
  }

  /**
   * Recalculate all scores for a student in a specific intervention after task submission
   * @param {string} studentId - Student UUID
   * @param {string} interventionId - Intervention UUID
   * @returns {Object} Recalculation result
   */
  async recalculateStudentScores(studentId, interventionId) {
    console.log(`🔄 Starting score recalculation for student ${studentId} in intervention ${interventionId}`);
    
    try {
      // 1. Recalculate intervention scores
      const interventionScores = await this.calculateInterventionScore(studentId, interventionId);
      console.log(`✅ Intervention scores recalculated: ${interventionScores.overall_score.percentage.toFixed(2)}%`);

      // 2. Recalculate all scores including microcompetency aggregation
      const allScores = await this.recalculateAllScores(studentId, interventionId);
      console.log(`✅ All scores recalculated successfully`);

      // 3. Get student's current term and recalculate HPS
      const currentTermResult = await query(
        supabase
          .from('terms')
          .select('id')
          .eq('is_current', true)
          .limit(1)
      );

      if (currentTermResult.rows.length > 0) {
        const termId = currentTermResult.rows[0].id;
        console.log(`🔄 Triggering HPS recalculation for term ${termId}...`);
        await this.calculateStudentHPS(studentId, termId);
        console.log(`✅ HPS recalculation completed`);
      }

      console.log(`✅ Complete score recalculation finished for student ${studentId}`);
      return { 
        success: true, 
        message: 'Scores recalculated successfully',
        intervention_score: interventionScores.overall_score.percentage
      };

    } catch (error) {
      console.error(`❌ Error in score recalculation for student ${studentId}:`, error);
      throw error;
    }
  }

  /**
   * Get score statistics for an intervention
   * @param {string} interventionId - Intervention UUID
   * @returns {Object} Score statistics
   */
  async getInterventionStatistics(interventionId) {
    try {
      // Get all students enrolled in intervention
      const enrolledStudents = await query(
        supabase
          .from('intervention_enrollments')
          .select('student_id')
          .eq('intervention_id', interventionId)
          .eq('enrollment_status', 'Enrolled')
      );

      const statistics = {
        intervention_id: interventionId,
        total_students: enrolledStudents.rows.length,
        scores_calculated: 0,
        average_percentage: 0,
        grade_distribution: {
          'A+': 0, 'A': 0, 'B': 0, 'C': 0, 'D': 0, 'E': 0, 'IC': 0
        },
        quadrant_averages: {},
        calculated_at: new Date().toISOString()
      };

      // Calculate statistics for each student
      let totalPercentage = 0;
      let studentsWithScores = 0;

      for (const enrollment of enrolledStudents.rows) {
        try {
          const studentScore = await this.calculateInterventionScore(
            enrollment.student_id, 
            interventionId
          );
          
          if (studentScore.overall_score.percentage > 0) {
            studentsWithScores++;
            totalPercentage += studentScore.overall_score.percentage;
            statistics.grade_distribution[studentScore.overall_score.grade]++;
          }
        } catch (error) {
          console.warn(`⚠️ Could not calculate score for student ${enrollment.student_id}`);
        }
      }

      statistics.scores_calculated = studentsWithScores;
      statistics.average_percentage = studentsWithScores > 0 
        ? totalPercentage / studentsWithScores 
        : 0;

      return statistics;
    } catch (error) {
      console.error('❌ Get intervention statistics error:', error);
      throw new Error(`Failed to get intervention statistics: ${error.message}`);
    }
  }
}

module.exports = new ScoreCalculationService();
