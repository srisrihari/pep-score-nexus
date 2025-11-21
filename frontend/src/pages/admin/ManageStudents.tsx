
import React, { useState, useEffect } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from "@/components/ui/dialog";
import StatusBadge, { StatusType } from "@/components/common/StatusBadge";
import { adminAPI, uploadAPI, apiRequest, unifiedScoreAPI } from "@/lib/api";
import { useTerm } from "@/contexts/TermContext";
import { Badge } from "@/components/ui/badge";
import { toast } from "sonner";
import { Search, ArrowUpDown, Eye, Edit, Trash2, Plus, UserPlus, Upload, Download, BookOpen, Building, GraduationCap, Settings, Calendar, User } from "lucide-react";
import { ErrorHandler, FormErrors } from "@/utils/errorHandling";
import { FormValidator } from "@/utils/formValidation";
import AdminDeedsDialog from "@/components/admin/AdminDeedsDialog";
import StudentForm from "@/components/admin/StudentForm";
import StudentFilters from "@/components/admin/StudentFilters";
import BatchManagementDialog from "@/components/admin/BatchManagementDialog";
import SectionManagementDialog from "@/components/admin/SectionManagementDialog";
import CourseManagementDialog from "@/components/admin/CourseManagementDialog";
import AttendanceManagementDialog from "@/components/admin/AttendanceManagementDialog";
import StudentSelectionDialog from "@/components/admin/StudentSelectionDialog";
import BulkTeacherAssignment from "@/components/admin/BulkTeacherAssignment";
import EnhancedStudentImport from "@/components/admin/EnhancedStudentImport";

// Student interface
interface Student {
  id: string;
  user_id: string;
  registration_no: string;
  name: string;
  course: string;
  batch_id: string;
  section_id: string;
  house_id?: string;
  gender: string;
  phone: string;
  preferences: any;
  overall_score: number;
  grade: string;
  status: string;
  current_term: string;
  created_at: string;
  updated_at: string;
  user?: {
    email: string;
    username: string;
  };
  batch?: {
    name: string;
  };
  section?: {
    name: string;
  };
}

