
import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import { AuthProvider, useAuth } from "@/contexts/AuthContext";

import Layout from "./components/layout/Layout";
import NotFound from "./pages/NotFound";
import Login from "./pages/Login";

// Student pages
import StudentDashboard from "./pages/student/StudentDashboard";
import QuadrantDetail from "./pages/student/QuadrantDetail";
import Feedback from "./pages/student/Feedback";
import Settings from "./pages/student/Settings";

// Admin pages
import AdminDashboard from "./pages/admin/AdminDashboard";
import ManageStudents from "./pages/admin/ManageStudents";
import InputScores from "./pages/admin/InputScores";
import Reports from "./pages/admin/Reports";

const queryClient = new QueryClient();

// Protected route component
const ProtectedRoute = ({ 
  children, 
  requiredRole 
}: { 
  children: React.ReactNode;
  requiredRole: "student" | "admin";
}) => {
  const { isAuthenticated, userRole } = useAuth();

  if (!isAuthenticated) {
    return <Navigate to="/" replace />;
  }

  if (requiredRole && userRole !== requiredRole) {
    return <Navigate to="/" replace />;
  }

  return <>{children}</>;
};

const AppRoutes = () => {
  const { isAuthenticated, userRole } = useAuth();

  // Redirect logged in users to their dashboard
  if (isAuthenticated && window.location.pathname === "/") {
    if (userRole === "student") {
      return <Navigate to="/student" replace />;
    } else if (userRole === "admin") {
      return <Navigate to="/admin" replace />;
    }
  }

  return (
    <Routes>
      <Route path="/" element={<Login />} />
      
      {/* Student Routes */}
      <Route path="/student" element={
        <ProtectedRoute requiredRole="student">
          <Layout>
            <StudentDashboard />
          </Layout>
        </ProtectedRoute>
      } />
      <Route path="/student/quadrant/:quadrantId" element={
        <ProtectedRoute requiredRole="student">
          <Layout>
            <QuadrantDetail />
          </Layout>
        </ProtectedRoute>
      } />
      <Route path="/student/feedback" element={
        <ProtectedRoute requiredRole="student">
          <Layout>
            <Feedback />
          </Layout>
        </ProtectedRoute>
      } />
      <Route path="/student/settings" element={
        <ProtectedRoute requiredRole="student">
          <Layout>
            <Settings />
          </Layout>
        </ProtectedRoute>
      } />
      
      {/* Admin Routes */}
      <Route path="/admin" element={
        <ProtectedRoute requiredRole="admin">
          <Layout>
            <AdminDashboard />
          </Layout>
        </ProtectedRoute>
      } />
      <Route path="/admin/students" element={
        <ProtectedRoute requiredRole="admin">
          <Layout>
            <ManageStudents />
          </Layout>
        </ProtectedRoute>
      } />
      <Route path="/admin/scores" element={
        <ProtectedRoute requiredRole="admin">
          <Layout>
            <InputScores />
          </Layout>
        </ProtectedRoute>
      } />
      <Route path="/admin/reports" element={
        <ProtectedRoute requiredRole="admin">
          <Layout>
            <Reports />
          </Layout>
        </ProtectedRoute>
      } />
      
      {/* Catch-all route */}
      <Route path="*" element={<NotFound />} />
    </Routes>
  );
};

const App = () => (
  <QueryClientProvider client={queryClient}>
    <AuthProvider>
      <TooltipProvider>
        <Toaster />
        <Sonner />
        <BrowserRouter>
          <AppRoutes />
        </BrowserRouter>
      </TooltipProvider>
    </AuthProvider>
  </QueryClientProvider>
);

export default App;
