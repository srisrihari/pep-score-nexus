// Authentication utilities for the frontend

export interface LoginResponse {
  success: boolean;
  message: string;
  data: {
    user: {
      id: string;
      username: string;
      email: string;
      role: 'student' | 'teacher' | 'admin';
      status: string;
    };
    token: string;
  };
  timestamp: string;
}

export interface RegisterResponse {
  success: boolean;
  message: string;
  data: {
    user: {
      id: string;
      username: string;
      email: string;
      role: 'student' | 'teacher' | 'admin';
      status: string;
    };
    token: string;
  };
  timestamp: string;
}

const API_BASE_URL = 'http://localhost:3001/api/v1';

export const authService = {
  async login(username: string, password: string): Promise<LoginResponse> {
    const response = await fetch(`${API_BASE_URL}/auth/login`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ username, password }),
    });
    
    return response.json();
  },

  async register(userData: {
    username: string;
    email: string;
    password: string;
    name: string;
    role: 'student' | 'teacher' | 'admin';
  }): Promise<RegisterResponse> {
    const response = await fetch(`${API_BASE_URL}/auth/register`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(userData),
    });
    
    return response.json();
  },

  async getProfile(token: string) {
    const response = await fetch(`${API_BASE_URL}/auth/profile`, {
      headers: {
        'Authorization': `Bearer ${token}`,
      },
    });
    
    return response.json();
  },

  // Token management
  getToken(): string | null {
    return localStorage.getItem('authToken');
  },

  setToken(token: string): void {
    localStorage.setItem('authToken', token);
  },

  removeToken(): void {
    localStorage.removeItem('authToken');
  },

  // User data management
  getUser(): any {
    const userData = localStorage.getItem('userData');
    return userData ? JSON.parse(userData) : null;
  },

  setUser(userData: any): void {
    localStorage.setItem('userData', JSON.stringify(userData));
  },

  removeUser(): void {
    localStorage.removeItem('userData');
  },

  // Quick admin login for testing
  async loginAsAdmin(): Promise<LoginResponse> {
    return this.login('admin', 'admin123');
  },

  // Logout
  logout(): void {
    this.removeToken();
    this.removeUser();
  }
};

export default authService; 