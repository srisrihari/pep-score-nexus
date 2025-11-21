# Good Deed / Bad Deed Feature Implementation Plan

**Date:** ${new Date().toISOString().split('T')[0]}  
**Status:** Planning Phase

---

## Overview

This document outlines the implementation plan for two new features:

1. **Enhanced Teacher Student Management**: Show ALL students across all batches in teacher dashboard
2. **Good Deed / Bad Deed System**: Allow teachers to add positive/negative behavior scores that automatically affect student HPS

---

## Feature 1: Show All Students in Teacher Dashboard

### Current State
- **File:** `frontend/src/pages/teacher/TeacherStudents.tsx`
- **Backend API:** `GET /api/v1/teachers/:teacherId/students` (in `backend/src/controllers/teacherController.js`)
- **Current Behavior:** Only shows students assigned to teacher's interventions
- **Query Logic:** Filters students based on `teacher_assignments` and `intervention_enrollments`

### Required Changes

#### Backend Changes

**File:** `backend/src/controllers/teacherController.js`

**Function:** `getAssignedStudents`

**Changes:**
1. Add new query parameter `all_students=true` to fetch all students
2. When `all_students=true`, bypass assignment filtering
3. Return all active students with their basic information

**New Endpoint (Optional):**
- `GET /api/v1/teachers/students/all` - Get all students (simpler approach)

**Implementation:**
```javascript
const getAllStudents = async (req, res) => {
  try {
    const { teacherId } = req.user; // From auth middleware
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const offset = (page - 1) * limit;
    const search = req.query.search || '';

    // Get ALL active students (not filtered by assignments)
    let studentsQuery = supabase
      .from('students')
      .select(`
        id,
        registration_no,
        name,
        course,
        overall_score,
        grade,
        status,
        batches:batch_id(name, year),
        sections:section_id(name),
        houses:house_id(name, color)
      `)
      .eq('status', 'Active');

    // Apply search filter
    if (search) {
      studentsQuery = studentsQuery.or(
        `name.ilike.%${search}%,registration_no.ilike.%${search}%,course.ilike.%${search}%`
      );
    }

    // Get total count
    const countQuery = supabase
      .from('students')
      .select('*', { count: 'exact', head: true })
      .eq('status', 'Active');

    if (search) {
      countQuery.or(`name.ilike.%${search}%,registration_no.ilike.%${search}%,course.ilike.%${search}%`);
    }

    const [studentsResult, countResult] = await Promise.all([
      query(studentsQuery.range(offset, offset + limit - 1)),
      query(countQuery)
    ]);

    return res.json({
      success: true,
      data: studentsResult.rows || [],
      pagination: {
        page,
        limit,
        total: countResult.count || 0,
        totalPages: Math.ceil((countResult.count || 0) / limit)
      }
    });
  } catch (error) {
    // Error handling
  }
};
```

#### Frontend Changes

**File:** `frontend/src/pages/teacher/TeacherStudents.tsx`

**Changes:**
1. Update `fetchStudents` function to call new endpoint
2. Remove filtering logic that restricts to assigned students
3. Update UI text to reflect "All Students" instead of "Assigned Students"

**API Update:**
**File:** `frontend/src/lib/api.ts`

Add new function:
```typescript
getAllStudents: (params?: {
  page?: number;
  limit?: number;
  search?: string;
}) => Promise<ApiResponse<Student[]>>;
```

---

## Feature 2: Good Deed / Bad Deed System

### Database Schema

#### New Table: `student_deeds`

