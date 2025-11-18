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
 * Create Wellness and Behavior interventions for all terms
 */
async function createWellnessBehaviorInterventions() {
  try {
    console.log('\n📊 Creating Wellness and Behavior Interventions\n');
    console.log('='.repeat(80));
    
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
    
    // Get all terms
    const termsResult = await query(
      supabase
        .from('terms')
        .select('id, name, start_date, end_date')
        .in('name', ['Level 0', 'Level 1', 'Level 2', 'Level 3'])
        .eq('is_active', true)
        .order('start_date')
    );
    
    console.log(`\n📚 Found ${termsResult.rows.length} terms\n`);
    
    // Get Wellness microcompetencies
    const wellnessMicrocompsResult = await query(
      supabase
        .from('microcompetencies')
        .select('id, name, max_score, component_id')
        .in('name', ['3KM Run', 'BCA', 'Beep test', 'Push Ups', 'Sit & reach', 'Sit Ups'])
    );
    
    console.log(`✅ Found ${wellnessMicrocompsResult.rows.length} Wellness microcompetencies`);
    
    // Get Wellness component/subcategory
    const wellnessComponentResult = await query(
      supabase
        .from('components')
        .select('id, name, sub_category_id')
        .eq('name', 'Fitness')
        .limit(1)
    );
    
    if (!wellnessComponentResult.rows || wellnessComponentResult.rows.length === 0) {
      throw new Error('Wellness Fitness component not found');
    }
    
    const wellnessComponentId = wellnessComponentResult.rows[0].id;
    const wellnessSubcategoryId = wellnessComponentResult.rows[0].sub_category_id;
    
    // Check if Behavior quadrant has structure, if not create it
    const behaviorQuadrantResult = await query(
      supabase
        .from('quadrants')
        .select('id')
        .eq('name', 'Behavior')
        .limit(1)
    );
    
    if (!behaviorQuadrantResult.rows || behaviorQuadrantResult.rows.length === 0) {
      throw new Error('Behavior quadrant not found');
    }
    
    const behaviorQuadrantId = behaviorQuadrantResult.rows[0].id;
    
    // Check if Behavior subcategory exists
    let behaviorSubcategoryId = null;
    const behaviorSubcategoryResult = await query(
      supabase
        .from('sub_categories')
        .select('id, name')
        .eq('quadrant_id', behaviorQuadrantId)
        .limit(1)
    );
    
    if (!behaviorSubcategoryResult.rows || behaviorSubcategoryResult.rows.length === 0) {
      // Create Behavior subcategory
      console.log('\n📝 Creating Behavior subcategory...');
      const { data: newSubcategory, error: subcatError } = await supabase
        .from('sub_categories')
        .insert({
          quadrant_id: behaviorQuadrantId,
          name: 'Professional Conduct',
          description: 'Professional conduct and behavior assessment',
          weightage: 100.00,
          display_order: 1,
          is_active: true
        })
        .select()
        .single();
      
      if (subcatError) {
        throw new Error(`Failed to create Behavior subcategory: ${subcatError.message}`);
      }
      
      behaviorSubcategoryId = newSubcategory.id;
      console.log(`✅ Created Behavior subcategory: ${behaviorSubcategoryId}`);
    } else {
      behaviorSubcategoryId = behaviorSubcategoryResult.rows[0].id;
      console.log(`✅ Found Behavior subcategory: ${behaviorSubcategoryId}`);
    }
    
    // Check if Behavior component exists
    let behaviorComponentId = null;
    const behaviorComponentResult = await query(
      supabase
        .from('components')
        .select('id, name')
        .eq('sub_category_id', behaviorSubcategoryId)
        .limit(1)
    );
    
    if (!behaviorComponentResult.rows || behaviorComponentResult.rows.length === 0) {
      // Create Behavior component
      console.log('\n📝 Creating Behavior component...');
      const { data: newComponent, error: compError } = await supabase
        .from('components')
        .insert({
          sub_category_id: behaviorSubcategoryId,
          name: 'Behavior Assessment',
          description: 'Overall behavior assessment',
          max_score: 5,
          weightage: 100.00,
          category: 'Professional',
          display_order: 1,
          is_active: true
        })
        .select()
        .single();
      
      if (compError) {
        throw new Error(`Failed to create Behavior component: ${compError.message}`);
      }
      
      behaviorComponentId = newComponent.id;
      console.log(`✅ Created Behavior component: ${behaviorComponentId}`);
    } else {
      behaviorComponentId = behaviorComponentResult.rows[0].id;
      console.log(`✅ Found Behavior component: ${behaviorComponentId}`);
    }
    
    // Check if Behavior microcompetency exists
    let behaviorMicrocompId = null;
    const behaviorMicrocompResult = await query(
      supabase
        .from('microcompetencies')
        .select('id, name')
        .eq('component_id', behaviorComponentId)
        .limit(1)
    );
    
    if (!behaviorMicrocompResult.rows || behaviorMicrocompResult.rows.length === 0) {
      // Create Behavior microcompetency
      console.log('\n📝 Creating Behavior microcompetency...');
      const { data: newMicrocomp, error: microcompError } = await supabase
        .from('microcompetencies')
        .insert({
          component_id: behaviorComponentId,
          name: 'Behavior Score',
          description: 'Overall behavior score',
          max_score: 5,
          weightage: 100.00,
          display_order: 1,
          is_active: true
        })
        .select()
        .single();
      
      if (microcompError) {
        throw new Error(`Failed to create Behavior microcompetency: ${microcompError.message}`);
      }
      
      behaviorMicrocompId = newMicrocomp.id;
      console.log(`✅ Created Behavior microcompetency: ${behaviorMicrocompId}`);
    } else {
      behaviorMicrocompId = behaviorMicrocompResult.rows[0].id;
      console.log(`✅ Found Behavior microcompetency: ${behaviorMicrocompId}`);
    }
    
    // Get all students
    const studentsResult = await query(
      supabase
        .from('students')
        .select('id, registration_no, name')
        .eq('status', 'Active')
        .order('registration_no')
    );
    
    console.log(`\n📚 Found ${studentsResult.rows.length} students\n`);
    
    // Create interventions for each term
    for (const term of termsResult.rows) {
      console.log(`\n📅 Processing term: ${term.name}`);
      
      // Create Wellness intervention
      const wellnessInterventionName = `Wellness (${term.name})`;
      let wellnessInterventionId = null;
      
      const existingWellness = await query(
        supabase
          .from('interventions')
          .select('id')
          .eq('term_id', term.id)
          .ilike('name', `%wellness%${term.name}%`)
          .limit(1)
      );
      
      if (existingWellness.rows && existingWellness.rows.length > 0) {
        wellnessInterventionId = existingWellness.rows[0].id;
        console.log(`  ⚠️  Wellness intervention already exists: ${wellnessInterventionId}`);
      } else {
        const { data: newWellnessIntervention, error: wellnessError } = await supabase
          .from('interventions')
          .insert({
            name: wellnessInterventionName,
            description: `${term.name} Wellness intervention`,
            term_id: term.id,
            start_date: term.start_date,
            end_date: term.end_date,
            status: 'Active',
            is_scoring_open: true,
            created_by: adminId,
            created_at: new Date().toISOString()
          })
          .select()
          .single();
        
        if (wellnessError) {
          console.error(`  ❌ Failed to create Wellness intervention: ${wellnessError.message}`);
          continue;
        }
        
        wellnessInterventionId = newWellnessIntervention.id;
        console.log(`  ✅ Created Wellness intervention: ${wellnessInterventionId}`);
        
        // Link Wellness microcompetencies
        const wellnessMicrocomps = wellnessMicrocompsResult.rows.map(mc => ({
          intervention_id: wellnessInterventionId,
          microcompetency_id: mc.id,
          weightage: 10.00,
          max_score: 5,
          is_active: true,
          created_at: new Date().toISOString()
        }));
        
        const { error: linkWellnessError } = await supabase
          .from('intervention_microcompetencies')
          .insert(wellnessMicrocomps);
        
        if (linkWellnessError) {
          console.error(`  ❌ Failed to link Wellness microcompetencies: ${linkWellnessError.message}`);
        } else {
          console.log(`  ✅ Linked ${wellnessMicrocomps.length} Wellness microcompetencies`);
        }
        
        // Assign teacher
        const { error: assignWellnessError } = await supabase
          .from('intervention_teachers')
          .insert({
            teacher_id: teacherId,
            intervention_id: wellnessInterventionId,
            assigned_quadrants: [],
            role: 'Lead',
            permissions: [],
            assigned_by: adminId,
            is_active: true,
            assigned_at: new Date().toISOString()
          });
        
        if (assignWellnessError) {
          console.error(`  ❌ Failed to assign teacher: ${assignWellnessError.message}`);
        } else {
          console.log(`  ✅ Assigned teacher to Wellness intervention`);
        }
        
        // Enroll students
        const wellnessEnrollments = studentsResult.rows.map(s => ({
          student_id: s.id,
          intervention_id: wellnessInterventionId,
          enrollment_date: new Date().toISOString(),
          status: 'Enrolled'
        }));
        
        const { error: enrollWellnessError } = await supabase
          .from('student_interventions')
          .insert(wellnessEnrollments);
        
        if (enrollWellnessError) {
          console.error(`  ❌ Failed to enroll students: ${enrollWellnessError.message}`);
        } else {
          console.log(`  ✅ Enrolled ${wellnessEnrollments.length} students`);
        }
      }
      
      // Create Behavior intervention
      const behaviorInterventionName = `Behavior (${term.name})`;
      let behaviorInterventionId = null;
      
      const existingBehavior = await query(
        supabase
          .from('interventions')
          .select('id')
          .eq('term_id', term.id)
          .ilike('name', `%behavior%${term.name}%`)
          .limit(1)
      );
      
      if (existingBehavior.rows && existingBehavior.rows.length > 0) {
        behaviorInterventionId = existingBehavior.rows[0].id;
        console.log(`  ⚠️  Behavior intervention already exists: ${behaviorInterventionId}`);
      } else {
        const { data: newBehaviorIntervention, error: behaviorError } = await supabase
          .from('interventions')
          .insert({
            name: behaviorInterventionName,
            description: `${term.name} Behavior intervention`,
            term_id: term.id,
            start_date: term.start_date,
            end_date: term.end_date,
            status: 'Active',
            is_scoring_open: true,
            created_by: adminId,
            created_at: new Date().toISOString()
          })
          .select()
          .single();
        
        if (behaviorError) {
          console.error(`  ❌ Failed to create Behavior intervention: ${behaviorError.message}`);
          continue;
        }
        
        behaviorInterventionId = newBehaviorIntervention.id;
        console.log(`  ✅ Created Behavior intervention: ${behaviorInterventionId}`);
        
        // Link Behavior microcompetency
        const { error: linkBehaviorError } = await supabase
          .from('intervention_microcompetencies')
          .insert({
            intervention_id: behaviorInterventionId,
            microcompetency_id: behaviorMicrocompId,
            weightage: 100.00,
            max_score: 5,
            is_active: true,
            created_at: new Date().toISOString()
          });
        
        if (linkBehaviorError) {
          console.error(`  ❌ Failed to link Behavior microcompetency: ${linkBehaviorError.message}`);
        } else {
          console.log(`  ✅ Linked Behavior microcompetency`);
        }
        
        // Assign teacher
        const { error: assignBehaviorError } = await supabase
          .from('intervention_teachers')
          .insert({
            teacher_id: teacherId,
            intervention_id: behaviorInterventionId,
            assigned_quadrants: [],
            role: 'Lead',
            permissions: [],
            assigned_by: adminId,
            is_active: true,
            assigned_at: new Date().toISOString()
          });
        
        if (assignBehaviorError) {
          console.error(`  ❌ Failed to assign teacher: ${assignBehaviorError.message}`);
        } else {
          console.log(`  ✅ Assigned teacher to Behavior intervention`);
        }
        
        // Enroll students
        const behaviorEnrollments = studentsResult.rows.map(s => ({
          student_id: s.id,
          intervention_id: behaviorInterventionId,
          enrollment_date: new Date().toISOString(),
          status: 'Enrolled'
        }));
        
        const { error: enrollBehaviorError } = await supabase
          .from('student_interventions')
          .insert(behaviorEnrollments);
        
        if (enrollBehaviorError) {
          console.error(`  ❌ Failed to enroll students: ${enrollBehaviorError.message}`);
        } else {
          console.log(`  ✅ Enrolled ${behaviorEnrollments.length} students`);
        }
      }
    }
    
    console.log('\n✅ Successfully created Wellness and Behavior interventions for all terms!');
    
    return {
      wellnessMicrocompIds: wellnessMicrocompsResult.rows.map(m => m.id),
      behaviorMicrocompId: behaviorMicrocompId
    };
    
  } catch (error) {
    console.error('❌ Error creating Wellness/Behavior interventions:', error);
    throw error;
  }
}

// Run if executed directly
if (require.main === module) {
  createWellnessBehaviorInterventions()
    .then(() => {
      console.log('\n✅ Wellness/Behavior intervention creation completed');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ Wellness/Behavior intervention creation failed:', error);
      process.exit(1);
    });
}

module.exports = { createWellnessBehaviorInterventions };

