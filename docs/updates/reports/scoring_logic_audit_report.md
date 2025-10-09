# Scoring Logic Audit Report

## 📋 Executive Summary
This document analyzes the current scoring calculation logic against the specified requirements to identify any discrepancies.

## 🎯 User Requirements (Expected Logic)

### Hierarchy Flow:
1. **Microcompetency → Component**
   - Average microcompetency scores for a component
   - **Exclusion**: If a microcompetency has NO intervention assignment, EXCLUDE it from the average
   - **Weighting**: Use microcompetency weightage if available
   - **Max Score Conversion**: Convert average to component's max_score (e.g., if component max_score = 5, convert to out of 5)

2. **Component → Sub-Category**
   - Average component scores for a sub-category
   - **Exclusion**: If a component has ALL microcompetencies unassigned to interventions, EXCLUDE the component
   - **Weighting**: Use component weightage if available
   - **Max Score Conversion**: Convert average to sub-category's max_score

3. **Sub-Category → Quadrant**
   - Average sub-category scores for a quadrant
   - **Exclusion**: If a sub-category has no scores (all components excluded), EXCLUDE it
   - **Weighting**: Use sub-category weightage if available
   - **Max Score Conversion**: Convert average to quadrant's max_score

4. **Quadrant → HPS**
   - Average quadrant scores for HPS
   - **Exclusion**: If a quadrant has no scores, EXCLUDE it
   - **Weighting**: Use quadrant weightage (batch-term specific or default)
   - **Max Score Conversion**: HPS is typically out of 100

## 🔍 Current Implementation Analysis

### ✅ What's Working Correctly:

#### 1. **Exclusion Logic** ✅
**Location**: `backend/src/services/enhancedUnifiedScoreCalculationServiceV2.js` (lines 363-443)

**Microcompetency Level** (Lines 366-376):
```javascript
if (microcompetency.scores.length > 0) {
  microcompetency.averageScore = microcompetency.scores.reduce((sum, score) => sum + score, 0) / microcompetency.scores.length;
  microcompetency.hasInterventionScores = true;
} else {
  microcompetency.averageScore = 0;
  microcompetency.hasInterventionScores = false;
}
```
✅ **Correct**: Sets `hasInterventionScores = false` when no scores exist.

**Component Level** (Lines 380-398):
```javascript
Object.values(component.microcompetencies).forEach(microcompetency => {
  if (microcompetency.hasInterventionScores && microcompetency.weightage > 0) {
    weightedSum += microcompetency.averageScore * (microcompetency.weightage / 100);
    totalWeight += (microcompetency.weightage / 100);
    hasActiveMicrocompetencies = true;
  }
});
component.hasInterventionScores = hasActiveMicrocompetencies;
```
✅ **Correct**: Only includes microcompetencies with intervention scores and positive weightage.

**Sub-Category Level** (Lines 401-418):
```javascript
Object.values(subcategory.components).forEach(component => {
  if (component.hasInterventionScores && component.weightage > 0) {
    weightedSum += component.averageScore * (component.weightage / 100);
    totalWeight += (component.weightage / 100);
    hasActiveComponents = true;
  }
});
subcategory.hasInterventionScores = hasActiveComponents;
```
✅ **Correct**: Only includes components with intervention scores and positive weightage.

**Quadrant Level** (Lines 420-443):
```javascript
Object.values(quadrant.subcategories).forEach(subcategory => {
  if (subcategory.hasInterventionScores && subcategory.weightage > 0) {
    quadrantWeightedSum += subcategory.averageScore * (subcategory.weightage / 100);
    quadrantTotalWeight += (subcategory.weightage / 100);
    hasActiveSubcategories = true;
  }
});
quadrantScore.hasInterventionScores = hasActiveSubcategories;
```
✅ **Correct**: Only includes subcategories with intervention scores and positive weightage.

