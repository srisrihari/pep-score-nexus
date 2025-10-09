/**
 * Student Ranking Service
 * Implements Excel-style ranking system for quadrants and overall HPS
 */

const { supabase, query } = require('../config/supabase');

class StudentRankingService {

  /**
   * Calculate and update rankings for all students in a term
   * @param {string} termId - Term UUID
   */
  async calculateTermRankings(termId) {
    try {
      console.log(`🏆 Calculating rankings for term: ${termId}`);

      // Get all students in the term
      const studentsResult = await query(
        supabase
          .from('students')
          .select('id, name, registration_no')
          .eq('current_term_id', termId)
      );

      const students = studentsResult.rows || [];
      
      if (students.length === 0) {
        console.log('No students found for term');
        return { success: true, message: 'No students to rank' };
      }

      // Calculate quadrant rankings
      await this.calculateQuadrantRankings(termId, students);
      
      // Calculate overall HPS rankings
      await this.calculateOverallRankings(termId, students);

      console.log(`✅ Rankings calculated for ${students.length} students`);
      
      return {
        success: true,
        students_ranked: students.length,
        term_id: termId,
        calculated_at: new Date().toISOString()
      };

    } catch (error) {
      console.error('❌ Calculate term rankings error:', error);
      throw new Error(`Failed to calculate term rankings: ${error.message}`);
    }
  }

  /**
   * Calculate rankings for each quadrant
   */
  async calculateQuadrantRankings(termId, students) {
    try {
      // Get all quadrants
      const quadrantsResult = await query(
        supabase
          .from('quadrants')
          .select('id, name')
          .eq('is_active', true)
      );

      const quadrants = quadrantsResult.rows || [];

      for (const quadrant of quadrants) {
        console.log(`📊 Calculating ${quadrant.name} rankings...`);
        
        // Get scores for all students in this quadrant
        const studentScores = [];
        
        for (const student of students) {
          const quadrantScore = await this.getStudentQuadrantScore(student.id, termId, quadrant.id);
          studentScores.push({
            student_id: student.id,
            student_name: student.name,
            registration_no: student.registration_no,
            score: quadrantScore.percentage || 0,
            status: quadrantScore.status || 'Not Cleared'
          });
        }

        // Sort by score (descending)
        studentScores.sort((a, b) => b.score - a.score);

        // Assign ranks (handle ties)
        let currentRank = 1;
        for (let i = 0; i < studentScores.length; i++) {
          if (i > 0 && studentScores[i].score < studentScores[i-1].score) {
            currentRank = i + 1;
          }
          studentScores[i].rank = currentRank;
        }

        // Save rankings to database
        await this.saveQuadrantRankings(termId, quadrant.id, studentScores);
      }

    } catch (error) {
      console.error('❌ Calculate quadrant rankings error:', error);
      throw error;
    }
  }

  /**
   * Calculate overall HPS rankings
   */
  async calculateOverallRankings(termId, students) {
    try {
      console.log('🎯 Calculating overall HPS rankings...');
      
      const studentHPSScores = [];
      
      for (const student of students) {
        const hpsScore = await this.getStudentHPSScore(student.id, termId);
        studentHPSScores.push({
          student_id: student.id,
          student_name: student.name,
          registration_no: student.registration_no,
          hps_score: hpsScore.total || 0,
          grade: hpsScore.grade || 'E',
          status: hpsScore.status || 'Not Cleared'
        });
      }

      // Sort by HPS score (descending)
      studentHPSScores.sort((a, b) => b.hps_score - a.hps_score);

      // Assign ranks
      let currentRank = 1;
      for (let i = 0; i < studentHPSScores.length; i++) {
        if (i > 0 && studentHPSScores[i].hps_score < studentHPSScores[i-1].hps_score) {
          currentRank = i + 1;
        }
        studentHPSScores[i].rank = currentRank;
      }

      // Save overall rankings
      await this.saveOverallRankings(termId, studentHPSScores);

    } catch (error) {
      console.error('❌ Calculate overall rankings error:', error);
      throw error;
    }
  }

