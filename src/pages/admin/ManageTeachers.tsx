import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { Card, CardContent, CardHeader, CardTitle, CardDescription, CardFooter } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Checkbox } from "@/components/ui/checkbox";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Separator } from "@/components/ui/separator";
import { toast } from "sonner";
import { 
  Search, 
  Plus, 
  Edit, 
  Trash2, 
  Download, 
  Upload, 
  UserPlus,
  Users,
  CheckCircle,
  XCircle,
  Filter,
  MoreHorizontal,
  PenTool
} from "lucide-react";
import { studentList } from "@/data/mockData";

// Mock teacher data
const teachersData = [
  {
    id: "teacher-001",
    name: "Dr. Sharma",
    email: "sharma@edu.in",
    specialization: "wellness",
    assignedStudents: 45,
    status: "active",
    joinDate: "2022-06-15"
  },
  {
    id: "teacher-002",
    name: "Prof. Patel",
    email: "patel@edu.in",
    specialization: "persona",
    assignedStudents: 38,
    status: "active",
    joinDate: "2022-07-20"
  },
  {
    id: "teacher-003",
    name: "Ms. Gupta",
    email: "gupta@edu.in",
    specialization: "behavior",
    assignedStudents: 42,
    status: "active",
    joinDate: "2022-08-05"
  },
  {
    id: "teacher-004",
    name: "Dr. Reddy",
    email: "reddy@edu.in",
    specialization: "discipline",
    assignedStudents: 40,
    status: "inactive",
    joinDate: "2022-05-10"
  },
  {
    id: "teacher-005",
    name: "Prof. Kumar",
    email: "kumar@edu.in",
    specialization: "wellness",
    assignedStudents: 35,
    status: "active",
    joinDate: "2022-09-01"
  }
];

// Mock quadrants for assignment
const quadrants = [
  { id: "persona", name: "Persona" },
  { id: "wellness", name: "Wellness" },
  { id: "behavior", name: "Behavior" },
  { id: "discipline", name: "Discipline" }
];