**HPS Level** (Lines 532-544):
```javascript
if (quadrantScore && qw.weightage > 0 && quadrantScore.hasInterventionScores) {
  weightedSum += quadrantScore.averageScore * (qw.weightage / 100);
  totalWeight += (qw.weightage / 100);
} else if (quadrantScore && !quadrantScore.hasInterventionScores) {
  excludedQuadrants.push(`${qw.name} (no intervention scores)`);
}
```
✅ **Correct**: Only includes quadrants with intervention scores and positive weightage.

#### 2. **Weighted Average Calculation** ✅

**Current Implementation**:
- **Microcompetency → Component**: `weightedSum / totalWeight` where weights are normalized (weightage / 100)
- **Component → Sub-Category**: `weightedSum / totalWeight` where weights are normalized (weightage / 100)
- **Sub-Category → Quadrant**: `weightedSum / totalWeight` where weights are normalized (weightage / 100)
- **Quadrant → HPS**: `weightedSum / totalWeight` where weights are normalized (weightage / 100)

✅ **Correct**: Uses weighted averages at all levels.

#### 3. **Multiple Intervention Scores Averaging** ✅

**Location**: Lines 351-354, 368-369
```javascript
// When populating scores (line 353):
quadrantData[quadrantId].subcategories[subcategoryId].components[componentId].microcompetencies[microcompetencyId].scores.push(percentage);

// When calculating average (lines 368-369):
microcompetency.averageScore = microcompetency.scores.reduce((sum, score) => sum + score, 0) / microcompetency.scores.length;
```
✅ **Correct**: Averages multiple scores for same microcompetency across different interventions.

### ❌ What's NOT Working Correctly:

#### 1. **Max Score Conversion** ❌

**Issue**: The current implementation does NOT convert scores to match upper-level max_scores.

**Current Behavior**:
- Microcompetency scores are calculated as percentages (0-100%)
- These percentages are directly averaged using weighted formulas
- **NO conversion** to component max_score (5)
- **NO conversion** to sub-category max_score (if it existed)
- **NO conversion** to quadrant max_score (if it existed)
- Result is always a percentage, not "out of max_score"

**Example of the Problem**:
```
Microcompetency A1: 4 out of 5 = 80%
Microcompetency A2: 3 out of 5 = 60%
Component "Analytical Thinking" max_score = 5

Current Implementation:
  Component Score = (80% + 60%) / 2 = 70% (THIS IS A PERCENTAGE)
  
Expected Implementation:
  Component Score = 70% of 5 = 3.5 out of 5 (THIS SHOULD BE THE RESULT)
```

**Where the conversion SHOULD happen**:
- Line 396: `component.averageScore = totalWeight > 0 ? weightedSum / totalWeight : 0;`
  Should be: `component.averageScore = totalWeight > 0 ? (weightedSum / totalWeight) * (component.max_score / 100) : 0;`
  
- Line 416: `subcategory.averageScore = totalWeight > 0 ? weightedSum / totalWeight : 0;`
  Should convert to subcategory max_score (but sub_categories table has NO max_score column)
  
- Line 437: `averageScore: quadrantTotalWeight > 0 ? quadrantWeightedSum / quadrantTotalWeight : 0,`
  Should convert to quadrant max_score (but quadrants table has NO max_score column)

**Root Cause**: 
1. The code works entirely in percentages (0-100%)
2. No conversion to actual "out of X" scores at any level
3. Database schema is missing `max_score` column for `sub_categories` and `quadrants` tables

#### 2. **Database Schema Incomplete** ❌

**Missing Columns**:
- `sub_categories` table: NO `max_score` column
- `quadrants` table: NO `max_score` column

**Current Schema**:
```
microcompetencies: has max_score (default: 10.00) ✅
components: has max_score (default: 5.00) ✅
sub_categories: NO max_score ❌
quadrants: NO max_score ❌
```

This means even if we wanted to convert to max_score, we can't for sub_categories and quadrants.

#### 3. **Weightage Interpretation** ⚠️

