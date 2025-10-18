import React, { useState, useEffect } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Badge } from '@/components/ui/badge';
import { Calendar, Plus, Settings, Users, CheckCircle, Edit, Trash2 } from 'lucide-react';
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { termAPI } from '@/lib/api';
import { useTerm } from '@/contexts/TermContext';
import { toast } from 'sonner';

interface Term {
  id: string;
  name: string;
  description?: string;
  start_date: string;
  end_date: string;
  is_active: boolean;
  is_current: boolean;
  academic_year: string;
  created_at: string;
}

const TermManagement: React.FC = () => {
  const { currentTerm, availableTerms, refreshTerms, setCurrentTerm } = useTerm();
  const [isLoading, setIsLoading] = useState(false);
  const [showCreateForm, setShowCreateForm] = useState(false);
  const [formData, setFormData] = useState({
    name: '',
    description: '',
    start_date: '',
    end_date: '',
    academic_year: '',
    is_active: true,
    is_current: false
  });

  // Edit state
  const [editingTerm, setEditingTerm] = useState<Term | null>(null);
  const [showEditDialog, setShowEditDialog] = useState(false);
  const [editFormData, setEditFormData] = useState({
    name: '',
    description: '',
    start_date: '',
    end_date: '',
    academic_year: '',
    is_active: true
  });

  // Delete state
  const [deletingTerm, setDeletingTerm] = useState<Term | null>(null);
  const [showDeleteDialog, setShowDeleteDialog] = useState(false);
  const [isDeletingTerm, setIsDeletingTerm] = useState(false);

  const handleCreateTerm = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);

    try {
      const response = await termAPI.createTerm(formData);
      if (response.success) {
        toast.success('Term created successfully');
        setShowCreateForm(false);
        setFormData({
          name: '',
          description: '',
          start_date: '',
          end_date: '',
          academic_year: '',
          is_active: true,
          is_current: false
        });
        await refreshTerms();
      } else {
        toast.error('Failed to create term');
      }
    } catch (error) {
      console.error('Error creating term:', error);
      toast.error('Failed to create term');
    } finally {
      setIsLoading(false);
    }
  };

  const handleSetCurrentTerm = async (termId: string) => {
    setIsLoading(true);
    try {
      await setCurrentTerm(termId);
      toast.success('Current term updated successfully');
    } catch (error) {
      console.error('Error setting current term:', error);
      toast.error('Failed to set current term');
    } finally {
      setIsLoading(false);
    }
  };

  const handleTransitionStudents = async (termId: string) => {
    setIsLoading(true);
    try {
      const response = await termAPI.transitionStudents(termId);
      if (response.success) {
        toast.success(`Successfully transitioned ${response.data.studentsTransitioned} students`);
      } else {
        toast.error('Failed to transition students');
      }
    } catch (error) {
      console.error('Error transitioning students:', error);
      toast.error('Failed to transition students');
    } finally {
      setIsLoading(false);
    }
  };

  const handleResetScores = async (termId: string) => {
    if (!confirm('Are you sure you want to reset all scores for this term? This action cannot be undone.')) {
      return;
    }

    setIsLoading(true);
    try {
      const response = await termAPI.resetTermScores(termId);
      if (response.success) {
        toast.success(`Successfully reset scores for ${response.data.studentsReset} students`);
      } else {
        toast.error('Failed to reset scores');
      }
    } catch (error) {
      console.error('Error resetting scores:', error);
      toast.error('Failed to reset scores');
    } finally {
      setIsLoading(false);
    }
  };

  const handleEditTerm = (term: Term) => {
    setEditingTerm(term);
    setEditFormData({
      name: term.name,
      description: term.description || '',
      start_date: term.start_date,
      end_date: term.end_date,
      academic_year: term.academic_year,
      is_active: term.is_active
    });
    setShowEditDialog(true);
  };

  const handleUpdateTerm = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!editingTerm) return;

    setIsLoading(true);
    try {
      const response = await termAPI.updateTerm(editingTerm.id, editFormData);
      if (response.success) {
        toast.success('Term updated successfully');
        setShowEditDialog(false);
        setEditingTerm(null);
        await refreshTerms();
      } else {
        toast.error('Failed to update term');
      }
    } catch (error) {
      console.error('Error updating term:', error);
      toast.error('Failed to update term');
    } finally {
      setIsLoading(false);
    }
  };

  const handleDeleteTerm = (term: Term) => {
    setDeletingTerm(term);
    setShowDeleteDialog(true);
  };

  const confirmDeleteTerm = async (forceCascade = false) => {
    if (!deletingTerm) return;

    setIsDeletingTerm(true);
    try {
      const response = await termAPI.deleteTerm(deletingTerm.id, forceCascade);
      if (response.success) {
        toast.success(
          forceCascade 
            ? 'Term and all associated data deleted successfully' 
            : 'Term deleted successfully'
        );
        setShowDeleteDialog(false);
        setDeletingTerm(null);
        await refreshTerms();
      } else {
        // Check if it's a cascade warning
        if (response.associations && !forceCascade) {
          const details = response.associations.map(a => `${a.table}: ${a.count} records`).join(', ');
          const shouldCascade = confirm(
            `This term has associated data: ${details}\n\nDo you want to permanently delete ALL related data? This cannot be undone.`
          );
          
          if (shouldCascade) {
            // Retry with force cascade
            confirmDeleteTerm(true);
            return;
          }
        }
        toast.error(response.message || 'Failed to delete term');
      }
    } catch (error: any) {
      console.error('Error deleting term:', error);
      if (error.message?.includes('associated data')) {
        const shouldCascade = confirm(
          `${error.message}\n\nDo you want to permanently delete ALL related data? This cannot be undone.`
        );
        
        if (shouldCascade) {
          confirmDeleteTerm(true);
          return;
        }
      }
      toast.error('Failed to delete term: ' + (error.message || 'Unknown error'));
    } finally {
      setIsDeletingTerm(false);
    }
  };

  return (
    <div className="container mx-auto p-6 space-y-6">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-3xl font-bold">Term Management</h1>
          <p className="text-muted-foreground">
            Manage academic terms and student transitions
          </p>
        </div>
        <Button onClick={() => setShowCreateForm(true)} className="flex items-center gap-2">
          <Plus className="h-4 w-4" />
          Create New Term
        </Button>
      </div>

      {/* Current Term Info */}
      {currentTerm && (
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <CheckCircle className="h-5 w-5 text-green-500" />
              Current Term
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <div>
                <Label className="text-sm font-medium">Term Name</Label>
                <p className="text-lg">{currentTerm.name}</p>
              </div>
              <div>
                <Label className="text-sm font-medium">Academic Year</Label>
                <p className="text-lg">{currentTerm.academic_year}</p>
              </div>
              <div>
                <Label className="text-sm font-medium">Duration</Label>
                <p className="text-lg">
                  {new Date(currentTerm.start_date).toLocaleDateString()} - {new Date(currentTerm.end_date).toLocaleDateString()}
                </p>
              </div>
            </div>
          </CardContent>
        </Card>
      )}

      {/* Create Term Form */}
      {showCreateForm && (
        <Card>
          <CardHeader>
            <CardTitle>Create New Term</CardTitle>
            <CardDescription>
              Add a new academic term to the system
            </CardDescription>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleCreateTerm} className="space-y-4">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="name">Term Name *</Label>
                  <Input
                    id="name"
                    value={formData.name}
                    onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                    placeholder="e.g., Term 2 / Level 1"
                    required
                  />
                </div>
                <div>
                  <Label htmlFor="academic_year">Academic Year *</Label>
                  <Input
                    id="academic_year"
                    value={formData.academic_year}
                    onChange={(e) => setFormData({ ...formData, academic_year: e.target.value })}
                    placeholder="e.g., 2024"
                    required
                  />
                </div>
                <div>
                  <Label htmlFor="start_date">Start Date *</Label>
                  <Input
                    id="start_date"
                    type="date"
                    value={formData.start_date}
                    onChange={(e) => setFormData({ ...formData, start_date: e.target.value })}
                    required
                  />
                </div>
                <div>
                  <Label htmlFor="end_date">End Date *</Label>
                  <Input
                    id="end_date"
                    type="date"
                    value={formData.end_date}
                    onChange={(e) => setFormData({ ...formData, end_date: e.target.value })}
                    required
                  />
                </div>
              </div>
              <div>
                <Label htmlFor="description">Description</Label>
                <Textarea
                  id="description"
                  value={formData.description}
                  onChange={(e) => setFormData({ ...formData, description: e.target.value })}
                  placeholder="Optional description for this term"
                />
              </div>
              <div className="flex items-center space-x-4">
                <label className="flex items-center space-x-2">
                  <input
                    type="checkbox"
                    checked={formData.is_current}
                    onChange={(e) => setFormData({ ...formData, is_current: e.target.checked })}
                  />
                  <span>Set as current term</span>
                </label>
              </div>
              <div className="flex gap-2">
                <Button type="submit" disabled={isLoading}>
                  {isLoading ? 'Creating...' : 'Create Term'}
                </Button>
                <Button type="button" variant="outline" onClick={() => setShowCreateForm(false)}>
                  Cancel
                </Button>
              </div>
            </form>
          </CardContent>
        </Card>
      )}

      {/* Terms List */}
      <Card>
        <CardHeader>
          <CardTitle>All Terms</CardTitle>
          <CardDescription>
            Manage existing academic terms
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {availableTerms.map((term) => (
              <div key={term.id} className="flex items-center justify-between p-4 border rounded-lg">
                <div className="flex-1">
                  <div className="flex items-center gap-2">
                    <h3 className="font-semibold">{term.name}</h3>
                    {term.is_current && (
                      <Badge variant="default">Current</Badge>
                    )}
                    {term.is_active && (
                      <Badge variant="secondary">Active</Badge>
                    )}
                  </div>
                  <p className="text-sm text-muted-foreground">
                    {term.academic_year} • {new Date(term.start_date).toLocaleDateString()} - {new Date(term.end_date).toLocaleDateString()}
                  </p>
                  {term.description && (
                    <p className="text-sm text-muted-foreground mt-1">{term.description}</p>
                  )}
                </div>
                <div className="flex gap-2">
                  {!term.is_current && (
                    <Button
                      size="sm"
                      variant="outline"
                      onClick={() => handleSetCurrentTerm(term.id)}
                      disabled={isLoading}
                    >
                      Set as Current
                    </Button>
                  )}
                  <Button
                    size="sm"
                    variant="outline"
                    onClick={() => handleEditTerm(term)}
                    disabled={isLoading}
                    className="flex items-center gap-1"
                  >
                    <Edit className="h-3 w-3" />
                    Edit
                  </Button>
                  <Button
                    size="sm"
                    variant="outline"
                    onClick={() => handleTransitionStudents(term.id)}
                    disabled={isLoading}
                    className="flex items-center gap-1"
                  >
                    <Users className="h-3 w-3" />
                    Transition Students
                  </Button>
                  <Button
                    size="sm"
                    variant="outline"
                    onClick={() => handleResetScores(term.id)}
                    disabled={isLoading}
                    className="flex items-center gap-1 text-orange-600 hover:text-orange-700"
                  >
                    <Settings className="h-3 w-3" />
                    Reset Scores
                  </Button>
                  {!term.is_current && (
                    <Button
                      size="sm"
                      variant="outline"
                      onClick={() => handleDeleteTerm(term)}
                      disabled={isLoading}
                      className="flex items-center gap-1 text-red-600 hover:text-red-700"
                    >
                      <Trash2 className="h-3 w-3" />
                      Delete
                    </Button>
                  )}
                </div>
              </div>
            ))}
            {availableTerms.length === 0 && (
              <div className="text-center py-8 text-muted-foreground">
                No terms found. Create your first term to get started.
              </div>
            )}
          </div>
        </CardContent>
      </Card>

      {/* Edit Term Dialog */}
      <Dialog open={showEditDialog} onOpenChange={setShowEditDialog}>
        <DialogContent className="max-w-md">
          <DialogHeader>
            <DialogTitle>Edit Term</DialogTitle>
            <DialogDescription>
              Update the term details below.
            </DialogDescription>
          </DialogHeader>
          <form onSubmit={handleUpdateTerm} className="space-y-4">
            <div>
              <Label htmlFor="edit-name">Term Name</Label>
              <Input
                id="edit-name"
                value={editFormData.name}
                onChange={(e) => setEditFormData(prev => ({ ...prev, name: e.target.value }))}
                required
              />
            </div>
            <div>
              <Label htmlFor="edit-description">Description</Label>
              <Textarea
                id="edit-description"
                value={editFormData.description}
                onChange={(e) => setEditFormData(prev => ({ ...prev, description: e.target.value }))}
                placeholder="Optional description..."
              />
            </div>
            <div>
              <Label htmlFor="edit-academic-year">Academic Year</Label>
              <Input
                id="edit-academic-year"
                value={editFormData.academic_year}
                onChange={(e) => setEditFormData(prev => ({ ...prev, academic_year: e.target.value }))}
                placeholder="e.g., 2024-2025"
                required
              />
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div>
                <Label htmlFor="edit-start-date">Start Date</Label>
                <Input
                  id="edit-start-date"
                  type="date"
                  value={editFormData.start_date}
                  onChange={(e) => setEditFormData(prev => ({ ...prev, start_date: e.target.value }))}
                  required
                />
              </div>
              <div>
                <Label htmlFor="edit-end-date">End Date</Label>
                <Input
                  id="edit-end-date"
                  type="date"
                  value={editFormData.end_date}
                  onChange={(e) => setEditFormData(prev => ({ ...prev, end_date: e.target.value }))}
                  required
                />
              </div>
            </div>
            <DialogFooter>
              <Button type="button" variant="outline" onClick={() => setShowEditDialog(false)}>
                Cancel
              </Button>
              <Button type="submit" disabled={isLoading}>
                {isLoading ? 'Updating...' : 'Update Term'}
              </Button>
            </DialogFooter>
          </form>
        </DialogContent>
      </Dialog>

      {/* Delete Term Dialog */}
      <Dialog open={showDeleteDialog} onOpenChange={setShowDeleteDialog}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Delete Term</DialogTitle>
            <DialogDescription>
              Are you sure you want to delete "{deletingTerm?.name}"? This will permanently delete:
              <br />• All student scores for this term
              <br />• All interventions in this term
              <br />• All term-specific data
              <br /><br />
              <strong>This action cannot be undone.</strong>
            </DialogDescription>
          </DialogHeader>
          <DialogFooter>
            <Button 
              variant="outline" 
              onClick={() => setShowDeleteDialog(false)}
              disabled={isDeletingTerm}
            >
              Cancel
            </Button>
            <Button 
              variant="destructive" 
              onClick={confirmDeleteTerm}
              disabled={isDeletingTerm}
            >
              {isDeletingTerm ? 'Deleting...' : 'Delete Term'}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
};

export default TermManagement;
