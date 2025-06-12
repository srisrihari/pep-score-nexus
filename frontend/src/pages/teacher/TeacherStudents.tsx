import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Input } from "@/components/ui/input";
import { 
  Search, 
  ArrowLeft, 
  Filter, 
  CheckCircle, 
  Clock, 
  AlertCircle,
  Download
} from "lucide-react";

// Mock data for assigned students
const assignedStudents = [
  { 
    id: "2024-Ajith", 
    name: "Ajith", 
    registrationNo: "2334", 
    course: "PGDM", 
    batch: "2024", 
    section: "A", 
    status: "pending",
    lastAssessment: null,
    quadrant: "wellness"
  },
  { 
    id: "2024-Rohan", 
    name: "Rohan S", 
    registrationNo: "2335", 
    course: "PGDM", 
    batch: "2024", 
    section: "A", 
    status: "completed",
    lastAssessment: "2023-04-10",
    quadrant: "wellness"
  },
  { 
    id: "2024-Priya", 
    name: "Priya M", 
    registrationNo: "2361", 
    course: "PGDM", 
    batch: "2024", 
    section: "A", 
    status: "pending",
    lastAssessment: null,
    quadrant: "wellness"
  },
  { 
    id: "2024-Kavita", 
    name: "Kavita R", 
    registrationNo: "2362", 
    course: "PGDM", 
    batch: "2024", 
    section: "B", 
    status: "incomplete",
    lastAssessment: "2023-04-05",
    quadrant: "wellness"
  },
  { 
    id: "2024-Arjun", 
    name: "Arjun K", 
    registrationNo: "2363", 
    course: "PGDM", 
    batch: "2024", 
    section: "B", 
    status: "completed",
    lastAssessment: "2023-04-12",
    quadrant: "wellness"
  },
  { 
    id: "2024-Divya", 
    name: "Divya P", 
    registrationNo: "2364", 
    course: "PGDM", 
    batch: "2024", 
    section: "B", 
    status: "completed",
    lastAssessment: "2023-04-11",
    quadrant: "wellness"
  },
  { 
    id: "2024-Rahul", 
    name: "Rahul M", 
    registrationNo: "2365", 
    course: "PGDM", 
    batch: "2024", 
    section: "C", 
    status: "pending",
    lastAssessment: null,
    quadrant: "wellness"
  },
  { 
    id: "2024-Karthik", 
    name: "Karthik L", 
    registrationNo: "2366", 
    course: "PGDM", 
    batch: "2024", 
    section: "C", 
    status: "pending",
    lastAssessment: null,
    quadrant: "wellness"
  },
  { 
    id: "2024-Meena", 
    name: "Meena S", 
    registrationNo: "2367", 
    course: "PGDM", 
    batch: "2024", 
    section: "C", 
    status: "incomplete",
    lastAssessment: "2023-04-03",
    quadrant: "wellness"
  },
  { 
    id: "2024-Ananya", 
    name: "Ananya K", 
    registrationNo: "2368", 
    course: "PGDM", 
    batch: "2024", 
    section: "D", 
    status: "completed",
    lastAssessment: "2023-04-09",
    quadrant: "wellness"
  },
];

