import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { studentData, studentList } from "@/data/mockData";
import { 
  GraduationCap, 
  ClipboardCheck, 
  Clock, 
  AlertCircle, 
  CheckCircle, 
  Calendar, 
  ArrowRight,
  Search
} from "lucide-react";
import { Input } from "@/components/ui/input";

// Mock data for teacher dashboard
const teacherStudents = [
  { id: "2024-Ajith", name: "Ajith", registrationNo: "2334", course: "PGDM", batch: "2024", section: "A", status: "pending" },
  { id: "2024-Rohan", name: "Rohan S", registrationNo: "2335", course: "PGDM", batch: "2024", section: "A", status: "completed" },
  { id: "2024-Priya", name: "Priya M", registrationNo: "2361", course: "PGDM", batch: "2024", section: "A", status: "pending" },
  { id: "2024-Kavita", name: "Kavita R", registrationNo: "2362", course: "PGDM", batch: "2024", section: "B", status: "incomplete" },
  { id: "2024-Arjun", name: "Arjun K", registrationNo: "2363", course: "PGDM", batch: "2024", section: "B", status: "completed" },
];

const recentActivity = [
  { id: 1, studentName: "Rohan S", action: "Scored Wellness assessment", timestamp: "2 hours ago" },
  { id: 2, studentName: "Arjun K", action: "Provided feedback on fitness plan", timestamp: "1 day ago" },
  { id: 3, studentName: "Priya M", action: "Scheduled intervention", timestamp: "2 days ago" },
];

