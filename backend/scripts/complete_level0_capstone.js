// Load environment variables first
require('dotenv').config({ path: require('path').join(__dirname, '../.env') });

const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');
const { query } = require('../src/config/supabase');
const { createClient } = require('@supabase/supabase-js');

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY
);

/**
 * Complete Level 0 Capstone setup: assign teacher, enroll students, import scores
 */
async function completeLevel0Capstone() {
  try {
    console.log('\n📊 Completing Level 0 Capstone Setup\n');
    console.log('='.repeat(80));
    
    // Get Capstone intervention
    const capstoneResult = await query(
      supabase
        .from('interventions')
        .select('id, name, term_id')
        .ilike('name', '%capstone%level 0%')
        .limit(1)
    );
    
    if (!capstoneResult.rows || capstoneResult.rows.length === 0) {
      throw new Error('Capstone (Level 0) intervention not found');
    }
    
    const capstoneIntervention = capstoneResult.rows[0];
    console.log(`✅ Found Capstone intervention: ${capstoneIntervention.name} (${capstoneIntervention.id})`);
    
    const termId = capstoneIntervention.term_id;
    
    // Get teacher ID (Raj)
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
    
    // Check if teacher is already assigned
    const existingAssignment = await query(
      supabase
        .from('intervention_teachers')
        .select('id')
        .eq('intervention_id', capstoneIntervention.id)
        .eq('teacher_id', teacherId)
        .limit(1)
    );
    
    if (!existingAssignment.rows || existingAssignment.rows.length === 0) {
      // Get admin user for assigned_by
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
      
      // Assign teacher (using correct table structure)
      const teacherAssignment = {
        teacher_id: teacherId,
        intervention_id: capstoneIntervention.id,
        assigned_quadrants: [], // Empty array for all quadrants
        role: 'Lead',
        permissions: [],
        assigned_by: adminId,
        is_active: true,
        assigned_at: new Date().toISOString()
      };
      
      const { error: assignError } = await supabase
        .from('intervention_teachers')
        .insert(teacherAssignment);
      
      if (assignError) {
        throw new Error(`Failed to assign teacher: ${assignError.message}`);
      }
      
      console.log(`✅ Assigned teacher to intervention`);
    } else {
      console.log(`✅ Teacher already assigned`);
    }
    
    // Get all students
    const studentsResult = await query(
      supabase
        .from('students')
        .select('id, registration_no, name')
        .eq('status', 'Active')
        .order('registration_no')
    );
    
    console.log(`\n📚 Found ${studentsResult.rows.length} students`);
    
    // Check existing enrollments
    const existingEnrollments = await query(
      supabase
        .from('student_interventions')
        .select('student_id')
        .eq('intervention_id', capstoneIntervention.id)
    );
    
    const enrolledStudentIds = new Set((existingEnrollments.rows || []).map(e => e.student_id));
    const studentsToEnroll = studentsResult.rows.filter(s => !enrolledStudentIds.has(s.id));
    
    if (studentsToEnroll.length > 0) {
      // Enroll students (using correct table structure)
      const enrollments = studentsToEnroll.map(s => ({
        student_id: s.id,
        intervention_id: capstoneIntervention.id,
        enrollment_date: new Date().toISOString(),
        status: 'Enrolled'
      }));
      
      const { error: enrollError } = await supabase
        .from('student_interventions')
        .insert(enrollments);
      
      if (enrollError) {
        throw new Error(`Failed to enroll students: ${enrollError.message}`);
      }
      
      console.log(`✅ Enrolled ${enrollments.length} students`);
    } else {
      console.log(`✅ All students already enrolled`);
    }
    
    // Check if scores already exist
    const existingScores = await query(
      supabase
        .from('microcompetency_scores')
        .select('id')
        .eq('intervention_id', capstoneIntervention.id)
        .limit(1)
    );
    
    if (existingScores.rows && existingScores.rows.length > 0) {
      console.log(`\n✅ Scores already imported`);
      return;
    }
    
    // Get microcompetencies for Capstone
    const microcompNames = ['A4', 'C2', 'C3', 'C5', 'E2', 'L1', 'N4'];
    const microcompResult = await query(
      supabase
        .from('microcompetencies')
        .select('id, name')
        .in('name', microcompNames)
    );
    
    console.log(`\n📋 Found ${microcompResult.rows.length} microcompetencies`);
    
    // Parse Capstone scores from Excel
    console.log('\n📊 Parsing Capstone scores from Excel...');
    const capstonePath = path.join(__dirname, '../../test_data_2/Level 0 Capstone(1).xlsx');
    const workbook = XLSX.readFile(capstonePath);
    const ws = workbook.Sheets[workbook.SheetNames[0]];
    const excelData = XLSX.utils.sheet_to_json(ws, { header: 1 });
    
    // Header row
    const headers = excelData[0];
    const regNoCol = headers.findIndex(h => h && h.toString().toLowerCase().includes('registration'));
    
    // Map microcompetency columns
    const microcompCols = {};
    headers.forEach((h, idx) => {
      if (h && h.toString().includes('Score')) {
        const mcName = h.toString().replace(' Score', '').trim();
        if (microcompNames.includes(mcName)) {
          microcompCols[mcName] = idx;
        }
      }
    });
    
    console.log('  Microcompetency columns:', Object.keys(microcompCols).join(', '));
    
    // Import scores
    const scores = [];
    for (let i = 1; i < excelData.length; i++) {
      const row = excelData[i];
      const regNo = row[regNoCol];
      
      if (!regNo) continue;
      
      const student = studentsResult.rows.find(s => s.registration_no === regNo);
      if (!student) {
        console.warn(`⚠️  Student not found: ${regNo}`);
        continue;
      }
      
      Object.entries(microcompCols).forEach(([mcName, colIdx]) => {
        const score = row[colIdx];
        if (score !== undefined && score !== null && !isNaN(score)) {
          const mc = microcompResult.rows.find(m => m.name === mcName);
          if (mc) {
            scores.push({
              student_id: student.id,
              intervention_id: capstoneIntervention.id,
              microcompetency_id: mc.id,
              obtained_score: score,
              max_score: 5,
              scored_by: teacherId,
              scored_at: new Date().toISOString(),
              feedback: '',
              status: 'Submitted',
              term_id: termId
            });
          }
        }
      });
    }
    
    console.log(`\n📝 Importing ${scores.length} scores...`);
    
    // Insert scores in batches
    const batchSize = 100;
    let importedCount = 0;
    for (let i = 0; i < scores.length; i += batchSize) {
      const batch = scores.slice(i, i + batchSize);
      const { error: scoreError } = await supabase
        .from('microcompetency_scores')
        .upsert(batch, { onConflict: 'student_id,intervention_id,microcompetency_id' });
      
      if (scoreError) {
        console.error(`❌ Error inserting batch ${i / batchSize + 1}:`, scoreError.message);
        // Try individual inserts for this batch
        for (const score of batch) {
          const { error: individualError } = await supabase
            .from('microcompetency_scores')
            .upsert(score, { onConflict: 'student_id,intervention_id,microcompetency_id' });
          
          if (individualError) {
            console.error(`  ❌ Failed to insert score for student ${score.student_id}, microcomp ${score.microcompetency_id}:`, individualError.message);
          } else {
            importedCount++;
          }
        }
      } else {
        importedCount += batch.length;
        console.log(`  ✅ Inserted batch ${i / batchSize + 1} (${batch.length} scores)`);
      }
    }
    
    console.log(`\n✅ Successfully imported ${importedCount} scores!`);
    
  } catch (error) {
    console.error('❌ Error completing Level 0 Capstone:', error);
    throw error;
  }
}

// Run if executed directly
if (require.main === module) {
  completeLevel0Capstone()
    .then(() => {
      console.log('\n✅ Level 0 Capstone setup completed');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ Level 0 Capstone setup failed:', error);
      process.exit(1);
    });
}

module.exports = { completeLevel0Capstone };

