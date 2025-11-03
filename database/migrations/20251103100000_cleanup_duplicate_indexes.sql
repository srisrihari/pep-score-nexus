-- Cleanup Duplicate and Redundant Indexes
-- Part of HPS System Remediation Plan - Performance Hygiene
--
-- This migration removes:
-- 1. Duplicate unique indexes on intervention_enrollments
-- 2. Redundant single-column indexes that are covered by composite unique indexes
--
-- ROLLBACK NOTES:
-- If rollback is needed, recreate the constraint and index:
-- ALTER TABLE intervention_enrollments ADD CONSTRAINT unique_student_intervention_enrollment UNIQUE (intervention_id, student_id);
-- CREATE INDEX idx_student_score_summary_student ON student_score_summary(student_id);
-- Note: idx_student_score_summary_term was kept as it may be used for term-only queries.

DO $$
BEGIN
  RAISE NOTICE '🧹 Starting index cleanup...';
END $$;

-- ==========================================
-- 1. REMOVE DUPLICATE UNIQUE INDEXES
-- ==========================================

-- intervention_enrollments has TWO identical unique constraints on (intervention_id, student_id)
-- Keep: uk_intervention_enrollment (more descriptive name)
-- Drop: unique_student_intervention_enrollment (duplicate constraint)

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conrelid = 'intervention_enrollments'::regclass
      AND conname = 'unique_student_intervention_enrollment'
      AND contype = 'u'
  ) THEN
    ALTER TABLE intervention_enrollments DROP CONSTRAINT IF EXISTS unique_student_intervention_enrollment;
    RAISE NOTICE '✅ Dropped duplicate unique constraint: unique_student_intervention_enrollment';
  ELSE
    RAISE NOTICE 'ℹ️  Constraint unique_student_intervention_enrollment already does not exist';
  END IF;
END $$;

-- ==========================================
-- 2. REMOVE REDUNDANT SINGLE-COLUMN INDEXES
-- ==========================================

-- student_score_summary has a unique index on (student_id, term_id)
-- Single-column indexes on student_id and term_id are redundant:
-- - student_id queries can use the leftmost column of the unique index
-- - term_id-only queries are rare (all queries in codebase include student_id)
-- However, we'll be conservative and only remove student_id index since term_id-only might be used elsewhere

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM pg_indexes 
    WHERE schemaname = 'public' 
      AND tablename = 'student_score_summary' 
      AND indexname = 'idx_student_score_summary_student'
  ) THEN
    -- Check if this index is actually used (PostgreSQL tracks index usage)
    -- Note: We'll drop it anyway as the unique composite index covers student_id lookups
    DROP INDEX IF EXISTS idx_student_score_summary_student;
    RAISE NOTICE '✅ Dropped redundant index: idx_student_score_summary_student (covered by unique_student_term_summary)';
  ELSE
    RAISE NOTICE 'ℹ️  Index idx_student_score_summary_student already does not exist';
  END IF;
END $$;

-- ==========================================
-- 3. ANALYZE TABLES AFTER CLEANUP
-- ==========================================

ANALYZE intervention_enrollments;
ANALYZE student_score_summary;

DO $$
BEGIN
  RAISE NOTICE '✅ Index cleanup completed successfully';
  RAISE NOTICE '📊 Tables analyzed for updated statistics';
END $$;

-- ==========================================
-- VERIFICATION QUERY (for manual checking)
-- ==========================================
-- Run this after migration to verify cleanup:
-- SELECT 
--     tablename,
--     indexname,
--     indexdef
-- FROM pg_indexes
-- WHERE schemaname = 'public'
--     AND tablename IN ('intervention_enrollments', 'student_score_summary')
-- ORDER BY tablename, indexname;

