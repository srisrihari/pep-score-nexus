# Intervention Teacher Assignment Restructure Plan

## 📋 **Understanding Your Proposed Change**

### **System Flow Clarification:**

1. **Create Intervention** → Assign multiple microcompetencies ✅
2. **Assign Multiple Teachers** → Each teacher handles ALL microcompetencies ✅
3. **Enroll Student Groups** → For EACH teacher, enroll a group of students ✅
4. **Critical Constraint** → Each student can ONLY be enrolled ONCE per intervention (cannot be assigned to multiple teachers in same intervention) ✅

### **Current System (Complex)**
```
Interventions
    ├── intervention_microcompetencies (microcompetencies linked to intervention)
    ├── teacher_microcompetency_assignments (teachers assigned per microcompetency)
    │   └── Each teacher assignment is tied to a specific microcompetency_id
    └── intervention_enrollments (students enrolled globally)
        └── Students enrolled in intervention, but no direct teacher link
        └── ⚠️ No constraint preventing duplicate enrollments
```

**Problem:** Teachers are assigned per microcompetency, creating complexity. Students can't be grouped by teacher.

### **Proposed New System (Simplified & Constrained)**
```
Interventions
    ├── intervention_microcompetencies (microcompetencies linked to intervention)
    ├── teacher_microcompetency_assignments (teachers assigned to intervention - NO microcompetency_id)
    │   └── Teachers assigned to intervention directly (all microcompetencies)
    └── intervention_enrollments (students enrolled with REQUIRED teacher assignment)
        └── intervention_teacher_id column (REQUIRED, links student to specific teacher)
        └── UNIQUE constraint: (intervention_id, student_id) - One enrollment per student per intervention
```

**Key Requirements:**
- ✅ Teachers assigned once to intervention (handle all microcompetencies)
- ✅ Students MUST be assigned to a teacher when enrolled
- ✅ Each student can ONLY be enrolled ONCE per intervention
- ✅ Student group assignment: For each teacher, assign a group of students
- ✅ Student scoring: Students are scored by their assigned teacher
- ✅ Task completion: Students complete tasks from their assigned teacher

---

## 🗄️ **Current Database Structure**

### **1. `teacher_microcompetency_assignments` Table**
```sql
Current Columns:
- id (uuid, PK)
- intervention_id (uuid, FK → interventions)
- teacher_id (uuid, FK → teachers)
- microcompetency_id (uuid, FK → microcompetencies) ⚠️ TO BE REMOVED
- can_score (boolean, default: true)
- can_create_tasks (boolean, default: true)
- assigned_at (timestamp, default: CURRENT_TIMESTAMP)
- assigned_by (uuid, FK → users)
- is_active (boolean, default: true)

Current Data: 33 records
```

### **2. `intervention_enrollments` Table**
```sql
Current Columns:
- id (uuid, PK)
- intervention_id (uuid, FK → interventions)
- student_id (uuid, FK → students)
- enrollment_date (date, default: CURRENT_DATE)
- enrollment_status (enum: 'Enrolled', 'Pending', 'Dropped', 'Completed')
- enrollment_type (enum: 'Mandatory', 'Optional')
- progress_data (jsonb, default: '{}')
- current_score (numeric, default: 0.00)
- completion_percentage (numeric, default: 0.00)
- enrolled_by (uuid, FK → users)
- enrollment_deadline (timestamp, nullable)

Current Data: 25 records
⚠️ MISSING: intervention_teacher_id column
```

### **3. `intervention_microcompetencies` Table**
```sql
Current Columns:
- id (uuid, PK)
- intervention_id (uuid, FK → interventions)
- microcompetency_id (uuid, FK → microcompetencies)
- weightage (numeric)
- max_score (numeric, default: 10.00)
- is_active (boolean, default: true)
- created_at (timestamp, default: CURRENT_TIMESTAMP)

Current Data: 43 records
✅ NO CHANGES NEEDED - This structure is correct
```

---

## 🔄 **Proposed Database Changes**

### **Change 1: Modify `teacher_microcompetency_assignments`**

**Action:** Remove `microcompetency_id` column, make teacher assignments intervention-level only

