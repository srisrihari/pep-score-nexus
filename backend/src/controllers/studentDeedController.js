const { supabase, query } = require('../config/supabase');
const studentDeedService = require('../services/studentDeedService');

class StudentDeedController {
  /**
   * Add a deed for a student
   * POST /api/v1/teachers/students/:studentId/deeds
   */
  async addDeed(req, res) {
    try {
      const { studentId } = req.params;
      const { termId, deedType, score, comment } = req.body;
      
      // Validate user authentication
      if (!req.user || !req.user.userId) {
        return res.status(401).json({
          success: false,
          message: 'User not authenticated'
        });
      }
      
      const userId = req.user.userId;
      
      // Validate required fields first
      if (!termId || !deedType || score === undefined) {
        return res.status(400).json({
          success: false,
          message: 'Missing required fields: termId, deedType, score'
        });
      }
      
      // Validate UUIDs
      if (!studentId || studentId === 'undefined') {
        return res.status(400).json({
          success: false,
          message: 'Invalid student ID'
        });
      }
      
      if (!termId || termId === 'undefined') {
        return res.status(400).json({
          success: false,
          message: 'Invalid term ID'
        });
      }
      
      // Get teacher record
      const teacherResult = await query(
        supabase
          .from('teachers')
          .select('id')
          .eq('user_id', userId)
          .limit(1)
      );

      if (!teacherResult.rows || teacherResult.rows.length === 0) {
        return res.status(403).json({
          success: false,
          message: 'Teacher record not found'
        });
      }

      const teacherId = teacherResult.rows[0].id;

      const deed = await studentDeedService.addDeed(
        studentId,
        teacherId,
        termId,
        deedType,
        parseFloat(score),
        comment,
        userId
      );

      return res.json({
        success: true,
        data: deed,
        message: `${deedType === 'good' ? 'Good' : 'Bad'} deed added successfully. HPS updated.`
      });
    } catch (error) {
      console.error('Error in addDeed:', error);
      return res.status(500).json({
        success: false,
        message: error.message || 'Failed to add deed'
      });
    }
  }

  /**
   * Get all deeds for a student
   * GET /api/v1/teachers/students/:studentId/deeds?termId=xxx
   */
  async getStudentDeeds(req, res) {
    try {
      const { studentId } = req.params;
      const { termId } = req.query;

      if (!termId) {
        return res.status(400).json({
          success: false,
          message: 'termId query parameter is required'
        });
      }

      const deeds = await studentDeedService.getStudentDeeds(studentId, termId);

      return res.json({
        success: true,
        data: deeds
      });
    } catch (error) {
      console.error('Error in getStudentDeeds:', error);
      return res.status(500).json({
        success: false,
        message: error.message || 'Failed to fetch deeds'
      });
    }
  }

  /**
   * Get all deeds for a student by current teacher
   * GET /api/v1/teachers/students/:studentId/deeds/my?termId=xxx
   */
  async getMyDeedsForStudent(req, res) {
    try {
      const { studentId } = req.params;
      const { termId } = req.query;

      // Validate user authentication
      if (!req.user || (!req.user.userId && !req.user.id)) {
        return res.status(401).json({
          success: false,
          message: 'User not authenticated'
        });
      }

      const userId = req.user.userId || req.user.id;

      // Get teacher record
      const teacherResult = await query(
        supabase
          .from('teachers')
          .select('id')
          .eq('user_id', userId)
          .limit(1)
      );

      if (!teacherResult.rows || teacherResult.rows.length === 0) {
        return res.status(403).json({
          success: false,
          message: 'Teacher record not found'
        });
      }

      const teacherId = teacherResult.rows[0].id;

      // Get all deeds by this teacher for this student (optionally filtered by term)
      let deedsQuery = supabase
        .from('student_deeds')
        .select(`
          *,
          term:terms(id, name),
          student:students(id, name, registration_no)
        `)
        .eq('student_id', studentId)
        .eq('teacher_id', teacherId)
        .order('created_at', { ascending: false });

      if (termId) {
        deedsQuery = deedsQuery.eq('term_id', termId);
      }

      return res.json({
        success: true,
        data: (await query(deedsQuery)).rows || []
      });
    } catch (error) {
      console.error('Error in getMyDeedsForStudent:', error);
      return res.status(500).json({
        success: false,
        message: error.message || 'Failed to fetch deeds'
      });
    }
  }

  /**
   * Admin: Get all deeds for a student (optional term filter)
   * GET /api/v1/admin/students/:studentId/deeds
   */
  async getAdminStudentDeeds(req, res) {
    try {
      const { studentId } = req.params;
      const { termId } = req.query;

      const deeds = await studentDeedService.getStudentDeedsForAdmin(studentId, termId);

      return res.json({
        success: true,
        data: deeds
      });
    } catch (error) {
      console.error('Error in getAdminStudentDeeds:', error);
      return res.status(500).json({
        success: false,
        message: error.message || 'Failed to fetch deeds'
      });
    }
  }

  /**
   * Admin: delete a deed
   * DELETE /api/v1/admin/deeds/:deedId
   */
  async deleteDeed(req, res) {
    try {
      const { deedId } = req.params;
      await studentDeedService.deleteDeed(deedId);

      return res.json({
        success: true,
        message: 'Deed deleted successfully'
      });
    } catch (error) {
      console.error('Error in deleteDeed:', error);
      return res.status(500).json({
        success: false,
        message: error.message || 'Failed to delete deed'
      });
    }
  }

  /**
   * Get own deeds (student view)
   * GET /api/v1/students/me/deeds?termId=xxx
   */
  async getOwnDeeds(req, res) {
    try {
      if (!req.user || (!req.user.userId && !req.user.id)) {
        return res.status(401).json({
          success: false,
          message: 'User not authenticated'
        });
      }

      const userId = req.user.userId || req.user.id;
      const { termId } = req.query;

      if (!termId) {
        return res.status(400).json({
          success: false,
          message: 'termId query parameter is required'
        });
      }

      // Get student ID from user_id
      const studentResult = await query(
        supabase
          .from('students')
          .select('id')
          .eq('user_id', userId)
          .limit(1)
      );

      if (!studentResult.rows || studentResult.rows.length === 0) {
        return res.status(403).json({
          success: false,
          message: 'Student record not found'
        });
      }

      const studentId = studentResult.rows[0].id;
      const deeds = await studentDeedService.getStudentDeeds(studentId, termId);

      return res.json({
        success: true,
        data: deeds
      });
    } catch (error) {
      console.error('Error in getOwnDeeds:', error);
      return res.status(500).json({
        success: false,
        message: error.message || 'Failed to fetch deeds'
      });
    }
  }
}

module.exports = new StudentDeedController();