const ManageTeachers: React.FC = () => {
  const navigate = useNavigate();
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedTab, setSelectedTab] = useState("all");
  const [selectedTeacher, setSelectedTeacher] = useState<typeof teachersData[0] | null>(null);
  const [isAssignDialogOpen, setIsAssignDialogOpen] = useState(false);
  const [isAddTeacherDialogOpen, setIsAddTeacherDialogOpen] = useState(false);
  
  // New teacher form state
  const [newTeacherName, setNewTeacherName] = useState("");
  const [newTeacherEmail, setNewTeacherEmail] = useState("");
  const [newTeacherSpecialization, setNewTeacherSpecialization] = useState("");
  
  // Assignment state
  const [selectedQuadrants, setSelectedQuadrants] = useState<string[]>([]);
  const [availableStudents, setAvailableStudents] = useState(studentList);
  const [assignedStudents, setAssignedStudents] = useState<typeof studentList>([]);
  const [studentSearchQuery, setStudentSearchQuery] = useState("");
  
  // Filter teachers based on search query and tab
  const filteredTeachers = teachersData.filter(teacher => {
    const matchesSearch = 
      teacher.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      teacher.email.toLowerCase().includes(searchQuery.toLowerCase()) ||
      teacher.specialization.toLowerCase().includes(searchQuery.toLowerCase());
    
    const matchesTab = 
      selectedTab === "all" || 
      (selectedTab === "active" && teacher.status === "active") ||
      (selectedTab === "inactive" && teacher.status === "inactive");
    
    return matchesSearch && matchesTab;
  });
  
  // Filter students for assignment
  const filteredAvailableStudents = availableStudents.filter(student => 
    student.name.toLowerCase().includes(studentSearchQuery.toLowerCase()) ||
    student.registrationNo.toLowerCase().includes(studentSearchQuery.toLowerCase())
  );
  
  // Handle adding a new teacher
  const handleAddTeacher = () => {
    if (!newTeacherName.trim()) {
      toast.error("Please enter teacher name");
      return;
    }
    
    if (!newTeacherEmail.trim()) {
      toast.error("Please enter teacher email");
      return;
    }
    
    if (!newTeacherSpecialization) {
      toast.error("Please select a specialization");
      return;
    }
    
    toast.success("Teacher added successfully");
    setIsAddTeacherDialogOpen(false);
    setNewTeacherName("");
    setNewTeacherEmail("");
    setNewTeacherSpecialization("");
    // In a real app, you would add the new teacher to the database
  };
  
  // Handle assigning students to teacher
  const handleAssignStudents = () => {
    if (selectedQuadrants.length === 0) {
      toast.error("Please select at least one quadrant");
      return;
    }
    
    if (assignedStudents.length === 0) {
      toast.error("Please assign at least one student");
      return;
    }
    
    toast.success(`${assignedStudents.length} students assigned to ${selectedTeacher?.name}`);
    setIsAssignDialogOpen(false);
    setSelectedQuadrants([]);
    setAssignedStudents([]);
    // In a real app, you would update the teacher-student assignments in the database
  };
  
  // Handle assigning a student
  const handleAssignStudent = (student: typeof studentList[0]) => {
    setAvailableStudents(prev => prev.filter(s => s.id !== student.id));
    setAssignedStudents(prev => [...prev, student]);
  };
  
  // Handle removing an assigned student
  const handleRemoveAssignedStudent = (student: typeof studentList[0]) => {
    setAssignedStudents(prev => prev.filter(s => s.id !== student.id));
    setAvailableStudents(prev => [...prev, student]);
  };
  
  // Handle quadrant selection
  const handleQuadrantSelection = (quadrantId: string) => {
    setSelectedQuadrants(prev => {
      if (prev.includes(quadrantId)) {
        return prev.filter(id => id !== quadrantId);
      } else {
        return [...prev, quadrantId];
      }
    });
  };

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold">Manage Teachers</h1>
        <p className="text-muted-foreground">
          Add, edit, and assign teachers to students and quadrants
        </p>
      </div>

      <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
        <div className="flex flex-col sm:flex-row gap-2">
          <div className="relative">
            <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
            <Input
              type="search"
              placeholder="Search teachers..."
              className="pl-8 w-full sm:w-[250px]"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
            />
          </div>
          
          <Select value={selectedTab} onValueChange={setSelectedTab}>
            <SelectTrigger className="w-[130px]">
              <SelectValue placeholder="Filter" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">All Teachers</SelectItem>
              <SelectItem value="active">Active</SelectItem>
              <SelectItem value="inactive">Inactive</SelectItem>
            </SelectContent>
          </Select>
        </div>
        
        <div className="flex gap-2">
          <Dialog open={isAddTeacherDialogOpen} onOpenChange={setIsAddTeacherDialogOpen}>
            <DialogTrigger asChild>
              <Button className="gap-1">
                <UserPlus className="h-4 w-4" />
                Add Teacher
              </Button>
            </DialogTrigger>
            <DialogContent>
              <DialogHeader>
                <DialogTitle>Add New Teacher</DialogTitle>
                <DialogDescription>
                  Enter the details of the new teacher to add them to the system.
                </DialogDescription>
              </DialogHeader>
              
              <div className="space-y-4 py-4">
                <div className="space-y-2">
                  <Label htmlFor="name">Full Name</Label>
                  <Input
                    id="name"
                    placeholder="Enter teacher's full name"
                    value={newTeacherName}
                    onChange={(e) => setNewTeacherName(e.target.value)}
                  />
                </div>
                
                <div className="space-y-2">
                  <Label htmlFor="email">Email Address</Label>
                  <Input
                    id="email"
                    type="email"
                    placeholder="Enter teacher's email"
                    value={newTeacherEmail}
                    onChange={(e) => setNewTeacherEmail(e.target.value)}
                  />
                </div>
                
                <div className="space-y-2">
                  <Label htmlFor="specialization">Specialization</Label>
                  <Select value={newTeacherSpecialization} onValueChange={setNewTeacherSpecialization}>
                    <SelectTrigger id="specialization">
                      <SelectValue placeholder="Select specialization" />
                    </SelectTrigger>
                    <SelectContent>
                      {quadrants.map(quadrant => (
                        <SelectItem key={quadrant.id} value={quadrant.id}>
                          {quadrant.name}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
                
                <div className="space-y-2">
                  <Label>Initial Access</Label>
                  <div className="grid grid-cols-2 gap-2">
                    {quadrants.map(quadrant => (
                      <div key={quadrant.id} className="flex items-center space-x-2">
                        <Checkbox id={`quadrant-${quadrant.id}`} />
                        <Label htmlFor={`quadrant-${quadrant.id}`} className="text-sm">
                          {quadrant.name}
                        </Label>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
              
              <DialogFooter>
                <Button variant="outline" onClick={() => setIsAddTeacherDialogOpen(false)}>
                  Cancel
                </Button>
                <Button onClick={handleAddTeacher}>
                  Add Teacher
                </Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
          
          <Button variant="outline" className="gap-1">
            <Download className="h-4 w-4" />
            Export
          </Button>
        </div>
      </div>

      <Card>
        <CardContent className="p-0">
          <div className="rounded-md">
            <div className="grid grid-cols-7 p-4 text-sm font-medium bg-muted/50">
              <div className="col-span-2">Teacher</div>
              <div>Specialization</div>
              <div>Assigned Students</div>
              <div>Status</div>
              <div>Join Date</div>
              <div className="text-right">Actions</div>
            </div>
            <div className="divide-y">
              {filteredTeachers.length > 0 ? (
                filteredTeachers.map((teacher) => (
                  <div key={teacher.id} className="grid grid-cols-7 p-4 text-sm items-center">
                    <div className="col-span-2">
                      <div className="font-medium">{teacher.name}</div>
                      <div className="text-xs text-muted-foreground">{teacher.email}</div>
                    </div>
                    <div>
                      <Badge variant="outline" className="capitalize">
                        {teacher.specialization}
                      </Badge>
                    </div>
                    <div>{teacher.assignedStudents}</div>
                    <div>
                      {teacher.status === "active" ? (
                        <Badge variant="success" className="gap-1">
                          <CheckCircle className="h-3 w-3" /> Active
                        </Badge>
                      ) : (
                        <Badge variant="secondary" className="gap-1">
                          <XCircle className="h-3 w-3" /> Inactive
                        </Badge>
                      )}
                    </div>
                    <div>{new Date(teacher.joinDate).toLocaleDateString()}</div>
                    <div className="flex justify-end gap-2">
                      <Dialog open={isAssignDialogOpen && selectedTeacher?.id === teacher.id} onOpenChange={(open) => {
                        setIsAssignDialogOpen(open);
                        if (open) {
                          setSelectedTeacher(teacher);
                          // Reset assignment state
                          setSelectedQuadrants([]);
                          setAssignedStudents([]);
                          setAvailableStudents(studentList);
                        }
                      }}>
                        <DialogTrigger asChild>
                          <Button variant="outline" size="sm" className="gap-1" onClick={() => setSelectedTeacher(teacher)}>
                            <Users className="h-3.5 w-3.5" />
                            Assign
                          </Button>
                        </DialogTrigger>
                        <DialogContent className="max-w-3xl">
                          <DialogHeader>
                            <DialogTitle>Assign Students to {teacher.name}</DialogTitle>
                            <DialogDescription>
                              Select quadrants and assign students to this teacher.
                            </DialogDescription>
                          </DialogHeader>
                          
                          <div className="space-y-4 py-4">
                            <div className="space-y-2">
                              <Label>Quadrant Access</Label>
                              <div className="flex flex-wrap gap-2">
                                {quadrants.map(quadrant => (
                                  <Badge 
                                    key={quadrant.id} 
                                    variant={selectedQuadrants.includes(quadrant.id) ? "default" : "outline"}
                                    className="cursor-pointer capitalize"
                                    onClick={() => handleQuadrantSelection(quadrant.id)}
                                  >
                                    {quadrant.name}
                                  </Badge>
                                ))}
                              </div>
                            </div>
                            
                            <Separator />
                            
                            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                              <div className="space-y-2">
                                <Label>Available Students</Label>
                                <div className="relative mb-2">
                                  <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
                                  <Input
                                    type="search"
                                    placeholder="Search students..."
                                    className="pl-8"
                                    value={studentSearchQuery}
                                    onChange={(e) => setStudentSearchQuery(e.target.value)}
                                  />
                                </div>
                                <div className="border rounded-md h-[300px] overflow-y-auto">
                                  {filteredAvailableStudents.length > 0 ? (
                                    filteredAvailableStudents.map(student => (
                                      <div 
                                        key={student.id} 
                                        className="flex justify-between items-center p-2 hover:bg-muted/50 cursor-pointer"
                                        onClick={() => handleAssignStudent(student)}
                                      >
                                        <div>
                                          <div className="font-medium">{student.name}</div>
                                          <div className="text-xs text-muted-foreground">{student.registrationNo}</div>
                                        </div>
                                        <Button variant="ghost" size="sm">
                                          <Plus className="h-4 w-4" />
                                        </Button>
                                      </div>
                                    ))
                                  ) : (
                                    <div className="p-4 text-center text-muted-foreground">
                                      No students available
                                    </div>
                                  )}
                                </div>
                              </div>
                              
                              <div className="space-y-2">
                                <Label>Assigned Students</Label>
                                <div className="border rounded-md h-[300px] overflow-y-auto">
                                  {assignedStudents.length > 0 ? (
                                    assignedStudents.map(student => (
                                      <div 
                                        key={student.id} 
                                        className="flex justify-between items-center p-2 hover:bg-muted/50"
                                      >
                                        <div>
                                          <div className="font-medium">{student.name}</div>
                                          <div className="text-xs text-muted-foreground">{student.registrationNo}</div>
                                        </div>
                                        <Button 
                                          variant="ghost" 
                                          size="sm" 
                                          onClick={() => handleRemoveAssignedStudent(student)}
                                        >
                                          <Trash2 className="h-4 w-4 text-destructive" />
                                        </Button>
                                      </div>
                                    ))
                                  ) : (
                                    <div className="p-4 text-center text-muted-foreground">
                                      No students assigned yet
                                    </div>
                                  )}
                                </div>
                              </div>
                            </div>
                          </div>
                          
                          <DialogFooter>
                            <Button variant="outline" onClick={() => setIsAssignDialogOpen(false)}>
                              Cancel
                            </Button>
                            <Button onClick={handleAssignStudents}>
                              Save Assignments
                            </Button>
                          </DialogFooter>
                        </DialogContent>
                      </Dialog>
                      
                      <Button variant="outline" size="sm">
                        <Edit className="h-3.5 w-3.5" />
                      </Button>
                      
                      <Button variant="outline" size="sm" className="text-destructive">
                        <Trash2 className="h-3.5 w-3.5" />
                      </Button>
                    </div>
                  </div>
                ))
              ) : (
                <div className="p-4 text-center text-muted-foreground">
                  No teachers found matching your search criteria
                </div>
              )}
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
};

export default ManageTeachers;
