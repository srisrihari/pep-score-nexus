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
  Users,
  Building,
  Save,
  X
} from 'lucide-react';
import { toast } from "sonner";
import { apiRequest } from '@/lib/api';

interface Batch {
  id: string;
  name: string;
  year: number;
}

interface Section {
  id: string;
  name: string;
  capacity: number;
  is_active: boolean;
  created_at: string;
  batches?: Batch;
  _count?: { count: number };
}

interface SectionFormData {
  name: string;
  batch_id: string;
  capacity: number;
}

interface SectionManagementDialogProps {
  trigger: React.ReactNode;
}

const SectionManagementDialog: React.FC<SectionManagementDialogProps> = ({ trigger }) => {
  const [open, setOpen] = useState(false);
  const [sections, setSections] = useState<Section[]>([]);
  const [batches, setBatches] = useState<Batch[]>([]);
  const [loading, setLoading] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const [batchFilter, setBatchFilter] = useState('all');
  const [editingSection, setEditingSection] = useState<Section | null>(null);
  const [showForm, setShowForm] = useState(false);
  const [formData, setFormData] = useState<SectionFormData>({
    name: '',
    batch_id: '',
    capacity: 60
  });

  const fetchSections = async () => {
    setLoading(true);
    try {
      const params = new URLSearchParams();
      if (batchFilter && batchFilter !== 'all') params.append('batch_id', batchFilter);
      
      const response = await apiRequest(`/api/v1/admin/section-management/sections?${params}`, {
        method: 'GET',
      });
      setSections(response.data);
    } catch (error) {
      console.error('Error fetching sections:', error);
      toast.error('Failed to fetch sections');
    } finally {
      setLoading(false);
    }
  };

  const fetchBatches = async () => {
    try {
      const response = await apiRequest('/api/v1/admin/batch-management/batches', {
        method: 'GET',
      });
      setBatches(response.data);
    } catch (error) {
      console.error('Error fetching batches:', error);
      toast.error('Failed to fetch batches');
    }
  };

  useEffect(() => {
    if (open) {
      fetchSections();
      fetchBatches();
    }
  }, [open, batchFilter]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!formData.name || !formData.batch_id) {
      toast.error('Please fill in all required fields');
      return;
    }

    try {
      if (editingSection) {
        await apiRequest(`/api/v1/admin/section-management/sections/${editingSection.id}`, {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(formData)
        });
        toast.success('Section updated successfully');
      } else {
        await apiRequest('/api/v1/admin/section-management/sections', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(formData)
        });
        toast.success('Section created successfully');
      }
      
      setShowForm(false);
      setEditingSection(null);
      resetForm();
      fetchSections();
    } catch (error: any) {
      console.error('Error saving section:', error);
      toast.error(error.message || 'Failed to save section');
    }
  };

  const handleEdit = (section: Section) => {
    setEditingSection(section);
    setFormData({
      name: section.name,
      batch_id: section.batches?.id || '',
      capacity: section.capacity
    });
    setShowForm(true);
  };

  const handleDelete = async (section: Section) => {
    if (!confirm(`Are you sure you want to delete section "${section.name}"?`)) {
      return;
    }

    try {
      await apiRequest(`/api/v1/admin/section-management/sections/${section.id}`, {
        method: 'DELETE',
      });
      toast.success('Section deleted successfully');
      fetchSections();
    } catch (error: any) {
      console.error('Error deleting section:', error);
      if (error.message.includes('active students')) {
        if (confirm(`${error.message}\n\nWould you like to deactivate this section instead?`)) {
          try {
            await apiRequest(`/api/v1/admin/section-management/sections/${section.id}?force=true`, {
              method: 'DELETE',
            });
            toast.success('Section deactivated successfully');
            fetchSections();
          } catch (deactivateError: any) {
            toast.error(deactivateError.message || 'Failed to deactivate section');
          }
        }
      } else {
        toast.error(error.message || 'Failed to delete section');
      }
    }
  };

  const resetForm = () => {
    setFormData({
      name: '',
      batch_id: '',
      capacity: 60
    });
  };

  const filteredSections = sections.filter(section =>
    section.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    section.batches?.name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const getStatusBadge = (section: Section) => {
    return section.is_active 
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
            <Building className="h-5 w-5" />
            Section Management
          </DialogTitle>
          <DialogDescription>
            Manage sections within batches to organize students into smaller groups.
          </DialogDescription>
        </DialogHeader>

        <Tabs defaultValue="list" className="flex-1 flex flex-col overflow-hidden">
          <TabsList className="grid w-full grid-cols-2">
            <TabsTrigger value="list">Section List</TabsTrigger>
            <TabsTrigger value="form" disabled={!showForm}>
              {editingSection ? 'Edit Section' : 'New Section'}
            </TabsTrigger>
          </TabsList>

          <TabsContent value="list" className="flex-1 flex flex-col overflow-hidden">
            <div className="flex items-center justify-between gap-4 mb-4">
              <div className="flex items-center gap-2 flex-1">
                <Search className="h-4 w-4 text-gray-400" />
                <Input
                  placeholder="Search sections..."
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  className="max-w-sm"
                />
                <Select value={batchFilter} onValueChange={setBatchFilter}>
                  <SelectTrigger className="w-48">
                    <SelectValue placeholder="Filter by batch" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">All Batches</SelectItem>
                    {batches
                      .filter(batch => batch.id && batch.id.trim() !== '')
                      .map((batch) => (
                        <SelectItem key={batch.id} value={batch.id}>
                          {batch.name} ({batch.year})
                        </SelectItem>
                      ))}
                  </SelectContent>
                </Select>
              </div>
              <Button 
                onClick={() => {
                  setShowForm(true);
                  setEditingSection(null);
                  resetForm();
                }}
                className="flex items-center gap-2"
              >
                <Plus className="h-4 w-4" />
                Add Section
              </Button>
            </div>

            <Card className="flex-1 overflow-hidden">
              <CardContent className="p-0">
                <div className="overflow-auto max-h-[500px]">
                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead>Name</TableHead>
                        <TableHead>Batch</TableHead>
                        <TableHead>Capacity</TableHead>
                        <TableHead>Students</TableHead>
                        <TableHead>Status</TableHead>
                        <TableHead>Actions</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {loading ? (
                        <TableRow>
                          <TableCell colSpan={6} className="text-center py-8">
                            Loading sections...
                          </TableCell>
                        </TableRow>
                      ) : filteredSections.length === 0 ? (
                        <TableRow>
                          <TableCell colSpan={6} className="text-center py-8">
                            No sections found
                          </TableCell>
                        </TableRow>
                      ) : (
                        filteredSections.map((section) => (
                          <TableRow key={section.id}>
                            <TableCell className="font-medium">{section.name}</TableCell>
                            <TableCell>
                              <div>
                                <div className="font-medium">{section.batches?.name || 'N/A'}</div>
                                <div className="text-sm text-gray-500">Year {section.batches?.year}</div>
                              </div>
                            </TableCell>
                            <TableCell>{section.capacity}</TableCell>
                            <TableCell>
                              <div className="flex items-center gap-1">
                                <Users className="h-4 w-4" />
                                {section._count?.count || 0} / {section.capacity}
                              </div>
                            </TableCell>
                            <TableCell>{getStatusBadge(section)}</TableCell>
                            <TableCell>
                              <div className="flex items-center gap-2">
                                <Button
                                  variant="outline"
                                  size="sm"
                                  onClick={() => handleEdit(section)}
                                >
                                  <Edit className="h-4 w-4" />
                                </Button>
                                <Button
                                  variant="outline"
                                  size="sm"
                                  onClick={() => handleDelete(section)}
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
                  {editingSection ? `Edit Section: ${editingSection.name}` : 'Create New Section'}
                </CardTitle>
              </CardHeader>
              <CardContent>
                <form onSubmit={handleSubmit} className="space-y-4">
                  <div className="grid grid-cols-2 gap-4">
                    <div>
                      <Label htmlFor="name">Section Name *</Label>
                      <Input
                        id="name"
                        value={formData.name}
                        onChange={(e) => setFormData(prev => ({ ...prev, name: e.target.value }))}
                        placeholder="e.g., Section A, Section B"
                        required
                      />
                    </div>
                    <div>
                      <Label htmlFor="batch_id">Batch *</Label>
                      <Select 
                        value={formData.batch_id} 
                        onValueChange={(value) => setFormData(prev => ({ ...prev, batch_id: value }))}
                      >
                        <SelectTrigger>
                          <SelectValue placeholder="Select batch" />
                        </SelectTrigger>
                        <SelectContent>
                          {batches
                            .filter(batch => batch.id && batch.id.trim() !== '')
                            .map((batch) => (
                              <SelectItem key={batch.id} value={batch.id}>
                                {batch.name} ({batch.year})
                              </SelectItem>
                            ))}
                        </SelectContent>
                      </Select>
                    </div>
                  </div>

                  <div>
                    <Label htmlFor="capacity">Capacity</Label>
                    <Input
                      id="capacity"
                      type="number"
                      value={formData.capacity}
                      onChange={(e) => setFormData(prev => ({ ...prev, capacity: parseInt(e.target.value) }))}
                      min="1"
                      max="200"
                      placeholder="Maximum number of students"
                    />
                  </div>

                  <div className="flex justify-end gap-2">
                    <Button
                      type="button"
                      variant="outline"
                      onClick={() => {
                        setShowForm(false);
                        setEditingSection(null);
                        resetForm();
                      }}
                    >
                      <X className="h-4 w-4 mr-2" />
                      Cancel
                    </Button>
                    <Button type="submit">
                      <Save className="h-4 w-4 mr-2" />
                      {editingSection ? 'Update' : 'Create'} Section
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

export default SectionManagementDialog;
