import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { toast } from 'sonner';
import { 
  ArrowLeft, 
  Target, 
  User, 
  CheckCircle, 
  Clock, 
  Edit,
  Save,
  X
} from 'lucide-react';
import { interventionAPI } from '@/lib/api';
import { useAuth } from '@/contexts/AuthContext';
import { useTerm } from '@/contexts/TermContext';

interface MicrocompetencyDetails {
  id: string;
  name: string;
  description: string;
  max_score: number;
  weightage: number;
  intervention: {
    id: string;
    name: string;
    description: string;
    is_scoring_open: boolean;
    scoring_deadline?: string;
  };
}

interface StudentScore {
  id: string;
  name: string;
  registration_no: string;
  enrollment_status: string;
  enrolled_at: string;
  score?: {
    obtained_score: number;
    max_score: number;
    percentage: number;
    feedback?: string;
    status: string;
    scored_at: string;
  };
}

const MicrocompetencyScoringPage: React.FC = () => {
  const { interventionId, microcompetencyId } = useParams<{ 
    interventionId: string; 
    microcompetencyId: string; 
  }>();
  const navigate = useNavigate();
  const { user } = useAuth();
  const { selectedTerm } = useTerm();
  
  const [microcompetencyDetails, setMicrocompetencyDetails] = useState<MicrocompetencyDetails | null>(null);
  const [students, setStudents] = useState<StudentScore[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [localScores, setLocalScores] = useState<Record<string, {
    obtained_score: number;
    feedback: string;
    status: 'Draft' | 'Submitted' | 'Reviewed';
  }>>({});

  useEffect(() => {
    if (interventionId && microcompetencyId && user?.id) {
      fetchData();
    }
  }, [interventionId, microcompetencyId, user]);

  const fetchData = async () => {
    try {
      setLoading(true);
      setError(null);

      if (!user?.id) {
        throw new Error('User not authenticated');
      }

      // Get microcompetency details and students
      const [microcompetenciesResponse, studentsResponse] = await Promise.all([
        interventionAPI.getTeacherInterventionMicrocompetencies(user.id, interventionId!),
        interventionAPI.getTeacherInterventionStudents(user.id, interventionId!, microcompetencyId)
      ]);

      // Find the specific microcompetency
      const targetMicrocompetency = microcompetenciesResponse.data.microcompetencies.find(
        (mc: any) => mc.microcompetencies?.id === microcompetencyId
      );

      if (!targetMicrocompetency) {
        throw new Error('Microcompetency not found or not assigned to you');
      }

      setMicrocompetencyDetails({
        id: targetMicrocompetency.microcompetencies.id,
        name: targetMicrocompetency.microcompetencies.name,
        description: targetMicrocompetency.microcompetencies.description,
        max_score: targetMicrocompetency.max_score,
        weightage: targetMicrocompetency.weightage,
        intervention: microcompetenciesResponse.data.intervention
      });

      const newStudents = studentsResponse.data.students;
      setStudents(newStudents);
      
      // Initialize local scores
      const initialScores: Record<string, { obtained_score: number; feedback: string; status: 'Draft' | 'Submitted' | 'Reviewed' }> = {};
      newStudents.forEach(student => {
        initialScores[student.id] = {
          obtained_score: student.score?.obtained_score || 0,
          feedback: student.score?.feedback || '',
          status: (student.score?.status as 'Draft' | 'Submitted' | 'Reviewed') || 'Submitted'
        };
      });
      setLocalScores(initialScores);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to fetch data');
    } finally {
      setLoading(false);
    }
  };


  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
    });
  };

  const getScoreColor = (percentage: number) => {
    if (percentage >= 90) return 'text-green-600';
    if (percentage >= 80) return 'text-blue-600';
    if (percentage >= 70) return 'text-yellow-600';
    return 'text-red-600';
  };

  if (loading) {
    return (
      <div className="container mx-auto p-6">
        <div className="flex items-center justify-center py-12">
          <div className="text-center">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto mb-4"></div>
            <p className="text-gray-600">Loading microcompetency details...</p>
          </div>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="container mx-auto p-6">
        <Card>
          <CardContent className="flex flex-col items-center justify-center py-12">
            <X className="h-12 w-12 text-red-400 mb-4" />
            <h3 className="text-lg font-semibold text-gray-900 mb-2">Error Loading Data</h3>
            <p className="text-gray-600 text-center mb-4">{error}</p>
            <Button onClick={() => navigate(-1)} variant="outline">
              <ArrowLeft className="h-4 w-4 mr-2" />
              Go Back
            </Button>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="container mx-auto p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          <Button
            variant="outline"
            size="sm"
            onClick={() => navigate(`/teacher/interventions/${interventionId}/scoring`)}
          >
            <ArrowLeft className="h-4 w-4 mr-2" />
            Back to Intervention
          </Button>
          <div>
            <h1 className="text-2xl font-bold text-gray-900">Microcompetency Scoring</h1>
            <p className="text-gray-600">{microcompetencyDetails?.name}</p>
          </div>
        </div>
        <Badge
          className={
            microcompetencyDetails?.intervention.is_scoring_open
              ? 'bg-green-100 text-green-800 border-green-200'
              : 'bg-red-100 text-red-800 border-red-200'
          }
        >
          {microcompetencyDetails?.intervention.is_scoring_open ? (
            <>
              <CheckCircle className="h-3 w-3 mr-1" />
              Scoring Open
            </>
          ) : (
            <>
              <Clock className="h-3 w-3 mr-1" />
              Scoring Closed
            </>
          )}
        </Badge>
      </div>

      {/* Microcompetency Details */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Target className="h-5 w-5" />
            {microcompetencyDetails?.name}
          </CardTitle>
          <CardDescription>
            {microcompetencyDetails?.description}
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div>
              <Label className="text-sm text-gray-500">Max Score</Label>
              <p className="text-lg font-bold text-blue-600">{microcompetencyDetails?.max_score}</p>
            </div>
            <div>
              <Label className="text-sm text-gray-500">Weightage</Label>
              <p className="text-lg font-bold text-purple-600">{microcompetencyDetails?.weightage}%</p>
            </div>
            <div>
              <Label className="text-sm text-gray-500">Students to Score</Label>
              <p className="text-lg font-bold text-gray-900">{students.length}</p>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Students Table */}
      <Card>
        <CardHeader>
          <CardTitle>Students ({students.length})</CardTitle>
          <CardDescription>
            Score students on this microcompetency
          </CardDescription>
        </CardHeader>
        <CardContent>
          {students.length === 0 ? (
            <div className="text-center py-12">
              <User className="h-12 w-12 text-gray-400 mx-auto mb-4" />
              <h3 className="text-lg font-semibold text-gray-900 mb-2">No students enrolled</h3>
              <p className="text-gray-600">
                No students are enrolled in this intervention yet.
              </p>
            </div>
          ) : (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Student</TableHead>
                  <TableHead>Registration No</TableHead>
                  <TableHead>Score (out of {microcompetencyDetails?.max_score})</TableHead>
                  <TableHead>Feedback</TableHead>
                  <TableHead>Status</TableHead>
                  <TableHead className="text-right">Actions</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {students.map((student) => (
                  <TableRow key={student.id}>
                    <TableCell>
                      <div className="flex items-center gap-2">
                        <User className="h-4 w-4 text-gray-400" />
                        <span className="font-medium">{student.name}</span>
                      </div>
                    </TableCell>
                    <TableCell>
                      <span className="text-sm text-gray-600">{student.registration_no}</span>
                    </TableCell>
                    <TableCell>
                      <Input
                        type="number"
                        min={0}
                        max={microcompetencyDetails?.max_score}
                        step={0.5}
                        value={localScores[student.id]?.obtained_score}
                        onChange={(e) => {
                          const value = parseFloat(e.target.value);
                          if (!isNaN(value)) {
                            setLocalScores(prev => ({
                              ...prev,
                              [student.id]: {
                                ...prev[student.id],
                                obtained_score: value
                              }
                            }));
                          }
                        }}
                        className="w-24"
                      />
                    </TableCell>
                    <TableCell>
                      <Input
                        type="text"
                        placeholder="Add feedback..."
                        value={localScores[student.id]?.feedback}
                        onChange={(e) => {
                          setLocalScores(prev => ({
                            ...prev,
                            [student.id]: {
                              ...prev[student.id],
                              feedback: e.target.value
                            }
                          }));
                        }}
                        className="w-full"
                      />
                    </TableCell>
                    <TableCell>
                      <Select
                        value={localScores[student.id]?.status}
                        onValueChange={(value: 'Draft' | 'Submitted' | 'Reviewed') => {
                          setLocalScores(prev => ({
                            ...prev,
                            [student.id]: {
                              ...prev[student.id],
                              status: value
                            }
                          }));
                        }}
                      >
                        <SelectTrigger className="w-32">
                          <SelectValue />
                        </SelectTrigger>
                        <SelectContent>
                          <SelectItem value="Draft">Draft</SelectItem>
                          <SelectItem value="Submitted">Submitted</SelectItem>
                          <SelectItem value="Reviewed">Reviewed</SelectItem>
                        </SelectContent>
                      </Select>
                    </TableCell>
                    <TableCell className="text-right">
                      <Button
                        variant="default"
                        size="sm"
                        onClick={async () => {
                          if (!user?.id || !microcompetencyDetails || !selectedTerm?.id) {
                            toast.error('Missing required data. Please ensure a term is selected.');
                            return;
                          }
                          try {
                            setIsSubmitting(true);
                            await interventionAPI.scoreStudentMicrocompetency(
                              user.id,
                              interventionId!,
                              student.id,
                              microcompetencyId!,
                              {
                                obtained_score: localScores[student.id].obtained_score,
                                feedback: localScores[student.id].feedback,
                                status: localScores[student.id].status,
                                term_id: selectedTerm.id
                              }
                            );
                            toast.success('Score saved successfully');
                            fetchData(); // Refresh data
                          } catch (err) {
                            toast.error(err instanceof Error ? err.message : 'Failed to save score');
                          } finally {
                            setIsSubmitting(false);
                          }
                        }}
                        disabled={!microcompetencyDetails?.intervention.is_scoring_open || isSubmitting}
                      >
                        {isSubmitting ? (
                          <>
                            <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white mr-2"></div>
                            Saving...
                          </>
                        ) : (
                          <>
                            <Save className="h-4 w-4 mr-2" />
                            Save
                          </>
                        )}
                      </Button>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          )}
        </CardContent>
      </Card>

    </div>
  );
};

export default MicrocompetencyScoringPage;