```sql
-- Step 1: Drop foreign key constraint
ALTER TABLE teacher_microcompetency_assignments 
DROP CONSTRAINT teacher_microcompetency_assignments_microcompetency_id_fkey;

-- Step 2: Remove microcompetency_id column
ALTER TABLE teacher_microcompetency_assignments 
DROP COLUMN microcompetency_id;

-- Step 3: Add unique constraint (optional but recommended)
-- Prevents duplicate teacher assignments to same intervention
ALTER TABLE teacher_microcompetency_assignments
ADD CONSTRAINT unique_teacher_intervention 
UNIQUE (teacher_id, intervention_id) 
WHERE is_active = true;

-- Resulting structure:
-- id, intervention_id, teacher_id, can_score, can_create_tasks, 
-- assigned_at, assigned_by, is_active
```

**Impact:**
- Teachers are now assigned to interventions (not individual microcompetencies)
- Each teacher handles ALL microcompetencies in their assigned intervention
- One record per teacher per intervention (instead of multiple per microcompetency)

### **Change 2: Add `intervention_teacher_id` to `intervention_enrollments`**

**Action:** Add REQUIRED column to link students to their assigned teacher, with UNIQUE constraint

```sql
-- Step 1: Add new column (nullable initially for migration)
ALTER TABLE intervention_enrollments
ADD COLUMN intervention_teacher_id uuid;

-- Step 2: Add UNIQUE constraint to prevent duplicate enrollments
-- CRITICAL: One student can only be enrolled once per intervention
ALTER TABLE intervention_enrollments
ADD CONSTRAINT unique_student_intervention_enrollment 
UNIQUE (intervention_id, student_id);

-- Step 3: Add foreign key constraint
ALTER TABLE intervention_enrollments
ADD CONSTRAINT intervention_enrollments_intervention_teacher_id_fkey
FOREIGN KEY (intervention_teacher_id)
REFERENCES teacher_microcompetency_assignments(id)
ON DELETE RESTRICT; -- Prevent deletion of teacher assignment if students are enrolled

-- Step 4: Add index for performance
CREATE INDEX idx_intervention_enrollments_intervention_teacher_id
ON intervention_enrollments(intervention_teacher_id);

-- Step 5: After migration, make intervention_teacher_id REQUIRED (NOT NULL)
-- This ensures all enrollments MUST have a teacher assignment
ALTER TABLE intervention_enrollments
ALTER COLUMN intervention_teacher_id SET NOT NULL;

-- Resulting structure:
-- ... existing columns ...
-- intervention_teacher_id (uuid, FK → teacher_microcompetency_assignments.id, REQUIRED)
-- UNIQUE constraint: (intervention_id, student_id) - Ensures one enrollment per student
```

**Impact:**
- ✅ Each student enrollment MUST link to a specific teacher assignment
- ✅ Students can be assigned to different teachers (but only ONE per intervention)
- ✅ UNIQUE constraint prevents duplicate enrollments
- ✅ Enables student group management per teacher
- ✅ Validation enforced at database level

---

## 📊 **New Data Flow**

### **Example Scenario:**

**Step 1: Create Intervention**
- **Intervention:** "Communication Skills 2024"
- **Microcompetencies:** MC1, MC2, MC3, MC4, MC5 (all assigned to intervention via `intervention_microcompetencies`)

**Step 2: Assign Teachers to Intervention**
- **Teacher A** → Assigned to intervention (handles ALL microcompetencies)
  - Assignment ID: `assignment_A_id` (from `teacher_microcompetency_assignments`)
- **Teacher B** → Assigned to intervention (handles ALL microcompetencies)
  - Assignment ID: `assignment_B_id` (from `teacher_microcompetency_assignments`)

**Step 3: Enroll Student Groups to Teachers**
- **For Teacher A (assignment_A_id):**
  - Student 1 → Enrolled with `intervention_teacher_id` = `assignment_A_id`
  - Student 2 → Enrolled with `intervention_teacher_id` = `assignment_A_id`
  - Student 5 → Enrolled with `intervention_teacher_id` = `assignment_A_id`
  
