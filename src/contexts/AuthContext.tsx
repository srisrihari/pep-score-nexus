
import React, { createContext, useContext, useState, ReactNode } from "react";
import { toast } from "sonner";

type UserRole = "student" | "admin" | null;

interface AuthContextType {
  isAuthenticated: boolean;
  userRole: UserRole;
  userId: string | null;
  login: (username: string, password: string) => Promise<boolean>;
  logout: () => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error("useAuth must be used within an AuthProvider");
  }
  return context;
};

interface AuthProviderProps {
  children: ReactNode;
}

// Mock user credentials
const MOCK_CREDENTIALS = {
  student: { username: "student", password: "password", userId: "2024-Ajith" },
  admin: { username: "admin", password: "password", userId: "admin-001" }
};

export const AuthProvider: React.FC<AuthProviderProps> = ({ children }) => {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [userRole, setUserRole] = useState<UserRole>(null);
  const [userId, setUserId] = useState<string | null>(null);

  const login = async (username: string, password: string): Promise<boolean> => {
    // Mock authentication logic
    if (username === MOCK_CREDENTIALS.student.username && password === MOCK_CREDENTIALS.student.password) {
      setIsAuthenticated(true);
      setUserRole("student");
      setUserId(MOCK_CREDENTIALS.student.userId);
      toast.success("Logged in as Student");
      return true;
    } else if (username === MOCK_CREDENTIALS.admin.username && password === MOCK_CREDENTIALS.admin.password) {
      setIsAuthenticated(true);
      setUserRole("admin");
      setUserId(MOCK_CREDENTIALS.admin.userId);
      toast.success("Logged in as Admin");
      return true;
    } else {
      toast.error("Invalid credentials");
      return false;
    }
  };

  const logout = () => {
    setIsAuthenticated(false);
    setUserRole(null);
    setUserId(null);
    toast.info("Logged out successfully");
  };

  return (
    <AuthContext.Provider value={{ isAuthenticated, userRole, userId, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
};
