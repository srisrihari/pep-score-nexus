-- ============================================================
-- Migration: Intervention Teacher Assignment Restructure
-- Description: 
--   1. Remove microcompetency_id from teacher_microcompetency_assignments
--   2. Add intervention_teacher_id to intervention_enrollments
--   3. Add UNIQUE constraint to prevent duplicate enrollments
--   4. Make teacher assignments intervention-level only
-- ============================================================

BEGIN;

-- ============================================================
-- Step 1: Add intervention_teacher_id to intervention_enrollments
-- ============================================================
-- Add column (nullable initially for migration)
ALTER TABLE intervention_enrollments
ADD COLUMN IF NOT EXISTS intervention_teacher_id uuid;

-- Add index for performance
CREATE INDEX IF NOT EXISTS idx_intervention_enrollments_intervention_teacher_id
ON intervention_enrollments(intervention_teacher_id);

-- Add UNIQUE constraint to prevent duplicate enrollments
-- CRITICAL: One student can only be enrolled once per intervention
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint 
        WHERE conname = 'unique_student_intervention_enrollment'
    ) THEN
        ALTER TABLE intervention_enrollments
        ADD CONSTRAINT unique_student_intervention_enrollment 
        UNIQUE (intervention_id, student_id);
    END IF;
END $$;

-- ============================================================
-- Step 2: Modify teacher_microcompetency_assignments
-- ============================================================

-- First, check if we need to migrate existing data
-- Note: We'll handle data migration separately via a script

-- Drop the foreign key constraint for microcompetency_id
DO $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM pg_constraint 
        WHERE conname = 'teacher_microcompetency_assignments_microcompetency_id_fkey'
    ) THEN
        ALTER TABLE teacher_microcompetency_assignments
        DROP CONSTRAINT teacher_microcompetency_assignments_microcompetency_id_fkey;
    END IF;
END $$;

-- Remove microcompetency_id column
DO $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'teacher_microcompetency_assignments' 
        AND column_name = 'microcompetency_id'
    ) THEN
        ALTER TABLE teacher_microcompetency_assignments
        DROP COLUMN microcompetency_id;
    END IF;
END $$;

-- Add unique constraint to prevent duplicate teacher assignments
-- One active teacher assignment per intervention
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint 
        WHERE conname = 'unique_teacher_intervention_assignment'
    ) THEN
        ALTER TABLE teacher_microcompetency_assignments
        ADD CONSTRAINT unique_teacher_intervention_assignment 
        UNIQUE (teacher_id, intervention_id, is_active);
    END IF;
END $$;

-- ============================================================
-- Step 3: Add foreign key constraint for intervention_teacher_id
-- ============================================================

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint 
        WHERE conname = 'intervention_enrollments_intervention_teacher_id_fkey'
    ) THEN
        ALTER TABLE intervention_enrollments
        ADD CONSTRAINT intervention_enrollments_intervention_teacher_id_fkey
        FOREIGN KEY (intervention_teacher_id)
        REFERENCES teacher_microcompetency_assignments(id)
        ON DELETE RESTRICT; -- Prevent deletion of teacher assignment if students are enrolled
    END IF;
END $$;

COMMIT;

-- ============================================================
-- Note: After data migration is complete, run this to make intervention_teacher_id REQUIRED:
-- ============================================================
-- ALTER TABLE intervention_enrollments
-- ALTER COLUMN intervention_teacher_id SET NOT NULL;

