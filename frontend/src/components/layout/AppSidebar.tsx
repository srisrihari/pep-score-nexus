
import React from "react";
import { useNavigate, useLocation } from "react-router-dom";
import { useAuth } from "@/contexts/AuthContext";
import {
  Sidebar,
  SidebarContent,
  SidebarHeader,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarMenu,
  SidebarMenuItem,
  SidebarMenuButton,
  SidebarFooter,
} from "@/components/ui/sidebar";
import {
  Home,
  User,
  BarChart3,
  Settings,
  MessageSquare,
  Users,
  LogOut,
  ClipboardEdit,
  FileBarChart,
  FileSpreadsheet,
  GraduationCap,
  PenTool,
  CheckSquare,
  BookOpen
} from "lucide-react";
import { Button } from "@/components/ui/button";

export function AppSidebar() {
  const { userRole, logout } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();

  const studentMenuItems = [
    { title: "Dashboard", path: "/student", icon: Home },
    { title: "Interventions", path: "/student/interventions", icon: BookOpen },
    { title: "Feedback", path: "/student/feedback", icon: MessageSquare },
    { title: "Settings", path: "/student/settings", icon: Settings },
  ];

  const teacherMenuItems = [
    { title: "Dashboard", path: "/teacher", icon: Home },
    { title: "My Students", path: "/teacher/students", icon: GraduationCap },
    { title: "Interventions", path: "/teacher/interventions", icon: BookOpen },
    { title: "Feedback", path: "/teacher/feedback", icon: MessageSquare },
    { title: "Settings", path: "/teacher/settings", icon: Settings },
  ];

  const adminMenuItems = [
    { title: "Dashboard", path: "/admin", icon: Home },
    { title: "Manage Students", path: "/admin/students", icon: Users },
    { title: "Manage Teachers", path: "/admin/teachers", icon: PenTool },
    { title: "Manage Users", path: "/admin/users", icon: User },
    { title: "Interventions", path: "/admin/interventions", icon: BookOpen },
    { title: "Input Scores", path: "/admin/scores", icon: ClipboardEdit },
    { title: "Reports", path: "/admin/reports", icon: FileBarChart },
    { title: "Data Import", path: "/admin/import", icon: FileSpreadsheet },
  ];

  let menuItems;
  if (userRole === "admin") {
    menuItems = adminMenuItems;
  } else if (userRole === "teacher") {
    menuItems = teacherMenuItems;
  } else {
    menuItems = studentMenuItems;
  }

  const handleNavigate = (path: string) => {
    navigate(path);
  };

  const handleLogout = () => {
    logout();
    navigate("/");
  };

  return (
    <Sidebar>
      <SidebarHeader>
        <div className="flex items-center px-4 py-2">
          <div className="flex items-center space-x-2">
            <BarChart3 className="h-6 w-6 text-primary" />
            <span className="text-lg font-bold">PEP Score Nexus</span>
          </div>
        </div>
      </SidebarHeader>
      <SidebarContent>
        <SidebarGroup>
          <SidebarGroupLabel>Navigation</SidebarGroupLabel>
          <SidebarGroupContent>
            <SidebarMenu>
              {menuItems.map((item) => (
                <SidebarMenuItem key={item.path}>
                  <SidebarMenuButton
                    className={location.pathname === item.path ? "bg-primary text-white" : ""}
                    onClick={() => handleNavigate(item.path)}
                  >
                    <item.icon className="h-4 w-4 mr-2" />
                    <span>{item.title}</span>
                  </SidebarMenuButton>
                </SidebarMenuItem>
              ))}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>
      </SidebarContent>
      <SidebarFooter>
        <div className="px-4 py-2 space-y-2">
          <div className="flex items-center space-x-2 p-2 rounded-md bg-muted">
            <User className="h-5 w-5 text-muted-foreground" />
            <div className="space-y-0.5">
              <p className="text-sm font-medium">
                {userRole === "student" ? "Student User" : userRole === "teacher" ? "Teacher User" : "Admin User"}
              </p>
              <p className="text-xs text-muted-foreground">
                {userRole === "student" ? "Batch 2024" : userRole === "teacher" ? "Wellness Instructor" : "Management"}
              </p>
            </div>
          </div>
          <Button
            variant="outline"
            className="w-full flex items-center justify-center"
            onClick={handleLogout}
          >
            <LogOut className="h-4 w-4 mr-2" /> Logout
          </Button>
        </div>
      </SidebarFooter>
    </Sidebar>
  );
}