  /**
   * Get student's quadrant score
   */
  async getStudentQuadrantScore(studentId, termId, quadrantId) {
    try {
      // Use intervention microcompetency scores only
      const microScoresResult = await query(
        supabase
          .from('microcompetency_scores')
          .select('obtained_score, max_score, microcompetency_id')
          .eq('student_id', studentId)
          .eq('term_id', termId)
      );

      const microScores = microScoresResult.rows || [];

      // Get microcompetencies for components under this quadrant
      const microListResult = await query(
        supabase
          .from('microcompetencies')
          .select('id, component_id')
          .in('component_id',
            supabase
              .from('components')
              .select('id')
              .in('sub_category_id',
                supabase
                  .from('sub_categories')
                  .select('id')
                  .eq('quadrant_id', quadrantId)
              )
          )
      );

      const microIds = microListResult.rows?.map(m => m.id) || [];

      // Calculate quadrant score from microcompetency scores
      const quadrantMicroScores = microScores.filter(s => microIds.includes(s.microcompetency_id));
      const totalObtained = quadrantMicroScores.reduce((sum, s) => sum + (s.obtained_score || 0), 0);
      const totalMax = quadrantMicroScores.reduce((sum, s) => sum + (s.max_score || 0), 0);

      const percentage = totalMax > 0 ? (totalObtained / totalMax) * 100 : 0;
      const status = percentage >= 40 ? 'Cleared' : 'Not Cleared';

      return {
        percentage: Math.round(percentage * 100) / 100,
        status: status,
        total_obtained: totalObtained,
        total_max: totalMax
      };

    } catch (error) {
      console.error('❌ Get student quadrant score error:', error);
      return { percentage: 0, status: 'Not Cleared' };
    }
  }

  /**
   * Get student's overall HPS score
   */
  async getStudentHPSScore(studentId, termId) {
    try {
      // Get student's batch id
      const studentResult = await query(
        supabase
          .from('students')
          .select('batch_id')
          .eq('id', studentId)
          .limit(1)
      );

      const batchId = studentResult.rows?.[0]?.batch_id || null;

      // Get batch-term quadrant weightages if configured
      let quadWeights = [];
      if (batchId) {
        const configResult = await query(
          supabase
            .from('batch_term_weightage_config')
            .select('id')
            .eq('batch_id', batchId)
            .eq('term_id', termId)
            .eq('is_active', true)
            .limit(1)
        );
        const configId = configResult.rows?.[0]?.id || null;
        if (configId) {
          const weightageResult = await query(
            supabase
              .from('batch_term_quadrant_weightages')
              .select('quadrant_id, weightage')
              .eq('config_id', configId)
          );
          quadWeights = weightageResult.rows || [];
        }
      }

      // Fallback to default quadrant weightages
      if (!quadWeights || quadWeights.length === 0) {
        const quadrantsResult = await query(
          supabase
            .from('quadrants')
            .select('id, weightage')
            .eq('is_active', true)
        );
        quadWeights = (quadrantsResult.rows || []).map(q => ({ quadrant_id: q.id, weightage: q.weightage }));
      }

      let totalWeightedScore = 0;
      let totalWeightage = 0; // denominator over non-zero weights only

      for (const qw of quadWeights) {
        const w = parseFloat(qw.weightage) || 0;
        if (w <= 0) continue; // exclude zero-weight quadrants
        const quadrantScore = await this.getStudentQuadrantScore(studentId, termId, qw.quadrant_id);
        totalWeightedScore += (quadrantScore.percentage * w / 100);
        totalWeightage += w;
      }

      const hpsScore = totalWeightage > 0 ? (totalWeightedScore * (100 / totalWeightage)) : 0;
      const grade = this.calculateGrade(hpsScore);
      const status = hpsScore >= 50 ? 'Cleared' : 'Not Cleared';

      return {
        total: Math.round(hpsScore * 100) / 100,
        grade: grade,
        status: status
      };

    } catch (error) {
      console.error('❌ Get student HPS score error:', error);
      return { total: 0, grade: 'E', status: 'Not Cleared' };
    }
  }

