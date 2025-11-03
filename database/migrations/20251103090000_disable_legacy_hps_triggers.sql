-- Disable legacy HPS-related triggers on microcompetency_scores
-- These triggers previously mutated enrollment and student rows.
-- Backend now owns recalculation and persistence paths (term-aware).

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM pg_trigger WHERE tgrelid = 'public.microcompetency_scores'::regclass AND tgname = 'trigger_update_enrollment_scores'
  ) THEN
    EXECUTE 'DROP TRIGGER IF EXISTS trigger_update_enrollment_scores ON public.microcompetency_scores';
  END IF;

  IF EXISTS (
    SELECT 1 FROM pg_trigger WHERE tgrelid = 'public.microcompetency_scores'::regclass AND tgname = 'trigger_update_student_overall_score'
  ) THEN
    EXECUTE 'DROP TRIGGER IF EXISTS trigger_update_student_overall_score ON public.microcompetency_scores';
  END IF;

  IF EXISTS (
    SELECT 1 FROM pg_trigger WHERE tgrelid = 'public.microcompetency_scores'::regclass AND tgname = 'trigger_recalculate_scores'
  ) THEN
    EXECUTE 'DROP TRIGGER IF EXISTS trigger_recalculate_scores ON public.microcompetency_scores';
  END IF;
END$$;

-- No RLS/security changes in this phase.

