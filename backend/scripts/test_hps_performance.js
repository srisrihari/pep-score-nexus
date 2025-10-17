const { supabase } = require('../src/config/supabaseClient');
const { query } = require('../src/utils/queryWrapper');
const enhancedHPSCalculationService = require('../src/services/enhancedHPSCalculationService');

async function measurePerformance(fn, name, ...args) {
    const start = process.hrtime.bigint();
    const result = await fn(...args);
    const end = process.hrtime.bigint();
    const duration = Number(end - start) / 1_000_000; // Convert to milliseconds
    return { result, duration };
}

async function testHPSPerformance() {
    try {
        console.log('🔍 Starting HPS performance test...');

        // 1. Get test data
        console.log('📚 Fetching test data...');
        const { data: students } = await query(
            supabase
                .from('students')
                .select('id, current_term_id')
                .eq('status', 'Active')
                .limit(100)
        );

        // 2. Test single calculation performance
        console.log('\n🧮 Testing single calculation performance...');
        const singleResults = [];
        for (let i = 0; i < 10; i++) {
            const student = students[i];
            const { duration } = await measurePerformance(
                enhancedHPSCalculationService.calculateStudentHPS.bind(enhancedHPSCalculationService),
                'Single Calculation',
                student.id,
                student.current_term_id
            );
            singleResults.push(duration);
        }

        const avgSingleDuration = singleResults.reduce((a, b) => a + b, 0) / singleResults.length;
        console.log(`Average single calculation time: ${avgSingleDuration.toFixed(2)}ms`);
        console.log(`Min: ${Math.min(...singleResults).toFixed(2)}ms`);
        console.log(`Max: ${Math.max(...singleResults).toFixed(2)}ms`);

        // 3. Test batch calculation performance
        console.log('\n🔄 Testing batch calculation performance...');
        const batchSizes = [10, 25, 50, 100];
        for (const size of batchSizes) {
            const testStudents = students.slice(0, size);
            const start = process.hrtime.bigint();
            
            // Queue calculations
            const queueEntries = testStudents.map(student => ({
                student_id: student.id,
                term_id: student.current_term_id,
                trigger_type: 'performance_test',
                priority: 1,
                status: 'pending'
            }));

            await query(
                supabase
                    .from('hps_recalculation_queue')
                    .upsert(queueEntries)
            );

            // Process queue
            const { data: queueResult } = await query(
                supabase.rpc('process_hps_recalculation_queue')
            );

            const end = process.hrtime.bigint();
            const duration = Number(end - start) / 1_000_000;
            const avgPerStudent = duration / size;

            console.log(`\nBatch size ${size}:`);
            console.log(`Total time: ${duration.toFixed(2)}ms`);
            console.log(`Average per student: ${avgPerStudent.toFixed(2)}ms`);
            console.log(`Processed: ${queueResult.processed_count}`);
            console.log(`Errors: ${queueResult.error_count}`);
        }

        // 4. Test cache performance
        console.log('\n💾 Testing cache performance...');
        const testStudent = students[0];
        
        // Clear cache
        await query(
            supabase
                .from('hps_score_cache')
                .delete()
                .eq('student_id', testStudent.id)
        );

        // First request (no cache)
        const { duration: noCacheDuration } = await measurePerformance(
            enhancedHPSCalculationService.calculateStudentHPS.bind(enhancedHPSCalculationService),
            'No Cache',
            testStudent.id,
            testStudent.current_term_id
        );

        // Second request (with cache)
        const { duration: withCacheDuration } = await measurePerformance(
            enhancedHPSCalculationService.calculateStudentHPS.bind(enhancedHPSCalculationService),
            'With Cache',
            testStudent.id,
            testStudent.current_term_id
        );

        console.log(`No cache: ${noCacheDuration.toFixed(2)}ms`);
        console.log(`With cache: ${withCacheDuration.toFixed(2)}ms`);
        console.log(`Cache improvement: ${((noCacheDuration - withCacheDuration) / noCacheDuration * 100).toFixed(2)}%`);

        // 5. Test concurrent calculations
        console.log('\n🔄 Testing concurrent calculations...');
        const concurrencyLevels = [5, 10, 20];
        for (const concurrency of concurrencyLevels) {
            const testStudents = students.slice(0, concurrency);
            const start = process.hrtime.bigint();

            // Run calculations concurrently
            await Promise.all(
                testStudents.map(student =>
                    enhancedHPSCalculationService.calculateStudentHPS(
                        student.id,
                        student.current_term_id
                    )
                )
            );

            const end = process.hrtime.bigint();
            const duration = Number(end - start) / 1_000_000;
            const avgPerStudent = duration / concurrency;

            console.log(`\nConcurrency level ${concurrency}:`);
            console.log(`Total time: ${duration.toFixed(2)}ms`);
            console.log(`Average per student: ${avgPerStudent.toFixed(2)}ms`);
        }

        // 6. Memory usage
        console.log('\n📊 Memory usage:');
        const used = process.memoryUsage();
        for (let key in used) {
            console.log(`${key}: ${Math.round(used[key] / 1024 / 1024 * 100) / 100} MB`);
        }

        console.log('\n✅ Performance test completed');

    } catch (error) {
        console.error('❌ Test failed:', error);
        process.exit(1);
    }
}

// Run the test
testHPSPerformance().catch(console.error);
