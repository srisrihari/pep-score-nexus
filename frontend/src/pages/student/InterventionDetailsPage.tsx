import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Progress } from '@/components/ui/progress';
import { Alert, AlertDescription } from '@/components/ui/alert';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import {
  ArrowLeft,
  Calendar,
  Users,
  Target,
  Clock,
  BookOpen,
  CheckCircle,
  AlertCircle,
  PlayCircle,
  FileText,
  User,
  Award,
  TrendingUp,
} from 'lucide-react';
import { interventionAPI } from '@/lib/api';
import { InterventionDetails, InterventionTask } from '@/types/intervention';
import { useAuth } from '@/contexts/AuthContext';

const InterventionDetailsPage: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { user } = useAuth();
  const [intervention, setIntervention] = useState<InterventionDetails | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [enrolling, setEnrolling] = useState(false);

  useEffect(() => {
    if (id) {
      fetchInterventionDetails();
    }
  }, [id]);

  const fetchInterventionDetails = async () => {
    try {
      setLoading(true);
      const response = await interventionAPI.getInterventionById(id!);
      setIntervention(response.data);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to fetch intervention details');
    } finally {
      setLoading(false);
    }
  };

  const handleEnroll = async () => {
    if (!intervention || !user) return;
    
    try {
      setEnrolling(true);
      // This would typically be handled by a student enrollment API
      // For now, we'll show a success message
      alert('Enrollment request submitted successfully!');
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to enroll in intervention');
    } finally {
      setEnrolling(false);
    }
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'Active':
        return 'bg-green-100 text-green-800 border-green-200';
      case 'Draft':
        return 'bg-yellow-100 text-yellow-800 border-yellow-200';
      case 'Completed':
        return 'bg-blue-100 text-blue-800 border-blue-200';
      case 'Cancelled':
        return 'bg-red-100 text-red-800 border-red-200';
      default:
        return 'bg-gray-100 text-gray-800 border-gray-200';
    }
  };

  const getStatusIcon = (status: string) => {
    switch (status) {
      case 'Active':
        return <PlayCircle className="h-4 w-4" />;
      case 'Completed':
        return <CheckCircle className="h-4 w-4" />;
      case 'Draft':
        return <Clock className="h-4 w-4" />;
      case 'Cancelled':
        return <AlertCircle className="h-4 w-4" />;
      default:
        return <Clock className="h-4 w-4" />;
    }
  };

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
    });
  };

  const calculateProgress = (startDate: string, endDate: string) => {
    const start = new Date(startDate).getTime();
    const end = new Date(endDate).getTime();
    const now = Date.now();
    
    if (now < start) return 0;
    if (now > end) return 100;
    
    return Math.round(((now - start) / (end - start)) * 100);
  };

  const getDaysRemaining = (endDate: string) => {
    const end = new Date(endDate).getTime();
    const now = Date.now();
    const diffTime = end - now;
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
    return diffDays > 0 ? diffDays : 0;
  };

  const getTaskStatusColor = (status: string) => {
    switch (status) {
      case 'Active':
        return 'text-green-600';
      case 'Completed':
        return 'text-blue-600';
      case 'Draft':
        return 'text-yellow-600';
      default:
        return 'text-gray-600';
    }
  };

  if (loading) {
    return (
      <div className="container mx-auto p-6">
        <div className="flex items-center justify-center h-64">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
        </div>
      </div>
    );
  }

  if (error || !intervention) {
    return (
      <div className="container mx-auto p-6">
        <Alert variant="destructive">
          <AlertCircle className="h-4 w-4" />
          <AlertDescription>{error || 'Intervention not found'}</AlertDescription>
        </Alert>
      </div>
    );
  }

  const progress = calculateProgress(intervention.start_date, intervention.end_date);
  const daysRemaining = getDaysRemaining(intervention.end_date);
  const isEnrolled = intervention.enrolled_students.some(student => student.id === user?.id);

  return (
    <div className="container mx-auto p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center gap-4">
        <Button
          variant="ghost"
          size="sm"
          onClick={() => navigate('/student/interventions')}
          className="flex items-center gap-2"
        >
          <ArrowLeft className="h-4 w-4" />
          Back to Interventions
        </Button>
      </div>

      {/* Main Content */}
      <div className="grid gap-6 lg:grid-cols-3">
        {/* Left Column - Main Details */}
        <div className="lg:col-span-2 space-y-6">
          {/* Intervention Header */}
          <Card>
            <CardHeader>
              <div className="flex items-start justify-between">
                <div className="flex-1">
                  <div className="flex items-center gap-3 mb-2">
                    <CardTitle className="text-2xl">{intervention.name}</CardTitle>
                    <Badge className={getStatusColor(intervention.status)}>
                      {getStatusIcon(intervention.status)}
                      <span className="ml-1">{intervention.status}</span>
                    </Badge>
                  </div>
                  <CardDescription className="text-base">
                    {intervention.description}
                  </CardDescription>
                </div>
              </div>

              {/* Progress Bar for Active Interventions */}
              {intervention.status === 'Active' && (
                <div className="space-y-2 mt-4">
                  <div className="flex justify-between text-sm">
                    <span className="text-gray-600">Overall Progress</span>
                    <span className="font-medium">{progress}%</span>
                  </div>
                  <Progress value={progress} className="h-3" />
                  <div className="text-sm text-gray-600">
                    {daysRemaining > 0 ? `${daysRemaining} days remaining` : 'Intervention ended'}
                  </div>
                </div>
              )}
            </CardHeader>
          </Card>

          {/* Tabs Content */}
          <Tabs defaultValue="overview" className="w-full">
            <TabsList className="grid w-full grid-cols-4">
              <TabsTrigger value="overview">Overview</TabsTrigger>
              <TabsTrigger value="tasks">Tasks</TabsTrigger>
              <TabsTrigger value="teachers">Teachers</TabsTrigger>
              <TabsTrigger value="students">Students</TabsTrigger>
            </TabsList>

            <TabsContent value="overview" className="space-y-6">
              {/* Objectives */}
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <Target className="h-5 w-5" />
                    Learning Objectives
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <ul className="space-y-2">
                    {intervention.objectives.map((objective, index) => (
                      <li key={index} className="flex items-start gap-2">
                        <CheckCircle className="h-4 w-4 text-green-600 mt-0.5 flex-shrink-0" />
                        <span className="text-gray-700">{objective}</span>
                      </li>
                    ))}
                  </ul>
                </CardContent>
              </Card>

              {/* Prerequisites */}
              {intervention.prerequisites && intervention.prerequisites.length > 0 && (
                <Card>
                  <CardHeader>
                    <CardTitle className="flex items-center gap-2">
                      <BookOpen className="h-5 w-5" />
                      Prerequisites
                    </CardTitle>
                  </CardHeader>
                  <CardContent>
                    <ul className="space-y-2">
                      {intervention.prerequisites.map((prerequisite, index) => (
                        <li key={index} className="flex items-start gap-2">
                          <AlertCircle className="h-4 w-4 text-amber-600 mt-0.5 flex-shrink-0" />
                          <span className="text-gray-700">{prerequisite}</span>
                        </li>
                      ))}
                    </ul>
                  </CardContent>
                </Card>
              )}

              {/* Quadrant Focus */}
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <TrendingUp className="h-5 w-5" />
                    Focus Areas & Weightages
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-3">
                    {Object.entries(intervention.quadrant_weightages).map(([quadrant, weight]) => (
                      <div key={quadrant} className="flex items-center justify-between">
                        <span className="font-medium capitalize">{quadrant}</span>
                        <div className="flex items-center gap-2">
                          <div className="w-24 bg-gray-200 rounded-full h-2">
                            <div 
                              className="bg-blue-600 h-2 rounded-full" 
                              style={{ width: `${weight}%` }}
                            />
                          </div>
                          <span className="text-sm font-medium w-12 text-right">{weight}%</span>
                        </div>
                      </div>
                    ))}
                  </div>
                </CardContent>
              </Card>
            </TabsContent>

            <TabsContent value="tasks" className="space-y-4">
              {intervention.tasks.length === 0 ? (
                <Card>
                  <CardContent className="flex flex-col items-center justify-center py-12">
                    <FileText className="h-12 w-12 text-gray-400 mb-4" />
                    <h3 className="text-lg font-semibold text-gray-900 mb-2">No tasks yet</h3>
                    <p className="text-gray-600 text-center">
                      Tasks will be added by instructors as the intervention progresses.
                    </p>
                  </CardContent>
                </Card>
              ) : (
                <div className="space-y-4">
                  {intervention.tasks.map((task) => (
                    <Card key={task.id}>
                      <CardHeader className="pb-3">
                        <div className="flex items-start justify-between">
                          <div className="flex-1">
                            <CardTitle className="text-lg">{task.name}</CardTitle>
                            <div className="flex items-center gap-2 mt-1">
                              <Badge variant="outline" className="capitalize">
                                {task.quadrant_id}
                              </Badge>
                              <Badge variant="outline" className={getTaskStatusColor(task.status)}>
                                {task.status}
                              </Badge>
                            </div>
                          </div>
                          <div className="text-right text-sm text-gray-600">
                            <div className="font-medium">{task.max_score} points</div>
                            <div>Due: {formatDate(task.due_date)}</div>
                          </div>
                        </div>
                      </CardHeader>
                      <CardContent>
                        <p className="text-gray-700 mb-3">{task.description}</p>
                        <div className="flex items-center gap-4 text-sm text-gray-600">
                          <span className="flex items-center gap-1">
                            <FileText className="h-4 w-4" />
                            {task.submission_type}
                          </span>
                          <span className="flex items-center gap-1">
                            <Clock className="h-4 w-4" />
                            {task.allow_late_submission ? 'Late submission allowed' : 'No late submissions'}
                          </span>
                        </div>
                      </CardContent>
                    </Card>
                  ))}
                </div>
              )}
            </TabsContent>

            <TabsContent value="teachers" className="space-y-4">
              {intervention.teachers.length === 0 ? (
                <Card>
                  <CardContent className="flex flex-col items-center justify-center py-12">
                    <User className="h-12 w-12 text-gray-400 mb-4" />
                    <h3 className="text-lg font-semibold text-gray-900 mb-2">No teachers assigned</h3>
                    <p className="text-gray-600 text-center">
                      Teachers will be assigned to this intervention soon.
                    </p>
                  </CardContent>
                </Card>
              ) : (
                <div className="grid gap-4 md:grid-cols-2">
                  {intervention.teachers.map((teacher) => (
                    <Card key={teacher.id}>
                      <CardHeader className="pb-3">
                        <div className="flex items-center gap-3">
                          <div className="w-10 h-10 bg-blue-100 rounded-full flex items-center justify-center">
                            <User className="h-5 w-5 text-blue-600" />
                          </div>
                          <div className="flex-1">
                            <CardTitle className="text-base">{teacher.name}</CardTitle>
                            <p className="text-sm text-gray-600">{teacher.employee_id}</p>
                          </div>
                          <Badge variant="outline">{teacher.role}</Badge>
                        </div>
                      </CardHeader>
                      <CardContent>
                        <div className="space-y-2">
                          <div>
                            <span className="text-sm font-medium text-gray-700">Assigned Quadrants:</span>
                            <div className="flex flex-wrap gap-1 mt-1">
                              {teacher.assigned_quadrants.map((quadrant) => (
                                <Badge key={quadrant} variant="secondary" className="text-xs capitalize">
                                  {quadrant}
                                </Badge>
                              ))}
                            </div>
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                  ))}
                </div>
              )}
            </TabsContent>

            <TabsContent value="students" className="space-y-4">
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <Users className="h-5 w-5" />
                    Enrolled Students ({intervention.enrolled_students.length}/{intervention.max_students})
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  {intervention.enrolled_students.length === 0 ? (
                    <div className="text-center py-8">
                      <Users className="h-12 w-12 text-gray-400 mx-auto mb-4" />
                      <h3 className="text-lg font-semibold text-gray-900 mb-2">No students enrolled</h3>
                      <p className="text-gray-600">Be the first to join this intervention!</p>
                    </div>
                  ) : (
                    <div className="space-y-2">
                      {intervention.enrolled_students.map((student) => (
                        <div key={student.id} className="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                          <div className="flex items-center gap-3">
                            <div className="w-8 h-8 bg-blue-100 rounded-full flex items-center justify-center">
                              <User className="h-4 w-4 text-blue-600" />
                            </div>
                            <div>
                              <div className="font-medium">{student.name}</div>
                              <div className="text-sm text-gray-600">{student.registration_no}</div>
                            </div>
                          </div>
                          <Badge variant="outline" className="capitalize">
                            {student.enrollment_status}
                          </Badge>
                        </div>
                      ))}
                    </div>
                  )}
                </CardContent>
              </Card>
            </TabsContent>
          </Tabs>
        </div>

        {/* Right Column - Sidebar */}
        <div className="space-y-6">
          {/* Quick Stats */}
          <Card>
            <CardHeader>
              <CardTitle className="text-lg">Quick Stats</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="flex items-center justify-between">
                <span className="text-gray-600">Duration</span>
                <span className="font-medium">
                  {Math.ceil((new Date(intervention.end_date).getTime() - new Date(intervention.start_date).getTime()) / (1000 * 60 * 60 * 24))} days
                </span>
              </div>
              <div className="flex items-center justify-between">
                <span className="text-gray-600">Start Date</span>
                <span className="font-medium">{formatDate(intervention.start_date)}</span>
              </div>
              <div className="flex items-center justify-between">
                <span className="text-gray-600">End Date</span>
                <span className="font-medium">{formatDate(intervention.end_date)}</span>
              </div>
              <div className="flex items-center justify-between">
                <span className="text-gray-600">Tasks</span>
                <span className="font-medium">{intervention.tasks.length}</span>
              </div>
              <div className="flex items-center justify-between">
                <span className="text-gray-600">Teachers</span>
                <span className="font-medium">{intervention.teachers.length}</span>
              </div>
            </CardContent>
          </Card>

          {/* Enrollment Action */}
          {intervention.status === 'Active' && !isEnrolled && (
            <Card>
              <CardHeader>
                <CardTitle className="text-lg">Join This Intervention</CardTitle>
                <CardDescription>
                  Start your learning journey and develop new skills.
                </CardDescription>
              </CardHeader>
              <CardContent>
                <Button 
                  onClick={handleEnroll} 
                  disabled={enrolling}
                  className="w-full"
                >
                  {enrolling ? 'Enrolling...' : 'Enroll Now'}
                </Button>
                <p className="text-xs text-gray-600 mt-2 text-center">
                  You can withdraw within the first week if needed.
                </p>
              </CardContent>
            </Card>
          )}

          {/* Already Enrolled */}
          {isEnrolled && (
            <Card>
              <CardHeader>
                <CardTitle className="text-lg flex items-center gap-2">
                  <CheckCircle className="h-5 w-5 text-green-600" />
                  Enrolled
                </CardTitle>
                <CardDescription>
                  You are enrolled in this intervention.
                </CardDescription>
              </CardHeader>
              <CardContent>
                <Button variant="outline" className="w-full">
                  View My Progress
                </Button>
              </CardContent>
            </Card>
          )}
        </div>
      </div>
    </div>
  );
};

export default InterventionDetailsPage;
