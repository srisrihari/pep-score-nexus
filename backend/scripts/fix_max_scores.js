// Load environment variables first
require('dotenv').config({ path: require('path').join(__dirname, '../.env') });

const { query } = require('../src/config/supabase');
const { createClient } = require('@supabase/supabase-js');

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY
);

/**
 * Fix max_score values for all intervention microcompetencies to 5
 * Also normalize existing scores if max_score was different
 */
async function fixMaxScores() {
  try {
    console.log('\n📊 Fixing Max Scores for All Interventions\n');
    console.log('='.repeat(80));
    
    // Get all intervention microcompetencies with their current max_score
    const interventionMicrocompsResult = await query(
      supabase
        .from('intervention_microcompetencies')
        .select(`
          id,
          intervention_id,
          microcompetency_id,
          max_score,
          interventions!inner(
            id,
            name,
            term_id,
            terms!inner(name)
          )
        `)
        .in('interventions.term_id', 
          (await query(supabase.from('terms').select('id').in('name', ['Level 0', 'Level 1', 'Level 2', 'Level 3']).eq('is_active', true))).rows.map(t => t.id)
        )
    );
    
    console.log(`📚 Found ${interventionMicrocompsResult.rows.length} intervention microcompetencies\n`);
    
    // Group by max_score to see distribution
    const maxScoreDistribution = {};
    interventionMicrocompsResult.rows.forEach(im => {
      const maxScore = parseFloat(im.max_score);
      if (!maxScoreDistribution[maxScore]) {
        maxScoreDistribution[maxScore] = 0;
      }
      maxScoreDistribution[maxScore]++;
    });
    
    console.log('📊 Current Max Score Distribution:');
    Object.entries(maxScoreDistribution).sort((a, b) => parseFloat(b[0]) - parseFloat(a[0])).forEach(([maxScore, count]) => {
      console.log(`  Max Score ${maxScore}: ${count} microcompetencies`);
    });
    
    // Find interventions that need fixing
    const needsFixing = interventionMicrocompsResult.rows.filter(im => {
      const maxScore = parseFloat(im.max_score);
      return maxScore !== 5;
    });
    
    console.log(`\n🔧 Found ${needsFixing.length} microcompetencies that need max_score fixed\n`);
    
    if (needsFixing.length === 0) {
      console.log('✅ All max_scores are already set to 5!');
      return { fixed: 0, normalized: 0 };
    }
    
    // Group by intervention for reporting
    const byIntervention = {};
    needsFixing.forEach(im => {
      const interventionName = im.interventions.name;
      if (!byIntervention[interventionName]) {
        byIntervention[interventionName] = [];
      }
      byIntervention[interventionName].push({
        id: im.id,
        max_score: parseFloat(im.max_score),
        microcompetency_id: im.microcompetency_id
      });
    });
    
    console.log('📋 Interventions Needing Fixes:');
    Object.entries(byIntervention).forEach(([interventionName, microcomps]) => {
      const uniqueMaxScores = [...new Set(microcomps.map(m => m.max_score))];
      console.log(`  ${interventionName}: ${microcomps.length} microcompetencies (max_score: ${uniqueMaxScores.join(', ')})`);
    });
    
    // Fix max_score values and normalize scores
    let fixedCount = 0;
    let normalizedScoreCount = 0;
    
    for (const im of needsFixing) {
      const oldMaxScore = parseFloat(im.max_score);
      const newMaxScore = 5;
      
      // Update intervention_microcompetencies max_score
      const { error: updateError } = await supabase
        .from('intervention_microcompetencies')
        .update({ max_score: newMaxScore })
        .eq('id', im.id);
      
      if (updateError) {
        console.error(`  ❌ Failed to update intervention_microcompetency ${im.id}:`, updateError.message);
        continue;
      }
      
      fixedCount++;
      
      // Normalize existing scores if max_score was different
      if (oldMaxScore !== newMaxScore) {
        // Get all scores for this intervention-microcompetency combination
        const scoresResult = await query(
          supabase
            .from('microcompetency_scores')
            .select('id, obtained_score, max_score')
            .eq('intervention_id', im.intervention_id)
            .eq('microcompetency_id', im.microcompetency_id)
        );
        
        if (scoresResult.rows && scoresResult.rows.length > 0) {
          // Normalize scores
          for (const score of scoresResult.rows) {
            const oldScoreMax = parseFloat(score.max_score);
            const obtainedScore = parseFloat(score.obtained_score);
            
            // Calculate normalized score
            // If old max was 10 and score is 8, normalized to 5 scale: (8/10) * 5 = 4
            // If old max was 100 and score is 80, normalized to 5 scale: (80/100) * 5 = 4
            let normalizedScore = obtainedScore;
            
            if (oldScoreMax !== newMaxScore && oldScoreMax > 0) {
              // Convert to percentage first, then to new scale
              const percentage = (obtainedScore / oldScoreMax) * 100;
              normalizedScore = (percentage / 100) * newMaxScore;
            }
            
            // Update score
            const { error: scoreUpdateError } = await supabase
              .from('microcompetency_scores')
              .update({
                obtained_score: normalizedScore,
                max_score: newMaxScore
              })
              .eq('id', score.id);
            
            if (scoreUpdateError) {
              console.error(`    ❌ Failed to normalize score ${score.id}:`, scoreUpdateError.message);
            } else {
              normalizedScoreCount++;
            }
          }
        }
      }
    }
    
    console.log(`\n✅ Fixed ${fixedCount} intervention microcompetency max_scores`);
    console.log(`✅ Normalized ${normalizedScoreCount} existing scores`);
    
    // Verify fixes
    console.log('\n🔍 Verification:');
    const verificationResult = await query(
      supabase
        .from('intervention_microcompetencies')
        .select('max_score')
        .in('intervention_id', 
          (await query(supabase.from('interventions').select('id').in('term_id', 
            (await query(supabase.from('terms').select('id').in('name', ['Level 0', 'Level 1', 'Level 2', 'Level 3']).eq('is_active', true))).rows.map(t => t.id)
          ))).rows.map(i => i.id)
        )
    );
    
    const verificationDistribution = {};
    verificationResult.rows.forEach(im => {
      const maxScore = parseFloat(im.max_score);
      if (!verificationDistribution[maxScore]) {
        verificationDistribution[maxScore] = 0;
      }
      verificationDistribution[maxScore]++;
    });
    
    console.log('📊 Max Score Distribution After Fix:');
    Object.entries(verificationDistribution).sort((a, b) => parseFloat(b[0]) - parseFloat(a[0])).forEach(([maxScore, count]) => {
      console.log(`  Max Score ${maxScore}: ${count} microcompetencies`);
    });
    
    const stillNeedsFixing = Object.keys(verificationDistribution).filter(ms => parseFloat(ms) !== 5);
    if (stillNeedsFixing.length > 0) {
      console.log(`\n⚠️  Still have max_scores that are not 5: ${stillNeedsFixing.join(', ')}`);
    } else {
      console.log('\n✅ All max_scores are now set to 5!');
    }
    
    return { fixed: fixedCount, normalized: normalizedScoreCount };
    
  } catch (error) {
    console.error('❌ Error fixing max scores:', error);
    throw error;
  }
}

// Run if executed directly
if (require.main === module) {
  fixMaxScores()
    .then(() => {
      console.log('\n✅ Max score fix completed');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ Max score fix failed:', error);
      process.exit(1);
    });
}

module.exports = { fixMaxScores };