```sql
CREATE TABLE student_deeds (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  teacher_id UUID NOT NULL REFERENCES teachers(id) ON DELETE CASCADE,
  term_id UUID NOT NULL REFERENCES terms(id) ON DELETE CASCADE,
  deed_type VARCHAR(10) NOT NULL CHECK (deed_type IN ('good', 'bad')),
  score NUMERIC(3,2) NOT NULL CHECK (score >= 0 AND score <= 5),
  comment TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_by UUID NOT NULL REFERENCES users(id),
  
  -- Indexes for performance
  CONSTRAINT student_deeds_student_term_idx UNIQUE NULLS NOT DISTINCT (student_id, term_id, teacher_id, created_at)
);

-- Indexes
CREATE INDEX idx_student_deeds_student_id ON student_deeds(student_id);
CREATE INDEX idx_student_deeds_teacher_id ON student_deeds(teacher_id);
CREATE INDEX idx_student_deeds_term_id ON student_deeds(term_id);
CREATE INDEX idx_student_deeds_created_at ON student_deeds(created_at DESC);

-- RLS Policies (if using Row Level Security)
ALTER TABLE student_deeds ENABLE ROW LEVEL SECURITY;

-- Teachers can view all deeds
CREATE POLICY "Teachers can view all deeds" ON student_deeds
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM teachers WHERE user_id = auth.uid()
    )
  );

-- Teachers can insert their own deeds
CREATE POLICY "Teachers can insert deeds" ON student_deeds
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM teachers WHERE user_id = auth.uid() AND id = teacher_id
    )
  );

-- Students can view their own deeds
CREATE POLICY "Students can view own deeds" ON student_deeds
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM students WHERE user_id = auth.uid() AND id = student_id
    )
  );
```

### Backend Implementation

#### 1. Database Migration

**File:** `database/migrations/create_student_deeds_table.sql`

Create migration file with table schema above.

#### 2. Model/Service Layer

**File:** `backend/src/services/studentDeedService.js`

```javascript
const { supabase, query } = require('../config/supabase');

class StudentDeedService {
  /**
   * Add a deed (good or bad) for a student
   */
  async addDeed(studentId, teacherId, termId, deedType, score, comment, createdBy) {
    // Validation
    if (!['good', 'bad'].includes(deedType)) {
      throw new Error('Invalid deed_type. Must be "good" or "bad"');
    }
    if (score < 0 || score > 5) {
      throw new Error('Score must be between 0 and 5');
    }

    const { data, error } = await query(
      supabase
        .from('student_deeds')
        .insert({
          student_id: studentId,
          teacher_id: teacherId,
          term_id: termId,
          deed_type: deedType,
          score: score,
          comment: comment || null,
          created_by: createdBy
        })
        .select()
        .single()
    );

    if (error) throw error;

    // Trigger HPS recalculation
    await this.triggerHPSRecalculation(studentId, termId);

    return data;
  }

  /**
   * Get all deeds for a student in a term
   */
  async getStudentDeeds(studentId, termId) {
    const { data, error } = await query(
      supabase
        .from('student_deeds')
        .select(`
          *,
          teacher:teachers(id, name, employee_id),
          term:terms(id, name)
        `)
        .eq('student_id', studentId)
        .eq('term_id', termId)
        .order('created_at', { ascending: false })
    );

    if (error) throw error;
    return data || [];
  }

  /**
   * Calculate behavior score from deeds
   * Good deeds: +score, Bad deeds: -score
   * Returns net score (can be negative)
   */
  async calculateDeedScore(studentId, termId) {
    const deeds = await this.getStudentDeeds(studentId, termId);
    
    let totalScore = 0;
    deeds.forEach(deed => {
      if (deed.deed_type === 'good') {
        totalScore += parseFloat(deed.score);
      } else {
        totalScore -= parseFloat(deed.score);
      }
    });

    // Normalize to 0-100 scale (assuming max possible is ±25 for 5 deeds × 5 points)
    // Or use a different normalization strategy
    return totalScore;
  }

  /**
   * Trigger HPS recalculation after deed addition
   */
  async triggerHPSRecalculation(studentId, termId) {
    // Import HPS calculation service
    const EnhancedUnifiedScoreCalculationServiceV2 = require('./enhancedUnifiedScoreCalculationServiceV2');
    const hpsService = new EnhancedUnifiedScoreCalculationServiceV2();
    
    try {
      await hpsService.calculateUnifiedHPS(studentId, termId);
    } catch (error) {
      console.error('Error recalculating HPS after deed addition:', error);
      // Don't throw - deed was added successfully, HPS can be recalculated later
    }
  }
}

module.exports = new StudentDeedService();
```

#### 3. Controller Layer

**File:** `backend/src/controllers/studentDeedController.js`

