// Intervention Types
export interface Intervention {
  id: string;
  name: string;
  description: string;
  start_date: string;
  end_date: string;
  status: 'Draft' | 'Active' | 'Completed' | 'Cancelled';
  quadrant_weightages: Record<string, number>;
  max_students: number;
  objectives: string[];
  prerequisites?: string[];
  created_at: string;
  updated_at: string;
  enrolled_count?: number;
}

export interface InterventionDetails extends Intervention {
  teachers: InterventionTeacher[];
  enrolled_students: EnrolledStudent[];
  tasks: InterventionTask[];
}

export interface InterventionTeacher {
  id: string;
  name: string;
  employee_id: string;
  assigned_quadrants: string[];
  role: 'Lead' | 'Assistant' | 'Observer';
  permissions: string[];
  assigned_at: string;
  is_active: boolean;
}

export interface EnrolledStudent {
  id: string;
  name: string;
  registration_no: string;
  enrollment_status: 'Enrolled' | 'Completed' | 'Dropped' | 'Pending';
  enrolled_at: string;
  completion_percentage?: number;
}

export interface InterventionTask {
  id: string;
  name: string;
  description: string;
  quadrant_id: string;
  component_id: string;
  max_score: number;
  due_date: string;
  instructions: string;
  submission_type: 'Document' | 'Presentation' | 'Video' | 'Audio' | 'Link' | 'Text';
  status: 'Draft' | 'Active' | 'Completed' | 'Cancelled';
  allow_late_submission: boolean;
  late_penalty: number;
  created_at: string;
  created_by: string;
  components?: {
    name: string;
  };
}

export interface TaskSubmission {
  id: string;
  task_id: string;
  student_id: string;
  submitted_at: string;
  status: 'Submitted' | 'Graded' | 'Late' | 'Pending Review';
  is_late: boolean;
  submission_text: string;
  submission_files?: string[];
  score?: number;
  feedback?: string;
  private_notes?: string;
  graded_at?: string;
  graded_by?: string;
  tasks: {
    id: string;
    name: string;
    quadrant_id: string;
    max_score: number;
    due_date: string;
  };
  students: {
    id: string;
    name: string;
    registration_no: string;
  };
}

export interface InterventionAnalytics {
  intervention: {
    id: string;
    name: string;
    status: string;
    duration_days: number;
  };
  enrollment: {
    total_enrolled: number;
    max_capacity: number;
    capacity_utilization: string;
    by_status: Record<string, number>;
    average_completion: number;
    average_score: number;
  };
  tasks: {
    total_tasks: number;
    by_status: Record<string, number>;
    by_quadrant: Record<string, number>;
  };
  submissions: {
    total_submissions: number;
    by_status: Record<string, number>;
    late_submissions: number;
  };
}

export interface TeacherInterventionAssignment {
  id: string;
  assigned_quadrants: string[];
  role: string;
  permissions: string[];
  assigned_at: string;
  is_active: boolean;
  interventions: {
    id: string;
    name: string;
    description: string;
    start_date: string;
    end_date: string;
    status: string;
    max_students: number;
  };
}

export interface TeacherInterventionDetails {
  intervention: {
    id: string;
    name: string;
    description: string;
    start_date: string;
    end_date: string;
    status: string;
    max_students: number;
    objectives: string[];
  };
  assignment: {
    role: string;
    assigned_quadrants: string[];
    permissions: string[];
  };
  tasks: InterventionTask[];
  enrolled_students: number;
}

// Form Types
export interface CreateInterventionForm {
  name: string;
  description: string;
  startDate: string;
  endDate: string;
  quadrantWeightages: Record<string, number>;
  prerequisites: string[];
  maxStudents: number;
  objectives: string[];
}

export interface CreateTaskForm {
  name: string;
  description: string;
  quadrantId: string;
  componentId?: string;
  maxScore: number;
  dueDate: string;
  instructions: string;
  submissionType: 'Document' | 'Presentation' | 'Video' | 'Audio' | 'Link' | 'Text';
  allowLateSubmission: boolean;
  latePenalty: number;
}

export interface AssignTeachersForm {
  teachers: Array<{
    teacherId: string;
    assignedQuadrants: string[];
    role: 'Lead' | 'Assistant' | 'Observer';
    permissions: string[];
  }>;
}

export interface EnrollStudentsForm {
  students: string[];
  enrollmentType: 'Mandatory' | 'Optional' | 'Recommended';
}

export interface GradeSubmissionForm {
  score?: number;
  feedback?: string;
  privateNotes?: string;
}

// Filter and Search Types
export interface InterventionFilters {
  status?: string;
  search?: string;
  page?: number;
  limit?: number;
}

export interface SubmissionFilters {
  taskId?: string;
  status?: string;
}

// API Response Types
export interface InterventionListResponse {
  success: boolean;
  data: {
    interventions: Intervention[];
    pagination: {
      page: number;
      limit: number;
      total: number;
      totalPages: number;
    };
  };
}

export interface InterventionResponse {
  success: boolean;
  data: InterventionDetails;
}

export interface TeacherInterventionsResponse {
  success: boolean;
  message: string;
  data: {
    teacher: {
      id: string;
      name: string;
      employee_id: string;
    };
    interventions: TeacherInterventionAssignment[];
  };
}

export interface SubmissionsResponse {
  success: boolean;
  message: string;
  data: TaskSubmission[];
}

export interface AnalyticsResponse {
  success: boolean;
  data: InterventionAnalytics;
}