- **For Teacher B (assignment_B_id):**
  - Student 3 → Enrolled with `intervention_teacher_id` = `assignment_B_id`
  - Student 4 → Enrolled with `intervention_teacher_id` = `assignment_B_id`

**Result:**
- ✅ Teacher A handles Students 1, 2, 5 for ALL microcompetencies (MC1-MC5)
- ✅ Teacher B handles Students 3, 4 for ALL microcompetencies (MC1-MC5)
- ✅ Each student enrolled ONLY ONCE (UNIQUE constraint enforced)
- ✅ Students complete tasks from their assigned teacher
- ✅ Students are scored by their assigned teacher for all microcompetencies

**❌ NOT ALLOWED:**
- Student 1 cannot be enrolled again under Teacher B in same intervention
- Student enrollment without `intervention_teacher_id` (REQUIRED)

---

## 🔧 **Backend API Changes Required**

### **1. Teacher Assignment APIs**

#### **Current API: `POST /api/v1/interventions/:id/assign-teachers-microcompetencies`**
```javascript
// CURRENT: Assigns teachers to specific microcompetencies
POST /api/v1/interventions/:id/assign-teachers-microcompetencies
Body: {
  assignments: [
    { teacher_id, microcompetency_id, can_score, can_create_tasks }
  ]
}
```

#### **New API: `POST /api/v1/interventions/:id/assign-teachers`**
```javascript
// NEW: Assigns teachers directly to intervention
POST /api/v1/interventions/:id/assign-teachers
Body: {
  teachers: [
    { 
      teacher_id, 
      can_score: true, 
      can_create_tasks: true 
    }
  ]
}

// Implementation:
// 1. For each teacher, create ONE record in teacher_microcompetency_assignments
//    WITHOUT microcompetency_id
// 2. Return assignment IDs for use in student enrollment
```

#### **Update API: `GET /api/v1/interventions/:id/teachers`**
```javascript
// CURRENT: Returns teachers per microcompetency
GET /api/v1/interventions/:id/teachers
Response: {
  teachers: [
    {
      teacher_id,
      name,
      microcompetencies: [mc1, mc2, ...] // Per microcompetency
    }
  ]
}

// NEW: Returns all teachers assigned to intervention
GET /api/v1/interventions/:id/teachers
Response: {
  teachers: [
    {
      assignment_id, // ID from teacher_microcompetency_assignments
      teacher_id,
      name,
      can_score,
      can_create_tasks,
      assigned_at,
      // All microcompetencies in intervention (from intervention_microcompetencies)
      intervention_microcompetencies: [mc1, mc2, mc3, ...]
    }
  ]
}
```

### **2. Student Enrollment APIs**

#### **Update API: `POST /api/v1/interventions/:id/enroll-students`**
```javascript
// CURRENT: Enrolls students globally
POST /api/v1/interventions/:id/enroll-students
Body: {
  studentIds: [student1, student2, ...],
  enrollmentType: 'Mandatory'
}

// NEW: Enrolls students with REQUIRED teacher assignment
POST /api/v1/interventions/:id/enroll-students
Body: {
  intervention_teacher_id: 'assignment_id', // REQUIRED: ID from teacher_microcompetency_assignments
  studentIds: [student1, student2, ...], // Group of students for this teacher
  enrollmentType: 'Mandatory'
}

// Validation:
// 1. intervention_teacher_id MUST be provided (REQUIRED)
// 2. intervention_teacher_id must exist in teacher_microcompetency_assignments for this intervention
// 3. Check each student_id: If already enrolled (intervention_id, student_id), REJECT with error
// 4. Create enrollments with intervention_teacher_id for all students
// 5. Return enrollment IDs and teacher assignment info

// Response:
{
  success: true,
  message: "Students enrolled successfully",
  data: {
    intervention_teacher_id: 'assignment_id',
    teacher_name: 'Teacher Name',
    enrollments_created: 5,
    enrollments: [...],
    rejected_students: [ // Students already enrolled
      { student_id: 'xxx', reason: 'Already enrolled in this intervention' }
    ]
  }
}
```