```javascript
const { supabase, query } = require('../config/supabase');
const studentDeedService = require('../services/studentDeedService');

class StudentDeedController {
  /**
   * Add a deed for a student
   * POST /api/v1/teachers/students/:studentId/deeds
   */
  async addDeed(req, res) {
    try {
      const { studentId } = req.params;
      const { termId, deedType, score, comment } = req.body;
      const teacherId = req.user.teacherId; // From auth middleware
      const userId = req.user.id; // From auth middleware

      // Validate required fields
      if (!termId || !deedType || score === undefined) {
        return res.status(400).json({
          success: false,
          message: 'Missing required fields: termId, deedType, score'
        });
      }

      const deed = await studentDeedService.addDeed(
        studentId,
        teacherId,
        termId,
        deedType,
        parseFloat(score),
        comment,
        userId
      );

      return res.json({
        success: true,
        data: deed,
        message: `${deedType === 'good' ? 'Good' : 'Bad'} deed added successfully`
      });
    } catch (error) {
      return res.status(500).json({
        success: false,
        message: error.message
      });
    }
  }

  /**
   * Get all deeds for a student
   * GET /api/v1/teachers/students/:studentId/deeds?termId=xxx
   */
  async getStudentDeeds(req, res) {
    try {
      const { studentId } = req.params;
      const { termId } = req.query;

      if (!termId) {
        return res.status(400).json({
          success: false,
          message: 'termId query parameter is required'
        });
      }

      const deeds = await studentDeedService.getStudentDeeds(studentId, termId);

      return res.json({
        success: true,
        data: deeds
      });
    } catch (error) {
      return res.status(500).json({
        success: false,
        message: error.message
      });
    }
  }

  /**
   * Get own deeds (student view)
   * GET /api/v1/students/me/deeds?termId=xxx
   */
  async getOwnDeeds(req, res) {
    try {
      const studentId = req.user.studentId; // From auth middleware
      const { termId } = req.query;

      if (!termId) {
        return res.status(400).json({
          success: false,
          message: 'termId query parameter is required'
        });
      }

      const deeds = await studentDeedService.getStudentDeeds(studentId, termId);

      return res.json({
        success: true,
        data: deeds
      });
    } catch (error) {
      return res.status(500).json({
        success: false,
        message: error.message
      });
    }
  }
}

module.exports = new StudentDeedController();
```

#### 4. Routes

**File:** `backend/src/routes/studentDeeds.js`

```javascript
const express = require('express');
const router = express.Router();
const studentDeedController = require('../controllers/studentDeedController');
const { authenticate, authorize } = require('../middleware/auth');
const { validateTermId } = require('../middleware/termValidation');

// Teacher routes
router.post(
  '/teachers/students/:studentId/deeds',
  authenticate,
  authorize('teacher'),
  studentDeedController.addDeed
);

router.get(
  '/teachers/students/:studentId/deeds',
  authenticate,
  authorize('teacher'),
  validateTermId,
  studentDeedController.getStudentDeeds
);

// Student routes
router.get(
  '/students/me/deeds',
  authenticate,
  authorize('student'),
  validateTermId,
  studentDeedController.getOwnDeeds
);

module.exports = router;
```

**File:** `backend/src/server.js`

Add route:
```javascript
app.use('/api/v1', require('./routes/studentDeeds'));
```

#### 5. HPS Calculation Integration

**File:** `backend/src/services/enhancedUnifiedScoreCalculationServiceV2.js`

**Modify:** `calculateInterventionQuadrantScoresV2` method

Add deed score calculation for Behavior quadrant:

```javascript
// In calculateInterventionQuadrantScoresV2 method
// After calculating behavior_score from interventions:

// Add deed scores to behavior quadrant
if (unifiedQuadrantScores.behavior) {
  const studentDeedService = require('./studentDeedService');
  const deedScore = await studentDeedService.calculateDeedScore(studentId, termId);
  
  // Add deed score to behavior (deed score is already normalized)
  // Assuming behavior_score is out of 100, and deed score needs to be added
  // Max possible deed impact: ±25 points (5 deeds × 5 points each)
  // Normalize to percentage: (deedScore / 25) * 100 = percentage impact
  const deedPercentage = (deedScore / 25) * 100; // Or use different normalization
  unifiedQuadrantScores.behavior.percentage = Math.max(0, Math.min(100, 
    unifiedQuadrantScores.behavior.percentage + deedPercentage
  ));
}
```

### Frontend Implementation

#### 1. API Client

**File:** `frontend/src/lib/api.ts`

Add new API functions:

```typescript
// Student Deeds API
studentDeedAPI: {
  addDeed: async (
    studentId: string,
    data: {
      termId: string;
      deedType: 'good' | 'bad';
      score: number;
      comment?: string;
    }
  ): Promise<ApiResponse<StudentDeed>> => {
    return apiRequest<StudentDeed>(
      `/api/v1/teachers/students/${studentId}/deeds`,
      {
        method: 'POST',
        body: JSON.stringify(data),
      }
    );
  },

  getStudentDeeds: async (
    studentId: string,
    termId: string
  ): Promise<ApiResponse<StudentDeed[]>> => {
    return apiRequest<StudentDeed[]>(
      `/api/v1/teachers/students/${studentId}/deeds?termId=${termId}`
    );
  },

  getOwnDeeds: async (
    termId: string
  ): Promise<ApiResponse<StudentDeed[]>> => {
    return apiRequest<StudentDeed[]>(
      `/api/v1/students/me/deeds?termId=${termId}`
    );
  },
},
```

**Types:**

```typescript
interface StudentDeed {
  id: string;
  student_id: string;
  teacher_id: string;
  term_id: string;
  deed_type: 'good' | 'bad';
  score: number;
  comment?: string;
  created_at: string;
  updated_at: string;
  created_by: string;
  teacher?: {
    id: string;
    name: string;
    employee_id: string;
  };
  term?: {
    id: string;
    name: string;
  };
}
```

#### 2. Teacher Dashboard - Add Deed Dialog

**File:** `frontend/src/components/teacher/AddDeedDialog.tsx` (NEW)

```typescript
import React, { useState } from 'react';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Label } from '@/components/ui/label';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { studentDeedAPI } from '@/lib/api';
import { useTerm } from '@/contexts/TermContext';
import { toast } from 'sonner';
import { ThumbsUp, ThumbsDown } from 'lucide-react';

interface AddDeedDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  studentId: string;
  studentName: string;
  onSuccess?: () => void;
}

const AddDeedDialog: React.FC<AddDeedDialogProps> = ({
  open,
  onOpenChange,
  studentId,
  studentName,
  onSuccess,
}) => {
  const { selectedTerm } = useTerm();
  const [deedType, setDeedType] = useState<'good' | 'bad'>('good');
  const [score, setScore] = useState<string>('0');
  const [comment, setComment] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async () => {
    if (!selectedTerm) {
      toast.error('Please select a term');
      return;
    }

    const scoreNum = parseFloat(score);
    if (isNaN(scoreNum) || scoreNum < 0 || scoreNum > 5) {
      toast.error('Score must be between 0 and 5');
      return;
    }

    try {
      setLoading(true);
      await studentDeedAPI.addDeed(studentId, {
        termId: selectedTerm.id,
        deedType,
        score: scoreNum,
        comment: comment.trim() || undefined,
      });

      toast.success(
        `${deedType === 'good' ? 'Good' : 'Bad'} deed added successfully`
      );
      setDeedType('good');
      setScore('0');
      setComment('');
      onOpenChange(false);
      onSuccess?.();
    } catch (error) {
      toast.error(
        error instanceof Error
          ? error.message
          : 'Failed to add deed'
      );
    } finally {
      setLoading(false);
    }
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>
            Add {deedType === 'good' ? 'Good' : 'Bad'} Deed - {studentName}
          </DialogTitle>
        </DialogHeader>

        <div className="space-y-4">
          <div>
            <Label>Deed Type</Label>
            <Select
              value={deedType}
              onValueChange={(value) => setDeedType(value as 'good' | 'bad')}
            >
              <SelectTrigger>
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="good">
                  <div className="flex items-center gap-2">
                    <ThumbsUp className="h-4 w-4 text-green-600" />
                    Good Deed (+)
                  </div>
                </SelectItem>
                <SelectItem value="bad">
                  <div className="flex items-center gap-2">
                    <ThumbsDown className="h-4 w-4 text-red-600" />
                    Bad Deed (-)
                  </div>
                </SelectItem>
              </SelectContent>
            </Select>
          </div>

          <div>
            <Label>Score (0-5)</Label>
            <Input
              type="number"
              min="0"
              max="5"
              step="0.1"
              value={score}
              onChange={(e) => setScore(e.target.value)}
              placeholder="Enter score"
            />
            <p className="text-xs text-muted-foreground mt-1">
              {deedType === 'good'
                ? 'Positive score will be added to HPS'
                : 'Negative score will be subtracted from HPS'}
            </p>
          </div>

          <div>
            <Label>Comment (Optional)</Label>
            <Textarea
              value={comment}
              onChange={(e) => setComment(e.target.value)}
              placeholder="Add a comment describing the deed..."
              rows={4}
            />
          </div>
        </div>

        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)}>
            Cancel
          </Button>
          <Button onClick={handleSubmit} disabled={loading}>
            {loading ? 'Adding...' : 'Add Deed'}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
};

export default AddDeedDialog;
```