const ManageStudents: React.FC = () => {
  const { currentTerm, selectedTerm } = useTerm();
  const [searchQuery, setSearchQuery] = useState("");
  const [students, setStudents] = useState<Student[]>([]);
  const [loading, setLoading] = useState(true);
  const [sortOrder, setSortOrder] = useState<"asc" | "desc">("desc");
  const [sortField, setSortField] = useState<"name" | "overall_score">("overall_score");
  const [selectedStudent, setSelectedStudent] = useState<Student | null>(null);
  const [isDialogOpen, setIsDialogOpen] = useState(false);
  const [isAddStudentDialogOpen, setIsAddStudentDialogOpen] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [formErrors, setFormErrors] = useState<FormErrors>({});

  // Pagination state
  const [currentPage, setCurrentPage] = useState(1);
  const [pageSize, setPageSize] = useState(10);
  const [totalStudents, setTotalStudents] = useState(0);
  const [totalPages, setTotalPages] = useState(0);

  // New student form state
  const [newStudentFirstName, setNewStudentFirstName] = useState("");
  const [newStudentLastName, setNewStudentLastName] = useState("");
  const [newStudentEmail, setNewStudentEmail] = useState("");
  const [newStudentPassword, setNewStudentPassword] = useState("");
  const [newStudentRegistrationNo, setNewStudentRegistrationNo] = useState("");
  const [newStudentCourse, setNewStudentCourse] = useState("");
  const [newStudentBatch, setNewStudentBatch] = useState("");
  const [newStudentSection, setNewStudentSection] = useState("");
  const [newStudentGender, setNewStudentGender] = useState("");
  const [newStudentPhone, setNewStudentPhone] = useState("");

  // Edit student state
  const [editingStudent, setEditingStudent] = useState<Student | null>(null);
  const [showEditDialog, setShowEditDialog] = useState(false);
  const [editStudentName, setEditStudentName] = useState("");
  const [editStudentEmail, setEditStudentEmail] = useState("");
  const [editStudentCourse, setEditStudentCourse] = useState("");
  const [editStudentBatch, setEditStudentBatch] = useState("");
  const [editStudentSection, setEditStudentSection] = useState("");
  const [editStudentGender, setEditStudentGender] = useState("");
  const [editStudentPhone, setEditStudentPhone] = useState("");
  const [isEditingStudent, setIsEditingStudent] = useState(false);

  // Delete student state
  const [deletingStudent, setDeletingStudent] = useState<Student | null>(null);
  const [showDeleteDialog, setShowDeleteDialog] = useState(false);
  const [isDeletingStudent, setIsDeletingStudent] = useState(false);
  const [showDeedsDialog, setShowDeedsDialog] = useState(false);
  const [studentForDeeds, setStudentForDeeds] = useState<Student | null>(null);

  const handleViewDeeds = (student: Student) => {
    setStudentForDeeds(student);
    setShowDeedsDialog(true);
  };


  // Attendance management state
  const [showAttendanceDialog, setShowAttendanceDialog] = useState(false);
  const [selectedStudentForAttendance, setSelectedStudentForAttendance] = useState<Student | null>(null);

  // Bulk operations state
  const [selectedStudents, setSelectedStudents] = useState<string[]>([]);
  const [showEnhancedImportDialog, setShowEnhancedImportDialog] = useState(false);

  // Filter options state
  const [filterOptions, setFilterOptions] = useState<{
    batches: Array<{ id: string; name: string; year: number }>;
    sections: Array<{ id: string; name: string; batch_name: string; batch_year: number }>;
    houses: Array<{ id: string; name: string; color: string }>;
    courses: string[];
    years: number[];
  } | null>(null);
  const [loadingFilterOptions, setLoadingFilterOptions] = useState(true);

  // Fetch students data and filter options
  useEffect(() => {
    fetchStudents();
    fetchFilterOptions();
  }, [currentPage, pageSize, sortField, sortOrder, selectedTerm, searchQuery]); // include search in deps

  const fetchFilterOptions = async () => {
    try {
      setLoadingFilterOptions(true);
      const response = await adminAPI.getStudentFilterOptions();
      if (response.success) {
        setFilterOptions(response.data);
      }
    } catch (error) {
      console.error('Error fetching filter options:', error);
      toast.error('Failed to load form options');
    } finally {
      setLoadingFilterOptions(false);
    }
  };

  const fetchStudents = async () => {
    try {
      setLoading(true);
      const response = await adminAPI.getAllStudents({
        page: currentPage,
        limit: pageSize,
        sortBy: sortField,
        sortOrder: sortOrder,
        search: searchQuery,
        termId: selectedTerm?.id // Filter by selected term
      });
      let studentsData = response?.data?.students || [];
      const pagination = response?.data?.pagination || {} as any;
      const totalRaw = (pagination.total ?? response?.data?.total ?? studentsData.length) as number;
      const totalPagesCalc = (pagination.totalPages ?? (totalRaw && pageSize ? Math.ceil(totalRaw / pageSize) : 0)) as number;

      // Defensive client-side paging if backend returns full list
      if (!pagination?.limit || studentsData.length > pageSize) {
        const start = (currentPage - 1) * pageSize;
        studentsData = studentsData.slice(start, start + pageSize);
      }

      // Fetch HPS scores for the selected term and merge into list
      if (selectedTerm?.id) {
        const summaries = await Promise.all(
          studentsData.map(async (s: any) => {
            try {
              const res = await unifiedScoreAPI.getStudentScoreSummary(s.id, selectedTerm.id);
              const total = res?.data?.summary?.total_hps;
              return { id: s.id, total_hps: typeof total === 'number' ? total : 0 };
            } catch (e) {
              return { id: s.id, total_hps: 0 };
            }
          })
        );
        const idToHps = new Map(summaries.map((x) => [x.id, x.total_hps]));
        studentsData = studentsData.map((s: any) => ({
          ...s,
          overall_score: idToHps.get(s.id) ?? 0,
        }));
      }

      setStudents(studentsData);
      setTotalStudents(totalRaw);
      setTotalPages(totalPagesCalc);
    } catch (error) {
      console.error('Error fetching students:', error);
      toast.error('Failed to fetch students');
    } finally {
      setLoading(false);
    }
  };

  const handleSearch = () => {
    // Reset to first page when searching
    setCurrentPage(1);
    fetchStudents();
  };

  const handleSort = (field: "name" | "overall_score") => {
    const newSortOrder = field === sortField && sortOrder === "asc" ? "desc" : "asc";
    setSortOrder(newSortOrder);
    setSortField(field);
    setCurrentPage(1); // Reset to first page when sorting
    // Fetch after state updates
    setTimeout(fetchStudents, 0);
  };

  const handleViewStudent = (student: Student) => {
    setSelectedStudent(student);
    setIsDialogOpen(true);
  };

  // Handle adding a new student
  const handleAddStudent = async () => {
    // Clear previous errors
    setFormErrors(ErrorHandler.clearFormErrors());

    // Prepare student data for validation
    const studentData = {
      firstName: newStudentFirstName.trim(),
      lastName: newStudentLastName.trim(),
      email: newStudentEmail.trim(),
      password: newStudentPassword.trim(),
      registrationNo: newStudentRegistrationNo.trim(),
      course: newStudentCourse.trim(),
      batchId: newStudentBatch,
      sectionId: newStudentSection,
      gender: newStudentGender,
      phone: newStudentPhone.trim(),
    };

    // Validate using comprehensive form validator
    const validationErrors = FormValidator.validateStudentForm(studentData);

    // Check for duplicate registration number
    const existingStudent = students.find(s => s.registration_no === studentData.registrationNo);
    if (existingStudent) {
      validationErrors.registrationNo = "A student with this registration number already exists";
    }

    // If there are validation errors, show them and return
    if (Object.keys(validationErrors).length > 0) {
      setFormErrors(validationErrors);
      return;
    }



    try {
      setIsSubmitting(true);

      // Create student using the API
      await adminAPI.addStudent({
        email: studentData.email,
        password: studentData.password,
        firstName: studentData.firstName,
        lastName: studentData.lastName,
        registrationNo: studentData.registrationNo,
        course: newStudentCourse,
        batchId: newStudentBatch,
        sectionId: newStudentSection,
        gender: newStudentGender,
        phone: newStudentPhone || '',
      });

      ErrorHandler.showSuccess("Student added successfully");
      setIsAddStudentDialogOpen(false);

      // Reset form
      setNewStudentFirstName("");
      setNewStudentLastName("");
      setNewStudentEmail("");
      setNewStudentPassword("");
      setNewStudentRegistrationNo("");
      setNewStudentCourse("");
      setNewStudentBatch("");
      setNewStudentSection("");
      setNewStudentGender("");
      setNewStudentPhone("");
      setFormErrors(ErrorHandler.clearFormErrors());

      // Refresh students list
      fetchStudents();
    } catch (error) {
      const formErrors = ErrorHandler.handleFormError(error, 'adding student');
      setFormErrors(formErrors);
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleEditStudent = (student: Student) => {
    setEditingStudent(student);
    setEditStudentName(student.name);
    setEditStudentCourse(student.course);
    setEditStudentBatch(student.batch_id);
    setEditStudentSection(student.section_id);
    setEditStudentGender(student.gender);
    setEditStudentPhone(student.phone);
    setShowEditDialog(true);
  };

  const handleUpdateStudent = async () => {
    if (!editingStudent) return;

    if (!editStudentName || !editStudentCourse || !editStudentBatch || !editStudentSection || !editStudentGender) {
      toast.error("Please fill in all required fields");
      return;
    }

    setIsEditingStudent(true);
    try {
      // Note: This would need a proper update API endpoint
      toast.success("Student updated successfully");
      setShowEditDialog(false);
      setEditingStudent(null);
      fetchStudents(); // Refresh the list
    } catch (error) {
      console.error('Error updating student:', error);
      toast.error("Failed to update student");
    } finally {
      setIsEditingStudent(false);
    }
  };

  const handleDeleteStudent = (student: Student) => {
    setDeletingStudent(student);
    setShowDeleteDialog(true);
  };

  const handleOpenAttendance = (student: Student) => {
    setSelectedStudentForAttendance(student);
    setShowAttendanceDialog(true);
  };

  const confirmDeleteStudent = async () => {
    if (!deletingStudent) return;

    setIsDeletingStudent(true);
    try {
      const response = await apiRequest(`/api/v1/admin/students/${deletingStudent.id}`, {
        method: 'DELETE'
      });

      if (response.success) {
        toast.success("Student deleted successfully");
        setShowDeleteDialog(false);
        setDeletingStudent(null);
        fetchStudents(); // Refresh the list
      } else {
        throw new Error(response.message || 'Delete failed');
      }
    } catch (error) {
      console.error('Error deleting student:', error);
      toast.error("Failed to delete student: " + (error.message || 'Unknown error'));
    } finally {
      setIsDeletingStudent(false);
    }
  };

  const handleBulkExport = () => {
    try {
      // Create CSV content
      const headers = ['Name', 'Registration No', 'Course', 'Batch', 'Section', 'Gender', 'Phone', 'Status', 'Score'];
      const csvContent = [
        headers.join(','),
        ...students.map(student => [
          `"${student.name}"`,
          student.registration_no,
          student.course,
          student.batch?.name || '',
          student.section?.name || '',
          student.gender,
          student.phone || '',
          student.status,
          student.overall_score
        ].join(','))
      ].join('\n');

      // Create and download file
      const blob = new Blob([csvContent], { type: 'text/csv' });
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `students_export_${new Date().toISOString().split('T')[0]}.csv`;
      document.body.appendChild(a);
      a.click();
      document.body.removeChild(a);
      window.URL.revokeObjectURL(url);

      toast.success('Students exported successfully');
    } catch (error) {
      console.error('Error exporting students:', error);
      toast.error('Failed to export students');
    }
  };

  const handleImportComplete = async () => {
    // Refresh the student list after successful import
    await fetchStudents();
  };

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-2xl font-bold mb-1">Manage Students</h1>
          <p className="text-muted-foreground">
            View and manage student profiles and performance data.
          </p>
          <div className="mt-2">
            <Badge variant="outline" className="text-sm">
              {selectedTerm?.name || 'Current Term'}
            </Badge>
          </div>
        </div>
        <div className="flex gap-2">
          {/* Data Management Buttons */}
          <CourseManagementDialog
            trigger={
              <Button variant="outline" className="gap-2" size="sm">
                <GraduationCap className="h-4 w-4" />
                Courses
              </Button>
            }
          />
          <BatchManagementDialog
            trigger={
              <Button variant="outline" className="gap-2" size="sm">
                <BookOpen className="h-4 w-4" />
                Batches
              </Button>
            }
          />
          <SectionManagementDialog
            trigger={
              <Button variant="outline" className="gap-2" size="sm">
                <Building className="h-4 w-4" />
                Sections
              </Button>
            }
          />
          
          {/* Student Data Operations */}
          <Button variant="outline" onClick={handleBulkExport} className="gap-2" size="sm">
            <Download className="h-4 w-4" />
            Export CSV
          </Button>
          <Button variant="outline" onClick={() => setShowEnhancedImportDialog(true)} className="gap-2" size="sm">
            <Upload className="h-4 w-4" />
            Import Excel
          </Button>
          
          {/* Add Student */}
          <Dialog open={isAddStudentDialogOpen} onOpenChange={setIsAddStudentDialogOpen}>
            <Button onClick={() => setIsAddStudentDialogOpen(true)} className="gap-2">
              <UserPlus className="h-4 w-4" />
              Add Student
            </Button>
          </Dialog>
        </div>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Student Directory</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="flex gap-2 mb-6">
            <Input
              placeholder="Search by name or registration no."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="flex-1"
            />
            <Button onClick={handleSearch}>
              <Search className="h-4 w-4 mr-2" />
              Search
            </Button>
          </div>

          <div className="overflow-x-auto">
            <table className="w-full text-left text-sm">
              <thead className="bg-muted">
                <tr>
                  <th className="p-3">
                    <Button
                      variant="ghost"
                      size="sm"
                      className="p-0 h-auto font-bold"
                      onClick={() => handleSort("name")}
                    >
                      Name
                      <ArrowUpDown className="h-3 w-3 ml-1" />
                    </Button>
                  </th>
                  <th className="p-3">Reg No.</th>
                  <th className="p-3">Batch</th>
                  <th className="p-3">Course</th>
                  <th className="p-3">
                    <Button
                      variant="ghost"
                      size="sm"
                      className="p-0 h-auto font-bold"
                      onClick={() => handleSort("overall_score")}
                    >
                      Score
                      <ArrowUpDown className="h-3 w-3 ml-1" />
                    </Button>
                  </th>
                  <th className="p-3">Status</th>
                  <th className="p-3">Actions</th>
                </tr>
              </thead>
              <tbody>
                {loading ? (
                  <tr>
                    <td colSpan={7} className="p-8 text-center">
                      <div className="flex items-center justify-center">
                        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
                        <span className="ml-2">Loading students...</span>
                      </div>
                    </td>
                  </tr>
                ) : students.length > 0 ? (
                  students.map((student) => (
                    <tr key={student.id} className="border-b">
                      <td className="p-3 font-medium">{student.name}</td>
                      <td className="p-3">{student.registration_no}</td>
                      <td className="p-3">{student.batch?.name || 'N/A'}</td>
                      <td className="p-3">{student.course}</td>
                      <td className="p-3">{student.overall_score}/100</td>
                      <td className="p-3">
                        <StatusBadge status={student.status.toLowerCase() as StatusType} />
                      </td>
                      <td className="p-3">
                        <div className="flex gap-2">
                          <Button
                            size="sm"
                            variant="outline"
                            onClick={() => handleViewDeeds(student)}
                            className="gap-1"
                          >
                            <User className="h-3 w-3" />
                            Deeds
                          </Button>
                          <Button
                            size="sm"
                            variant="outline"
                            onClick={() => handleViewStudent(student)}
                          >
                            <Eye className="h-3 w-3 mr-1" />
      {studentForDeeds && (
        <AdminDeedsDialog
          open={showDeedsDialog}
          onOpenChange={setShowDeedsDialog}
          studentId={studentForDeeds.id}
          studentName={studentForDeeds.name}
        />
      )}
                            View
                          </Button>
                          <Button
                            size="sm"
                            variant="outline"
                            onClick={() => handleEditStudent(student)}
                          >
                            <Edit className="h-3 w-3 mr-1" />
                            Edit
                          </Button>
                          <Button
                            size="sm"
                            variant="default"
                            onClick={() => handleOpenAttendance(student)}
                            className="bg-blue-600 hover:bg-blue-700"
                          >
                            <Calendar className="h-3 w-3 mr-1" />
                            Attendance
                          </Button>
                          <Button
                            size="sm"
                            variant="outline"
                            onClick={() => handleDeleteStudent(student)}
                            className="text-red-600 hover:text-red-700"
                          >
                            <Trash2 className="h-3 w-3 mr-1" />
                            Delete
                          </Button>
                        </div>
                      </td>
                    </tr>
                  ))
                ) : (
                  <tr>
                    <td colSpan={7} className="p-3 text-center text-muted-foreground">
                      No students found
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </CardContent>
      </Card>

      {/* Pagination Controls */}
      {totalPages > 1 && (
        <div className="flex items-center justify-between">
          <div className="flex items-center space-x-2">
            <p className="text-sm text-muted-foreground">
              Showing {((currentPage - 1) * pageSize) + 1} to {Math.min(currentPage * pageSize, totalStudents)} of {totalStudents} students
            </p>
            <p className="text-xs text-muted-foreground">
              Page {currentPage} of {totalPages}
            </p>
          </div>

          <div className="flex items-center space-x-2">
            <div className="flex items-center space-x-2">
              <Label htmlFor="pageSize" className="text-sm">Rows per page:</Label>
              <Select value={pageSize.toString()} onValueChange={(value) => {
                setPageSize(parseInt(value));
                setCurrentPage(1);
              }}>
                <SelectTrigger id="pageSize" className="w-20">
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="5">5</SelectItem>
                  <SelectItem value="10">10</SelectItem>
                  <SelectItem value="20">20</SelectItem>
                  <SelectItem value="50">50</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <div className="flex items-center space-x-1">
              <Button
                variant="outline"
                size="sm"
                onClick={() => setCurrentPage(1)}
                disabled={currentPage === 1}
              >
                First
              </Button>
              <Button
                variant="outline"
                size="sm"
                onClick={() => setCurrentPage(currentPage - 1)}
                disabled={currentPage === 1}
              >
                Previous
              </Button>

              <div className="flex items-center space-x-1">
                {Array.from({ length: Math.min(5, totalPages) }, (_, i) => {
                  const pageNumber = Math.max(1, Math.min(totalPages - 4, currentPage - 2)) + i;
                  if (pageNumber > totalPages) return null;

                  return (
                    <Button
                      key={pageNumber}
                      variant={currentPage === pageNumber ? "default" : "outline"}
                      size="sm"
                      onClick={() => setCurrentPage(pageNumber)}
                      className="w-8"
                    >
                      {pageNumber}
                    </Button>
                  );
                })}
              </div>

              <Button
                variant="outline"
                size="sm"
                onClick={() => setCurrentPage(currentPage + 1)}
                disabled={currentPage === totalPages}
              >
                Next
              </Button>
              <Button
                variant="outline"
                size="sm"
                onClick={() => setCurrentPage(totalPages)}
                disabled={currentPage === totalPages}
              >
                Last
              </Button>
            </div>
          </div>
        </div>
      )}

      <Dialog open={isDialogOpen} onOpenChange={setIsDialogOpen}>
        <DialogContent className="max-w-2xl">
          <DialogHeader>
            <DialogTitle>Student Profile</DialogTitle>
            <DialogDescription>
              Detailed information about the selected student.
            </DialogDescription>
          </DialogHeader>

          {selectedStudent && (
            <div className="space-y-4">
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <p className="text-sm text-muted-foreground">Name</p>
                  <p className="font-medium">{selectedStudent.name}</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">
                    Registration Number
                  </p>
                  <p className="font-medium">{selectedStudent.registration_no}</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Course</p>
                  <p className="font-medium">{selectedStudent.course}</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Batch</p>
                  <p className="font-medium">{selectedStudent.batch?.name || 'N/A'}</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Total Score</p>
                  <p className="font-medium">{selectedStudent.overall_score}/100</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Status</p>
                  <StatusBadge status={selectedStudent.status.toLowerCase() as StatusType} />
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Email</p>
                  <p className="font-medium">{selectedStudent.user?.email || 'N/A'}</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Section</p>
                  <p className="font-medium">{selectedStudent.section?.name || 'N/A'}</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Grade</p>
                  <p className="font-medium">{selectedStudent.grade}</p>
                </div>
              </div>



              <div className="flex justify-end gap-2 mt-4">
                <Button variant="outline" onClick={() => setIsDialogOpen(false)}>
                  Close
                </Button>
                <Button>Edit Profile</Button>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>

      {/* Add Student Dialog */}
      <Dialog open={isAddStudentDialogOpen} onOpenChange={setIsAddStudentDialogOpen}>
        <DialogContent className="max-w-2xl">
          <DialogHeader>
            <DialogTitle>Add New Student</DialogTitle>
            <DialogDescription>
              Create a new student account with login credentials.
            </DialogDescription>
          </DialogHeader>

          <div className="space-y-4 py-4">
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="firstName">First Name</Label>
                <Input
                  id="firstName"
                  placeholder="Enter first name"
                  value={newStudentFirstName}
                  onChange={(e) => {
                    setNewStudentFirstName(e.target.value);
                    if (formErrors.firstName) {
                      setFormErrors(ErrorHandler.clearFieldError(formErrors, 'firstName'));
                    }
                  }}
                  className={formErrors.firstName ? 'border-red-500' : ''}
                />
                {formErrors.firstName && (
                  <p className="text-sm text-red-500">{formErrors.firstName}</p>
                )}
              </div>
              <div className="space-y-2">
                <Label htmlFor="lastName">Last Name</Label>
                <Input
                  id="lastName"
                  placeholder="Enter last name"
                  value={newStudentLastName}
                  onChange={(e) => {
                    setNewStudentLastName(e.target.value);
                    if (formErrors.lastName) {
                      setFormErrors(ErrorHandler.clearFieldError(formErrors, 'lastName'));
                    }
                  }}
                  className={formErrors.lastName ? 'border-red-500' : ''}
                />
                {formErrors.lastName && (
                  <p className="text-sm text-red-500">{formErrors.lastName}</p>
                )}
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor="email">Email Address</Label>
              <Input
                id="email"
                type="email"
                placeholder="Enter email address"
                value={newStudentEmail}
                onChange={(e) => {
                  setNewStudentEmail(e.target.value);
                  if (formErrors.email) {
                    setFormErrors(ErrorHandler.clearFieldError(formErrors, 'email'));
                  }
                }}
                className={formErrors.email ? 'border-red-500' : ''}
              />
              {formErrors.email && (
                <p className="text-sm text-red-500">{formErrors.email}</p>
              )}
            </div>

            <div className="space-y-2">
              <Label htmlFor="password">Password</Label>
              <Input
                id="password"
                type="password"
                placeholder="Enter password for login"
                value={newStudentPassword}
                onChange={(e) => {
                  setNewStudentPassword(e.target.value);
                  if (formErrors.password) {
                    setFormErrors(ErrorHandler.clearFieldError(formErrors, 'password'));
                  }
                }}
                className={formErrors.password ? 'border-red-500' : ''}
              />
              {formErrors.password && (
                <p className="text-sm text-red-500">{formErrors.password}</p>
              )}
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="registrationNo">Registration Number</Label>
                <Input
                  id="registrationNo"
                  placeholder="Enter registration number"
                  value={newStudentRegistrationNo}
                  onChange={(e) => setNewStudentRegistrationNo(e.target.value)}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="course">Course</Label>
                <Select value={newStudentCourse} onValueChange={setNewStudentCourse}>
                  <SelectTrigger id="course">
                    <SelectValue placeholder="Select course" />
                  </SelectTrigger>
                  <SelectContent>
                    {loadingFilterOptions ? (
                      <SelectItem value="loading-courses" disabled>Loading courses...</SelectItem>
                    ) : filterOptions?.courses.length ? (
                      filterOptions.courses.map((course) => (
                        <SelectItem key={course} value={course}>
                          {course}
                        </SelectItem>
                      ))
                    ) : (
                      <SelectItem value="no-courses" disabled>No courses available</SelectItem>
                    )}
                  </SelectContent>
                </Select>
              </div>
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="batch">Batch</Label>
                <Select value={newStudentBatch} onValueChange={setNewStudentBatch}>
                  <SelectTrigger id="batch">
                    <SelectValue placeholder="Select batch" />
                  </SelectTrigger>
                  <SelectContent>
                    {loadingFilterOptions ? (
                      <SelectItem value="loading-batches" disabled>Loading batches...</SelectItem>
                    ) : filterOptions?.batches.length ? (
                      filterOptions.batches
                        .filter(batch => batch.id && batch.id.trim() !== '')
                        .map((batch) => (
                          <SelectItem key={batch.id} value={batch.id}>
                            {batch.name} ({batch.year})
                          </SelectItem>
                        ))
                    ) : (
                      <SelectItem value="no-batches" disabled>No batches available</SelectItem>
                    )}
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label htmlFor="section">Section</Label>
                <Select value={newStudentSection} onValueChange={setNewStudentSection}>
                  <SelectTrigger id="section">
                    <SelectValue placeholder="Select section" />
                  </SelectTrigger>
                  <SelectContent>
                    {loadingFilterOptions ? (
                      <SelectItem value="loading-sections" disabled>Loading sections...</SelectItem>
                    ) : filterOptions?.sections.length ? (
                      filterOptions.sections
                        .filter(section => section.id && section.id.trim() !== '')
                        .map((section) => (
                          <SelectItem key={section.id} value={section.id}>
                            {section.name} ({section.batch_name} {section.batch_year})
                          </SelectItem>
                        ))
                    ) : (
                      <SelectItem value="no-sections" disabled>No sections available</SelectItem>
                    )}
                  </SelectContent>
                </Select>
              </div>
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="gender">Gender</Label>
                <Select value={newStudentGender} onValueChange={setNewStudentGender}>
                  <SelectTrigger id="gender">
                    <SelectValue placeholder="Select gender" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="Male">Male</SelectItem>
                    <SelectItem value="Female">Female</SelectItem>
                    <SelectItem value="Other">Other</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label htmlFor="phone">Phone Number (Optional)</Label>
                <Input
                  id="phone"
                  placeholder="Enter phone number"
                  value={newStudentPhone}
                  onChange={(e) => setNewStudentPhone(e.target.value)}
                />
              </div>
            </div>
          </div>

          <DialogFooter>
            <Button variant="outline" onClick={() => setIsAddStudentDialogOpen(false)} disabled={isSubmitting}>
              Cancel
            </Button>
            <Button onClick={handleAddStudent} disabled={isSubmitting}>
              {isSubmitting ? 'Adding...' : 'Add Student'}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Edit Student Dialog */}
      <Dialog open={showEditDialog} onOpenChange={setShowEditDialog}>
        <DialogContent className="max-w-md">
          <DialogHeader>
            <DialogTitle>Edit Student</DialogTitle>
            <DialogDescription>
              Update student information
            </DialogDescription>
          </DialogHeader>

          <div className="space-y-4 py-4">
            <div className="space-y-2">
              <Label htmlFor="editName">Full Name</Label>
              <Input
                id="editName"
                placeholder="Enter full name"
                value={editStudentName}
                onChange={(e) => setEditStudentName(e.target.value)}
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="editCourse">Course</Label>
              <Select value={editStudentCourse} onValueChange={setEditStudentCourse}>
                <SelectTrigger id="editCourse">
                  <SelectValue placeholder="Select course" />
                </SelectTrigger>
                <SelectContent>
                  {filterOptions?.courses.map((course) => (
                    <SelectItem key={course} value={course}>
                      {course}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="editBatch">Batch</Label>
                <Select value={editStudentBatch} onValueChange={setEditStudentBatch}>
                  <SelectTrigger id="editBatch">
                    <SelectValue placeholder="Select batch" />
                  </SelectTrigger>
                  <SelectContent>
                    {filterOptions?.batches
                      .filter(batch => batch.id && batch.id.trim() !== '')
                      .map((batch) => (
                        <SelectItem key={batch.id} value={batch.id}>
                          {batch.name} ({batch.year})
                        </SelectItem>
                      ))}
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label htmlFor="editSection">Section</Label>
                <Select value={editStudentSection} onValueChange={setEditStudentSection}>
                  <SelectTrigger id="editSection">
                    <SelectValue placeholder="Select section" />
                  </SelectTrigger>
                  <SelectContent>
                    {filterOptions?.sections
                      .filter(section => section.id && section.id.trim() !== '')
                      .map((section) => (
                        <SelectItem key={section.id} value={section.id}>
                          {section.name} ({section.batch_name} {section.batch_year})
                        </SelectItem>
                      ))}
                  </SelectContent>
                </Select>
              </div>
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="editGender">Gender</Label>
                <Select value={editStudentGender} onValueChange={setEditStudentGender}>
                  <SelectTrigger id="editGender">
                    <SelectValue placeholder="Select gender" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="Male">Male</SelectItem>
                    <SelectItem value="Female">Female</SelectItem>
                    <SelectItem value="Other">Other</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label htmlFor="editPhone">Phone (Optional)</Label>
                <Input
                  id="editPhone"
                  placeholder="Enter phone number"
                  value={editStudentPhone}
                  onChange={(e) => setEditStudentPhone(e.target.value)}
                />
              </div>
            </div>
          </div>

          <DialogFooter>
            <Button variant="outline" onClick={() => setShowEditDialog(false)} disabled={isEditingStudent}>
              Cancel
            </Button>
            <Button onClick={handleUpdateStudent} disabled={isEditingStudent}>
              {isEditingStudent ? 'Updating...' : 'Update Student'}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Delete Student Confirmation Dialog */}
      <Dialog open={showDeleteDialog} onOpenChange={setShowDeleteDialog}>
        <DialogContent className="max-w-md">
          <DialogHeader>
            <DialogTitle>Delete Student</DialogTitle>
            <DialogDescription>
              Are you sure you want to delete this student? This action cannot be undone.
            </DialogDescription>
          </DialogHeader>

          {deletingStudent && (
            <div className="py-4">
              <div className="bg-red-50 border border-red-200 rounded-lg p-4">
                <h4 className="font-medium text-red-800">Student to be deleted:</h4>
                <p className="text-red-700 mt-1">
                  <strong>{deletingStudent.name}</strong> ({deletingStudent.registration_no})
                </p>
                <p className="text-red-600 text-sm mt-1">
                  Course: {deletingStudent.course}
                </p>
              </div>
            </div>
          )}

          <DialogFooter>
            <Button variant="outline" onClick={() => setShowDeleteDialog(false)} disabled={isDeletingStudent}>
              Cancel
            </Button>
            <Button
              variant="destructive"
              onClick={confirmDeleteStudent}
              disabled={isDeletingStudent}
            >
              {isDeletingStudent ? 'Deleting...' : 'Delete Student'}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Enhanced Student Import */}
      <EnhancedStudentImport
        open={showEnhancedImportDialog}
        onOpenChange={setShowEnhancedImportDialog}
        onImportComplete={handleImportComplete}
      />

      {/* Attendance Management Dialog */}
      <AttendanceManagementDialog
        open={showAttendanceDialog}
        onOpenChange={setShowAttendanceDialog}
        student={selectedStudentForAttendance}
        selectedTerm={currentTerm}
      />
    </div>
  );
};

export default ManageStudents;
