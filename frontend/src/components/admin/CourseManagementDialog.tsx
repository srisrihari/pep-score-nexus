import React, { useState, useEffect } from 'react';
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { 
  Plus, 
  Edit, 
  Trash2, 
  Search,
  GraduationCap,
  Clock,
  BookOpen,
  Save,
  X
} from 'lucide-react';
import { toast } from "sonner";
import { apiRequest } from '@/lib/api';

interface Course {
  id: string;
  name: string;
  code?: string;
  description?: string;
  duration_years: number;
  total_terms: number;
  is_active: boolean;
  created_at: string;
  updated_at: string;
  _count?: { count: number };
}

interface CourseFormData {
  name: string;
  code: string;
  description: string;
  duration_years: number;
  total_terms: number;
}

interface CourseManagementDialogProps {
  trigger: React.ReactNode;
}

const CourseManagementDialog: React.FC<CourseManagementDialogProps> = ({ trigger }) => {
  const [open, setOpen] = useState(false);
  const [courses, setCourses] = useState<Course[]>([]);
  const [loading, setLoading] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const [editingCourse, setEditingCourse] = useState<Course | null>(null);
  const [showForm, setShowForm] = useState(false);
  const [formData, setFormData] = useState<CourseFormData>({
    name: '',
    code: '',
    description: '',
    duration_years: 4,
    total_terms: 8
  });

  const fetchCourses = async () => {
    setLoading(true);
    try {
      const response = await apiRequest('/api/v1/admin/course-management/courses', {
        method: 'GET',
      });
      setCourses(response.data);
    } catch (error) {
      console.error('Error fetching courses:', error);
      toast.error('Failed to fetch courses');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (open) {
      fetchCourses();
    }
  }, [open]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!formData.name) {
      toast.error('Course name is required');
      return;
    }

    try {
      if (editingCourse) {
        await apiRequest(`/api/v1/admin/course-management/courses/${editingCourse.id}`, {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(formData)
        });
        toast.success('Course updated successfully');
      } else {
        await apiRequest('/api/v1/admin/course-management/courses', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(formData)
        });
        toast.success('Course created successfully');
      }
      
      setShowForm(false);
      setEditingCourse(null);
      resetForm();
      fetchCourses();
    } catch (error: any) {
      console.error('Error saving course:', error);
      toast.error(error.message || 'Failed to save course');
    }
  };

  const handleEdit = (course: Course) => {
    setEditingCourse(course);
    setFormData({
      name: course.name,
      code: course.code || '',
      description: course.description || '',
      duration_years: course.duration_years,
      total_terms: course.total_terms
    });
    setShowForm(true);
  };

  const handleDelete = async (course: Course) => {
    if (!confirm(`Are you sure you want to delete course "${course.name}"?`)) {
      return;
    }

    try {
      await apiRequest(`/api/v1/admin/course-management/courses/${course.id}`, {
        method: 'DELETE',
      });
      toast.success('Course deleted successfully');
      fetchCourses();
    } catch (error: any) {
      console.error('Error deleting course:', error);
      if (error.message.includes('dependencies')) {
        if (confirm(`${error.message}\n\nWould you like to deactivate this course instead?`)) {
          try {
            await apiRequest(`/api/v1/admin/course-management/courses/${course.id}?force=true`, {
              method: 'DELETE',
            });
            toast.success('Course deactivated successfully');
            fetchCourses();
          } catch (deactivateError: any) {
            toast.error(deactivateError.message || 'Failed to deactivate course');
          }
        }
      } else {
        toast.error(error.message || 'Failed to delete course');
      }
    }
  };

  const resetForm = () => {
    setFormData({
      name: '',
      code: '',
      description: '',
      duration_years: 4,
      total_terms: 8
    });
  };

  const filteredCourses = courses.filter(course =>
    course.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    course.code?.toLowerCase().includes(searchTerm.toLowerCase()) ||
    course.description?.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const getStatusBadge = (course: Course) => {
    return course.is_active 
      ? <Badge variant="default">Active</Badge>
      : <Badge variant="secondary">Inactive</Badge>;
  };

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        {trigger}
      </DialogTrigger>
      <DialogContent className="max-w-6xl max-h-[90vh] overflow-hidden flex flex-col">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2">
            <GraduationCap className="h-5 w-5" />
            Course Management
          </DialogTitle>
          <DialogDescription>
            Manage academic courses and programs offered by your institution.
          </DialogDescription>
        </DialogHeader>

        <Tabs defaultValue="list" className="flex-1 flex flex-col overflow-hidden">
          <TabsList className="grid w-full grid-cols-2">
            <TabsTrigger value="list">Course List</TabsTrigger>
            <TabsTrigger value="form" disabled={!showForm}>
              {editingCourse ? 'Edit Course' : 'New Course'}
            </TabsTrigger>
          </TabsList>

          <TabsContent value="list" className="flex-1 flex flex-col overflow-hidden">
            <div className="flex items-center justify-between gap-4 mb-4">
              <div className="flex items-center gap-2 flex-1">
                <Search className="h-4 w-4 text-gray-400" />
                <Input
                  placeholder="Search courses..."
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  className="max-w-sm"
                />
              </div>
              <Button 
                onClick={() => {
                  setShowForm(true);
                  setEditingCourse(null);
                  resetForm();
                }}
                className="flex items-center gap-2"
              >
                <Plus className="h-4 w-4" />
                Add Course
              </Button>
            </div>

            <Card className="flex-1 overflow-hidden">
              <CardContent className="p-0">
                <div className="overflow-auto max-h-[500px]">
                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead>Name</TableHead>
                        <TableHead>Code</TableHead>
                        <TableHead>Duration</TableHead>
                        <TableHead>Terms</TableHead>
                        <TableHead>Batches</TableHead>
                        <TableHead>Status</TableHead>
                        <TableHead>Actions</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {loading ? (
                        <TableRow>
                          <TableCell colSpan={7} className="text-center py-8">
                            Loading courses...
                          </TableCell>
                        </TableRow>
                      ) : filteredCourses.length === 0 ? (
                        <TableRow>
                          <TableCell colSpan={7} className="text-center py-8">
                            No courses found
                          </TableCell>
                        </TableRow>
                      ) : (
                        filteredCourses.map((course) => (
                          <TableRow key={course.id}>
                            <TableCell>
                              <div>
                                <div className="font-medium">{course.name}</div>
                                {course.description && (
                                  <div className="text-sm text-gray-500 max-w-xs truncate">
                                    {course.description}
                                  </div>
                                )}
                              </div>
                            </TableCell>
                            <TableCell>
                              <Badge variant="outline">{course.code || 'N/A'}</Badge>
                            </TableCell>
                            <TableCell>
                              <div className="flex items-center gap-1">
                                <Clock className="h-4 w-4" />
                                {course.duration_years} years
                              </div>
                            </TableCell>
                            <TableCell>
                              <div className="flex items-center gap-1">
                                <BookOpen className="h-4 w-4" />
                                {course.total_terms} terms
                              </div>
                            </TableCell>
                            <TableCell>
                              <Badge variant="secondary">
                                {course._count?.count || 0} batches
                              </Badge>
                            </TableCell>
                            <TableCell>{getStatusBadge(course)}</TableCell>
                            <TableCell>
                              <div className="flex items-center gap-2">
                                <Button
                                  variant="outline"
                                  size="sm"
                                  onClick={() => handleEdit(course)}
                                >
                                  <Edit className="h-4 w-4" />
                                </Button>
                                <Button
                                  variant="outline"
                                  size="sm"
                                  onClick={() => handleDelete(course)}
                                  className="text-red-600 hover:text-red-700"
                                >
                                  <Trash2 className="h-4 w-4" />
                                </Button>
                              </div>
                            </TableCell>
                          </TableRow>
                        ))
                      )}
                    </TableBody>
                  </Table>
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="form" className="flex-1">
            <Card>
              <CardHeader>
                <CardTitle>
                  {editingCourse ? `Edit Course: ${editingCourse.name}` : 'Create New Course'}
                </CardTitle>
              </CardHeader>
              <CardContent>
                <form onSubmit={handleSubmit} className="space-y-4">
                  <div className="grid grid-cols-2 gap-4">
                    <div>
                      <Label htmlFor="name">Course Name *</Label>
                      <Input
                        id="name"
                        value={formData.name}
                        onChange={(e) => setFormData(prev => ({ ...prev, name: e.target.value }))}
                        placeholder="e.g., Master of Business Administration"
                        required
                      />
                    </div>
                    <div>
                      <Label htmlFor="code">Course Code</Label>
                      <Input
                        id="code"
                        value={formData.code}
                        onChange={(e) => setFormData(prev => ({ ...prev, code: e.target.value }))}
                        placeholder="e.g., MBA, B.Tech"
                      />
                    </div>
                  </div>

                  <div>
                    <Label htmlFor="description">Description</Label>
                    <Textarea
                      id="description"
                      value={formData.description}
                      onChange={(e) => setFormData(prev => ({ ...prev, description: e.target.value }))}
                      placeholder="Brief description of the course..."
                      rows={3}
                    />
                  </div>

                  <div className="grid grid-cols-2 gap-4">
                    <div>
                      <Label htmlFor="duration_years">Duration (Years)</Label>
                      <Input
                        id="duration_years"
                        type="number"
                        value={formData.duration_years}
                        onChange={(e) => setFormData(prev => ({ ...prev, duration_years: parseInt(e.target.value) }))}
                        min="1"
                        max="10"
                        placeholder="4"
                      />
                    </div>
                    <div>
                      <Label htmlFor="total_terms">Total Terms</Label>
                      <Input
                        id="total_terms"
                        type="number"
                        value={formData.total_terms}
                        onChange={(e) => setFormData(prev => ({ ...prev, total_terms: parseInt(e.target.value) }))}
                        min="1"
                        max="20"
                        placeholder="8"
                      />
                    </div>
                  </div>

                  <div className="flex justify-end gap-2">
                    <Button
                      type="button"
                      variant="outline"
                      onClick={() => {
                        setShowForm(false);
                        setEditingCourse(null);
                        resetForm();
                      }}
                    >
                      <X className="h-4 w-4 mr-2" />
                      Cancel
                    </Button>
                    <Button type="submit">
                      <Save className="h-4 w-4 mr-2" />
                      {editingCourse ? 'Update' : 'Create'} Course
                    </Button>
                  </div>
                </form>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </DialogContent>
    </Dialog>
  );
};

export default CourseManagementDialog;
















