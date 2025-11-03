import React, { useState } from 'react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Badge } from '@/components/ui/badge';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Checkbox } from '@/components/ui/checkbox';
import { Plus, X, Users, BookOpen, Target, UserCheck, CheckCircle, Circle, Settings, Trash2, ChevronDown, ChevronRight } from 'lucide-react';

interface MultiStepInterventionFormProps {
  currentStep: number;
  createForm: any;
  setCreateForm: (form: any) => void;
  formErrors: Record<string, string>;
  setFormErrors: (errors: any) => void;
  selectedMicrocompetencies: any[];
  setSelectedMicrocompetencies: (mcs: any[]) => void;
  // NEW: Teacher assignment props (intervention-level)
  selectedTeachers: Array<{
    teacher_id: string;
    teacher: { id: string; name: string; employee_id: string };
    can_score: boolean;
    can_create_tasks: boolean;
  }>;
  setSelectedTeachers: (teachers: any[]) => void;
  // NEW: Teacher-student group assignments
  teacherStudentGroups: Array<{
    teacher_assignment_id?: string;
    teacher_id: string;
    teacher_name: string;
    studentIds: string[];
  }>;
  setTeacherStudentGroups: (groups: any[]) => void;
  availableMicrocompetencies: any[];
  availableTeachers: any[];
  availableStudents: any[];
  addObjective: () => void;
  updateObjective: (index: number, value: string) => void;
  removeObjective: (index: number) => void;
  addPrerequisite: () => void;
  updatePrerequisite: (index: number, value: string) => void;
  removePrerequisite: (index: number) => void;
  addMicrocompetency: (mc: any) => void;
  removeMicrocompetency: (id: string) => void;
  updateMicrocompetencyWeightage: (id: string, weightage: number) => void;
  updateMicrocompetencyMaxScore: (id: string, maxScore: number) => void;
  // NEW: Teacher management functions
  addTeacher: (teacher: any) => void;
  removeTeacher: (teacherId: string) => void;
  updateTeacherPermissions: (teacherId: string, permissions: { can_score?: boolean; can_create_tasks?: boolean }) => void;
  assignStudentsToTeacher: (teacherId: string, studentIds: string[]) => void;
  setShowStudentSelectionDialog: (show: boolean) => void;
}