#### 3. Update Teacher Students Page

**File:** `frontend/src/pages/teacher/TeacherStudents.tsx`

**Changes:**
1. Import `AddDeedDialog` component
2. Add "Add Deed" button in student row actions
3. Update API call to fetch all students (Feature 1)

```typescript
// Add state
const [showAddDeedDialog, setShowAddDeedDialog] = useState(false);
const [selectedStudentForDeed, setSelectedStudentForDeed] = useState<AssignedStudent | null>(null);

// Add button in student row
<Button
  variant="outline"
  size="sm"
  onClick={() => {
    setSelectedStudentForDeed(student);
    setShowAddDeedDialog(true);
  }}
>
  <ThumbsUp className="h-4 w-4 mr-1" />
  Add Deed
</Button>

// Add dialog
<AddDeedDialog
  open={showAddDeedDialog}
  onOpenChange={setShowAddDeedDialog}
  studentId={selectedStudentForDeed?.id || ''}
  studentName={selectedStudentForDeed?.name || ''}
  onSuccess={() => {
    // Refresh student list or show success message
  }}
/>
```

#### 4. Student Dashboard - Behavior Quadrant Deeds View

**File:** `frontend/src/pages/student/QuadrantDetail.tsx`

**Changes:**
1. Add new tab or section for "Deeds" when viewing Behavior quadrant
2. Fetch and display student's deeds

**New Component:** `frontend/src/components/student/StudentDeedsList.tsx`

```typescript
import React, { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { studentDeedAPI } from '@/lib/api';
import { useTerm } from '@/contexts/TermContext';
import { ThumbsUp, ThumbsDown, User } from 'lucide-react';
import { format } from 'date-fns';

interface StudentDeedsListProps {
  studentId: string;
}

const StudentDeedsList: React.FC<StudentDeedsListProps> = ({ studentId }) => {
  const { selectedTerm } = useTerm();
  const [deeds, setDeeds] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (selectedTerm) {
      fetchDeeds();
    }
  }, [selectedTerm, studentId]);

  const fetchDeeds = async () => {
    try {
      setLoading(true);
      const response = await studentDeedAPI.getOwnDeeds(selectedTerm!.id);
      setDeeds(response.data || []);
    } catch (error) {
      console.error('Error fetching deeds:', error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return <div>Loading...</div>;
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle>My Good & Bad Deeds</CardTitle>
      </CardHeader>
      <CardContent>
        {deeds.length === 0 ? (
          <p className="text-muted-foreground text-center py-8">
            No deeds recorded yet
          </p>
        ) : (
          <div className="space-y-4">
            {deeds.map((deed) => (
              <div
                key={deed.id}
                className={`p-4 rounded-lg border ${
                  deed.deed_type === 'good'
                    ? 'bg-green-50 border-green-200'
                    : 'bg-red-50 border-red-200'
                }`}
              >
                <div className="flex items-start justify-between">
                  <div className="flex items-start gap-3">
                    {deed.deed_type === 'good' ? (
                      <ThumbsUp className="h-5 w-5 text-green-600 mt-0.5" />
                    ) : (
                      <ThumbsDown className="h-5 w-5 text-red-600 mt-0.5" />
                    )}
                    <div className="flex-1">
                      <div className="flex items-center gap-2 mb-1">
                        <Badge
                          variant={
                            deed.deed_type === 'good' ? 'default' : 'destructive'
                          }
                        >
                          {deed.deed_type === 'good' ? '+' : '-'}
                          {deed.score}
                        </Badge>
                        <span className="text-sm text-muted-foreground">
                          by {deed.teacher?.name || 'Unknown Teacher'}
                        </span>
                      </div>
                      {deed.comment && (
                        <p className="text-sm mt-2">{deed.comment}</p>
                      )}
                      <p className="text-xs text-muted-foreground mt-2">
                        {format(new Date(deed.created_at), 'MMM dd, yyyy HH:mm')}
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}
      </CardContent>
    </Card>
  );
};

export default StudentDeedsList;
```

