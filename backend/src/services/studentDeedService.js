const { supabase, query } = require('../config/supabase');
const { getNetDeedScore } = require('../helpers/deedScoreHelper');

/**
 * Student Deed Service
 * Handles good/bad deed operations and HPS recalculation
 */
class StudentDeedService {
  /**
   * Add a deed (good or bad) for a student
   * @param {string} studentId - Student UUID
   * @param {string} teacherId - Teacher UUID
   * @param {string} termId - Term UUID
   * @param {string} deedType - 'good' or 'bad'
   * @param {number} score - Score from 0 to 5
   * @param {string} comment - Optional comment
   * @param {string} createdBy - User UUID who created the deed
   * @returns {Object} Created deed record
   */
  async addDeed(studentId, teacherId, termId, deedType, score, comment, createdBy) {
    // Validation
    if (!studentId || studentId === 'undefined') {
      throw new Error('Student ID is required');
    }
    if (!teacherId || teacherId === 'undefined') {
      throw new Error('Teacher ID is required');
    }
    if (!termId || termId === 'undefined') {
      throw new Error('Term ID is required');
    }
    if (!createdBy || createdBy === 'undefined') {
      throw new Error('Created by user ID is required');
    }
    if (!['good', 'bad'].includes(deedType)) {
      throw new Error('Invalid deed_type. Must be "good" or "bad"');
    }
    if (score < 0 || score > 5) {
      throw new Error('Score must be between 0 and 5');
    }

    console.log('Adding deed with:', {
      studentId,
      teacherId,
      termId,
      deedType,
      score,
      createdBy
    });

    const result = await query(
      supabase
        .from('student_deeds')
        .insert({
          student_id: studentId,
          teacher_id: teacherId,
          term_id: termId,
          deed_type: deedType,
          score: score,
          comment: comment || null,
          created_by: createdBy
        })
        .select()
        .single()
    );

    const data = result.rows?.[0] || null;

    // Trigger HPS recalculation (deeds affect final HPS)
    await this.triggerHPSRecalculation(studentId, termId);

    return data;
  }

  /**
   * Get all deeds for a student in a term
   * @param {string} studentId - Student UUID
   * @param {string} termId - Term UUID
   * @returns {Array} Array of deed records
   */
  async getStudentDeeds(studentId, termId) {
    const result = await query(
      supabase
        .from('student_deeds')
        .select(`
          *,
          teacher:teachers(id, name, employee_id),
          term:terms(id, name)
        `)
        .eq('student_id', studentId)
        .eq('term_id', termId)
        .order('created_at', { ascending: false })
    );

    return result.rows || [];
  }

  async getStudentDeedsForAdmin(studentId, termId) {
    let queryBuilder = supabase
      .from('student_deeds')
      .select(`
        *,
        teacher:teachers(id, name, employee_id),
        term:terms(id, name)
      `)
      .eq('student_id', studentId)
      .order('created_at', { ascending: false });

    if (termId) {
      queryBuilder = queryBuilder.eq('term_id', termId);
    }

    const result = await query(queryBuilder);
    return result.rows || [];
  }

  /**
   * Calculate net deed score for a student in a term
   * Good deeds: +score, Bad deeds: -score
   * @param {string} studentId - Student UUID
   * @param {string} termId - Term UUID
   * @returns {number} Net score (can be negative)
   */
  async calculateNetDeedScore(studentId, termId) {
    return getNetDeedScore(studentId, termId);
  }

  /**
   * Trigger HPS recalculation after deed addition
   * IMPORTANT: Deeds affect FINAL HPS directly, not quadrant scores
   * @param {string} studentId - Student UUID
   * @param {string} termId - Term UUID
   */
  async triggerHPSRecalculation(studentId, termId) {
    try {
      const hpsService = require('./enhancedUnifiedScoreCalculationServiceV2');
      await hpsService.calculateUnifiedHPS(studentId, termId);
      console.log(`✅ HPS recalculated with deed impact for student ${studentId}`);
    } catch (error) {
      console.error('Error recalculating HPS after deed addition:', error);
      // Don't throw - deed was added successfully, HPS can be recalculated later
    }
  }

  async deleteDeed(deedId) {
    const deedResult = await query(
      supabase
        .from('student_deeds')
        .select('id, student_id, term_id')
        .eq('id', deedId)
        .limit(1)
    );

    if (!deedResult.rows || deedResult.rows.length === 0) {
      throw new Error('Deed not found');
    }

    const deed = deedResult.rows[0];

    await query(
      supabase
        .from('student_deeds')
        .delete()
        .eq('id', deedId)
    );

    await this.triggerHPSRecalculation(deed.student_id, deed.term_id);
    return deed;
  }
}

module.exports = new StudentDeedService();

