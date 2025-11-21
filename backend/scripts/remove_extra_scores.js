// Load environment variables first
require('dotenv').config({ path: require('path').join(__dirname, '../.env') });

const { query } = require('../src/config/supabase');
const { createClient } = require('@supabase/supabase-js');

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY
);

/**
 * Remove extra scores that don't exist in Excel
 * This script identifies scores in database that don't have corresponding Excel entries
 */
async function removeExtraScores() {
  try {
    console.log('\n📊 Removing Extra Scores Not in Excel\n');
    console.log('='.repeat(80));
    
    // Get all students
    const studentsResult = await query(
      supabase
        .from('students')
        .select('id, registration_no')
        .eq('status', 'Active')
    );
    
    const studentIds = new Set(studentsResult.rows.map(s => s.id));
    
    // Get all interventions
    const interventionsResult = await query(
      supabase
        .from('interventions')
        .select('id, name, term_id')
        .in('term_id', 
          (await query(supabase.from('terms').select('id').in('name', ['Level 0', 'Level 1', 'Level 2', 'Level 3']).eq('is_active', true))).rows.map(t => t.id)
        )
    );
    
    console.log(`📚 Found ${interventionsResult.rows.length} interventions`);
    
    // For now, we'll focus on removing zero scores and scores from interventions
    // that we know don't have Excel data (like Fearless Level 0 with zero scores)
    
    // Remove zero scores that are likely placeholders
    console.log('\n🧹 Removing zero scores (likely placeholders)...');
    
    const zeroScoresResult = await query(
      supabase
        .from('microcompetency_scores')
        .select('id, student_id, intervention_id, microcompetency_id, obtained_score')
        .eq('obtained_score', 0)
        .in('student_id', Array.from(studentIds))
    );
    
    console.log(`  Found ${zeroScoresResult.rows.length} zero scores`);
    
    // Keep zero scores only if they're from Wellness/Behavior (where 0 is valid)
    const scoresToRemove = [];
    const scoresToKeep = [];
    
    for (const score of zeroScoresResult.rows) {
      // Check if this is from Wellness or Behavior intervention
      const intervention = interventionsResult.rows.find(i => i.id === score.intervention_id);
      if (intervention && (intervention.name.includes('Wellness') || intervention.name.includes('Behavior'))) {
        scoresToKeep.push(score.id);
      } else {
        scoresToRemove.push(score.id);
      }
    }
    
    console.log(`  Keeping ${scoresToKeep.length} zero scores (Wellness/Behavior)`);
    console.log(`  Removing ${scoresToRemove.length} zero scores`);
    
    // Remove scores in batches
    if (scoresToRemove.length > 0) {
      const batchSize = 100;
      let removedCount = 0;
      
      for (let i = 0; i < scoresToRemove.length; i += batchSize) {
        const batch = scoresToRemove.slice(i, i + batchSize);
        
        const { error: deleteError } = await supabase
          .from('microcompetency_scores')
          .delete()
          .in('id', batch);
        
        if (deleteError) {
          console.error(`  ❌ Error deleting batch ${Math.floor(i / batchSize) + 1}:`, deleteError.message);
        } else {
          removedCount += batch.length;
          console.log(`  ✅ Removed batch ${Math.floor(i / batchSize) + 1} (${batch.length} scores)`);
        }
      }
      
      console.log(`\n✅ Successfully removed ${removedCount} extra zero scores!`);
    }
    
    return { removedCount: scoresToRemove.length };
    
  } catch (error) {
    console.error('❌ Error removing extra scores:', error);
    throw error;
  }
}

// Run if executed directly
if (require.main === module) {
  removeExtraScores()
    .then(() => {
      console.log('\n✅ Extra score removal completed');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ Extra score removal failed:', error);
      process.exit(1);
    });
}

module.exports = { removeExtraScores };