**Update QuadrantDetail.tsx:**

```typescript
// Add import
import StudentDeedsList from '@/components/student/StudentDeedsList';

// In the Behavior quadrant section, add:
{activeQuadrant === "behavior" && (
  <div className="mt-8">
    <BehaviorRatingScale />
    <div className="mt-6">
      <StudentDeedsList studentId={studentId} />
    </div>
  </div>
)}
```

---

## Implementation Steps

### Phase 1: Database & Backend Foundation
1. ✅ Create database migration for `student_deeds` table
2. ✅ Create `studentDeedService.js`
3. ✅ Create `studentDeedController.js`
4. ✅ Create routes and integrate into server
5. ✅ Update HPS calculation to include deed scores

### Phase 2: Feature 1 - Show All Students
1. ✅ Update backend `getAssignedStudents` or create new endpoint
2. ✅ Update frontend API client
3. ✅ Update `TeacherStudents.tsx` to fetch all students
4. ✅ Test and verify

### Phase 3: Feature 2 - Deed System (Backend)
1. ✅ Test deed creation API
2. ✅ Test deed retrieval APIs
3. ✅ Verify HPS recalculation triggers
4. ✅ Test edge cases (score limits, validation)

### Phase 4: Feature 2 - Deed System (Frontend)
1. ✅ Create `AddDeedDialog` component
2. ✅ Integrate into `TeacherStudents.tsx`
3. ✅ Create `StudentDeedsList` component
4. ✅ Integrate into `QuadrantDetail.tsx` for Behavior quadrant
5. ✅ Test end-to-end flow

### Phase 5: Testing & Refinement
1. ✅ Test with multiple teachers and students
2. ✅ Verify HPS calculation accuracy
3. ✅ Test edge cases (negative scores, max scores)
4. ✅ UI/UX refinements
5. ✅ Performance testing

---

## Testing Checklist

### Feature 1: All Students View
- [ ] Teachers can see all students regardless of assignments
- [ ] Search functionality works
- [ ] Pagination works correctly
- [ ] Filters (batch, section) work correctly

### Feature 2: Deed System
- [ ] Teachers can add good deeds (+0 to 5)
- [ ] Teachers can add bad deeds (-0 to 5)
- [ ] Score validation works (0-5 range)
- [ ] Comments are saved correctly
- [ ] HPS recalculates automatically after deed addition
- [ ] Students can view their own deeds
- [ ] Deeds show correct teacher name
- [ ] Deeds are filtered by term correctly
- [ ] Behavior quadrant score includes deed impact
- [ ] Multiple deeds accumulate correctly

---

## Edge Cases & Considerations

1. **Score Normalization**: How to normalize deed scores to HPS percentage?
   - Option A: Direct addition/subtraction (±1 deed point = ±1 HPS point)
   - Option B: Scaled impact (e.g., ±1 deed point = ±0.5% HPS)
   - **Recommendation**: Start with Option A, make configurable later

2. **Deed Limits**: Should there be limits on number of deeds per student/term?
   - **Recommendation**: No hard limit initially, monitor usage

3. **Deed History**: Should old deeds be editable/deletable?
   - **Recommendation**: Read-only for audit trail, add edit/delete in future if needed

4. **Notifications**: Should students be notified when deeds are added?
   - **Recommendation**: Add in future phase

5. **Reporting**: Should there be reports on deed distribution?
   - **Recommendation**: Add in future phase

---

## Future Enhancements

1. Deed categories/tags
2. Bulk deed import
3. Deed templates
4. Deed analytics dashboard
5. Email notifications for students
6. Deed approval workflow (if needed)
7. Integration with attendance system
8. Deed leaderboards

---

## Notes

- Ensure proper authentication and authorization at all levels
- Add proper error handling and validation
- Consider adding audit logging for deed additions
- Performance: Index database properly for queries
- Security: Validate all inputs, prevent SQL injection
- UX: Provide clear feedback on deed impact on HPS

