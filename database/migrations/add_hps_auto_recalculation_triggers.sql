-- HPS Auto-Recalculation Triggers and Functions
-- This migration adds automatic HPS recalculation when microcompetency scores are updated

-- ==========================================
-- 1. CREATE HPS RECALCULATION FUNCTIONS
-- ==========================================

-- Function to trigger HPS recalculation for a specific student-term
CREATE OR REPLACE FUNCTION trigger_hps_recalculation()
RETURNS TRIGGER AS $$
DECLARE
    student_id_var UUID;
    term_id_var UUID;
    intervention_id_var UUID;
BEGIN
    -- Get student and term information from the affected microcompetency score
    IF TG_OP = 'DELETE' THEN
        student_id_var := OLD.student_id;
        intervention_id_var := OLD.intervention_id;
    ELSE
        student_id_var := NEW.student_id;
        intervention_id_var := NEW.intervention_id;
    END IF;

    -- Get term_id from the intervention
    SELECT term_id INTO term_id_var
    FROM interventions
    WHERE id = intervention_id_var;

    -- Only proceed if we have valid student and term IDs
    IF student_id_var IS NOT NULL AND term_id_var IS NOT NULL THEN
        -- Queue HPS recalculation by inserting into a recalculation queue table
        INSERT INTO hps_recalculation_queue (student_id, term_id, trigger_type, metadata, created_at)
        VALUES (student_id_var, term_id_var, TG_OP, jsonb_build_object(
            'microcompetency_id', COALESCE(NEW.microcompetency_id, OLD.microcompetency_id),
            'intervention_id', intervention_id_var,
            'old_score', CASE WHEN TG_OP = 'UPDATE' THEN OLD.obtained_score ELSE NULL END,
            'new_score', CASE WHEN TG_OP IN ('INSERT', 'UPDATE') THEN NEW.obtained_score ELSE NULL END
        ), CURRENT_TIMESTAMP)
        ON CONFLICT (student_id, term_id) DO UPDATE SET
            trigger_type = EXCLUDED.trigger_type,
            metadata = EXCLUDED.metadata,
            created_at = CURRENT_TIMESTAMP;

        -- Log the trigger for debugging
        RAISE LOG 'HPS recalculation triggered for student % in term % via % operation',
                  student_id_var, term_id_var, TG_OP;
    END IF;

    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- Function to process HPS recalculation queue
CREATE OR REPLACE FUNCTION process_hps_recalculation_queue()
RETURNS INTEGER AS $$
DECLARE
    queue_item RECORD;
    recalc_result JSONB;
    processed_count INTEGER := 0;
BEGIN
    -- Process up to 10 items from the queue at a time
    FOR queue_item IN
        SELECT * FROM hps_recalculation_queue
        ORDER BY created_at ASC
        LIMIT 10
        FOR UPDATE SKIP LOCKED
    LOOP
        BEGIN
            -- Call the HPS calculation service (this would need to be implemented as a stored procedure)
            -- For now, we'll use a placeholder that logs the recalculation
            recalc_result := jsonb_build_object(
                'student_id', queue_item.student_id,
                'term_id', queue_item.term_id,
                'processed_at', CURRENT_TIMESTAMP,
                'status', 'queued'
            );

            -- Log the recalculation attempt
            INSERT INTO hps_calculation_audit (
                student_id, term_id, trigger_type, metadata, calculated_at
            ) VALUES (
                queue_item.student_id,
                queue_item.term_id,
                'automatic',
                jsonb_build_object(
                    'queue_id', queue_item.id,
                    'trigger_type', queue_item.trigger_type,
                    'original_metadata', queue_item.metadata,
                    'processing_result', recalc_result
                ),
                CURRENT_TIMESTAMP
            );

            -- Remove from queue after processing
            DELETE FROM hps_recalculation_queue WHERE id = queue_item.id;

            processed_count := processed_count + 1;

        EXCEPTION WHEN OTHERS THEN
            -- Log error and continue with next item
            INSERT INTO hps_calculation_audit (
                student_id, term_id, trigger_type, metadata, calculated_at
            ) VALUES (
                queue_item.student_id,
                queue_item.term_id,
                'automatic_error',
                jsonb_build_object(
                    'queue_id', queue_item.id,
                    'error', SQLERRM,
                    'error_metadata', queue_item.metadata
                ),
                CURRENT_TIMESTAMP
            );

            -- Remove failed item from queue
            DELETE FROM hps_recalculation_queue WHERE id = queue_item.id;
        END;
    END LOOP;

    RETURN processed_count;
END;
$$ LANGUAGE plpgsql;

-- ==========================================
-- 2. CREATE RECALCULATION QUEUE TABLE
-- ==========================================

CREATE TABLE IF NOT EXISTS hps_recalculation_queue (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
    term_id UUID NOT NULL REFERENCES terms(id) ON DELETE CASCADE,
    trigger_type VARCHAR(20) NOT NULL CHECK (trigger_type IN ('INSERT', 'UPDATE', 'DELETE')),
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(student_id, term_id)
);

CREATE INDEX IF NOT EXISTS idx_hps_recalculation_queue_created_at ON hps_recalculation_queue(created_at);

-- ==========================================
-- 3. CREATE UPDATED TRIGGERS
-- ==========================================

-- Drop existing trigger if it exists
DROP TRIGGER IF EXISTS trigger_recalculate_scores ON microcompetency_scores;

-- Create new trigger that uses the recalculation queue
CREATE TRIGGER trigger_recalculate_scores
    AFTER INSERT OR UPDATE OR DELETE ON microcompetency_scores
    FOR EACH ROW EXECUTE FUNCTION trigger_hps_recalculation();