#### **Update API: `POST /api/v1/interventions/:id/enroll-batch`**
```javascript
// CURRENT: Enrolls entire batch
POST /api/v1/interventions/:id/enroll-batch
Body: {
  batch_ids: [batch1, batch2],
  enrollmentType: 'Mandatory'
}

// NEW: Enrolls batch and REQUIRES teacher assignment
POST /api/v1/interventions/:id/enroll-batch
Body: {
  batch_ids: [batch1, batch2],
  intervention_teacher_id: 'assignment_id', // REQUIRED: Assign all batch students to this teacher
  section_ids: [section1, section2], // Optional: Filter by sections
  enrollmentType: 'Mandatory'
}

// Validation:
// 1. intervention_teacher_id MUST be provided (REQUIRED)
// 2. Get all students from specified batches/sections
// 3. Filter out students already enrolled (check unique constraint)
// 4. Enroll remaining students with intervention_teacher_id
// 5. Return enrolled count and rejected students
```

#### **New API: `PUT /api/v1/interventions/:id/enrollments/:enrollmentId/reassign-teacher`**
```javascript
// NEW: Reassign student to different teacher in same intervention
// NOTE: This updates existing enrollment, not creating duplicate
PUT /api/v1/interventions/:id/enrollments/:enrollmentId/reassign-teacher
Body: {
  intervention_teacher_id: 'new-teacher-assignment-id' // REQUIRED
}

// Validation:
// 1. Check enrollment exists
// 2. Verify new intervention_teacher_id belongs to same intervention
// 3. Update enrollment.intervention_teacher_id
// 4. Return updated enrollment

// This is allowed because it's updating existing enrollment, not creating duplicate
```

### **3. Teacher Queries (Major Changes)**

#### **Update API: `GET /api/v1/teacher-microcompetencies/:teacherId/microcompetencies`**
```javascript
// CURRENT: Returns microcompetencies assigned to teacher
GET /api/v1/teacher-microcompetencies/:teacherId/microcompetencies

// NEW: Returns interventions where teacher is assigned (with all microcompetencies)
GET /api/v1/teacher-microcompetencies/:teacherId/interventions
Response: {
  interventions: [
    {
      intervention_id,
      intervention_name,
      teacher_assignment_id, // ID from teacher_microcompetency_assignments
      can_score,
      can_create_tasks,
      microcompetencies: [
        // ALL microcompetencies from intervention_microcompetencies
        { id, name, weightage, max_score, ... }
      ],
      assigned_students: [
        // Students with intervention_teacher_id = teacher_assignment_id
        { student_id, name, enrollment_status, ... }
      ]
    }
  ]
}
```

#### **Update API: `GET /api/v1/teacher-microcompetencies/:teacherId/students/:interventionId`**
```javascript
// CURRENT: Gets students per microcompetency
GET /api/v1/teacher-microcompetencies/:teacherId/students/:interventionId?microcompetencyId=xxx

// NEW: Gets all students assigned to teacher in intervention
GET /api/v1/teacher-microcompetencies/:teacherId/students/:interventionId
Response: {
  students: [
    {
      student_id,
      name,
      enrollment_id,
      enrollment_status,
      // All microcompetencies for scoring context
      microcompetencies: [mc1, mc2, ...]
    }
  ]
}
```

### **4. Scoring APIs**

#### **Update API: `POST /api/v1/teacher/:teacherId/score-microcompetency`**
```javascript
// CURRENT: Scores microcompetency (requires teacher assignment to that microcompetency)
POST /api/v1/teacher/:teacherId/score-microcompetency

// NEW: Scores microcompetency (requires teacher assigned to intervention)
// Validation: Check if student's intervention_teacher_id matches teacher's assignment
POST /api/v1/teacher/:teacherId/score-microcompetency
Body: {
  student_id,
  intervention_id,
  microcompetency_id,
  obtained_score,
  feedback
}

// Validation Logic:
// 1. Check if teacher is assigned to intervention (teacher_microcompetency_assignments)
// 2. Check if student's intervention_enrollments.intervention_teacher_id matches teacher's assignment_id
// 3. Check if microcompetency exists in intervention_microcompetencies
// 4. Allow scoring if all conditions met
```

