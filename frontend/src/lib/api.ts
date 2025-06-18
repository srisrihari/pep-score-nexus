const API_BASE_URL = 'http://localhost:3001/api/v1';

// Get auth token from localStorage
const getAuthToken = (): string | null => {
  return localStorage.getItem('authToken');
};

// Create headers with auth token
const createHeaders = (): HeadersInit => {
  const token = getAuthToken();
  return {
    'Content-Type': 'application/json',
    ...(token && { Authorization: `Bearer ${token}` }),
  };
};

// Generic API request function
const apiRequest = async <T>(
  endpoint: string,
  options: RequestInit = {}
): Promise<T> => {
  const url = `${API_BASE_URL}${endpoint}`;
  const config: RequestInit = {
    headers: createHeaders(),
    ...options,
  };

  try {
    const response = await fetch(url, config);
    
    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}));
      throw new Error(errorData.message || `HTTP error! status: ${response.status}`);
    }

    return await response.json();
  } catch (error) {
    console.error(`API request failed for ${endpoint}:`, error);
    throw error;
  }
};

// Auth API calls
export const authAPI = {
  login: async (credentials: { username: string; password: string }) => {
    return apiRequest<{
      success: boolean;
      message: string;
      token: string;
      user: {
        id: string;
        username: string;
        email: string;
        role: string;
        name: string;
      };
    }>('/auth/login', {
      method: 'POST',
      body: JSON.stringify(credentials),
    });
  },

  getProfile: async () => {
    return apiRequest<{
      success: boolean;
      user: {
        id: string;
        username: string;
        email: string;
        role: string;
        name: string;
      };
    }>('/auth/profile');
  },
};

