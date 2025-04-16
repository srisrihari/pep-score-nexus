
import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import { AuthProvider, useAuth } from "@/contexts/AuthContext";

import Layout from "./components/layout/Layout";
import NotFound from "./pages/NotFound";
import Login from "./pages/Login";
import Index from "./pages/Index";

// Student pages
import StudentDashboard from "./pages/student/StudentDashboard";
import QuadrantDetail from "./pages/student/QuadrantDetail";
import Feedback from "./pages/student/Feedback";
import Settings from "./pages/student/Settings";
import EligibilityPage from "./pages/student/EligibilityPage";
import ImprovementPlan from "./pages/student/ImprovementPlan";

// Teacher pages
import TeacherDashboard from "./pages/teacher/TeacherDashboard";
import TeacherStudents from "./pages/teacher/TeacherStudents";
import InterventionScoring from "./pages/teacher/InterventionScoring";
import TeacherFeedback from "./pages/teacher/TeacherFeedback";

// Admin pages
import AdminDashboard from "./pages/admin/AdminDashboard";
import ManageStudents from "./pages/admin/ManageStudents";
import InputScores from "./pages/admin/InputScores";
import Reports from "./pages/admin/Reports";
import DataImport from "./pages/admin/DataImport";
import ManageTeachers from "./pages/admin/ManageTeachers";

const queryClient = new QueryClient();

// Protected route component
const ProtectedRoute = ({
  children,
  requiredRole
}: {
  children: React.ReactNode;
  requiredRole: "student" | "admin" | "teacher";
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
  return (
    <Routes>
      <Route path="/" element={<Login />} />
      <Route path="/index" element={<Index />} />

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
      <Route path="/student/eligibility" element={
        <ProtectedRoute requiredRole="student">
          <Layout>
            <EligibilityPage />
          </Layout>
        </ProtectedRoute>
      } />
      <Route path="/student/improvement" element={
        <ProtectedRoute requiredRole="student">
          <Layout>
            <ImprovementPlan />
          </Layout>
        </ProtectedRoute>
      } />

      {/* Teacher Routes */}
      <Route path="/teacher" element={
        <ProtectedRoute requiredRole="teacher">
          <Layout>
            <TeacherDashboard />
          </Layout>
        </ProtectedRoute>
      } />
      <Route path="/teacher/students" element={
        <ProtectedRoute requiredRole="teacher">
          <Layout>
            <TeacherStudents />
          </Layout>
        </ProtectedRoute>
      } />
      <Route path="/teacher/score/:studentId" element={
        <ProtectedRoute requiredRole="teacher">
          <Layout>
            <InterventionScoring />
          </Layout>
        </ProtectedRoute>
      } />
      <Route path="/teacher/feedback" element={
        <ProtectedRoute requiredRole="teacher">
          <Layout>
            <TeacherFeedback />
          </Layout>
        </ProtectedRoute>
      } />
      <Route path="/teacher/settings" element={
        <ProtectedRoute requiredRole="teacher">
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
      <Route path="/admin/import" element={
        <ProtectedRoute requiredRole="admin">
          <Layout>
            <DataImport />
          </Layout>
        </ProtectedRoute>
      } />
      <Route path="/admin/teachers" element={
        <ProtectedRoute requiredRole="admin">
          <Layout>
            <ManageTeachers />
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
