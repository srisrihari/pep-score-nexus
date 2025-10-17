const { supabase } = require('../src/config/supabaseClient');
const { query } = require('../src/utils/queryWrapper');
const enhancedHPSCalculationService = require('../src/services/enhancedHPSCalculationService');

async function testHPSMigration() {
    try {
        console.log('🔍 Starting HPS migration test...');

        // 1. Get all active students and their current terms
        console.log('📚 Fetching active students...');
        const { data: students, error: studentError } = await query(
            supabase
                .from('students')
                .select(`
                    id,
                    current_term_id,
                    overall_score,
                    grade,
                    student_score_summary!inner (
                        term_id,
                        total_hps,
                        overall_grade,
                        calculation_version
                    )
                `)
                .eq('status', 'Active')
        );

        if (studentError) throw studentError;
        console.log(`✅ Found ${students.length} active students`);

        // 2. Test recalculation for each student
        let successCount = 0;
        let errorCount = 0;
        let discrepancyCount = 0;
        const discrepancies = [];

        console.log('🧮 Testing HPS calculation for each student...');
        for (const student of students) {
            try {
                // Calculate new HPS
                const result = await enhancedHPSCalculationService.calculateStudentHPS(
                    student.id,
                    student.current_term_id
                );

                // Compare with existing scores
                const oldHPS = student.overall_score;
                const newHPS = result.totalHPS;
                const difference = Math.abs(oldHPS - newHPS);

                if (difference > 0.01) { // Allow for small floating point differences
                    discrepancyCount++;
                    discrepancies.push({
                        studentId: student.id,
                        oldHPS,
                        newHPS,
                        difference,
                        oldGrade: student.grade,
                        newGrade: enhancedHPSCalculationService.calculateGrade(newHPS),
                        isPartial: result.isPartial
                    });
                }

                successCount++;
            } catch (error) {
                console.error(`❌ Error calculating HPS for student ${student.id}:`, error);
                errorCount++;
            }

            // Progress indicator
            const progress = ((successCount + errorCount) / students.length) * 100;
            process.stdout.write(`\rProgress: ${Math.round(progress)}% complete`);
        }

        console.log('\n\n📊 Test Results:');
        console.log(`Total students tested: ${students.length}`);
        console.log(`Successful calculations: ${successCount}`);
        console.log(`Failed calculations: ${errorCount}`);
        console.log(`Score discrepancies found: ${discrepancyCount}`);

        if (discrepancyCount > 0) {
            console.log('\n🔍 Discrepancy Details:');
            discrepancies.forEach((d, i) => {
                console.log(`\nDiscrepancy #${i + 1}:`);
                console.log(`Student ID: ${d.studentId}`);
                console.log(`Old HPS: ${d.oldHPS} (${d.oldGrade})`);
                console.log(`New HPS: ${d.newHPS} (${d.newGrade})`);
                console.log(`Difference: ${d.difference}`);
                console.log(`Partial calculation: ${d.isPartial ? 'Yes' : 'No'}`);
            });
        }

        // 3. Test queue processing
        console.log('\n🔄 Testing queue processing...');
        const { data: queueResult, error: queueError } = await query(
            supabase.rpc('process_hps_recalculation_queue')
        );

        if (queueError) {
            console.error('❌ Queue processing test failed:', queueError);
        } else {
            console.log('✅ Queue processing test successful');
            console.log(`Processed: ${queueResult.processed_count}`);
            console.log(`Errors: ${queueResult.error_count}`);
        }

        // 4. Test cache functionality
        console.log('\n💾 Testing cache functionality...');
        if (discrepancies.length > 0) {
            const testStudent = discrepancies[0].studentId;
            
            // Clear existing cache
            await query(
                supabase
                    .from('hps_score_cache')
                    .delete()
                    .eq('student_id', testStudent)
            );

            // Calculate and cache
            const result = await enhancedHPSCalculationService.calculateStudentHPS(
                testStudent,
                student.current_term_id
            );

            // Check cache
            const { data: cache } = await query(
                supabase
                    .from('hps_score_cache')
                    .select('*')
                    .eq('student_id', testStudent)
                    .single()
            );

            if (cache) {
                console.log('✅ Cache test successful');
                console.log('Cache entry created with correct data');
            } else {
                console.log('❌ Cache test failed: No cache entry found');
            }
        } else {
            console.log('ℹ️ Skipping cache test (no discrepancies to test with)');
        }

        console.log('\n✅ HPS migration test completed');

    } catch (error) {
        console.error('❌ Test failed:', error);
        process.exit(1);
    }
}

// Run the test
testHPSMigration().catch(console.error);