### **5. Controller Changes**

#### **Files to Modify:**

1. **`backend/src/controllers/interventionController.js`**
   - `assignTeachers()` → Remove microcompetency_id handling
   - `getInterventionTeachers()` → Return all teachers with all microcompetencies
   - `enrollStudents()` → Add intervention_teacher_id support
   - `enrollStudentsByBatch()` → Add intervention_teacher_id support

2. **`backend/src/controllers/teacherMicrocompetencyController.js`**
   - `getTeacherMicrocompetencies()` → Return interventions instead of microcompetencies
   - `getTeacherInterventionStudents()` → Get students via intervention_teacher_id
   - `assignTeachersToMicrocompetencies()` → Remove, replace with intervention-level assignment

3. **`backend/src/controllers/teacherController.js`**
   - `getAssignedStudents()` → Update to use intervention_teacher_id
   - `getStudentAssessmentDetails()` → Check intervention_teacher_id for access

4. **`backend/src/services/bulkTeacherAssignmentService.js`**
   - Update to create intervention-level assignments only

---

## 🎨 **Frontend UI Changes Required**

### **1. Admin: Intervention Creation (Multi-Step Form)**

#### **Current Step 3: Teacher Assignment Per Microcompetency**
```typescript
// CURRENT: Assign teacher to each microcompetency individually
selectedMicrocompetencies.map(mc => (
  <Select teacher for {mc.name} />
))
```

#### **New Step 3: Assign Teachers to Intervention**
```typescript
// NEW: Assign multiple teachers to intervention
// Then in Step 4: Assign students to teachers

// Step 3: Teacher Assignment
interface TeacherAssignment {
  teacher_id: string;
  teacher_name: string;
  can_score: boolean;
  can_create_tasks: boolean;
  assignment_id?: string; // Returned from API
}

// Step 4: Student Assignment to Teachers
interface StudentTeacherAssignment {
  student_id: string;
  intervention_teacher_id: string; // Teacher assignment ID
}

// UI Component: TeacherAssignmentStep.tsx
<div>
  <h3>Assign Teachers to Intervention</h3>
  {teachers.map(teacher => (
    <Checkbox 
      label={teacher.name}
      onChange={() => addTeacherToIntervention(teacher)}
    />
  ))}
  
  <Card>
    <h4>Assigned Teachers</h4>
    {assignedTeachers.map(assignment => (
      <div>
        <span>{assignment.teacher_name}</span>
        <Checkbox label="Can Score" />
        <Checkbox label="Can Create Tasks" />
      </div>
    ))}
  </Card>
</div>

// UI Component: StudentTeacherAssignmentStep.tsx
<div>
  <h3>Assign Student Groups to Teachers</h3>
  <Alert>
    Each student can only be enrolled ONCE per intervention. 
    Students already enrolled will be skipped.
  </Alert>
  
  {assignedTeachers.map(teacherAssignment => (
    <Card>
      <h4>{teacherAssignment.teacher_name}'s Student Group</h4>
      <StudentGroupSelector
        teacherAssignmentId={teacherAssignment.assignment_id}
        onStudentsSelected={(studentIds) => 
          assignStudentsToTeacher(studentIds, teacherAssignment.assignment_id)
        }
        // Options: Select by batch, section, or manually
        // Validation: Show warning if student already enrolled
      />
      
      <div className="enrolled-students-list">
        <h5>Currently Assigned Students ({teacherAssignment.students.length})</h5>
        {teacherAssignment.students.map(student => (
          <StudentCard student={student} />
        ))}
      </div>
    </Card>
  ))}
  
  <ValidationSummary>
    {/* Show students that couldn't be assigned (already enrolled) */}
    {rejectedStudents.map(student => (
      <Alert variant="warning">
        {student.name} is already enrolled under another teacher
      </Alert>
    ))}
  </ValidationSummary>
</div>
```

### **2. Teacher Pages**

