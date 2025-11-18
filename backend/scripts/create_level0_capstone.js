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
 * Create Level 0 Capstone intervention and import scores
 */
async function createLevel0Capstone() {
  try {
    console.log('\n📊 Creating Level 0 Capstone Intervention\n');
    console.log('='.repeat(80));
    
    // Get Level 0 term
    const termResult = await query(
      supabase
        .from('terms')
        .select('id, name, start_date, end_date')
        .eq('name', 'Level 0')
        .limit(1)
    );
    
    if (!termResult.rows || termResult.rows.length === 0) {
      throw new Error('Level 0 term not found');
    }
    
    const term = termResult.rows[0];
    console.log(`✅ Found Level 0 term: ${term.name} (${term.id})`);
    
    // Check if Capstone intervention already exists
    const existingCapstone = await query(
      supabase
        .from('interventions')
        .select('id, name')
        .eq('term_id', term.id)
        .ilike('name', '%capstone%')
        .limit(1)
    );
    
    if (existingCapstone.rows && existingCapstone.rows.length > 0) {
      console.log(`⚠️  Capstone intervention already exists: ${existingCapstone.rows[0].name} (${existingCapstone.rows[0].id})`);
      return existingCapstone.rows[0].id;
    }
    
    // Get admin user for created_by
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
    console.log(`✅ Found admin user: ${adminId}`);
    
    // Create Capstone intervention
    console.log('\n📝 Creating Capstone intervention...');
    const capstoneIntervention = {
      name: 'Capstone (Level 0)',
      description: 'Level 0 Capstone intervention',
      term_id: term.id,
      start_date: term.start_date,
      end_date: term.end_date,
      status: 'Active',
      is_scoring_open: true,
      created_by: adminId,
      created_at: new Date().toISOString()
    };
    
    const { data: newIntervention, error: interventionError } = await supabase
      .from('interventions')
      .insert(capstoneIntervention)
      .select()
      .single();
    
    if (interventionError) {
      throw new Error(`Failed to create intervention: ${interventionError.message}`);
    }
    
    console.log(`✅ Created Capstone intervention: ${newIntervention.id}`);
    
    // Get microcompetencies for Capstone (A4, C2, C3, C5, E2, L1, N4)
    const microcompNames = ['A4', 'C2', 'C3', 'C5', 'E2', 'L1', 'N4'];
    const microcompResult = await query(
      supabase
        .from('microcompetencies')
        .select('id, name')
        .in('name', microcompNames)
    );
    
    console.log(`\n📋 Found ${microcompResult.rows.length} microcompetencies:`, microcompResult.rows.map(m => m.name).join(', '));
    
    if (microcompResult.rows.length === 0) {
      throw new Error('No microcompetencies found for Capstone');
    }
    
    // Link microcompetencies to intervention
    console.log('\n🔗 Linking microcompetencies to intervention...');
    const interventionMicrocomps = microcompResult.rows.map(mc => ({
      intervention_id: newIntervention.id,
      microcompetency_id: mc.id,
      weightage: 10.00, // Default weightage
      max_score: 5,
      is_active: true,
      created_at: new Date().toISOString()
    }));
    
    const { error: linkError } = await supabase
      .from('intervention_microcompetencies')
      .insert(interventionMicrocomps);
    
    if (linkError) {
      throw new Error(`Failed to link microcompetencies: ${linkError.message}`);
    }
    
    console.log(`✅ Linked ${interventionMicrocomps.length} microcompetencies`);
    
    // Get teacher ID (Raj)
    const teacherResult = await query(
      supabase
        .from('teachers')
        .select('id')
        .ilike('name', '%raj%')
        .limit(1)
    );
    
    if (!teacherResult.rows || teacherResult.rows.length === 0) {
      throw new Error('Teacher Raj not found');
    }
    
    const teacherId = teacherResult.rows[0].id;
    console.log(`✅ Found teacher: ${teacherId}`);
    
    // Assign teacher to intervention
    const teacherAssignment = {
      teacher_id: teacherId,
      intervention_id: newIntervention.id,
      can_score: true,
      can_create_tasks: true,
      term_id: term.id,
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
    
    // Get all students
    const studentsResult = await query(
      supabase
        .from('students')
        .select('id, registration_no, name')
        .eq('status', 'Active')
        .order('registration_no')
    );
    
    console.log(`\n📚 Found ${studentsResult.rows.length} students`);
    
    // Enroll all students
    const enrollments = studentsResult.rows.map(s => ({
      student_id: s.id,
      intervention_id: newIntervention.id,
      term_id: term.id,
      enrollment_date: new Date().toISOString(),
      enrollment_status: 'Enrolled',
      enrollment_type: 'Regular'
    }));
    
    const { error: enrollError } = await supabase
      .from('student_interventions')
      .insert(enrollments);
    
    if (enrollError) {
      throw new Error(`Failed to enroll students: ${enrollError.message}`);
    }
    
    console.log(`✅ Enrolled ${enrollments.length} students`);
    
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
    
    console.log('  Microcompetency columns:', microcompCols);
    
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
              intervention_id: newIntervention.id,
              microcompetency_id: mc.id,
              obtained_score: score,
              max_score: 5,
              scored_by: teacherId,
              scored_at: new Date().toISOString(),
              feedback: '',
              status: 'Submitted',
              term_id: term.id
            });
          }
        }
      });
    }
    
    console.log(`\n📝 Importing ${scores.length} scores...`);
    
    // Insert scores in batches
    const batchSize = 100;
    for (let i = 0; i < scores.length; i += batchSize) {
      const batch = scores.slice(i, i + batchSize);
      const { error: scoreError } = await supabase
        .from('microcompetency_scores')
        .insert(batch);
      
      if (scoreError) {
        console.error(`❌ Error inserting batch ${i / batchSize + 1}:`, scoreError.message);
        // Try individual inserts for this batch
        for (const score of batch) {
          const { error: individualError } = await supabase
            .from('microcompetency_scores')
            .upsert(score, { onConflict: 'student_id,intervention_id,microcompetency_id' });
          
          if (individualError) {
            console.error(`  ❌ Failed to insert score for ${score.student_id}, ${score.microcompetency_id}:`, individualError.message);
          }
        }
      } else {
        console.log(`  ✅ Inserted batch ${i / batchSize + 1} (${batch.length} scores)`);
      }
    }
    
    console.log(`\n✅ Successfully created Level 0 Capstone intervention and imported scores!`);
    console.log(`   Intervention ID: ${newIntervention.id}`);
    console.log(`   Microcompetencies: ${microcompResult.rows.length}`);
    console.log(`   Scores imported: ${scores.length}`);
    
    return newIntervention.id;
  } catch (error) {
    console.error('❌ Error creating Level 0 Capstone:', error);
    throw error;
  }
}

// Run if executed directly
if (require.main === module) {
  createLevel0Capstone()
    .then(() => {
      console.log('\n✅ Level 0 Capstone creation completed');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ Level 0 Capstone creation failed:', error);
      process.exit(1);
    });
}

module.exports = { createLevel0Capstone };