// Student API calls
export const studentAPI = {
  getCurrentStudent: async () => {
    // First get the current user profile to get the student ID
    const profileResponse = await apiRequest<{
      success: boolean;
      data: {
        user: {
          id: string;
          email: string;
          role: string;
        };
        profile?: {
          id: string;
          registration_no: string;
          name: string;
          course: string;
          gender: string;
          phone: string;
          overall_score: number;
          grade: string;
          status: string;
          current_term: string;
          created_at: string;
          updated_at: string;
          batch_name: string;
          batch_year: number;
          section_name: string;
          house_name: string;
          house_color: string;
          batches: {
            name: string;
            year: number;
          };
          sections: {
            name: string;
          };
          houses: {
            name: string;
            color: string;
          };
        };
      };
    }>('/auth/profile');

    if (!profileResponse.data.profile) {
      throw new Error('Student profile not found. Please contact your administrator to set up your student profile.');
    }

    return {
      success: true,
      message: 'Student profile retrieved successfully',
      data: profileResponse.data.profile,
      timestamp: new Date().toISOString()
    };
  },

  // Dashboard Performance API
  getStudentPerformance: async (studentId: string, termId?: string, includeHistory?: boolean) => {
    const params = new URLSearchParams();
    if (termId) params.append('termId', termId);
    if (includeHistory) params.append('includeHistory', 'true');

    return apiRequest<{
      success: boolean;
      data: {
        student: {
          id: string;
          name: string;
          registrationNo: string;
          course: string;
          batch: string;
          section: string;
          houseName: string;
          gender: string;
          currentTerm: string;
        };
        currentTerm: {
          termId: string;
          termName: string;
          totalScore: number;
          grade: string;
          overallStatus: string;
          quadrants: Array<{
            id: string;
            name: string;
            obtained: number;
            weightage: number;
            status: string;
            attendance: number;
            eligibility: string;
            rank: number;
            components: Array<{
              id: string;
              name: string;
              score: number;
              maxScore: number;
              status: string;
              category?: string;
            }>;
          }>;
        };
        termHistory?: Array<any>;
        batchStats: {
          averageScore: number;
          bestScore: number;
          totalStudents: number;
        };
      };
    }>(`/students/${studentId}/performance${params.toString() ? '?' + params.toString() : ''}`);
  },

  // Leaderboard API
  getStudentLeaderboard: async (studentId: string, quadrantId?: string) => {
    const params = new URLSearchParams();
    if (quadrantId) params.append('quadrantId', quadrantId);

    return apiRequest<{
      success: boolean;
      data: {
        overall: {
          topStudents: Array<{ id: string; name: string; score: number }>;
          userRank: number;
          batchAvg: number;
          batchBest: number;
        };
        quadrants: Record<string, {
          topStudents: Array<{ id: string; name: string; score: number }>;
          userRank: number;
          batchAvg: number;
          batchBest: number;
        }>;
      };
    }>(`/students/${studentId}/leaderboard${params.toString() ? '?' + params.toString() : ''}`);
  },

  // Attendance API
  getStudentAttendance: async (studentId: string, termId?: string) => {
    const params = new URLSearchParams();
    if (termId) params.append('termId', termId);

    return apiRequest<{
      success: boolean;
      data: {
        overall: number;
        wellness: number;
        eligibility: string;
        history: Array<{
          term: string;
          overall: number;
          wellness: number;
        }>;
        quadrantAttendance: Array<{
          quadrantId: string;
          quadrantName: string;
          attendance: number;
          required: number;
          isEligible: boolean;
        }>;
      };
    }>(`/students/${studentId}/attendance${params.toString() ? '?' + params.toString() : ''}`);
  },

  // Score Breakdown API
  getScoreBreakdown: async (studentId: string, termId?: string) => {
    const params = new URLSearchParams();
    if (termId) params.append('termId', termId);

    return apiRequest<{
      success: boolean;
      data: {
        termId: string;
        termName: string;
        totalScore: number;
        quadrants: Array<{
          id: string;
          name: string;
          weightage: number;
          obtainedScore: number;
          components: Array<{
            id: string;
            name: string;
            score: number;
            maxScore: number;
            percentage: number;
            grade: string;
            status: string;
            assessmentDate: string;
            assessedBy: string;
          }>;
        }>;
      };
    }>(`/students/${studentId}/scores/breakdown${params.toString() ? '?' + params.toString() : ''}`);
  },

  // Quadrant Details API
  getQuadrantDetails: async (studentId: string, quadrantId: string, termId?: string) => {
    const params = new URLSearchParams();
    if (termId) params.append('termId', termId);

    return apiRequest<{
      success: boolean;
      data: {
        quadrant: {
          id: string;
          name: string;
          description: string;
          weightage: number;
          obtainedScore: number;
          status: string;
          attendance: number;
          eligibility: string;
          rank: number;
        };
        components: Array<{
          id: string;
          name: string;
          score: number;
          maxScore: number;
          percentage: number;
          grade: string;
          status: string;
          category: string;
          assessmentDate: string;
          assessedBy: string;
        }>;
        progressHistory: Array<{
          term: string;
          score: number;
        }>;
        batchComparison: {
          average: number;
          best: number;
          userRank: number;
        };
      };
    }>(`/students/${studentId}/quadrants/${quadrantId}${params.toString() ? '?' + params.toString() : ''}`);
  },

  // Feedback APIs
  submitFeedback: async (studentId: string, feedbackData: {
    subject: string;
    category: string;
    message: string;
  }) => {
    return apiRequest<{
      success: boolean;
      message: string;
      data: {
        id: string;
        subject: string;
        category: string;
        message: string;
        status: string;
        submittedAt: string;
      };
    }>(`/students/${studentId}/feedback`, {
      method: 'POST',
      body: JSON.stringify(feedbackData),
    });
  },

  getFeedbackHistory: async (studentId: string, page?: number, limit?: number) => {
    const params = new URLSearchParams();
    if (page) params.append('page', page.toString());
    if (limit) params.append('limit', limit.toString());

    return apiRequest<{
      success: boolean;
      data: {
        feedback: Array<{
          id: string;
          subject: string;
          category: string;
          message: string;
          status: string;
          submittedAt: string;
          response?: string;
          respondedAt?: string;
          respondedBy?: string;
        }>;
        pagination: {
          currentPage: number;
          totalPages: number;
          totalItems: number;
          itemsPerPage: number;
        };
      };
    }>(`/students/${studentId}/feedback${params.toString() ? '?' + params.toString() : ''}`);
  },

  // Profile Management APIs
  getStudentProfile: async (studentId: string) => {
    return apiRequest<{
      success: boolean;
      data: {
        id: string;
        name: string;
        registrationNo: string;
        email: string;
        phone: string;
        course: string;
        batch: string;
        section: string;
        houseName: string;
        gender: string;
        preferences: any;
        createdAt: string;
        updatedAt: string;
      };
    }>(`/students/${studentId}/profile`);
  },

  updateStudentProfile: async (studentId: string, profileData: {
    name?: string;
    email?: string;
    phone?: string;
    preferences?: any;
  }) => {
    return apiRequest<{
      success: boolean;
      message: string;
      data: {
        id: string;
        name: string;
        email: string;
        phone: string;
        preferences: any;
        updatedAt: string;
      };
    }>(`/students/${studentId}/profile`, {
      method: 'PUT',
      body: JSON.stringify(profileData),
    });
  },

  changePassword: async (studentId: string, passwordData: {
    currentPassword: string;
    newPassword: string;
    confirmPassword: string;
  }) => {
    return apiRequest<{
      success: boolean;
      message: string;
    }>(`/students/${studentId}/change-password`, {
      method: 'POST',
      body: JSON.stringify(passwordData),
    });
  },

  // Eligibility APIs
  getEligibilityRules: async () => {
    return apiRequest<{
      success: boolean;
      data: {
        quadrants: Array<{
          id: string;
          name: string;
          minimumAttendance: number;
          minimumScore: number;
          businessRules: any;
        }>;
        generalRules: Array<{
          rule: string;
          description: string;
        }>;
      };
    }>('/students/eligibility-rules');
  },

  checkStudentEligibility: async (studentId: string, termId?: string) => {
    const params = new URLSearchParams();
    if (termId) params.append('termId', termId);

    return apiRequest<{
      success: boolean;
      data: {
        overallEligibility: boolean;
        quadrantEligibility: Array<{
          quadrantId: string;
          quadrantName: string;
          isEligible: boolean;
          attendanceStatus: boolean;
          scoreStatus: boolean;
          issues: Array<string>;
        }>;
        recommendations: Array<string>;
      };
    }>(`/students/${studentId}/eligibility${params.toString() ? '?' + params.toString() : ''}`);
  },

  // Improvement Plan APIs
  getImprovementPlan: async (studentId: string, termId?: string) => {
    const params = new URLSearchParams();
    if (termId) params.append('termId', termId);

    return apiRequest<{
      success: boolean;
      data: {
        improvementAreas: Array<{
          quadrantId: string;
          quadrantName: string;
          currentScore: number;
          targetScore: number;
          priority: string;
          recommendations: Array<{
            action: string;
            description: string;
            timeframe: string;
            difficulty: string;
          }>;
        }>;
        overallGoals: Array<{
          goal: string;
          description: string;
          targetDate: string;
          progress: number;
        }>;
      };
    }>(`/students/${studentId}/improvement-plan${params.toString() ? '?' + params.toString() : ''}`);
  },

  setImprovementGoals: async (studentId: string, goalsData: {
    goals: Array<{
      quadrantId: string;
      targetScore: number;
      targetDate: string;
      actions: Array<string>;
    }>;
  }) => {
    return apiRequest<{
      success: boolean;
      message: string;
      data: {
        goalsSet: number;
        targetDate: string;
      };
    }>(`/students/${studentId}/improvement-goals`, {
      method: 'POST',
      body: JSON.stringify(goalsData),
    });
  },

  // Behavior Rating Scale API
  getBehaviorRatingScale: async (studentId: string, termId?: string) => {
    const params = new URLSearchParams();
    if (termId) params.append('termId', termId);

    return apiRequest<{
      success: boolean;
      data: {
        behaviorComponents: Array<{
          id: string;
          name: string;
          currentRating: number;
          maxRating: number;
          description: string;
          ratingScale: Array<{
            value: number;
            label: string;
            description: string;
          }>;
          history: Array<{
            term: string;
            rating: number;
          }>;
        }>;
        overallBehaviorScore: number;
        recommendations: Array<string>;
      };
    }>(`/students/${studentId}/behavior-rating-scale${params.toString() ? '?' + params.toString() : ''}`);
  },
};

