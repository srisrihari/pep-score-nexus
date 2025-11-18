# Comprehensive Score Audit - Issues Report

**Generated:** $(date -Iseconds)

## Executive Summary

This report provides a comprehensive analysis of all score discrepancies, missing scores, and calculation issues found when comparing the database scores with Excel source data across all 10 students, all interventions, and all terms (Level 0, Level 1, Level 2, Level 3).

### Overall Statistics

- **Total Comparisons:** 3,940
- **✅ Matches:** 89 (2.26%)
- **❌ Discrepancies:** 129 (3.27%)
- **⚠️ Missing Scores:** 88 (2.23%)
- **📦 Extra Scores (in DB but not in Excel):** 3,211 (81.50%)

### Critical Findings

1. **Wellness Scores Issue:** Many Wellness scores are missing or incorrectly normalized
2. **Intervention Score Parsing:** Several interventions don't have proper Excel parsing logic
3. **Score Normalization:** Raw fitness test values need proper conversion to 0-5 scale
4. **Missing Data:** Many scores exist in Excel but are missing from database
5. **Extra Data:** Many scores exist in database but not in Excel (likely from previous imports)

---

## Issues by Category

### 1. MISSING_SCORE (88 issues)

Scores that exist in Excel but are missing from the database.

#### Level 0
- **Wellness (Level 0):** All 6 microcompetencies missing for some students
- **Behavior (Level 0):** Some behavior scores missing

#### Level 1
- **Wellness (Level 1):** All 6 microcompetencies missing for all 10 students (60 missing scores)
- **Behavior (Level 1):** Some behavior scores missing

#### Level 2
- **Wellness (Level 2):** Missing scores for some students
- **Behavior (Level 2):** Missing scores for some students

#### Level 3
- **Wellness (Level 3):** Missing scores for some students
- **Behavior (Level 3):** Missing scores for some students

### 2. SCORE_MISMATCH (129 issues)

Scores that exist in both Excel and database but don't match.

#### Common Patterns:

1. **Wellness Scores Normalization Issues:**
   - Database has normalized scores (e.g., 53.40% for all microcompetencies)
   - Excel has individual raw scores that need proper normalization
   - Example: Student 2024JULB00002 - Push Ups: DB 53.40% vs Excel 60.00%

2. **Zero Score Handling:**
   - Database shows 10.00% for some Wellness scores
   - Excel shows 0.00% (not cleared)
   - Example: Multiple students - Beep test: DB 10.00% vs Excel 0.00%

3. **Individual Score Variations:**
   - Database has averaged/distributed scores
   - Excel has individual microcompetency scores
   - Example: Student 2024JULB00007 - Push Ups: DB 33.40% vs Excel 80.00%

### 3. EXTRA_SCORE (3,211 issues)

Scores that exist in database but not in Excel. These are likely:
- Scores from previous imports
- Scores that were calculated/estimated
- Scores that need to be removed or verified

#### Common Patterns:

1. **Fearless (Level 0):** Many zero scores (0/5) for microcompetencies not in Excel
2. **Other Interventions:** Scores exist but Excel parsing logic not implemented

---

## Root Causes

### 1. Wellness Score Normalization

**Problem:** Raw fitness test values (push-ups, sit-ups, BCA scores, etc.) are not properly normalized to 0-5 scale.

**Current State:**
- Some scores are averaged/distributed across all microcompetencies
- Raw values (e.g., 53 for BCA, 12 for push-ups) need conversion
- Excel uses individual scores, database uses averaged scores

**Solution Needed:**
- Implement proper normalization logic for each microcompetency type
- BCA: Convert 0-100 scale to 0-5 scale
- Push-ups, Sit-ups: Need to determine max values and normalize
- Beep test: Handle "M" (not cleared) as 0
- Use Fitness Test percentage from HPS sheet as reference

### 2. Missing Excel Parsing Logic

**Problem:** Many interventions don't have Excel parsing functions implemented.

**Affected Interventions:**
- Fearless (Level 0)
- All Level 1 interventions (except Wellness/Behavior)
- All Level 2 interventions (except Wellness/Behavior)
- All Level 3 interventions (except Wellness/Behavior)

**Solution Needed:**
- Implement `parseInterventionScores()` function for each intervention type
- Map Excel sheet names to intervention names
- Extract scores based on Excel structure
- Handle different Excel formats per intervention

### 3. Score Import Inconsistencies

**Problem:** Scores were imported using different methods, causing inconsistencies.

**Issues:**
- Some scores imported from aggregated Fitness Test percentage
- Some scores imported from individual raw values
- Some scores missing entirely
- Some scores exist but don't match Excel

**Solution Needed:**
- Standardize score import process
- Use Excel as single source of truth
- Re-import all scores with proper normalization
- Remove extra scores that don't exist in Excel

### 4. Calculation Logic Discrepancies

**Problem:** HPS calculation may not match Excel calculation method.

**Issues:**
- Excel uses direct sum of quadrant HPS values (no weights)
- Database uses weighted averages
- Different handling of zero scores
- Different rounding methods

**Solution Needed:**
- Verify Excel calculation formula
- Align database calculation with Excel
- Handle edge cases (zero scores, missing data) consistently

---

## Recommended Actions

### Priority 1: Critical Issues

1. **Import Missing Wellness Scores**
   - Level 1: Import all 60 missing Wellness scores
   - Level 2: Import missing Wellness scores
   - Level 3: Fix Wellness score normalization

2. **Fix Wellness Score Normalization**
   - Implement proper normalization for each microcompetency type
   - Use Fitness Test percentage from HPS sheet as reference
   - Handle special cases (M, NC, zero scores)

3. **Implement Excel Parsing for All Interventions**
   - Create parsing functions for each intervention type
   - Map Excel sheets to interventions
   - Extract and normalize scores correctly

### Priority 2: Important Issues

4. **Remove Extra Scores**
   - Identify and remove scores that don't exist in Excel
   - Verify each score against Excel source
   - Clean up database

5. **Fix Score Mismatches**
   - Re-import scores with correct normalization
   - Verify calculation logic
   - Align with Excel values

### Priority 3: Verification

6. **Verify Behavior Scores**
   - Check all Behavior scores across all terms
   - Ensure correct import from HPS sheet
   - Verify calculation

7. **Verify Capstone Scores**
   - Check Level 0 Capstone scores
   - Verify other level Capstone scores
   - Ensure correct parsing

---

## Next Steps

1. **Immediate:** Import missing Wellness scores for Level 1
2. **Short-term:** Implement Excel parsing for all interventions
3. **Medium-term:** Fix normalization logic and re-import all scores
4. **Long-term:** Verify and align calculation logic with Excel

---

## Detailed Issue Lists

See `comprehensive_score_audit_report.json` for complete list of all 3,428 issues with:
- Student registration numbers
- Intervention names
- Microcompetency names
- Database scores
- Excel scores
- Differences
- Issue types
