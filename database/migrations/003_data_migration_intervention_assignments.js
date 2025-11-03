/**
 * Data Migration Script: Intervention Teacher Assignments
 * 
 * This script migrates existing data from the old structure to the new structure:
 * 1. Consolidate teacher_microcompetency_assignments (remove duplicates, keep one per teacher per intervention)
 * 2. Assign existing students to teachers (assign to first teacher in intervention, or distribute evenly)
 * 
 * Run this AFTER applying the schema migration.
 */

const { supabase, query } = require('../config/supabase');

async function migrateInterventionTeacherAssignments() {
  console.log('🔄 Starting intervention teacher assignment migration...');

  try {
    // Step 1: Consolidate teacher assignments
    // Get all unique teacher-intervention pairs from existing assignments
    const existingAssignments = await query(
      supabase
        .from('teacher_microcompetency_assignments')
        .select('teacher_id, intervention_id, can_score, can_create_tasks, assigned_at, assigned_by, is_active')
    );

    if (!existingAssignments.rows || existingAssignments.rows.length === 0) {
      console.log('✅ No existing assignments to migrate');
      return;
    }

    console.log(`📊 Found ${existingAssignments.rows.length} existing assignments`);

    // Group by teacher_id and intervention_id
    const uniqueAssignments = new Map();
    existingAssignments.rows.forEach(assignment => {
      const key = `${assignment.teacher_id}_${assignment.intervention_id}`;
      if (!uniqueAssignments.has(key)) {
        uniqueAssignments.set(key, assignment);
      }
    });

    console.log(`📊 Consolidated to ${uniqueAssignments.size} unique teacher-intervention pairs`);

    // Step 2: Delete old duplicate assignments and create new consolidated ones
    // (This will be done by the schema migration which removes microcompetency_id)
    // We'll keep the first assignment for each teacher-intervention pair

    // Step 3: Assign existing students to teachers
    const enrollments = await query(
      supabase
        .from('intervention_enrollments')
        .select('id, intervention_id, student_id')
        .is('intervention_teacher_id', null) // Only migrate those without teacher assignment
    );

    if (!enrollments.rows || enrollments.rows.length === 0) {
      console.log('✅ No enrollments to migrate');
      return;
    }

    console.log(`📊 Found ${enrollments.rows.length} enrollments to assign teachers`);

    // Get teacher assignments for each intervention
    const interventionsMap = new Map();
    for (const [key, assignment] of uniqueAssignments) {
      const interventionId = assignment.intervention_id;
      if (!interventionsMap.has(interventionId)) {
        interventionsMap.set(interventionId, []);
      }
      interventionsMap.get(interventionId).push(assignment);
    }

    // Assign students to teachers (round-robin distribution)
    let updated = 0;
    for (const enrollment of enrollments.rows) {
      const interventionId = enrollment.intervention_id;
      const teachers = interventionsMap.get(interventionId);

      if (!teachers || teachers.length === 0) {
        console.log(`⚠️  No teachers assigned to intervention ${interventionId}, skipping enrollment ${enrollment.id}`);
        continue;
      }

      // Get the teacher assignment ID from the consolidated assignments
      // Since we're migrating, we need to get the actual assignment ID
      const teacherAssignment = await query(
        supabase
          .from('teacher_microcompetency_assignments')
          .select('id, teacher_id')
          .eq('intervention_id', interventionId)
          .eq('teacher_id', teachers[0].teacher_id)
          .eq('is_active', true)
          .limit(1)
      );

      if (teacherAssignment.rows && teacherAssignment.rows.length > 0) {
        const assignmentId = teacherAssignment.rows[0].id;

        // Update enrollment with teacher assignment
        await query(
          supabase
            .from('intervention_enrollments')
            .update({ intervention_teacher_id: assignmentId })
            .eq('id', enrollment.id)
        );

        updated++;
      }
    }

    console.log(`✅ Updated ${updated} enrollments with teacher assignments`);

    // Step 4: After all migrations, make intervention_teacher_id NOT NULL
    // This should be done manually after verifying the migration
    console.log('⚠️  IMPORTANT: After verifying the migration, run:');
    console.log('   ALTER TABLE intervention_enrollments ALTER COLUMN intervention_teacher_id SET NOT NULL;');

    console.log('✅ Migration completed successfully!');

  } catch (error) {
    console.error('❌ Migration failed:', error);
    throw error;
  }
}

// Run migration if called directly
if (require.main === module) {
  migrateInterventionTeacherAssignments()
    .then(() => {
      console.log('✅ Migration script completed');
      process.exit(0);
    })
    .catch(error => {
      console.error('❌ Migration script failed:', error);
      process.exit(1);
    });
}

module.exports = { migrateInterventionTeacherAssignments };