#### **MyMicrocompetencies.tsx - Major Rewrite**
```typescript
// CURRENT: Shows individual microcompetencies
// NEW: Shows interventions with all microcompetencies

interface TeacherInterventionView {
  intervention_id: string;
  intervention_name: string;
  assignment_id: string;
  microcompetencies: Microcompetency[];
  assigned_students: Student[];
}

// Component Update:
const MyInterventions: React.FC = () => {
  // Fetch teacher's interventions
  const { interventions } = useTeacherInterventions();
  
  return (
    <div>
      {interventions.map(intervention => (
        <Card>
          <h3>{intervention.name}</h3>
          <p>{intervention.microcompetencies.length} Microcompetencies</p>
          <p>{intervention.assigned_students.length} Students</p>
          <Button onClick={() => navigate(`/teacher/interventions/${intervention.id}`)}>
            View Details
          </Button>
        </Card>
      ))}
    </div>
  );
};
```

#### **MicrocompetencyScoringPage.tsx - Update**
```typescript
// CURRENT: Shows students for specific microcompetency
// NEW: Shows all students assigned to teacher in intervention

const MicrocompetencyScoringPage: React.FC = () => {
  const { interventionId, microcompetencyId } = useParams();
  
  // Fetch all students assigned to teacher in this intervention
  const { students } = useTeacherInterventionStudents(interventionId);
  
  // Filter to show students for scoring this microcompetency
  return (
    <div>
      <h2>Score {microcompetencyName}</h2>
      <p>Students assigned to you: {students.length}</p>
      {students.map(student => (
        <StudentScoreCard
          student={student}
          microcompetencyId={microcompetencyId}
        />
      ))}
    </div>
  );
};
```

#### **TeacherStudents.tsx - Update**
```typescript
// CURRENT: Shows all students assigned to teacher
// NEW: Group students by intervention

const TeacherStudents: React.FC = () => {
  const { studentsByIntervention } = useTeacherStudents();
  
  return (
    <Tabs>
      {studentsByIntervention.map(intervention => (
        <TabsTrigger value={intervention.id}>
          {intervention.name}
        </TabsTrigger>
      ))}
      
      {studentsByIntervention.map(intervention => (
        <TabsContent value={intervention.id}>
          <StudentList students={intervention.students} />
        </TabsContent>
      ))}
    </Tabs>
  );
};
```

### **3. Student Pages**

#### **InterventionDetailsPage.tsx - Minor Update**
```typescript
// Add: Show assigned teacher
interface StudentInterventionView {
  intervention: Intervention;
  assigned_teacher: {
    name: string;
    assignment_id: string;
  };
}

// Component Update:
<div>
  <h2>{intervention.name}</h2>
  <div>
    <span>Your Teacher: {assigned_teacher.name}</span>
  </div>
  {/* Rest of component */}
</div>
```

### **4. Admin: Intervention Management**

#### **InterventionTeachers.tsx - Major Rewrite**
```typescript
// CURRENT: Manage teachers per microcompetency
// NEW: Manage teachers for intervention, then assign student groups

const InterventionTeachers: React.FC = () => {
  const [teachers, setTeachers] = useState<TeacherAssignment[]>([]);
  const [studentAssignments, setStudentAssignments] = useState<StudentTeacherAssignment[]>([]);
  
  return (
    <Tabs>
      <TabsTrigger value="teachers">Assign Teachers</TabsTrigger>
      <TabsTrigger value="students">Assign Students to Teachers</TabsTrigger>
      
      <TabsContent value="teachers">
        {/* Assign teachers to intervention */}
        <TeacherAssignmentForm />
      </TabsContent>
      
      <TabsContent value="students">
        {/* Assign student groups to teachers */}
        <StudentTeacherAssignmentForm />
      </TabsContent>
    </Tabs>
  );
};
```

#### **InterventionStudents.tsx - Update**
```typescript
// CURRENT: Shows all enrolled students
// NEW: Show students grouped by assigned teacher

const InterventionStudents: React.FC = () => {
  const { studentsByTeacher } = useInterventionStudents(interventionId);
  
  return (
    <div>
      {studentsByTeacher.map(group => (
        <Card>
          <h3>Teacher: {group.teacher_name}</h3>
          <StudentList students={group.students} />
        </Card>
      ))}
    </div>
  );
};
```

---