export const MultiStepInterventionForm: React.FC<MultiStepInterventionFormProps> = ({
  currentStep,
  createForm,
  setCreateForm,
  formErrors,
  setFormErrors,
  selectedMicrocompetencies,
  selectedTeachers,
  setSelectedTeachers,
  teacherStudentGroups,
  setTeacherStudentGroups,
  availableMicrocompetencies,
  availableTeachers,
  availableStudents,
  addObjective,
  updateObjective,
  removeObjective,
  addPrerequisite,
  updatePrerequisite,
  removePrerequisite,
  addMicrocompetency,
  removeMicrocompetency,
  updateMicrocompetencyWeightage,
  updateMicrocompetencyMaxScore,
  addTeacher,
  removeTeacher,
  updateTeacherPermissions,
  assignStudentsToTeacher,
  setShowStudentSelectionDialog,
}) => {
  const renderStep1 = () => (
    <div className="space-y-6">
      <div className="space-y-4">
        <div className="space-y-2">
          <Label htmlFor="name">Intervention Name *</Label>
          <Input
            id="name"
            placeholder="Enter intervention name"
            value={createForm.name}
            onChange={(e) => {
              setCreateForm(prev => ({ ...prev, name: e.target.value }));
              if (formErrors.name) {
                setFormErrors(prev => ({ ...prev, name: '' }));
              }
            }}
            className={formErrors.name ? 'border-red-500' : ''}
          />
          {formErrors.name && (
            <p className="text-sm text-red-600">{formErrors.name}</p>
          )}
        </div>

        <div className="space-y-2">
          <Label htmlFor="description">Description *</Label>
          <Textarea
            id="description"
            placeholder="Describe the intervention program, its goals, and expected outcomes"
            value={createForm.description}
            onChange={(e) => {
              setCreateForm(prev => ({ ...prev, description: e.target.value }));
              if (formErrors.description) {
                setFormErrors(prev => ({ ...prev, description: '' }));
              }
            }}
            rows={4}
            className={formErrors.description ? 'border-red-500' : ''}
          />
          {formErrors.description && (
            <p className="text-sm text-red-600">{formErrors.description}</p>
          )}
        </div>

        <div className="grid grid-cols-2 gap-4">
          <div className="space-y-2">
            <Label htmlFor="startDate">Start Date *</Label>
            <Input
              id="startDate"
              type="date"
              value={createForm.startDate}
              onChange={(e) => {
                setCreateForm(prev => ({ ...prev, startDate: e.target.value }));
                if (formErrors.startDate) {
                  setFormErrors(prev => ({ ...prev, startDate: '' }));
                }
              }}
              className={formErrors.startDate ? 'border-red-500' : ''}
              min={new Date().toISOString().split('T')[0]}
            />
            {formErrors.startDate && (
              <p className="text-sm text-red-600">{formErrors.startDate}</p>
            )}
          </div>
          <div className="space-y-2">
            <Label htmlFor="endDate">End Date *</Label>
            <Input
              id="endDate"
              type="date"
              value={createForm.endDate}
              onChange={(e) => {
                setCreateForm(prev => ({ ...prev, endDate: e.target.value }));
                if (formErrors.endDate) {
                  setFormErrors(prev => ({ ...prev, endDate: '' }));
                }
              }}
              className={formErrors.endDate ? 'border-red-500' : ''}
              min={createForm.startDate || new Date().toISOString().split('T')[0]}
            />
            {formErrors.endDate && (
              <p className="text-sm text-red-600">{formErrors.endDate}</p>
            )}
          </div>
        </div>

        <div className="space-y-2">
          <Label htmlFor="maxStudents">Maximum Students *</Label>
          <Input
            id="maxStudents"
            type="number"
            min="1"
            max="1000"
            value={createForm.maxStudents}
            onChange={(e) => {
              const value = parseInt(e.target.value) || 1;
              setCreateForm(prev => ({ ...prev, maxStudents: value }));
              if (formErrors.maxStudents) {
                setFormErrors(prev => ({ ...prev, maxStudents: '' }));
              }
            }}
            className={formErrors.maxStudents ? 'border-red-500' : ''}
          />
          {formErrors.maxStudents && (
            <p className="text-sm text-red-600">{formErrors.maxStudents}</p>
          )}
        </div>
      </div>

      {/* Objectives */}
      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <div>
            <Label>Learning Objectives *</Label>
            <p className="text-xs text-gray-500">Define what students will achieve</p>
          </div>
          <Button type="button" variant="outline" size="sm" onClick={addObjective}>
            <Plus className="h-4 w-4 mr-1" />
            Add Objective
          </Button>
        </div>
        {createForm.objectives.map((objective, index) => (
          <div key={index} className="flex gap-2">
            <div className="flex-1">
              <Input
                placeholder={`Learning objective ${index + 1}`}
                value={objective}
                onChange={(e) => updateObjective(index, e.target.value)}
              />
            </div>
            <Button
              type="button"
              variant="outline"
              size="sm"
              onClick={() => removeObjective(index)}
            >
              <X className="h-4 w-4" />
            </Button>
          </div>
        ))}
      </div>

      {/* Prerequisites */}
      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <div>
            <Label>Prerequisites (Optional)</Label>
            <p className="text-xs text-gray-500">Skills or knowledge students should have</p>
          </div>
          <Button type="button" variant="outline" size="sm" onClick={addPrerequisite}>
            <Plus className="h-4 w-4 mr-1" />
            Add Prerequisite
          </Button>
        </div>
        {createForm.prerequisites.map((prerequisite, index) => (
          <div key={index} className="flex gap-2">
            <div className="flex-1">
              <Input
                placeholder={`Prerequisite ${index + 1}`}
                value={prerequisite}
                onChange={(e) => updatePrerequisite(index, e.target.value)}
              />
            </div>
            <Button
              type="button"
              variant="outline"
              size="sm"
              onClick={() => removePrerequisite(index)}
            >
              <X className="h-4 w-4" />
            </Button>
          </div>
        ))}
      </div>
    </div>
  );

  const renderStep2 = () => {
    // State for collapsed quadrants - all start collapsed
    const [collapsedQuadrants, setCollapsedQuadrants] = useState<Record<string, boolean>>(() => {
      const initial = {};
      const groupedMicrocompetencies = availableMicrocompetencies.reduce((acc, mc) => {
        const quadrantName = mc.quadrant?.name || 'Other';
        if (!acc[quadrantName]) {
          acc[quadrantName] = [];
        }
        acc[quadrantName].push(mc);
        return acc;
      }, {} as Record<string, any[]>);
      
      // Initialize all quadrants as collapsed
      Object.keys(groupedMicrocompetencies).forEach(quadrantName => {
        initial[quadrantName] = true;
      });
      return initial;
    });

    // Group microcompetencies by quadrant
    const groupedMicrocompetencies = availableMicrocompetencies.reduce((acc, mc) => {
      const quadrantName = mc.quadrant?.name || 'Other';
      if (!acc[quadrantName]) {
        acc[quadrantName] = [];
      }
      acc[quadrantName].push(mc);
      return acc;
    }, {} as Record<string, any[]>);

    // Get quadrant colors for visual distinction
    const getQuadrantColor = (quadrantName: string) => {
      const colors = {
        'Analytical & Critical Thinking': 'bg-blue-50 border-blue-200 text-blue-800',
        'Communication': 'bg-green-50 border-green-200 text-green-800',
        'Empathy': 'bg-purple-50 border-purple-200 text-purple-800',
        'Leadership': 'bg-orange-50 border-orange-200 text-orange-800',
        'Problem Solving': 'bg-red-50 border-red-200 text-red-800',
        'Other': 'bg-gray-50 border-gray-200 text-gray-800'
      };
      return colors[quadrantName as keyof typeof colors] || colors.Other;
    };

    // Toggle quadrant collapse state
    const toggleQuadrant = (quadrantName: string) => {
      setCollapsedQuadrants(prev => ({
        ...prev,
        [quadrantName]: !prev[quadrantName]
      }));
    };

    return (
      <div className="space-y-8">
        {/* Header Section */}
        <div className="flex items-center justify-between p-6 bg-gradient-to-r from-purple-50 to-blue-50 rounded-xl border border-purple-200">
          <div className="flex items-center space-x-4">
            <div className="p-3 bg-white rounded-lg shadow-sm">
              <Target className="h-6 w-6 text-purple-600" />
            </div>
            <div>
              <h3 className="text-xl font-bold text-gray-900">Select Microcompetencies</h3>
              <p className="text-sm text-gray-600 mt-1">Choose the skills to assess in this intervention</p>
            </div>
          </div>
          <div className="flex items-center space-x-3">
            <div className="text-right">
              <div className="text-2xl font-bold text-purple-600">{selectedMicrocompetencies.length}</div>
              <div className="text-xs text-gray-500">Selected</div>
            </div>
            <div className="p-3 bg-white rounded-lg shadow-sm">
              <CheckCircle className="h-6 w-6 text-green-500" />
            </div>
          </div>
        </div>

        {/* Microcompetencies Selection */}
        <div className="space-y-6">
          <div className="flex items-center space-x-2 mb-6">
            <BookOpen className="h-5 w-5 text-gray-600" />
            <h4 className="text-lg font-semibold text-gray-900">Associated Microcompetencies</h4>
          </div>
          
          {Object.entries(groupedMicrocompetencies).map(([quadrantName, microcompetencies]) => {
            const selectedCount = microcompetencies.filter(mc => 
              selectedMicrocompetencies.some(selected => selected.id === mc.id)
            ).length;
            const totalCount = microcompetencies.length;
            const isAllSelected = selectedCount === totalCount;
            const isPartiallySelected = selectedCount > 0 && selectedCount < totalCount;
            const isCollapsed = collapsedQuadrants[quadrantName];

            return (
              <Card key={quadrantName} className={`border-2 transition-all duration-200 hover:shadow-md ${getQuadrantColor(quadrantName)}`}>
                <CardHeader 
                  className="pb-3 cursor-pointer hover:bg-white/50 transition-colors duration-200"
                  onClick={() => toggleQuadrant(quadrantName)}
                >
                  <div className="flex items-center justify-between">
                    <div className="flex items-center space-x-3">
                      <div className="p-2 bg-white rounded-lg shadow-sm">
                        <Target className="h-4 w-4" />
                      </div>
                      <div>
                        <CardTitle className="text-base font-semibold">{quadrantName}</CardTitle>
                        <p className="text-sm opacity-75">
                          {selectedCount} of {totalCount} selected
                        </p>
                      </div>
                    </div>
                    <div className="flex items-center space-x-2">
                      {isAllSelected && <CheckCircle className="h-5 w-5 text-green-600" />}
                      {isPartiallySelected && <Circle className="h-5 w-5 text-yellow-600" />}
                      {selectedCount === 0 && <Circle className="h-5 w-5 text-gray-400" />}
                      <div className="p-1 hover:bg-white/50 rounded transition-colors duration-200">
                        {isCollapsed ? (
                          <ChevronRight className="h-4 w-4 text-gray-600" />
                        ) : (
                          <ChevronDown className="h-4 w-4 text-gray-600" />
                        )}
                      </div>
                    </div>
                  </div>
                </CardHeader>
                {!isCollapsed && (
                  <CardContent className="pt-0">
                    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-3">
                      {microcompetencies.map((mc) => {
                        const isSelected = selectedMicrocompetencies.some(selected => selected.id === mc.id);
                        return (
                          <div 
                            key={mc.id} 
                            className={`group relative p-4 rounded-lg border-2 transition-all duration-200 cursor-pointer ${
                              isSelected 
                                ? 'bg-white border-purple-300 shadow-md scale-105' 
                                : 'bg-white/50 border-gray-200 hover:border-purple-200 hover:bg-white hover:shadow-sm'
                            }`}
                            onClick={() => {
                              if (isSelected) {
                                removeMicrocompetency(mc.id);
                              } else {
                                addMicrocompetency(mc);
                              }
                            }}
                          >
                            <div className="flex items-start space-x-3">
                              <div className="flex-shrink-0 mt-1">
                                <Checkbox
                                  id={`mc-${mc.id}`}
                                  checked={isSelected}
                                  onCheckedChange={(checked) => {
                                    if (checked) {
                                      addMicrocompetency(mc);
                                    } else {
                                      removeMicrocompetency(mc.id);
                                    }
                                  }}
                                  className="data-[state=checked]:bg-purple-600 data-[state=checked]:border-purple-600"
                                />
                              </div>
                              <div className="flex-1 min-w-0">
                                <Label 
                                  htmlFor={`mc-${mc.id}`}
                                  className="text-sm font-medium cursor-pointer text-gray-900 block"
                                >
                                  {mc.name}
                                </Label>
                                {mc.description && (
                                  <p className="text-xs text-gray-600 mt-1 line-clamp-2">
                                    {mc.description}
                                  </p>
                                )}
                                <div className="flex items-center space-x-2 mt-2">
                                  <Badge variant="outline" className="text-xs">
                                    Max: {mc.max_score || 10}
                                  </Badge>
                                  {isSelected && (
                                    <Badge className="bg-green-100 text-green-800 text-xs">
                                      Selected
                                    </Badge>
                                  )}
                                </div>
                              </div>
                            </div>
                            
                            {/* Selection indicator */}
                            {isSelected && (
                              <div className="absolute top-2 right-2">
                                <CheckCircle className="h-4 w-4 text-green-600" />
                              </div>
                            )}
                          </div>
                        );
                      })}
                    </div>
                  </CardContent>
                )}
              </Card>
            );
          })}
        </div>

        {/* Selected Microcompetencies Summary */}
        {selectedMicrocompetencies.length > 0 && (
          <Card className="border-2 border-green-200 bg-green-50/30">
            <CardHeader className="bg-white rounded-t-lg">
              <div className="flex items-center justify-between">
                <div className="flex items-center space-x-3">
                  <div className="p-2 bg-green-100 rounded-lg">
                    <CheckCircle className="h-5 w-5 text-green-600" />
                  </div>
                  <div>
                    <CardTitle className="text-lg font-semibold text-gray-900">
                      Selected Microcompetencies
                    </CardTitle>
                    <p className="text-sm text-gray-600">
                      {selectedMicrocompetencies.length} microcompetencies selected with equal weightage and max score of 5
                    </p>
                  </div>
                </div>
                <Badge className="bg-green-100 text-green-800">
                  {selectedMicrocompetencies.length} selected
                </Badge>
              </div>
            </CardHeader>
            <CardContent className="space-y-3 max-h-96 overflow-y-auto">
              <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3">
                {selectedMicrocompetencies.map((mc, index) => (
                  <div key={mc.id} className="p-4 bg-white border border-gray-200 rounded-lg shadow-sm hover:shadow-md transition-shadow">
                    <div className="flex items-center justify-between mb-3">
                      <div className="flex items-center space-x-3">
                        <div className="flex items-center justify-center w-6 h-6 bg-purple-100 text-purple-600 rounded-full text-xs font-semibold">
                          {index + 1}
                        </div>
                        <div className="flex-1 min-w-0">
                          <div className="font-semibold text-gray-900 text-sm truncate">{mc.name}</div>
                          <Badge variant="outline" className="text-xs mt-1">
                            {mc.quadrant.name}
                          </Badge>
                        </div>
                      </div>
                      <Button
                        size="sm"
                        variant="outline"
                        onClick={() => removeMicrocompetency(mc.id)}
                        className="text-red-600 hover:text-red-700 hover:bg-red-50"
                      >
                        <Trash2 className="h-3 w-3" />
                      </Button>
                    </div>
                    
                    <div className="space-y-2">
                      <div className="flex items-center justify-between text-xs text-gray-600">
                        <span>Weightage:</span>
                        <span className="font-medium text-purple-600">{mc.weightage}%</span>
                      </div>
                      <div className="flex items-center justify-between text-xs text-gray-600">
                        <span>Max Score:</span>
                        <span className="font-medium text-green-600">{mc.maxScore}</span>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
              
              {/* Summary Stats */}
              <div className="mt-4 p-4 bg-blue-50 border border-blue-200 rounded-lg">
                <div className="flex items-center space-x-2 mb-2">
                  <Target className="h-4 w-4 text-blue-600" />
                  <span className="text-sm font-medium text-blue-800">Automatic Configuration</span>
                </div>
                <div className="text-xs text-blue-700 space-y-1">
                  <div>• All microcompetencies have equal weightage ({selectedMicrocompetencies.length > 0 ? selectedMicrocompetencies[0].weightage : 0}% each)</div>
                  <div>• All microcompetencies have a max score of 5</div>
                  <div>• Weightage automatically adjusts when adding/removing microcompetencies</div>
                </div>
              </div>
            </CardContent>
          </Card>
        )}
      </div>
    );
  };

  // NEW: Step 3 - Assign Teachers to Intervention (intervention-level, not per microcompetency)
  const renderStep3 = () => (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h3 className="text-lg font-semibold">Assign Teachers to Intervention</h3>
          <p className="text-sm text-gray-600">Assign teachers who will handle all microcompetencies in this intervention</p>
        </div>
        <Badge variant="secondary">
          {selectedTeachers.length} teacher{selectedTeachers.length !== 1 ? 's' : ''} assigned
        </Badge>
      </div>

      <div className="bg-blue-50 border border-blue-200 rounded-lg p-4 mb-6">
        <p className="text-sm text-blue-800">
          <strong>Note:</strong> Each teacher will be assigned to handle <strong>all {selectedMicrocompetencies.length} microcompetencies</strong> in this intervention. 
          You'll assign student groups to each teacher in the next step.
        </p>
      </div>

      {/* Available Teachers List */}
      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <h4 className="font-medium">Available Teachers</h4>
          <span className="text-sm text-gray-600">
            {availableTeachers.filter(t => !selectedTeachers.find(st => st.teacher_id === t.id)).length} available
          </span>
        </div>
        
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {availableTeachers
            .filter(teacher => !selectedTeachers.find(st => st.teacher_id === teacher.id))
            .map((teacher) => (
              <Card key={teacher.id} className="cursor-pointer hover:shadow-md transition-shadow" onClick={() => addTeacher(teacher)}>
                <CardContent className="p-4">
                  <div className="flex items-center justify-between">
                    <div className="flex-1">
                      <div className="font-medium">{teacher.name}</div>
                      <div className="text-sm text-gray-600">{teacher.employee_id}</div>
                      {teacher.specialization && (
                        <Badge variant="outline" className="mt-1">{teacher.specialization}</Badge>
                      )}
                    </div>
                    <Button size="sm" variant="outline">
                      <Plus className="h-4 w-4" />
                    </Button>
                  </div>
                </CardContent>
              </Card>
            ))}
        </div>
      </div>

      {/* Selected Teachers */}
      {selectedTeachers.length > 0 && (
        <div className="space-y-4 mt-6">
          <h4 className="font-medium">Assigned Teachers</h4>
          {selectedTeachers.map((teacherAssignment) => (
            <Card key={teacherAssignment.teacher_id}>
              <CardContent className="p-4">
                <div className="flex items-center justify-between">
                  <div className="flex-1">
                    <div className="font-medium">{teacherAssignment.teacher.name}</div>
                    <div className="text-sm text-gray-600">{teacherAssignment.teacher.employee_id}</div>
                  </div>
                  <div className="flex items-center gap-4">
                    <div className="flex items-center gap-2">
                      <Checkbox
                        id={`score-${teacherAssignment.teacher_id}`}
                        checked={teacherAssignment.can_score}
                        onCheckedChange={(checked) => 
                          updateTeacherPermissions(teacherAssignment.teacher_id, { can_score: !!checked })
                        }
                      />
                      <Label htmlFor={`score-${teacherAssignment.teacher_id}`} className="text-sm cursor-pointer">
                        Can Score
                      </Label>
                    </div>
                    <div className="flex items-center gap-2">
                      <Checkbox
                        id={`tasks-${teacherAssignment.teacher_id}`}
                        checked={teacherAssignment.can_create_tasks}
                        onCheckedChange={(checked) => 
                          updateTeacherPermissions(teacherAssignment.teacher_id, { can_create_tasks: !!checked })
                        }
                      />
                      <Label htmlFor={`tasks-${teacherAssignment.teacher_id}`} className="text-sm cursor-pointer">
                        Can Create Tasks
                      </Label>
                    </div>
                    <Button
                      size="sm"
                      variant="outline"
                      onClick={() => removeTeacher(teacherAssignment.teacher_id)}
                      className="text-red-600 hover:text-red-700"
                    >
                      <Trash2 className="h-4 w-4" />
                    </Button>
                  </div>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      )}
    </div>
  );

  // NEW: Step 4 - Assign Student Groups to Teachers
  const renderStep4 = () => {
    const totalStudentsEnrolled = teacherStudentGroups.reduce((sum, group) => sum + group.studentIds.length, 0);
    const allEnrolledStudentIds = new Set(
      teacherStudentGroups.flatMap(group => group.studentIds)
    );
    const availableStudentsForSelection = availableStudents.filter(
      s => !allEnrolledStudentIds.has(s.id)
    );

    return (
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <div>
            <h3 className="text-lg font-semibold">Assign Student Groups to Teachers</h3>
            <p className="text-sm text-gray-600">Assign groups of students to each teacher. Each student can only be assigned to one teacher.</p>
          </div>
          <Badge variant="secondary">
            {totalStudentsEnrolled} student{totalStudentsEnrolled !== 1 ? 's' : ''} enrolled
          </Badge>
        </div>

        {selectedTeachers.length === 0 ? (
          <div className="text-center py-12 text-gray-500">
            <UserCheck className="h-12 w-12 mx-auto mb-4" />
            <h3 className="text-lg font-semibold mb-2">No Teachers Assigned</h3>
            <p>Please go back to Step 3 and assign teachers first.</p>
          </div>
        ) : (
          <div className="space-y-6">
            {selectedTeachers.map((teacherAssignment) => {
              const group = teacherStudentGroups.find(g => g.teacher_id === teacherAssignment.teacher_id);
              const studentIds = group?.studentIds || [];

              return (
                <Card key={teacherAssignment.teacher_id} className="border-2">
                  <CardHeader className="bg-blue-50">
                    <div className="flex items-center justify-between">
                      <div>
                        <CardTitle className="text-base">{teacherAssignment.teacher.name}</CardTitle>
                        <p className="text-sm text-gray-600 mt-1">
                          {teacherAssignment.teacher.employee_id} • {studentIds.length} student{studentIds.length !== 1 ? 's' : ''} assigned
                        </p>
                      </div>
                      <Badge variant="secondary">
                        {studentIds.length} / {createForm.maxStudents}
                      </Badge>
                    </div>
                  </CardHeader>
                  <CardContent className="pt-4">
                    <div className="space-y-4">
                      <Button
                        variant="outline"
                        onClick={() => {
                          setShowStudentSelectionDialog(true);
                          // Store current teacher context for student selection
                          (window as any).__currentTeacherForSelection = teacherAssignment.teacher_id;
                        }}
                        className="w-full"
                      >
                        <Users className="h-4 w-4 mr-2" />
                        {studentIds.length === 0 ? 'Assign Students' : `Manage Students (${studentIds.length})`}
                      </Button>

                      {studentIds.length > 0 && (
                        <div className="space-y-2">
                          <div className="text-sm font-medium text-gray-700">Assigned Students:</div>
                          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-2 max-h-48 overflow-y-auto">
                            {studentIds.map((studentId) => {
                              const student = availableStudents.find(s => s.id === studentId);
                              if (!student) return null;

                              return (
                                <div key={studentId} className="flex items-center justify-between p-2 bg-gray-50 rounded border">
                                  <div className="flex-1 min-w-0">
                                    <div className="text-sm font-medium truncate">{student.name}</div>
                                    <div className="text-xs text-gray-600">{student.registration_no}</div>
                                  </div>
                                  <Button
                                    size="sm"
                                    variant="ghost"
                                    onClick={() => {
                                      const newIds = studentIds.filter(id => id !== studentId);
                                      assignStudentsToTeacher(teacherAssignment.teacher_id, newIds);
                                    }}
                                    className="ml-2 h-6 w-6 p-0"
                                  >
                                    <X className="h-3 w-3" />
                                  </Button>
                                </div>
                              );
                            })}
                          </div>
                        </div>
                      )}
                    </div>
                  </CardContent>
                </Card>
              );
            })}
          </div>
        )}

        <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-4">
          <p className="text-sm text-yellow-800">
            <strong>Important:</strong> Each student can only be enrolled once per intervention. 
            If a student is already assigned to a teacher, they won't appear in the selection for other teachers.
          </p>
        </div>
      </div>
    );
  };

  // NEW: Step 5 - Review and Summary
  const renderStep5 = () => {
    const totalStudentsEnrolled = teacherStudentGroups.reduce((sum, group) => sum + group.studentIds.length, 0);
    return (
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <div>
            <h3 className="text-lg font-semibold">Review Intervention</h3>
            <p className="text-sm text-gray-600">Review all details before creating the intervention</p>
          </div>
          <Badge variant="secondary" className="bg-green-100 text-green-800">
            Ready to Create
          </Badge>
        </div>

        {/* Summary */}
        <Card className="bg-blue-50 border-blue-200">
          <CardHeader>
            <CardTitle className="text-base text-blue-900">Intervention Summary</CardTitle>
          </CardHeader>
          <CardContent className="text-sm space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <div>
                <span className="font-medium">Intervention Name:</span> {createForm.name}
              </div>
              <div>
                <span className="font-medium">Duration:</span> {createForm.startDate} to {createForm.endDate}
              </div>
              <div>
                <span className="font-medium">Microcompetencies:</span> {selectedMicrocompetencies.length}
              </div>
              <div>
                <span className="font-medium">Teachers Assigned:</span> {selectedTeachers.length}
              </div>
              <div>
                <span className="font-medium">Students Enrolled:</span> {totalStudentsEnrolled}
              </div>
              <div>
                <span className="font-medium">Max Capacity:</span> {createForm.maxStudents}
              </div>
            </div>

            {selectedTeachers.length > 0 && (
              <div className="mt-4 pt-4 border-t border-blue-300">
                <div className="font-medium mb-2">Teacher-Student Assignments:</div>
                <div className="space-y-2">
                  {selectedTeachers.map((teacher) => {
                    const group = teacherStudentGroups.find(g => g.teacher_id === teacher.teacher_id);
                    const studentCount = group?.studentIds.length || 0;
                    return (
                      <div key={teacher.teacher_id} className="flex items-center justify-between text-sm">
                        <span>{teacher.teacher.name}:</span>
                        <span className="font-medium">{studentCount} student{studentCount !== 1 ? 's' : ''}</span>
                      </div>
                    );
                  })}
                </div>
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    );
  };

  switch (currentStep) {
    case 1:
      return renderStep1();
    case 2:
      return renderStep2();
    case 3:
      return renderStep3();
    case 4:
      return renderStep4();
    case 5:
      return renderStep5();
    default:
      return renderStep1();
  }
};
