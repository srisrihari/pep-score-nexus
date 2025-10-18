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
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { 
  Plus, 
  Edit, 
  Trash2, 
  Search, 
  Calendar,
  Users,
  BookOpen,
  AlertTriangle,
  Save,
  X
} from 'lucide-react';
import { toast } from "sonner";
import { apiRequest } from '@/lib/api';

interface Course {
  id: string;
  name: string;
  code: string;
  description?: string;
}

interface Batch {
  id: string;
  name: string;
  year: number;
  start_date: string;
  end_date: string;
  is_active: boolean;
  current_term_number: number;
  max_terms: number;
  batch_status: string;
  capacity: number;
  created_at: string;
  courses?: Course;
  _count?: { count: number };
}

interface BatchFormData {
  name: string;
  course_id: string;
  year: number;
  start_date: string;
  end_date: string;
  max_terms: number;
  capacity: number;
}

interface BatchManagementDialogProps {
  trigger: React.ReactNode;
}

const BatchManagementDialog: React.FC<BatchManagementDialogProps> = ({ trigger }) => {
  const [open, setOpen] = useState(false);
  const [batches, setBatches] = useState<Batch[]>([]);
  const [courses, setCourses] = useState<Course[]>([]);
  const [loading, setLoading] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const [editingBatch, setEditingBatch] = useState<Batch | null>(null);
  const [showForm, setShowForm] = useState(false);
  const [formData, setFormData] = useState<BatchFormData>({
    name: '',
    course_id: '',
    year: new Date().getFullYear(),
    start_date: '',
    end_date: '',
    max_terms: 4,
    capacity: 60
  });

  const fetchBatches = async () => {
    setLoading(true);
    try {
      const response = await apiRequest('/api/v1/admin/batch-management/batches', {
        method: 'GET',
      });
      setBatches(response.data);
    } catch (error) {
      console.error('Error fetching batches:', error);
      toast.error('Failed to fetch batches');
    } finally {
      setLoading(false);
    }
  };

  const fetchCourses = async () => {
    try {
      const response = await apiRequest('/api/v1/admin/course-management/courses', {
        method: 'GET',
      });
      setCourses(response.data);
    } catch (error) {
      console.error('Error fetching courses:', error);
      toast.error('Failed to fetch courses');
    }
  };

  useEffect(() => {
    if (open) {
      fetchBatches();
      fetchCourses();
    }
  }, [open]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!formData.name || !formData.course_id || !formData.start_date || !formData.end_date) {
      toast.error('Please fill in all required fields');
      return;
    }

    try {
      if (editingBatch) {
        await apiRequest(`/api/v1/admin/batch-management/batches/${editingBatch.id}`, {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(formData)
        });
        toast.success('Batch updated successfully');
      } else {
        await apiRequest('/api/v1/admin/batch-management/batches', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(formData)
        });
        toast.success('Batch created successfully');
      }
      
      setShowForm(false);
      setEditingBatch(null);
      resetForm();
      fetchBatches();
    } catch (error: any) {
      console.error('Error saving batch:', error);
      toast.error(error.message || 'Failed to save batch');
    }
  };

  const handleEdit = (batch: Batch) => {
    setEditingBatch(batch);
    setFormData({
      name: batch.name,
      course_id: batch.courses?.id || '',
      year: batch.year,
      start_date: batch.start_date,
      end_date: batch.end_date,
      max_terms: batch.max_terms,
      capacity: batch.capacity
    });
    setShowForm(true);
  };

  const handleDelete = async (batch: Batch) => {
    if (!confirm(`Are you sure you want to delete batch "${batch.name}"?`)) {
      return;
    }

    try {
      await apiRequest(`/api/v1/admin/batch-management/batches/${batch.id}`, {
        method: 'DELETE',
      });
      toast.success('Batch deleted successfully');
      fetchBatches();
    } catch (error: any) {
      console.error('Error deleting batch:', error);
      if (error.message.includes('active students')) {
        if (confirm(`${error.message}\n\nWould you like to archive this batch instead?`)) {
          try {
            await apiRequest(`/api/v1/admin/batch-management/batches/${batch.id}?force=true`, {
              method: 'DELETE',
            });
            toast.success('Batch archived successfully');
            fetchBatches();
          } catch (archiveError: any) {
            toast.error(archiveError.message || 'Failed to archive batch');
          }
        }
      } else {
        toast.error(error.message || 'Failed to delete batch');
      }
    }
  };

  const resetForm = () => {
    setFormData({
      name: '',
      course_id: '',
      year: new Date().getFullYear(),
      start_date: '',
      end_date: '',
      max_terms: 4,
      capacity: 60
    });
  };

  const filteredBatches = batches.filter(batch =>
    batch.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    batch.year.toString().includes(searchTerm) ||
    batch.courses?.name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const getStatusBadge = (batch: Batch) => {
    if (!batch.is_active) {
      return <Badge variant="secondary">Inactive</Badge>;
    }
    
    switch (batch.batch_status) {
      case 'active':
        return <Badge variant="default">Active</Badge>;
      case 'completed':
        return <Badge variant="outline">Completed</Badge>;
      case 'archived':
        return <Badge variant="secondary">Archived</Badge>;
      default:
        return <Badge variant="outline">{batch.batch_status}</Badge>;
    }
  };

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        {trigger}
      </DialogTrigger>
      <DialogContent className="max-w-6xl max-h-[90vh] overflow-hidden flex flex-col">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2">
            <BookOpen className="h-5 w-5" />
            Batch Management
          </DialogTitle>
          <DialogDescription>
            Manage batches, create new ones, and organize student groups by academic year.
          </DialogDescription>
        </DialogHeader>

        <Tabs defaultValue="list" className="flex-1 flex flex-col overflow-hidden">
          <TabsList className="grid w-full grid-cols-2">
            <TabsTrigger value="list">Batch List</TabsTrigger>
            <TabsTrigger value="form" disabled={!showForm}>
              {editingBatch ? 'Edit Batch' : 'New Batch'}
            </TabsTrigger>
          </TabsList>

          <TabsContent value="list" className="flex-1 flex flex-col overflow-hidden">
            <div className="flex items-center justify-between gap-4 mb-4">
              <div className="flex items-center gap-2 flex-1">
                <Search className="h-4 w-4 text-gray-400" />
                <Input
                  placeholder="Search batches..."
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  className="max-w-sm"
                />
              </div>
              <Button 
                onClick={() => {
                  setShowForm(true);
                  setEditingBatch(null);
                  resetForm();
                }}
                className="flex items-center gap-2"
              >
                <Plus className="h-4 w-4" />
                Add Batch
              </Button>
            </div>

            <Card className="flex-1 overflow-hidden">
              <CardContent className="p-0">
                <div className="overflow-auto max-h-[500px]">
                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead>Name</TableHead>
                        <TableHead>Course</TableHead>
                        <TableHead>Year</TableHead>
                        <TableHead>Duration</TableHead>
                        <TableHead>Students</TableHead>
                        <TableHead>Status</TableHead>
                        <TableHead>Actions</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {loading ? (
                        <TableRow>
                          <TableCell colSpan={7} className="text-center py-8">
                            Loading batches...
                          </TableCell>
                        </TableRow>
                      ) : filteredBatches.length === 0 ? (
                        <TableRow>
                          <TableCell colSpan={7} className="text-center py-8">
                            No batches found
                          </TableCell>
                        </TableRow>
                      ) : (
                        filteredBatches.map((batch) => (
                          <TableRow key={batch.id}>
                            <TableCell className="font-medium">{batch.name}</TableCell>
                            <TableCell>
                              <div>
                                <div className="font-medium">{batch.courses?.name || 'N/A'}</div>
                                <div className="text-sm text-gray-500">{batch.courses?.code}</div>
                              </div>
                            </TableCell>
                            <TableCell>{batch.year}</TableCell>
                            <TableCell>
                              <div className="flex items-center gap-1 text-sm">
                                <Calendar className="h-3 w-3" />
                                {new Date(batch.start_date).toLocaleDateString()} - {new Date(batch.end_date).toLocaleDateString()}
                              </div>
                            </TableCell>
                            <TableCell>
                              <div className="flex items-center gap-1">
                                <Users className="h-4 w-4" />
                                {batch._count?.count || 0} / {batch.capacity}
                              </div>
                            </TableCell>
                            <TableCell>{getStatusBadge(batch)}</TableCell>
                            <TableCell>
                              <div className="flex items-center gap-2">
                                <Button
                                  variant="outline"
                                  size="sm"
                                  onClick={() => handleEdit(batch)}
                                >
                                  <Edit className="h-4 w-4" />
                                </Button>
                                <Button
                                  variant="outline"
                                  size="sm"
                                  onClick={() => handleDelete(batch)}
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
                  {editingBatch ? `Edit Batch: ${editingBatch.name}` : 'Create New Batch'}
                </CardTitle>
              </CardHeader>
              <CardContent>
                <form onSubmit={handleSubmit} className="space-y-4">
                  <div className="grid grid-cols-2 gap-4">
                    <div>
                      <Label htmlFor="name">Batch Name *</Label>
                      <Input
                        id="name"
                        value={formData.name}
                        onChange={(e) => setFormData(prev => ({ ...prev, name: e.target.value }))}
                        placeholder="e.g., MBA 2024 Batch A"
                        required
                      />
                    </div>
                    <div>
                      <Label htmlFor="course_id">Course *</Label>
                      <Select 
                        value={formData.course_id} 
                        onValueChange={(value) => setFormData(prev => ({ ...prev, course_id: value }))}
                      >
                        <SelectTrigger>
                          <SelectValue placeholder="Select course" />
                        </SelectTrigger>
                        <SelectContent>
                          {courses
                            .filter(course => course.id && course.id.trim() !== '')
                            .map((course) => (
                              <SelectItem key={course.id} value={course.id}>
                                {course.name} {course.code ? `(${course.code})` : ''}
                              </SelectItem>
                            ))}
                        </SelectContent>
                      </Select>
                    </div>
                  </div>

                  <div className="grid grid-cols-3 gap-4">
                    <div>
                      <Label htmlFor="year">Academic Year *</Label>
                      <Input
                        id="year"
                        type="number"
                        value={formData.year}
                        onChange={(e) => setFormData(prev => ({ ...prev, year: parseInt(e.target.value) }))}
                        min="2020"
                        max="2050"
                        required
                      />
                    </div>
                    <div>
                      <Label htmlFor="max_terms">Max Terms</Label>
                      <Input
                        id="max_terms"
                        type="number"
                        value={formData.max_terms}
                        onChange={(e) => setFormData(prev => ({ ...prev, max_terms: parseInt(e.target.value) }))}
                        min="1"
                        max="12"
                      />
                    </div>
                    <div>
                      <Label htmlFor="capacity">Capacity</Label>
                      <Input
                        id="capacity"
                        type="number"
                        value={formData.capacity}
                        onChange={(e) => setFormData(prev => ({ ...prev, capacity: parseInt(e.target.value) }))}
                        min="1"
                        max="500"
                      />
                    </div>
                  </div>

                  <div className="grid grid-cols-2 gap-4">
                    <div>
                      <Label htmlFor="start_date">Start Date *</Label>
                      <Input
                        id="start_date"
                        type="date"
                        value={formData.start_date}
                        onChange={(e) => setFormData(prev => ({ ...prev, start_date: e.target.value }))}
                        required
                      />
                    </div>
                    <div>
                      <Label htmlFor="end_date">End Date *</Label>
                      <Input
                        id="end_date"
                        type="date"
                        value={formData.end_date}
                        onChange={(e) => setFormData(prev => ({ ...prev, end_date: e.target.value }))}
                        required
                      />
                    </div>
                  </div>

                  <div className="flex justify-end gap-2">
                    <Button
                      type="button"
                      variant="outline"
                      onClick={() => {
                        setShowForm(false);
                        setEditingBatch(null);
                        resetForm();
                      }}
                    >
                      <X className="h-4 w-4 mr-2" />
                      Cancel
                    </Button>
                    <Button type="submit">
                      <Save className="h-4 w-4 mr-2" />
                      {editingBatch ? 'Update' : 'Create'} Batch
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

export default BatchManagementDialog;