// Score API calls
export const scoreAPI = {
  getStudentScoreSummary: async (studentId: string) => {
    return apiRequest<{
      success: boolean;
      summary: {
        student_id: string;
        term_id: string;
        total_score: number;
        weighted_score: number;
        overall_grade: string;
        overall_status: string;
        quadrant_scores: Array<{
          quadrant_id: string;
          quadrant_name: string;
          weight_percentage: number;
          total_score: number;
          weighted_score: number;
          grade: string;
          status: string;
          attendance_percentage: number;
          attendance_required: boolean;
          min_attendance_percentage: number;
          is_attendance_met: boolean;
        }>;
        term: {
          id: string;
          name: string;
          academic_year: string;
          is_current: boolean;
        };
      };
    }>(`/scores/student/${studentId}/summary`);
  },

  getStudentScores: async (studentId: string) => {
    return apiRequest<{
      success: boolean;
      scores: Array<{
        id: string;
        student_id: string;
        component_id: string;
        term_id: string;
        obtained_score: number;
        max_score: number;
        grade: string;
        status: string;
        assessment_date: string;
        assessed_by: string;
        component: {
          id: string;
          name: string;
          max_score: number;
          category: string;
          sub_category: {
            id: string;
            name: string;
            quadrant: {
              id: string;
              name: string;
              weight_percentage: number;
            };
          };
        };
        assessor: {
          id: string;
          name: string;
          role: string;
        };
      }>;
    }>(`/scores/student/${studentId}`);
  },
};

