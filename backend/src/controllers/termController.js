const { supabase } = require('../config/supabase');

// Helper function for database queries
const query = async (queryBuilder) => {
  const { data, error, count } = await queryBuilder;
  if (error) {
    console.error('Database query error:', error);
    throw error;
  }
  return { rows: data, count };
};

// Get all terms
const getAllTerms = async (req, res) => {
  try {
    const { includeInactive = false } = req.query;

    let termsQuery = supabase
      .from('terms')
      .select('*')
      .order('start_date', { ascending: true });

    if (includeInactive !== 'true') {
      termsQuery = termsQuery.eq('is_active', true);
    }

    const { rows: terms } = await query(termsQuery);

    res.status(200).json({
      success: true,
      data: terms,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('❌ Get all terms error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to fetch terms',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get current term
const getCurrentTerm = async (req, res) => {
  try {
    const { rows: terms } = await query(
      supabase
        .from('terms')
        .select('*')
        .eq('is_current', true)
        .limit(1)
    );

    if (!terms || terms.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'No current term found',
        timestamp: new Date().toISOString()
      });
    }

    res.status(200).json({
      success: true,
      data: terms[0],
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('❌ Get current term error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to fetch current term',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Create new term
const createTerm = async (req, res) => {
  try {
    const {
      name,
      description,
      start_date,
      end_date,
      academic_year,
      is_active = true,
      is_current = false
    } = req.body;

    // Validation
    if (!name || !start_date || !end_date || !academic_year) {
      return res.status(400).json({
        success: false,
        message: 'Name, start_date, end_date, and academic_year are required',
        timestamp: new Date().toISOString()
      });
    }

    // Validate dates
    if (new Date(end_date) <= new Date(start_date)) {
      return res.status(400).json({
        success: false,
        message: 'End date must be after start date',
        timestamp: new Date().toISOString()
      });
    }

    // If setting as current, unset other current terms
    if (is_current) {
      await query(
        supabase
          .from('terms')
          .update({ is_current: false })
          .eq('is_current', true)
      );
    }

    const { rows: newTerm } = await query(
      supabase
        .from('terms')
        .insert({
          name,
          description,
          start_date,
          end_date,
          academic_year,
          is_active,
          is_current
        })
        .select()
    );

    res.status(201).json({
      success: true,
      data: newTerm[0],
      message: 'Term created successfully',
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('❌ Create term error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to create term',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Update term
const updateTerm = async (req, res) => {
  try {
    const { id } = req.params;
    const updates = req.body;

    // If setting as current, unset other current terms
    if (updates.is_current) {
      await query(
        supabase
          .from('terms')
          .update({ is_current: false })
          .eq('is_current', true)
          .neq('id', id)
      );
    }

    const { rows: updatedTerm } = await query(
      supabase
        .from('terms')
        .update(updates)
        .eq('id', id)
        .select()
    );

    if (!updatedTerm || updatedTerm.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Term not found',
        timestamp: new Date().toISOString()
      });
    }

    res.status(200).json({
      success: true,
      data: updatedTerm[0],
      message: 'Term updated successfully',
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('❌ Update term error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to update term',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Set current term
const setCurrentTerm = async (req, res) => {
  try {
    const { id } = req.params;

    // Unset all current terms
    await query(
      supabase
        .from('terms')
        .update({ is_current: false })
        .eq('is_current', true)
    );

    // Set new current term
    const { rows: updatedTerm } = await query(
      supabase
        .from('terms')
        .update({ is_current: true, is_active: true })
        .eq('id', id)
        .select()
    );

    if (!updatedTerm || updatedTerm.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Term not found',
        timestamp: new Date().toISOString()
      });
    }

    res.status(200).json({
      success: true,
      data: updatedTerm[0],
      message: 'Current term updated successfully',
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('❌ Set current term error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to set current term',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Transition students to new term
const transitionStudentsToTerm = async (req, res) => {
  try {
    const { id } = req.params;
    const { studentIds, resetScores = true } = req.body; // Optional: specific students, otherwise all active

    // Get term details
    const { rows: terms } = await query(
      supabase
        .from('terms')
        .select('*')
        .eq('id', id)
        .limit(1)
    );

    if (!terms || terms.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Term not found',
        timestamp: new Date().toISOString()
      });
    }

    // Get students to transition
    let studentsQuery = supabase
      .from('students')
      .select('id')
      .eq('status', 'Active');

    if (studentIds && studentIds.length > 0) {
      studentsQuery = studentsQuery.in('id', studentIds);
    }

    const { rows: students } = await query(studentsQuery);

    // Create student_terms records
    const studentTermsData = students.map(student => ({
      student_id: student.id,
      term_id: id,
      enrollment_status: 'Enrolled',
      total_score: 0.00,
      grade: 'IC',
      overall_status: 'Progress',
      is_eligible: true
    }));

    if (studentTermsData.length > 0) {
      await query(
        supabase
          .from('student_terms')
          .upsert(studentTermsData, {
            onConflict: 'student_id,term_id',
            ignoreDuplicates: false
          })
      );
    }

    // Initialize scores for new term if requested
    if (resetScores && students.length > 0) {
      await initializeScoresForTerm(id, students.map(s => s.id));
    }

    res.status(200).json({
      success: true,
      data: {
        term: terms[0],
        studentsTransitioned: students.length,
        scoresInitialized: resetScores
      },
      message: `Successfully transitioned ${students.length} students to ${terms[0].name}${resetScores ? ' with score reset' : ''}`,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('❌ Transition students error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to transition students',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Initialize scores for students in a new term
const initializeScoresForTerm = async (termId, studentIds) => {
  try {
    // Get all active components
    const { rows: components } = await query(
      supabase
        .from('components')
        .select('id, max_score')
        .eq('is_active', true)
    );

    if (!components || components.length === 0) {
      console.log('No active components found for score initialization');
      return;
    }

    // Get admin user ID for system operations
    const { rows: adminUsers } = await query(
      supabase
        .from('users')
        .select('id')
        .eq('role', 'admin')
        .limit(1)
    );

    const systemUserId = adminUsers && adminUsers.length > 0 ? adminUsers[0].id : null;

    if (!systemUserId) {
      console.error('No admin user found for system operations');
      return;
    }

    // Create score records for each student-component combination
    const scoreRecords = [];
    for (const studentId of studentIds) {
      for (const component of components) {
        scoreRecords.push({
          student_id: studentId,
          component_id: component.id,
          term_id: termId,
          obtained_score: 0.00,
          max_score: component.max_score,
          assessment_date: new Date().toISOString(),
          assessed_by: systemUserId,
          notes: 'Initial score for new term'
        });
      }
    }

    // Insert score records in batches to avoid query size limits
    const batchSize = 100;
    for (let i = 0; i < scoreRecords.length; i += batchSize) {
      const batch = scoreRecords.slice(i, i + batchSize);
      await query(
        supabase
          .from('scores')
          .upsert(batch, {
            onConflict: 'student_id,component_id,term_id',
            ignoreDuplicates: false
          })
      );
    }

    console.log(`✅ Initialized ${scoreRecords.length} score records for term ${termId}`);
  } catch (error) {
    console.error('❌ Score initialization error:', error);
    throw error;
  }
};

// Reset scores for a term
const resetTermScores = async (req, res) => {
  try {
    const { id } = req.params;
    const { studentIds } = req.body; // Optional: specific students, otherwise all enrolled

    // Get term details
    const { rows: terms } = await query(
      supabase
        .from('terms')
        .select('*')
        .eq('id', id)
        .limit(1)
    );

    if (!terms || terms.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Term not found',
        timestamp: new Date().toISOString()
      });
    }

    // Get students enrolled in this term
    let studentsQuery = supabase
      .from('student_terms')
      .select('student_id')
      .eq('term_id', id)
      .eq('enrollment_status', 'Enrolled');

    if (studentIds && studentIds.length > 0) {
      studentsQuery = studentsQuery.in('student_id', studentIds);
    }

    const { rows: enrolledStudents } = await query(studentsQuery);
    const studentIdsToReset = enrolledStudents.map(s => s.student_id);

    if (studentIdsToReset.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'No students found enrolled in this term',
        timestamp: new Date().toISOString()
      });
    }

    // Delete existing scores for this term
    await query(
      supabase
        .from('scores')
        .delete()
        .eq('term_id', id)
        .in('student_id', studentIdsToReset)
    );

    // Initialize fresh scores
    await initializeScoresForTerm(id, studentIdsToReset);

    // Reset student_terms totals
    await query(
      supabase
        .from('student_terms')
        .update({
          total_score: 0.00,
          grade: 'IC',
          overall_status: 'Progress'
        })
        .eq('term_id', id)
        .in('student_id', studentIdsToReset)
    );

    res.status(200).json({
      success: true,
      data: {
        term: terms[0],
        studentsReset: studentIdsToReset.length
      },
      message: `Successfully reset scores for ${studentIdsToReset.length} students in ${terms[0].name}`,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('❌ Reset term scores error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to reset term scores',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Delete term
const deleteTerm = async (req, res) => {
  try {
    const { id } = req.params;
    const { force = false } = req.query;

    console.log(`🗑️ Attempting to delete term: ${id}, force: ${force}`);

    // Check if term has associated data in all related tables
    const relatedTables = [
      { table: 'scores', field: 'term_id' },
      { table: 'student_terms', field: 'term_id' },
      { table: 'microcompetency_scores', field: 'term_id' },
      { table: 'interventions', field: 'term_id' },
      { table: 'direct_assessments', field: 'term_id' },
      { table: 'attendance', field: 'term_id' },
      { table: 'attendance_summary', field: 'term_id' },
      { table: 'attendance_eligibility', field: 'term_id' },
      { table: 'student_score_summary', field: 'term_id' },
      { table: 'student_rankings', field: 'term_id' },
      { table: 'hps_recalculation_queue', field: 'term_id' },
      { table: 'students', field: 'current_term_id' }
    ];

    const associations = [];
    for (const { table, field } of relatedTables) {
      try {
        const countResult = await query(
          supabase
            .from(table)
            .select('id', { count: 'exact', head: true })
            .eq(field, id)
        );
        
        const count = countResult.count || 0;
        if (count > 0) {
          associations.push({ table, count });
        }
      } catch (err) {
        console.warn(`⚠️ Could not check ${table}: ${err.message}`);
      }
    }

    if (associations.length > 0 && force !== 'true') {
      const details = associations.map(a => `${a.table}: ${a.count} records`).join(', ');
      return res.status(400).json({
        success: false,
        message: `Cannot delete term with associated data. Found: ${details}. Use force=true for cascading deletion.`,
        associations,
        timestamp: new Date().toISOString()
      });
    }

    if (force === 'true' && associations.length > 0) {
      console.log(`🔄 Force delete enabled, removing ${associations.length} associations...`);
      
      // Delete associated data in reverse dependency order
      const deletionOrder = [
        'hps_recalculation_queue',
        'student_rankings', 
        'student_score_summary',
        'attendance_eligibility',
        'attendance_summary',
        'attendance',
        'direct_assessments',
        'microcompetency_scores',
        'scores',
        'student_terms'
      ];

      for (const table of deletionOrder) {
        try {
          const field = relatedTables.find(t => t.table === table)?.field;
          if (field) {
            await query(
              supabase
                .from(table)
                .delete()
                .eq(field, id)
            );
            console.log(`✅ Deleted records from ${table}`);
          }
        } catch (err) {
          console.error(`❌ Error deleting from ${table}:`, err.message);
        }
      }

      // Update students current_term_id to null
      try {
        await query(
          supabase
            .from('students')
            .update({ current_term_id: null })
            .eq('current_term_id', id)
        );
        console.log('✅ Updated student current_term_id references');
      } catch (err) {
        console.error('❌ Error updating students:', err.message);
      }

      // Delete interventions (which may have their own cascade)
      try {
        await query(
          supabase
            .from('interventions')
            .delete()
            .eq('term_id', id)
        );
        console.log('✅ Deleted interventions');
      } catch (err) {
        console.error('❌ Error deleting interventions:', err.message);
      }
    }

    // Finally delete the term
    const deleteResult = await query(
      supabase
        .from('terms')
        .delete()
        .eq('id', id)
        .select()
    );

    if (!deleteResult.rows || deleteResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Term not found',
        timestamp: new Date().toISOString()
      });
    }

    console.log(`✅ Term ${id} deleted successfully`);
    res.status(200).json({
      success: true,
      message: force === 'true' ? 
        'Term and all associated data deleted successfully (cascading delete)' : 
        'Term deleted successfully',
      deletedAssociations: force === 'true' ? associations : [],
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('❌ Delete term error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to delete term',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

module.exports = {
  getAllTerms,
  getCurrentTerm,
  createTerm,
  updateTerm,
  setCurrentTerm,
  transitionStudentsToTerm,
  resetTermScores,
  deleteTerm
};