const TeacherDashboard: React.FC = () => {
  const navigate = useNavigate();
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedTerm, setSelectedTerm] = useState("Term1");
  const [selectedStatus, setSelectedStatus] = useState("all");

  // Filter students based on search query and filters
  const filteredStudents = teacherStudents.filter(student => {
    const matchesSearch = 
      student.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      student.registrationNo.toLowerCase().includes(searchQuery.toLowerCase());
    
    const matchesStatus = selectedStatus === "all" || student.status === selectedStatus;
    
    return matchesSearch && matchesStatus;
  });

  const pendingCount = teacherStudents.filter(s => s.status === "pending").length;
  const completedCount = teacherStudents.filter(s => s.status === "completed").length;
  const incompleteCount = teacherStudents.filter(s => s.status === "incomplete").length;

  const getStatusBadge = (status: string) => {
    switch (status) {
      case "pending":
        return <Badge variant="secondary">Pending</Badge>;
      case "completed":
        return <Badge variant="success">Completed</Badge>;
      case "incomplete":
        return <Badge variant="destructive">Incomplete</Badge>;
      default:
        return null;
    }
  };

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold">Teacher Dashboard</h1>
        <p className="text-muted-foreground">
          Manage your students and interventions
        </p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-lg flex items-center">
              <Clock className="mr-2 h-5 w-5 text-amber-500" />
              Pending Assessments
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">{pendingCount}</div>
            <p className="text-sm text-muted-foreground">
              Students waiting for assessment
            </p>
            <Button 
              variant="ghost" 
              className="mt-2 w-full justify-between"
              onClick={() => navigate("/teacher/students")}
            >
              View pending <ArrowRight className="h-4 w-4" />
            </Button>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-lg flex items-center">
              <CheckCircle className="mr-2 h-5 w-5 text-green-500" />
              Completed
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">{completedCount}</div>
            <p className="text-sm text-muted-foreground">
              Assessments completed this term
            </p>
            <Button 
              variant="ghost" 
              className="mt-2 w-full justify-between"
              onClick={() => navigate("/teacher/students")}
            >
              View completed <ArrowRight className="h-4 w-4" />
            </Button>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-lg flex items-center">
              <AlertCircle className="mr-2 h-5 w-5 text-red-500" />
              Incomplete
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">{incompleteCount}</div>
            <p className="text-sm text-muted-foreground">
              Assessments with missing components
            </p>
            <Button 
              variant="ghost" 
              className="mt-2 w-full justify-between"
              onClick={() => navigate("/teacher/students")}
            >
              View incomplete <ArrowRight className="h-4 w-4" />
            </Button>
          </CardContent>
        </Card>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div className="md:col-span-2">
          <Card>
            <CardHeader>
              <CardTitle>Students Requiring Attention</CardTitle>
              <CardDescription>
                Students with pending or incomplete assessments
              </CardDescription>
              <div className="flex flex-col sm:flex-row gap-2 mt-2">
                <div className="relative flex-1">
                  <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
                  <Input
                    type="search"
                    placeholder="Search students..."
                    className="pl-8"
                    value={searchQuery}
                    onChange={(e) => setSearchQuery(e.target.value)}
                  />
                </div>
                <Select value={selectedStatus} onValueChange={setSelectedStatus}>
                  <SelectTrigger className="w-[160px]">
                    <SelectValue placeholder="Filter by status" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">All Statuses</SelectItem>
                    <SelectItem value="pending">Pending</SelectItem>
                    <SelectItem value="completed">Completed</SelectItem>
                    <SelectItem value="incomplete">Incomplete</SelectItem>
                  </SelectContent>
                </Select>
                <Select value={selectedTerm} onValueChange={setSelectedTerm}>
                  <SelectTrigger className="w-[160px]">
                    <SelectValue placeholder="Select term" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="Term1">Term 1</SelectItem>
                    <SelectItem value="Term2">Term 2</SelectItem>
                    <SelectItem value="Term3">Term 3</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </CardHeader>
            <CardContent>
              <div className="rounded-md border">
                <div className="grid grid-cols-5 p-3 text-sm font-medium">
                  <div className="col-span-2">Student</div>
                  <div>Reg. No</div>
                  <div>Status</div>
                  <div className="text-right">Action</div>
                </div>
                <div className="divide-y">
                  {filteredStudents.length > 0 ? (
                    filteredStudents.map((student) => (
                      <div key={student.id} className="grid grid-cols-5 p-3 text-sm items-center">
                        <div className="col-span-2 font-medium">{student.name}</div>
                        <div>{student.registrationNo}</div>
                        <div>{getStatusBadge(student.status)}</div>
                        <div className="text-right">
                          <Button 
                            variant="outline" 
                            size="sm"
                            onClick={() => navigate(`/teacher/score/${student.id}`)}
                          >
                            {student.status === "completed" ? "View" : "Score"}
                          </Button>
                        </div>
                      </div>
                    ))
                  ) : (
                    <div className="p-4 text-center text-muted-foreground">
                      No students match your search criteria
                    </div>
                  )}
                </div>
              </div>
            </CardContent>
          </Card>
        </div>

        <div>
          <Card>
            <CardHeader>
              <CardTitle>Recent Activity</CardTitle>
              <CardDescription>
                Your recent assessment activities
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {recentActivity.map((activity) => (
                  <div key={activity.id} className="flex items-start gap-2 border-b pb-3 last:border-0 last:pb-0">
                    <div className="rounded-full bg-primary/10 p-1">
                      <ClipboardCheck className="h-4 w-4 text-primary" />
                    </div>
                    <div className="space-y-1">
                      <p className="text-sm font-medium">{activity.studentName}</p>
                      <p className="text-xs text-muted-foreground">{activity.action}</p>
                      <p className="text-xs text-muted-foreground">{activity.timestamp}</p>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>

          <Card className="mt-4">
            <CardHeader>
              <CardTitle>Upcoming Schedule</CardTitle>
              <CardDescription>
                Your upcoming assessment schedule
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="flex items-start gap-2 border-b pb-3">
                  <div className="rounded-full bg-primary/10 p-1">
                    <Calendar className="h-4 w-4 text-primary" />
                  </div>
                  <div className="space-y-1">
                    <p className="text-sm font-medium">Wellness Assessment</p>
                    <p className="text-xs text-muted-foreground">Section A - 10 students</p>
                    <p className="text-xs text-muted-foreground">Tomorrow, 10:00 AM</p>
                  </div>
                </div>
                <div className="flex items-start gap-2">
                  <div className="rounded-full bg-primary/10 p-1">
                    <Calendar className="h-4 w-4 text-primary" />
                  </div>
                  <div className="space-y-1">
                    <p className="text-sm font-medium">Wellness Assessment</p>
                    <p className="text-xs text-muted-foreground">Section B - 12 students</p>
                    <p className="text-xs text-muted-foreground">Friday, 2:00 PM</p>
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  );
};

export default TeacherDashboard;
