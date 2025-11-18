import React, { useState, useEffect } from 'react';
import { useParams, useNavigate, useSearchParams } from 'react-router-dom';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { toast } from 'sonner';
import { 
  ArrowLeft, 
  Target, 
  User, 
  CheckCircle, 
  Clock, 
  Save,
  X,
  BookOpen
} from 'lucide-react';
import { interventionAPI } from '@/lib/api';
import { useAuth } from '@/contexts/AuthContext';
import { useTerm } from '@/contexts/TermContext';
import { TeacherInterventionDetails, InterventionMicrocompetency } from '@/types/intervention';

interface StudentDetails {
  id: string;
  name: string;
  registration_no: string;
  enrollment_status: string;
  enrolled_at: string;
}

interface MicrocompetencyScore {
  id: string;
  name: string;
  description: string;
  max_score: number;
  weightage: number;
  component?: string;
  quadrant?: string;
  score?: {
    obtained_score: number;
    max_score: number;
    percentage: number;
    feedback?: string;
    status: string;
    scored_at: string;
  };
}

const StudentScoringPage: React.FC = () => {
  const { studentId } = useParams<{ studentId: string }>();
  const [searchParams] = useSearchParams();
  const interventionId = searchParams.get('interventionId');
  const navigate = useNavigate();
  const { user } = useAuth();
  const { selectedTerm } = useTerm();
  
  const [studentDetails, setStudentDetails] = useState<StudentDetails | null>(null);
  const [interventionDetails, setInterventionDetails] = useState<TeacherInterventionDetails | null>(null);
  const [microcompetencies, setMicrocompetencies] = useState<MicrocompetencyScore[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState<Record<string, boolean>>({});
  const [localScores, setLocalScores] = useState<Record<string, {
    obtained_score: number;
    feedback: string;
    status: 'Draft' | 'Submitted' | 'Reviewed';
  }>>({});

  useEffect(() => {
    if (studentId && interventionId && user?.id) {
      fetchData();
    } else if (studentId && !interventionId) {
      setError('Intervention ID is required. Please navigate from the intervention scoring page.');
      setLoading(false);
    }
  }, [studentId, interventionId, user]);

  const fetchData = async () => {
    try {
      setLoading(true);
      setError(null);

      if (!user?.id || !interventionId || !studentId) {
        throw new Error('Missing required parameters');
      }

      // Get intervention details with microcompetencies
      const [detailsResponse, studentsResponse] = await Promise.all([
        interventionAPI.getTeacherInterventionMicrocompetencies(user.id, interventionId),
        interventionAPI.getTeacherInterventionStudents(user.id, interventionId)
      ]);

      setInterventionDetails(detailsResponse.data);

      // Find the specific student
      const targetStudent = studentsResponse.data.students.find(
        (s: any) => s.id === studentId
      );

      if (!targetStudent) {
        throw new Error('Student not found or not assigned to you');
      }

      setStudentDetails({
        id: targetStudent.id,
        name: targetStudent.name,
        registration_no: targetStudent.registration_no,
        enrollment_status: targetStudent.enrollment_status,
        enrolled_at: targetStudent.enrolled_at
      });

      // Transform microcompetencies and fetch scores for each
      const microcompetencyList: MicrocompetencyScore[] = [];
      const initialScores: Record<string, { obtained_score: number; feedback: string; status: 'Draft' | 'Submitted' | 'Reviewed' }> = {};

      for (const mc of detailsResponse.data.microcompetencies) {
        // Extract component and quadrant data safely
        const microcompetencyData = mc.microcompetencies;
        
        // Access component and quadrant - same way as InterventionScoringPage does it
        // Backend now includes components in the flattened response
        const componentName = microcompetencyData?.components?.name || null;
        const quadrantName = microcompetencyData?.components?.sub_categories?.quadrants?.name || 
                             (mc as any)?.quadrant?.name ||  // Fallback to top-level quadrant if available
                             null;

        // Fetch score for this microcompetency and student
        try {
          const studentScoreResponse = await interventionAPI.getTeacherInterventionStudents(
            user.id,
            interventionId,
            microcompetencyData?.id
          );
          
          const studentWithScore = studentScoreResponse.data.students.find(
            (s: any) => s.id === studentId
          );

          microcompetencyList.push({
            id: microcompetencyData!.id,
            name: microcompetencyData!.name,
            description: microcompetencyData!.description || '',
            max_score: mc.max_score,
            weightage: mc.weightage,
            component: componentName || undefined,
            quadrant: quadrantName || undefined,
            score: studentWithScore?.score
          });

          initialScores[microcompetencyData!.id] = {
            obtained_score: studentWithScore?.score?.obtained_score || 0,
            feedback: studentWithScore?.score?.feedback || '',
            status: (studentWithScore?.score?.status as 'Draft' | 'Submitted' | 'Reviewed') || 'Submitted'
          };
        } catch (err) {
          // If fetching score fails, still add the microcompetency
          microcompetencyList.push({
            id: microcompetencyData!.id,
            name: microcompetencyData!.name,
            description: microcompetencyData!.description || '',
            max_score: mc.max_score,
            weightage: mc.weightage,
            component: componentName || undefined,
            quadrant: quadrantName || undefined
          });

          initialScores[microcompetencyData!.id] = {
            obtained_score: 0,
            feedback: '',
            status: 'Submitted'
          };
        }
      }

      setMicrocompetencies(microcompetencyList);
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

  const handleSaveScore = async (microcompetencyId: string) => {
    if (!user?.id || !interventionId || !studentId || !selectedTerm?.id) {
      toast.error('Missing required data. Please ensure a term is selected.');
      return;
    }

    try {
      setIsSubmitting(prev => ({ ...prev, [microcompetencyId]: true }));
      await interventionAPI.scoreStudentMicrocompetency(
        user.id,
        interventionId,
        studentId,
        microcompetencyId,
        {
          obtained_score: localScores[microcompetencyId].obtained_score,
          feedback: localScores[microcompetencyId].feedback,
          status: localScores[microcompetencyId].status,
          term_id: selectedTerm.id
        }
      );
      toast.success('Score saved successfully');
      fetchData(); // Refresh data
    } catch (err) {
      toast.error(err instanceof Error ? err.message : 'Failed to save score');
    } finally {
      setIsSubmitting(prev => ({ ...prev, [microcompetencyId]: false }));
    }
  };

  if (loading) {
    return (
      <div className="container mx-auto p-6">
        <div className="flex items-center justify-center py-12">
          <div className="text-center">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto mb-4"></div>
            <p className="text-gray-600">Loading student details...</p>
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
            onClick={() => navigate(interventionId ? `/teacher/interventions/${interventionId}/scoring` : '/teacher/interventions')}
          >
            <ArrowLeft className="h-4 w-4 mr-2" />
            Back to Intervention
          </Button>
          <div>
            <h1 className="text-2xl font-bold text-gray-900">Student Scoring</h1>
            <p className="text-gray-600">{studentDetails?.name}</p>
          </div>
        </div>
        <Badge
          className={
            interventionDetails?.intervention.is_scoring_open
              ? 'bg-green-100 text-green-800 border-green-200'
              : 'bg-red-100 text-red-800 border-red-200'
          }
        >
          {interventionDetails?.intervention.is_scoring_open ? (
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

      {/* Student Details */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <User className="h-5 w-5" />
            {studentDetails?.name}
          </CardTitle>
          <CardDescription>
            Registration No: {studentDetails?.registration_no}
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div>
              <Label className="text-sm text-gray-500">Enrollment Status</Label>
              <Badge
                className={
                  studentDetails?.enrollment_status === 'Enrolled'
                    ? 'bg-green-100 text-green-800 border-green-200 mt-1'
                    : 'bg-gray-100 text-gray-800 border-gray-200 mt-1'
                }
              >
                {studentDetails?.enrollment_status}
              </Badge>
            </div>
            <div>
              <Label className="text-sm text-gray-500">Enrolled Date</Label>
              <p className="text-sm mt-1">{studentDetails?.enrolled_at && formatDate(studentDetails.enrolled_at)}</p>
            </div>
            <div>
              <Label className="text-sm text-gray-500">Intervention</Label>
              <p className="text-sm mt-1 font-medium">{interventionDetails?.intervention.name}</p>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Microcompetencies Table */}
      <Card>
        <CardHeader>
          <CardTitle>Microcompetencies ({microcompetencies.length})</CardTitle>
          <CardDescription>
            Score all microcompetencies for {studentDetails?.name} in this intervention.
          </CardDescription>
        </CardHeader>
        <CardContent>
          {microcompetencies.length === 0 ? (
            <div className="text-center py-12">
              <Target className="h-12 w-12 text-gray-400 mx-auto mb-4" />
              <h3 className="text-lg font-semibold text-gray-900 mb-2">No microcompetencies assigned</h3>
              <p className="text-gray-600">
                You don't have any microcompetencies assigned to you for this intervention.
              </p>
            </div>
          ) : (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Microcompetency</TableHead>
                  <TableHead>Component</TableHead>
                  <TableHead>Quadrant</TableHead>
                  <TableHead>Max Score</TableHead>
                  <TableHead>Weightage</TableHead>
                  <TableHead>Score</TableHead>
                  <TableHead>Feedback</TableHead>
                  <TableHead>Status</TableHead>
                  <TableHead className="text-right">Actions</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {microcompetencies.map((microcompetency) => (
                  <TableRow key={microcompetency.id}>
                    <TableCell>
                      <div className="flex flex-col">
                        <span className="font-medium">{microcompetency.name}</span>
                        {microcompetency.description && (
                          <span className="text-xs text-gray-500 mt-1">{microcompetency.description}</span>
                        )}
                      </div>
                    </TableCell>
                    <TableCell>
                      {microcompetency.component ? (
                        <span className="text-sm text-gray-600">{microcompetency.component}</span>
                      ) : (
                        <span className="text-sm text-gray-400 italic">Not available</span>
                      )}
                    </TableCell>
                    <TableCell>
                      {microcompetency.quadrant ? (
                        <Badge variant="outline">{microcompetency.quadrant}</Badge>
                      ) : (
                        <Badge variant="outline" className="text-gray-400">Not available</Badge>
                      )}
                    </TableCell>
                    <TableCell>
                      <span className="text-sm font-medium">{microcompetency.max_score}</span>
                    </TableCell>
                    <TableCell>
                      <span className="text-sm text-gray-600">{microcompetency.weightage}%</span>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-2">
                        <Input
                          type="number"
                          min={0}
                          max={microcompetency.max_score}
                          step={0.5}
                          value={localScores[microcompetency.id]?.obtained_score || 0}
                          onChange={(e) => {
                            const value = parseFloat(e.target.value);
                            if (!isNaN(value)) {
                              setLocalScores(prev => ({
                                ...prev,
                                [microcompetency.id]: {
                                  ...prev[microcompetency.id],
                                  obtained_score: value
                                }
                              }));
                            }
                          }}
                          className="w-24"
                        />
                        <span className="text-xs text-gray-500">
                          / {microcompetency.max_score}
                        </span>
                        {microcompetency.score && (
                          <span className={`text-xs font-medium ${getScoreColor(microcompetency.score.percentage)}`}>
                            ({microcompetency.score.percentage.toFixed(1)}%)
                          </span>
                        )}
                      </div>
                    </TableCell>
                    <TableCell>
                      <Textarea
                        placeholder="Add feedback..."
                        value={localScores[microcompetency.id]?.feedback || ''}
                        onChange={(e) => {
                          setLocalScores(prev => ({
                            ...prev,
                            [microcompetency.id]: {
                              ...prev[microcompetency.id],
                              feedback: e.target.value
                            }
                          }));
                        }}
                        className="w-full min-h-[60px]"
                        rows={2}
                      />
                    </TableCell>
                    <TableCell>
                      <Select
                        value={localScores[microcompetency.id]?.status || 'Submitted'}
                        onValueChange={(value: 'Draft' | 'Submitted' | 'Reviewed') => {
                          setLocalScores(prev => ({
                            ...prev,
                            [microcompetency.id]: {
                              ...prev[microcompetency.id],
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
                      <div className="flex items-center justify-end gap-2">
                        {microcompetency.score?.scored_at && (
                          <span className="text-xs text-gray-500">
                            {formatDate(microcompetency.score.scored_at)}
                          </span>
                        )}
                        <Button
                          variant="default"
                          size="sm"
                          onClick={() => handleSaveScore(microcompetency.id)}
                          disabled={!interventionDetails?.intervention.is_scoring_open || isSubmitting[microcompetency.id]}
                        >
                          {isSubmitting[microcompetency.id] ? (
                            <>
                              <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white mr-2"></div>
                              Saving...
                            </>
                          ) : (
                            <>
                              <Save className="h-4 w-4 mr-2" />
                              {microcompetency.score ? 'Update' : 'Save'}
                            </>
                          )}
                        </Button>
                      </div>
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

export default StudentScoringPage;