// Quadrant API calls
export const quadrantAPI = {
  getAllQuadrants: async () => {
    return apiRequest<{
      success: boolean;
      message: string;
      data: Array<{
        id: string;
        name: string;
        description: string;
        weightage: number;
        minimum_attendance: number;
        business_rules: any;
        is_active: boolean;
        display_order: number;
        created_at: string;
      }>;
      count: number;
      timestamp: string;
    }>('/quadrants');
  },
};

// Admin API calls
export const adminAPI = {
  getDashboardOverview: async () => {
    return apiRequest<{
      success: boolean;
      message: string;
      data: {
        totalStudents: number;
        averageScore: number;
        highestScore: number;
        lowestScore: number;
        gradeDistribution: Array<{
          grade: string;
          count: number;
          percentage: number;
        }>;
        quadrantPerformance: Array<{
          quadrant_id: string;
          quadrant_name: string;
          average_score: number;
          max_score: number;
        }>;
        recentScores: Array<{
          student_name: string;
          score: number;
          date: string;
        }>;
        attendanceIssues: Array<{
          student_name: string;
          registration_no: string;
          attendance_percentage: number;
          quadrants_affected: string[];
        }>;
        redFlags: Array<{
          student_name: string;
          registration_no: string;
          issue_type: string;
          description: string;
        }>;
      };
      timestamp: string;
    }>('/admin/dashboard');
  },

  searchStudents: async (query: string, limit: number = 10) => {
    return apiRequest<{
      success: boolean;
      message: string;
      data: {
        students: Array<{
          id: string;
          name: string;
          registration_no: string;
          overall_score: number;
          grade: string;
          status: string;
          batch_name: string;
          section_name: string;
        }>;
        total: number;
      };
      timestamp: string;
    }>(`/admin/students/search?query=${encodeURIComponent(query)}&limit=${limit}`);
  },

  getAllStudents: async (page: number = 1, limit: number = 10, search?: string, batch?: string, section?: string, status?: string) => {
    const params = new URLSearchParams();
    params.append('page', page.toString());
    params.append('limit', limit.toString());
    if (search) params.append('search', search);
    if (batch) params.append('batch', batch);
    if (section) params.append('section', section);
    if (status) params.append('status', status);

    return apiRequest<{
      success: boolean;
      message: string;
      data: Array<{
        id: string;
        registration_no: string;
        name: string;
        course: string;
        gender: string;
        phone: string;
        overall_score: number;
        grade: string;
        status: string;
        current_term: string;
        created_at: string;
        batch_name: string;
        batch_year: number;
        section_name: string;
        house_name: string;
        house_color: string;
      }>;
      pagination: {
        currentPage: number;
        totalPages: number;
        totalStudents: number;
        studentsPerPage: number;
        hasNextPage: boolean;
        hasPrevPage: boolean;
      };
      filters: {
        search: string;
        batch: string;
        section: string;
        status: string;
      };
      timestamp: string;
    }>(`/admin/students?${params.toString()}`);
  },

  getAllTeachers: async () => {
    return apiRequest<{
      success: boolean;
      message: string;
      data: Array<{
        id: string;
        name: string;
        employee_id: string;
        department: string;
        specialization: string;
        assigned_students: number;
        status: string;
        join_date: string;
      }>;
      count: number;
      timestamp: string;
    }>('/admin/teachers');
  },
};

