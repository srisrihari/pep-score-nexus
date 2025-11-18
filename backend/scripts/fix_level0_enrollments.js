// Load environment variables first
require('dotenv').config({ path: require('path').join(__dirname, '../.env') });

const { query } = require('../src/config/supabase');
const { createClient } = require('@supabase/supabase-js');

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY
);

/**
 * Fix enrollments and teacher assignments for Level 0 interventions
 */
async function fixLevel0Enrollments() {
  try {
    console.log('\n📊 Fixing Level 0 Intervention Enrollments\n');
    console.log('='.repeat(80));
    
    // Get Level 0 term
    const termResult = await query(
      supabase
        .from('terms')
        .select('id, name')
        .eq('name', 'Level 0')
        .eq('is_active', true)
        .limit(1)
    );
    
    if (!termResult.rows || termResult.rows.length === 0) {
      throw new Error('Level 0 term not found');
    }
    
    const termId = termResult.rows[0].id;
    console.log(`✅ Found Level 0 term: ${termId}`);
    
    // Get all Level 0 interventions
    const interventionsResult = await query(
      supabase
        .from('interventions')
        .select('id, name')
        .eq('term_id', termId)
    );
    
    console.log(`\n📚 Found ${interventionsResult.rows.length} Level 0 interventions:`);
    interventionsResult.rows.forEach(i => {
      console.log(`  - ${i.name} (${i.id})`);
    });
    
    // Get all students
    const studentsResult = await query(
      supabase
        .from('students')
        .select('id, registration_no, name')
        .eq('status', 'Active')
        .order('registration_no')
    );
    
    console.log(`\n📚 Found ${studentsResult.rows.length} students`);
    
    // Get teacher (Raj)
    const teacherResult = await query(
      supabase
        .from('teachers')
        .select('id, name')
        .ilike('name', '%raj%')
        .limit(1)
    );
    
    if (!teacherResult.rows || teacherResult.rows.length === 0) {
      throw new Error('Teacher Raj not found');
    }
    
    const teacherId = teacherResult.rows[0].id;
    console.log(`✅ Found teacher: ${teacherResult.rows[0].name} (${teacherId})`);
    
    // Get admin user
    const adminResult = await query(
      supabase
        .from('users')
        .select('id')
        .eq('role', 'admin')
        .limit(1)
    );
    
    if (!adminResult.rows || adminResult.rows.length === 0) {
      throw new Error('No admin user found');
    }
    
    const adminId = adminResult.rows[0].id;
    
    // Process each intervention
    for (const intervention of interventionsResult.rows) {
      console.log(`\n📅 Processing: ${intervention.name}`);
      
      // Check existing enrollments
      const existingEnrollments = await query(
        supabase
          .from('student_interventions')
          .select('student_id')
          .eq('intervention_id', intervention.id)
      );
      
      const enrolledStudentIds = new Set((existingEnrollments.rows || []).map(e => e.student_id));
      const studentsToEnroll = studentsResult.rows.filter(s => !enrolledStudentIds.has(s.id));
      
      if (studentsToEnroll.length > 0) {
        console.log(`  📝 Enrolling ${studentsToEnroll.length} students...`);
        
        const enrollments = studentsToEnroll.map(s => ({
          student_id: s.id,
          intervention_id: intervention.id,
          enrollment_date: new Date().toISOString(),
          status: 'Enrolled'
        }));
        
        const { error: enrollError } = await supabase
          .from('student_interventions')
          .insert(enrollments);
        
        if (enrollError) {
          console.error(`  ❌ Failed to enroll students: ${enrollError.message}`);
        } else {
          console.log(`  ✅ Enrolled ${enrollments.length} students`);
        }
      } else {
        console.log(`  ✅ All students already enrolled`);
      }
      
      // Check teacher assignment
      const existingTeacher = await query(
        supabase
          .from('intervention_teachers')
          .select('id')
          .eq('intervention_id', intervention.id)
          .eq('teacher_id', teacherId)
          .limit(1)
      );
      
      if (!existingTeacher.rows || existingTeacher.rows.length === 0) {
        console.log(`  📝 Assigning teacher...`);
        
        const { error: assignError } = await supabase
          .from('intervention_teachers')
          .insert({
            teacher_id: teacherId,
            intervention_id: intervention.id,
            assigned_quadrants: [],
            role: 'Lead',
            permissions: [],
            assigned_by: adminId,
            is_active: true,
            assigned_at: new Date().toISOString()
          });
        
        if (assignError) {
          console.error(`  ❌ Failed to assign teacher: ${assignError.message}`);
        } else {
          console.log(`  ✅ Assigned teacher`);
        }
      } else {
        console.log(`  ✅ Teacher already assigned`);
      }
    }
    
    // Verify enrollments
    console.log('\n\n📊 Verification:');
    const verificationResult = await query(
      supabase
        .from('interventions')
        .select(`
          id,
          name,
          student_interventions(count),
          intervention_teachers!inner(teacher_id)
        `)
        .eq('term_id', termId)
    );
    
    verificationResult.rows.forEach(i => {
      const enrollmentCount = i.student_interventions?.[0]?.count || 0;
      const teacherCount = i.intervention_teachers?.length || 0;
      console.log(`  ${i.name}: ${enrollmentCount} students, ${teacherCount} teachers`);
    });
    
    console.log('\n✅ Level 0 enrollment fix completed!');
    
  } catch (error) {
    console.error('❌ Error fixing Level 0 enrollments:', error);
    throw error;
  }
}

// Run if executed directly
if (require.main === module) {
  fixLevel0Enrollments()
    .then(() => {
      console.log('\n✅ Enrollment fix completed');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ Enrollment fix failed:', error);
      process.exit(1);
    });
}

module.exports = { fixLevel0Enrollments };