  /**
   * Save quadrant rankings to database
   */
  async saveQuadrantRankings(termId, quadrantId, rankings) {
    try {
      // Create student_rankings table if not exists (would be in migration)
      const rankingRecords = rankings.map(ranking => ({
        student_id: ranking.student_id,
        term_id: termId,
        quadrant_id: quadrantId,
        rank_position: ranking.rank,
        score: ranking.score,
        total_students: rankings.length,
        ranking_type: 'quadrant',
        created_at: new Date().toISOString()
      }));

      // Delete existing rankings for this term/quadrant
      await query(
        supabase
          .from('student_rankings')
          .delete()
          .eq('term_id', termId)
          .eq('quadrant_id', quadrantId)
          .eq('ranking_type', 'quadrant')
      );

      // Insert new rankings
      const result = await query(
        supabase
          .from('student_rankings')
          .insert(rankingRecords)
      );

      return result;

    } catch (error) {
      console.error('❌ Save quadrant rankings error:', error);
      throw error;
    }
  }

  /**
   * Save overall HPS rankings
   */
  async saveOverallRankings(termId, rankings) {
    try {
      const rankingRecords = rankings.map(ranking => ({
        student_id: ranking.student_id,
        term_id: termId,
        quadrant_id: null, // Overall ranking
        rank_position: ranking.rank,
        score: ranking.hps_score,
        total_students: rankings.length,
        ranking_type: 'overall',
        grade: ranking.grade,
        created_at: new Date().toISOString()
      }));

      // Delete existing overall rankings for this term
      await query(
        supabase
          .from('student_rankings')
          .delete()
          .eq('term_id', termId)
          .eq('ranking_type', 'overall')
      );

      // Insert new rankings
      const result = await query(
        supabase
          .from('student_rankings')
          .insert(rankingRecords)
      );

      return result;

    } catch (error) {
      console.error('❌ Save overall rankings error:', error);
      throw error;
    }
  }

  /**
   * Get student's rank in specific quadrant
   */
  async getStudentQuadrantRank(studentId, termId, quadrantId) {
    try {
      const result = await query(
        supabase
          .from('student_rankings')
          .select('rank_position, total_students, score')
          .eq('student_id', studentId)
          .eq('term_id', termId)
          .eq('quadrant_id', quadrantId)
          .eq('ranking_type', 'quadrant')
          .limit(1)
      );

      return result.rows?.[0] || { rank_position: null, total_students: 0, score: 0 };

    } catch (error) {
      console.error('❌ Get student quadrant rank error:', error);
      return { rank_position: null, total_students: 0, score: 0 };
    }
  }

  /**
   * Get student's overall HPS rank
   */
  async getStudentOverallRank(studentId, termId) {
    try {
      const result = await query(
        supabase
          .from('student_rankings')
          .select('rank_position, total_students, score, grade')
          .eq('student_id', studentId)
          .eq('term_id', termId)
          .eq('ranking_type', 'overall')
          .limit(1)
      );

      return result.rows?.[0] || { rank_position: null, total_students: 0, score: 0, grade: 'E' };

    } catch (error) {
      console.error('❌ Get student overall rank error:', error);
      return { rank_position: null, total_students: 0, score: 0, grade: 'E' };
    }
  }

  /**
   * Calculate grade from score
   */
  calculateGrade(score) {
    if (score >= 80) return 'A+';
    if (score >= 66) return 'A';
    if (score >= 50) return 'B';
    if (score >= 34) return 'C';
    if (score > 0) return 'D';
    return 'E';
  }
}

module.exports = new StudentRankingService();