// User API calls
export const userAPI = {
  getAllUsers: async (page: number = 1, limit: number = 10, search?: string, role?: string, status?: string) => {
    const params = new URLSearchParams();
    params.append('page', page.toString());
    params.append('limit', limit.toString());
    if (search) params.append('search', search);
    if (role) params.append('role', role);
    if (status) params.append('status', status);

    return apiRequest<{
      success: boolean;
      message: string;
      data: Array<{
        id: string;
        username: string;
        email: string;
        role: string;
        status: string;
        last_login: string;
        created_at: string;
        updated_at: string;
      }>;
      pagination: {
        currentPage: number;
        totalPages: number;
        totalUsers: number;
        usersPerPage: number;
        hasNextPage: boolean;
        hasPrevPage: boolean;
      };
      statistics: {
        totalUsers: number;
        students: number;
        teachers: number;
        admins: number;
      };
      filters: {
        search: string;
        role: string;
        status: string;
      };
      timestamp: string;
    }>(`/users?${params.toString()}`);
  },

  getUserStats: async () => {
    return apiRequest<{
      success: boolean;
      message: string;
      data: {
        totals: {
          total: number;
          active: number;
          inactive: number;
          suspended: number;
        };
        byRole: {
          students: number;
          teachers: number;
          admins: number;
        };
        recentUsers: Array<{
          id: string;
          username: string;
          email: string;
          role: string;
          status: string;
          created_at: string;
        }>;
      };
      timestamp: string;
    }>('/users/stats');
  },

  createUser: async (userData: {
    username: string;
    email: string;
    password: string;
    name: string;
    role: string;
  }) => {
    return apiRequest<{
      success: boolean;
      message: string;
      user: {
        id: string;
        username: string;
        email: string;
        name: string;
        role: string;
        status: string;
      };
    }>('/users', {
      method: 'POST',
      body: JSON.stringify(userData),
    });
  },

  updateUser: async (userId: string, userData: {
    username?: string;
    email?: string;
    name?: string;
    role?: string;
    status?: string;
  }) => {
    return apiRequest<{
      success: boolean;
      message: string;
      user: {
        id: string;
        username: string;
        email: string;
        name: string;
        role: string;
        status: string;
      };
    }>(`/users/${userId}`, {
      method: 'PUT',
      body: JSON.stringify(userData),
    });
  },

  deleteUser: async (userId: string) => {
    return apiRequest<{
      success: boolean;
      message: string;
    }>(`/users/${userId}`, {
      method: 'DELETE',
    });
  },
};