## 📝 **Migration Strategy**

### **Step 1: Database Migration**
```sql
-- 1. Add intervention_teacher_id to intervention_enrollments (nullable)
ALTER TABLE intervention_enrollments
ADD COLUMN intervention_teacher_id uuid;

-- 2. Migrate existing data (if any)
-- For each intervention:
--   - Get teachers assigned to that intervention
--   - Create new teacher_microcompetency_assignments without microcompetency_id
--   - Assign students to teachers (you'll need a strategy here)

-- 3. Remove microcompetency_id from teacher_microcompetency_assignments
ALTER TABLE teacher_microcompetency_assignments
DROP COLUMN microcompetency_id;

-- 4. Add foreign key constraint
ALTER TABLE intervention_enrollments
ADD CONSTRAINT intervention_enrollments_intervention_teacher_id_fkey
FOREIGN KEY (intervention_teacher_id)
REFERENCES teacher_microcompetency_assignments(id)
ON DELETE SET NULL;
```

### **Step 2: Backend API Updates**
1. Update all controllers to use new structure
2. Update validation logic
3. Update query logic to join correctly
4. Test all endpoints

### **Step 3: Frontend Updates**
1. Update admin intervention creation flow
2. Update teacher pages
3. Update student pages
4. Update API integration

### **Step 4: Testing**
1. Create new intervention with new flow
2. Assign teachers
3. Enroll students with teacher assignments
4. Test teacher scoring
5. Test student views

---

## ⚠️ **Important Considerations**

### **1. Data Migration**
- **Current:** 33 teacher assignments, 25 student enrollments
- **Strategy:** Need to decide how to migrate existing data
- **Option A:** Assign all students to first teacher in each intervention
- **Option B:** Manual reassignment required
- **Option C:** Auto-assign based on batch/section

### **2. Backward Compatibility**
- Old API endpoints might still be used
- Consider maintaining old endpoints with deprecation warnings
- Or create versioned APIs (`/api/v2/...`)

### **3. Validation**
- Ensure student can only be assigned to one teacher per intervention
- Ensure teacher is assigned to intervention before student assignment
- Ensure microcompetency exists in intervention before scoring

### **4. Performance**
- Add indexes on `intervention_teacher_id`
- Optimize queries for teacher-student lookups
- Cache intervention teacher assignments

---

## ✅ **Summary**

Your proposed change is excellent! It simplifies the data model significantly while enforcing critical constraints:

### **System Flow:**
1. **Create Intervention** → Assign multiple microcompetencies
2. **Assign Multiple Teachers** → Each teacher handles ALL microcompetencies
3. **Enroll Student Groups** → For EACH teacher, enroll a group of students
4. **Enforcement** → Each student enrolled ONLY ONCE per intervention

### **Key Changes:**
**Before:** Teachers → Microcompetencies → Interventions → Students (no grouping, complex)
**After:** Interventions → Teachers & Microcompetencies → Students → Teachers (grouped, simple)

### **Database Constraints:**
- ✅ `intervention_teacher_id` is REQUIRED (NOT NULL)
- ✅ UNIQUE constraint: `(intervention_id, student_id)` - Prevents duplicate enrollments
- ✅ Foreign key ensures teacher assignment belongs to intervention

### **Benefits:**
- ✅ **Student Grouping:** Easy to assign groups of students to each teacher
- ✅ **Cleaner Data Model:** One teacher assignment per intervention (not per microcompetency)
- ✅ **Better Scalability:** Simpler queries, better performance
- ✅ **Simpler Teacher Workflow:** Teachers see all their students and all microcompetencies
- ✅ **Clearer Relationships:** Direct link between students and teachers
- ✅ **Data Integrity:** Database-level constraints prevent duplicate enrollments

### **Critical Requirements Enforced:**
- ✅ Students MUST be assigned to a teacher when enrolled
- ✅ Students CANNOT be enrolled multiple times in same intervention
- ✅ Students complete tasks from their assigned teacher
- ✅ Students are scored by their assigned teacher
- ✅ Each teacher handles ALL microcompetencies for their student group

The changes are significant but well-structured and will result in a much better system!