const TeacherStudents: React.FC = () => {
  const navigate = useNavigate();
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedTab, setSelectedTab] = useState("all");
  const [selectedSection, setSelectedSection] = useState("all");
  const [selectedBatch, setSelectedBatch] = useState("all");

  // Filter students based on search query, tab, and filters
  const filteredStudents = assignedStudents.filter(student => {
    const matchesSearch = 
      student.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      student.registrationNo.toLowerCase().includes(searchQuery.toLowerCase());
    
    const matchesTab = 
      selectedTab === "all" || 
      (selectedTab === "pending" && student.status === "pending") ||
      (selectedTab === "completed" && student.status === "completed") ||
      (selectedTab === "incomplete" && student.status === "incomplete");
    
    const matchesSection = selectedSection === "all" || student.section === selectedSection;
    const matchesBatch = selectedBatch === "all" || student.batch === selectedBatch;
    
    return matchesSearch && matchesTab && matchesSection && matchesBatch;
  });

  const getStatusBadge = (status: string) => {
    switch (status) {
      case "pending":
        return <Badge variant="secondary" className="flex items-center gap-1"><Clock className="h-3 w-3" /> Pending</Badge>;
      case "completed":
        return <Badge variant="success" className="flex items-center gap-1"><CheckCircle className="h-3 w-3" /> Completed</Badge>;
      case "incomplete":
        return <Badge variant="destructive" className="flex items-center gap-1"><AlertCircle className="h-3 w-3" /> Incomplete</Badge>;
      default:
        return null;
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center">
        <Button
          variant="ghost"
          size="icon"
          onClick={() => navigate("/teacher")}
          className="mr-2"
        >
          <ArrowLeft className="h-5 w-5" />
        </Button>
        <div>
          <h1 className="text-2xl font-bold">My Students</h1>
          <p className="text-muted-foreground">
            Manage and assess your assigned students
          </p>
        </div>
      </div>

      <Card>
        <CardHeader>
          <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
            <div>
              <CardTitle>Assigned Students</CardTitle>
              <CardDescription>
                Students assigned to you for assessment
              </CardDescription>
            </div>
            <div className="flex flex-col sm:flex-row gap-2">
              <div className="relative">
                <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
                <Input
                  type="search"
                  placeholder="Search students..."
                  className="pl-8 w-full sm:w-[200px]"
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                />
              </div>
              <Button variant="outline" className="gap-1">
                <Download className="h-4 w-4" />
                Export
              </Button>
            </div>
          </div>
        </CardHeader>
        <CardContent>
          <Tabs defaultValue="all" value={selectedTab} onValueChange={setSelectedTab} className="w-full">
            <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4 mb-4">
              <TabsList>
                <TabsTrigger value="all">All Students</TabsTrigger>
                <TabsTrigger value="pending">Pending</TabsTrigger>
                <TabsTrigger value="completed">Completed</TabsTrigger>
                <TabsTrigger value="incomplete">Incomplete</TabsTrigger>
              </TabsList>
              
              <div className="flex flex-wrap gap-2">
                <Select value={selectedSection} onValueChange={setSelectedSection}>
                  <SelectTrigger className="w-[120px]">
                    <SelectValue placeholder="Section" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">All Sections</SelectItem>
                    <SelectItem value="A">Section A</SelectItem>
                    <SelectItem value="B">Section B</SelectItem>
                    <SelectItem value="C">Section C</SelectItem>
                    <SelectItem value="D">Section D</SelectItem>
                  </SelectContent>
                </Select>
                
                <Select value={selectedBatch} onValueChange={setSelectedBatch}>
                  <SelectTrigger className="w-[120px]">
                    <SelectValue placeholder="Batch" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">All Batches</SelectItem>
                    <SelectItem value="2024">Batch 2024</SelectItem>
                    <SelectItem value="2023">Batch 2023</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
            
            <TabsContent value="all" className="m-0">
              <div className="rounded-md border">
                <div className="grid grid-cols-6 p-3 text-sm font-medium bg-muted/50">
                  <div className="col-span-2">Student</div>
                  <div>Reg. No</div>
                  <div>Section</div>
                  <div>Status</div>
                  <div className="text-right">Action</div>
                </div>
                <div className="divide-y">
                  {filteredStudents.length > 0 ? (
                    filteredStudents.map((student) => (
                      <div key={student.id} className="grid grid-cols-6 p-3 text-sm items-center">
                        <div className="col-span-2 font-medium">{student.name}</div>
                        <div>{student.registrationNo}</div>
                        <div>Section {student.section}</div>
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
            </TabsContent>
            
            <TabsContent value="pending" className="m-0">
              <div className="rounded-md border">
                <div className="grid grid-cols-6 p-3 text-sm font-medium bg-muted/50">
                  <div className="col-span-2">Student</div>
                  <div>Reg. No</div>
                  <div>Section</div>
                  <div>Status</div>
                  <div className="text-right">Action</div>
                </div>
                <div className="divide-y">
                  {filteredStudents.length > 0 ? (
                    filteredStudents.map((student) => (
                      <div key={student.id} className="grid grid-cols-6 p-3 text-sm items-center">
                        <div className="col-span-2 font-medium">{student.name}</div>
                        <div>{student.registrationNo}</div>
                        <div>Section {student.section}</div>
                        <div>{getStatusBadge(student.status)}</div>
                        <div className="text-right">
                          <Button 
                            variant="outline" 
                            size="sm"
                            onClick={() => navigate(`/teacher/score/${student.id}`)}
                          >
                            Score
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
            </TabsContent>
            
            <TabsContent value="completed" className="m-0">
              <div className="rounded-md border">
                <div className="grid grid-cols-6 p-3 text-sm font-medium bg-muted/50">
                  <div className="col-span-2">Student</div>
                  <div>Reg. No</div>
                  <div>Section</div>
                  <div>Last Assessment</div>
                  <div className="text-right">Action</div>
                </div>
                <div className="divide-y">
                  {filteredStudents.length > 0 ? (
                    filteredStudents.map((student) => (
                      <div key={student.id} className="grid grid-cols-6 p-3 text-sm items-center">
                        <div className="col-span-2 font-medium">{student.name}</div>
                        <div>{student.registrationNo}</div>
                        <div>Section {student.section}</div>
                        <div>{student.lastAssessment ? new Date(student.lastAssessment).toLocaleDateString() : "N/A"}</div>
                        <div className="text-right">
                          <Button 
                            variant="outline" 
                            size="sm"
                            onClick={() => navigate(`/teacher/score/${student.id}`)}
                          >
                            View
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
            </TabsContent>
            
            <TabsContent value="incomplete" className="m-0">
              <div className="rounded-md border">
                <div className="grid grid-cols-6 p-3 text-sm font-medium bg-muted/50">
                  <div className="col-span-2">Student</div>
                  <div>Reg. No</div>
                  <div>Section</div>
                  <div>Last Update</div>
                  <div className="text-right">Action</div>
                </div>
                <div className="divide-y">
                  {filteredStudents.length > 0 ? (
                    filteredStudents.map((student) => (
                      <div key={student.id} className="grid grid-cols-6 p-3 text-sm items-center">
                        <div className="col-span-2 font-medium">{student.name}</div>
                        <div>{student.registrationNo}</div>
                        <div>Section {student.section}</div>
                        <div>{student.lastAssessment ? new Date(student.lastAssessment).toLocaleDateString() : "N/A"}</div>
                        <div className="text-right">
                          <Button 
                            variant="outline" 
                            size="sm"
                            onClick={() => navigate(`/teacher/score/${student.id}`)}
                          >
                            Complete
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
            </TabsContent>
          </Tabs>
        </CardContent>
      </Card>
    </div>
  );
};

export default TeacherStudents;