**Current Behavior**:
- All weightages are stored as 100.00 (meaning 100%)
- Code divides by 100 to normalize: `microcompetency.weightage / 100` = 1.00
- This effectively makes all items have EQUAL weight

**Issue**:
- If all items have weightage = 100, then weighted average = simple average
- This works, but it's not utilizing the weightage system as intended
- Should support different weightages (e.g., 30%, 50%, 20%) for different items

**Example**:
```
Current: A1 (100%), A2 (100%), A3 (100%) → All equal weight
Possible: A1 (50%), A2 (30%), A3 (20%) → Different weights
```

The current implementation WOULD work with different weightages, but the data doesn't use this feature.

## 📊 Summary of Discrepancies

| Requirement | Current Implementation | Status |
|------------|----------------------|--------|
| Exclusion of unassigned microcompetencies | ✅ Correctly excludes | ✅ CORRECT |
| Exclusion of components with all unassigned microcomp | ✅ Correctly excludes | ✅ CORRECT |
| Exclusion of subcategories with no scores | ✅ Correctly excludes | ✅ CORRECT |
| Exclusion of quadrants with no scores | ✅ Correctly excludes | ✅ CORRECT |
| Weighted averages at all levels | ✅ Uses weighted averages | ✅ CORRECT |
| Multiple intervention scores averaging | ✅ Averages correctly | ✅ CORRECT |
| **Convert score to component max_score** | ❌ Returns percentage only | ❌ **INCORRECT** |
| **Convert score to sub-category max_score** | ❌ No max_score column exists | ❌ **INCORRECT** |
| **Convert score to quadrant max_score** | ❌ No max_score column exists | ❌ **INCORRECT** |
| **Convert score to HPS out of 100** | ✅ Already in percentage (0-100) | ✅ CORRECT |

## 🔧 Required Fixes

### Fix 1: Add max_score columns to database
```sql
ALTER TABLE sub_categories ADD COLUMN max_score NUMERIC DEFAULT 5.00;
ALTER TABLE quadrants ADD COLUMN max_score NUMERIC DEFAULT 100.00;
```

### Fix 2: Update calculation logic to convert to max_score

**Component Level** (Line 396):
```javascript
// Current:
component.averageScore = totalWeight > 0 ? weightedSum / totalWeight : 0;

// Should be:
const percentageScore = totalWeight > 0 ? weightedSum / totalWeight : 0;
component.averageScore = (percentageScore / 100) * component.max_score;
component.percentageScore = percentageScore; // Keep percentage for reference
```

**Sub-Category Level** (Line 416):
```javascript
// Current:
subcategory.averageScore = totalWeight > 0 ? weightedSum / totalWeight : 0;

// Should be:
const percentageScore = totalWeight > 0 ? weightedSum / totalWeight : 0;
subcategory.averageScore = (percentageScore / 100) * subcategory.max_score;
subcategory.percentageScore = percentageScore;
```

**Quadrant Level** (Line 437):
```javascript
// Current:
averageScore: quadrantTotalWeight > 0 ? quadrantWeightedSum / quadrantTotalWeight : 0,

// Should be:
const percentageScore = quadrantTotalWeight > 0 ? quadrantWeightedSum / quadrantTotalWeight : 0;
averageScore: (percentageScore / 100) * quadrant.max_score,
percentageScore: percentageScore,
```

**HPS Level** (Line 547):
```javascript
// Current (already correct as HPS is out of 100):
const hps = totalWeight > 0 ? weightedSum / totalWeight : 0;
```

## 🎯 Conclusion

**What's Working**:
✅ Exclusion logic is perfect - correctly excludes unassigned items at all levels
✅ Weighted average calculation is correct
✅ Multiple intervention scores are properly averaged
✅ HPS calculation respects batch-term weightages

**What Needs Fixing**:
❌ **CRITICAL**: Scores are not converted to upper-level max_scores
❌ **CRITICAL**: Database missing max_score columns for sub_categories and quadrants
⚠️ **MINOR**: Weightage system exists but all values are 100 (equal weight)
