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
    return apiRequest<{
      success: boolean;
      message: string;
      data: {
        id: string;
        registration_no: string;
        name: string;
        course: string;
        gender: string;
        phone: string;
        preferences: any;
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
      timestamp: string;
    }>('/students/me');
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

// User API calls
export const userAPI = {
  getAllUsers: async () => {
    return apiRequest<{
      success: boolean;
      users: Array<{
        id: string;
        username: string;
        email: string;
        name: string;
        role: string;
        status: string;
        created_at: string;
        updated_at: string;
      }>;
    }>('/users');
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

export default {
  auth: authAPI,
  student: studentAPI,
  score: scoreAPI,
  quadrant: quadrantAPI,
  user: userAPI,
}; 