// Intervention API calls
export const interventionAPI = {
  // Admin Intervention APIs
  createIntervention: async (interventionData: {
    name: string;
    description: string;
    startDate: string;
    endDate: string;
    quadrantWeightages: Record<string, number>;
    prerequisites?: string[];
    maxStudents: number;
    objectives: string[];
  }) => {
    return apiRequest<{
      success: boolean;
      message: string;
      data: {
        id: string;
        name: string;
        description: string;
        start_date: string;
        end_date: string;
        status: string;
        quadrant_weightages: Record<string, number>;
        max_students: number;
        objectives: string[];
        prerequisites?: string[];
        created_at: string;
      };
    }>('/interventions', {
      method: 'POST',
      body: JSON.stringify(interventionData),
    });
  },

  getAllInterventions: async (params?: {
    page?: number;
    limit?: number;
    status?: string;
    search?: string;
  }) => {
    const searchParams = new URLSearchParams();
    if (params?.page) searchParams.append('page', params.page.toString());
    if (params?.limit) searchParams.append('limit', params.limit.toString());
    if (params?.status) searchParams.append('status', params.status);
    if (params?.search) searchParams.append('search', params.search);

    return apiRequest<{
      success: boolean;
      data: {
        interventions: Array<{
          id: string;
          name: string;
          description: string;
          start_date: string;
          end_date: string;
          status: string;
          max_students: number;
          enrolled_count: number;
          created_at: string;
        }>;
        pagination: {
          page: number;
          limit: number;
          total: number;
          totalPages: number;
        };
      };
    }>(`/interventions${searchParams.toString() ? '?' + searchParams.toString() : ''}`);
  },

  getInterventionById: async (id: string) => {
    return apiRequest<{
      success: boolean;
      data: {
        id: string;
        name: string;
        description: string;
        start_date: string;
        end_date: string;
        status: string;
        quadrant_weightages: Record<string, number>;
        max_students: number;
        objectives: string[];
        prerequisites?: string[];
        created_at: string;
        updated_at: string;
        teachers: Array<{
          id: string;
          name: string;
          assigned_quadrants: string[];
          role: string;
        }>;
        enrolled_students: Array<{
          id: string;
          name: string;
          registration_no: string;
          enrollment_status: string;
        }>;
        tasks: Array<{
          id: string;
          name: string;
          quadrant_id: string;
          max_score: number;
          due_date: string;
          status: string;
        }>;
      };
    }>(`/interventions/${id}`);
  },

  updateIntervention: async (id: string, updateData: {
    name?: string;
    description?: string;
    startDate?: string;
    endDate?: string;
    quadrantWeightages?: Record<string, number>;
    maxStudents?: number;
    objectives?: string[];
    prerequisites?: string[];
  }) => {
    return apiRequest<{
      success: boolean;
      message: string;
      data: any;
    }>(`/interventions/${id}`, {
      method: 'PUT',
      body: JSON.stringify(updateData),
    });
  },

  updateInterventionStatus: async (id: string, status: string) => {
    return apiRequest<{
      success: boolean;
      message: string;
      data: any;
    }>(`/interventions/${id}/status`, {
      method: 'PUT',
      body: JSON.stringify({ status }),
    });
  },

  assignTeachers: async (id: string, teachers: Array<{
    teacherId: string;
    assignedQuadrants: string[];
    role: string;
    permissions: string[];
  }>) => {
    return apiRequest<{
      success: boolean;
      message: string;
      data: any;
    }>(`/interventions/${id}/assign-teachers`, {
      method: 'POST',
      body: JSON.stringify({ teachers }),
    });
  },

  enrollStudents: async (id: string, students: string[], enrollmentType: string = 'Mandatory') => {
    return apiRequest<{
      success: boolean;
      message: string;
      data: any;
    }>(`/interventions/${id}/enroll-students`, {
      method: 'POST',
      body: JSON.stringify({ students, enrollmentType }),
    });
  },

  getInterventionAnalytics: async (id: string) => {
    return apiRequest<{
      success: boolean;
      data: {
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
      };
    }>(`/interventions/${id}/analytics`);
  },

  createTask: async (interventionId: string, taskData: {
    name: string;
    description: string;
    quadrantId: string;
    componentId?: string;
    maxScore: number;
    dueDate: string;
    instructions: string;
    submissionType: string;
    allowLateSubmission?: boolean;
    latePenalty?: number;
  }) => {
    return apiRequest<{
      success: boolean;
      message: string;
      data: any;
    }>(`/interventions/${interventionId}/tasks`, {
      method: 'POST',
      body: JSON.stringify(taskData),
    });
  },

  // Teacher Intervention APIs
  getTeacherInterventions: async (teacherId: string) => {
    return apiRequest<{
      success: boolean;
      message: string;
      data: {
        teacher: {
          id: string;
          name: string;
          employee_id: string;
        };
        interventions: Array<{
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
        }>;
      };
    }>(`/interventions/teachers/${teacherId}`);
  },

  getTeacherInterventionDetails: async (teacherId: string, interventionId: string) => {
    return apiRequest<{
      success: boolean;
      message: string;
      data: {
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
        tasks: Array<{
          id: string;
          name: string;
          description: string;
          quadrant_id: string;
          max_score: number;
          due_date: string;
          instructions: string;
          submission_type: string;
          status: string;
          created_at: string;
          components: {
            name: string;
          };
        }>;
        enrolled_students: number;
      };
    }>(`/interventions/teachers/${teacherId}/${interventionId}`);
  },

  getTeacherSubmissions: async (teacherId: string, interventionId: string, params?: {
    taskId?: string;
    status?: string;
  }) => {
    const searchParams = new URLSearchParams();
    if (params?.taskId) searchParams.append('taskId', params.taskId);
    if (params?.status) searchParams.append('status', params.status);

    return apiRequest<{
      success: boolean;
      message: string;
      data: Array<{
        id: string;
        submitted_at: string;
        status: string;
        is_late: boolean;
        submission_text: string;
        score?: number;
        feedback?: string;
        graded_at?: string;
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
      }>;
    }>(`/interventions/teachers/${teacherId}/${interventionId}/submissions${searchParams.toString() ? '?' + searchParams.toString() : ''}`);
  },

  gradeSubmission: async (teacherId: string, interventionId: string, submissionId: string, gradeData: {
    score?: number;
    feedback?: string;
    privateNotes?: string;
  }) => {
    return apiRequest<{
      success: boolean;
      message: string;
      data: any;
    }>(`/interventions/teachers/${teacherId}/${interventionId}/submissions/${submissionId}/grade`, {
      method: 'POST',
      body: JSON.stringify(gradeData),
    });
  },
};

export default {
  auth: authAPI,
  student: studentAPI,
  score: scoreAPI,
  quadrant: quadrantAPI,
  admin: adminAPI,
  user: userAPI,
  intervention: interventionAPI,
};