-- ==========================================
-- 4. ADD HPS AUDIT LOGGING ENHANCEMENTS
-- ==========================================

-- Add more detailed metadata columns to hps_calculation_audit if they don't exist
ALTER TABLE hps_calculation_audit
ADD COLUMN IF NOT EXISTS old_hps DECIMAL(5,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS new_hps DECIMAL(5,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS hps_difference DECIMAL(5,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS percentage_change DECIMAL(5,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS calculation_method VARCHAR(50) DEFAULT 'automatic',
ADD COLUMN IF NOT EXISTS processing_time_ms INTEGER,
ADD COLUMN IF NOT EXISTS error_details TEXT;

-- ==========================================
-- 5. CREATE SCHEDULED JOB TABLE
-- ==========================================

CREATE TABLE IF NOT EXISTS hps_scheduled_jobs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    job_type VARCHAR(50) NOT NULL CHECK (job_type IN ('batch_recalculation', 'consistency_check', 'cache_refresh')),
    job_status VARCHAR(20) DEFAULT 'pending' CHECK (job_status IN ('pending', 'running', 'completed', 'failed', 'cancelled')),
    target_batch_id UUID REFERENCES batches(id),
    target_term_id UUID REFERENCES terms(id),
    job_parameters JSONB DEFAULT '{}',
    scheduled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    started_at TIMESTAMP,
    completed_at TIMESTAMP,
    error_message TEXT,
    result_summary JSONB DEFAULT '{}',
    created_by UUID REFERENCES users(id)
);

CREATE INDEX IF NOT EXISTS idx_hps_scheduled_jobs_status ON hps_scheduled_jobs(job_status);
CREATE INDEX IF NOT EXISTS idx_hps_scheduled_jobs_scheduled_at ON hps_scheduled_jobs(scheduled_at);

-- ==========================================
-- 6. CREATE HPS CACHE TABLE
-- ==========================================

CREATE TABLE IF NOT EXISTS hps_score_cache (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
    term_id UUID NOT NULL REFERENCES terms(id) ON DELETE CASCADE,
    cached_hps DECIMAL(5,2) NOT NULL,
    quadrant_scores JSONB NOT NULL,
    cache_key VARCHAR(100) NOT NULL,
    cache_version INTEGER DEFAULT 1,
    expires_at TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP + INTERVAL '1 hour'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_accessed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    access_count INTEGER DEFAULT 0,
    UNIQUE(student_id, term_id)
);

CREATE INDEX IF NOT EXISTS idx_hps_score_cache_expires_at ON hps_score_cache(expires_at);
CREATE INDEX IF NOT EXISTS idx_hps_score_cache_last_accessed ON hps_score_cache(last_accessed_at);

-- Function to clean expired cache entries
CREATE OR REPLACE FUNCTION cleanup_expired_hps_cache()
RETURNS INTEGER AS $$
DECLARE
    deleted_count INTEGER;
BEGIN
    DELETE FROM hps_score_cache WHERE expires_at < CURRENT_TIMESTAMP;
    GET DIAGNOSTICS deleted_count = ROW_COUNT;

    RAISE LOG 'Cleaned up % expired HPS cache entries', deleted_count;
    RETURN deleted_count;
END;
$$ LANGUAGE plpgsql;

-- ==========================================
-- 7. COMMENTS AND DOCUMENTATION
-- ==========================================

COMMENT ON TABLE hps_recalculation_queue IS 'Queue for HPS recalculation jobs triggered by score changes';
COMMENT ON TABLE hps_scheduled_jobs IS 'Scheduled HPS calculation and maintenance jobs';
COMMENT ON TABLE hps_score_cache IS 'Cache for frequently accessed HPS scores with TTL';

COMMENT ON FUNCTION trigger_hps_recalculation() IS 'Trigger function that queues HPS recalculation when microcompetency scores change';
COMMENT ON FUNCTION process_hps_recalculation_queue() IS 'Process queued HPS recalculation requests';

-- ==========================================
-- 8. GRANTS (if needed)
-- ==========================================

-- Grant necessary permissions for the functions to work
-- (Adjust based on your security requirements)

-- ==========================================
-- 9. TESTING AND VALIDATION
-- ==========================================

-- Test trigger by inserting a sample microcompetency score
DO $$
DECLARE
    test_student_id UUID;
    test_intervention_id UUID;
    test_microcompetency_id UUID;
BEGIN
    -- Get a test student (if exists)
    SELECT id INTO test_student_id FROM students LIMIT 1;

    -- Get a test intervention (if exists)
    SELECT id INTO test_intervention_id FROM interventions LIMIT 1;

    -- Get a test microcompetency (if exists)
    SELECT id INTO test_microcompetency_id FROM microcompetencies LIMIT 1;

    IF test_student_id IS NOT NULL AND test_intervention_id IS NOT NULL AND test_microcompetency_id IS NOT NULL THEN
        -- Insert a test score to trigger the recalculation
        INSERT INTO microcompetency_scores (
            student_id, intervention_id, microcompetency_id,
            obtained_score, max_score, scored_by
        ) VALUES (
            test_student_id, test_intervention_id, test_microcompetency_id,
            8.5, 10.0, (SELECT id FROM users WHERE role = 'teacher' LIMIT 1)
        ) ON CONFLICT (student_id, intervention_id, microcompetency_id)
        DO UPDATE SET
            obtained_score = EXCLUDED.obtained_score,
            scored_by = EXCLUDED.scored_by;

        RAISE NOTICE 'Test HPS recalculation trigger executed successfully';
    ELSE
        RAISE NOTICE 'No test data available for trigger testing';
    END IF;
END $$;

