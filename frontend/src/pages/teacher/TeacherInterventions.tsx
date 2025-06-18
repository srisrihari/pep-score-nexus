import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
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
import {
  BookOpen,
  Calendar,
  Users,
  Target,
  Clock,
  CheckCircle,
  AlertCircle,
  PlayCircle,
  FileText,
  Award,
  TrendingUp,
  ChevronRight,
} from 'lucide-react';
import { interventionAPI } from '@/lib/api';
import { TeacherInterventionAssignment } from '@/types/intervention';
import { useAuth } from '@/contexts/AuthContext';

const TeacherInterventions: React.FC = () => {
  const navigate = useNavigate();
  const { user } = useAuth();
  const [assignments, setAssignments] = useState<TeacherInterventionAssignment[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (user?.id) {
      fetchTeacherInterventions();
    }
  }, [user]);

  const fetchTeacherInterventions = async () => {
    try {
      setLoading(true);
      // For demo purposes, using a mock teacher ID
      // In real implementation, this would come from the authenticated user
      const teacherId = '17b0b78f-c435-4d5f-a7c5-a560a05ea353'; // John Smith
      const response = await interventionAPI.getTeacherInterventions(teacherId);
      setAssignments(response.data.interventions);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to fetch interventions');
    } finally {
      setLoading(false);
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
      month: 'short',
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

  if (loading) {
    return (
      <div className="container mx-auto p-6">
        <div className="flex items-center justify-center h-64">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
        </div>
      </div>
    );
  }

  return (
    <div className="container mx-auto p-6 space-y-6">
      {/* Header */}
      <div className="flex flex-col space-y-4">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">My Interventions</h1>
          <p className="text-gray-600 mt-1">
            Manage your assigned intervention programs and student progress
          </p>
        </div>
      </div>

      {error && (
        <Alert variant="destructive">
          <AlertCircle className="h-4 w-4" />
          <AlertDescription>{error}</AlertDescription>
        </Alert>
      )}

      {/* Quick Stats */}
      <div className="grid gap-4 md:grid-cols-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Active Interventions</CardTitle>
            <BookOpen className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              {assignments.filter(a => a.interventions.status === 'Active').length}
            </div>
          </CardContent>
        </Card>
        
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Total Students</CardTitle>
            <Users className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              {assignments.reduce((sum, a) => sum + (a.interventions.max_students || 0), 0)}
            </div>
          </CardContent>
        </Card>
        
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Assigned Quadrants</CardTitle>
            <Target className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              {new Set(assignments.flatMap(a => a.assigned_quadrants)).size}
            </div>
          </CardContent>
        </Card>
        
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Pending Reviews</CardTitle>
            <FileText className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">0</div>
            <p className="text-xs text-muted-foreground">No submissions pending</p>
          </CardContent>
        </Card>
      </div>

      {/* Interventions List */}
      <div className="space-y-6">
        <h2 className="text-xl font-semibold">Your Assigned Interventions</h2>
        
        {assignments.length === 0 ? (
          <Card>
            <CardContent className="flex flex-col items-center justify-center py-12">
              <BookOpen className="h-12 w-12 text-gray-400 mb-4" />
              <h3 className="text-lg font-semibold text-gray-900 mb-2">
                No interventions assigned
              </h3>
              <p className="text-gray-600 text-center max-w-md">
                You haven't been assigned to any interventions yet. Contact your administrator for intervention assignments.
              </p>
            </CardContent>
          </Card>
        ) : (
          <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
            {assignments.map((assignment) => (
              <Card 
                key={assignment.id} 
                className="hover:shadow-lg transition-shadow cursor-pointer"
                onClick={() => navigate(`/teacher/interventions/${assignment.interventions.id}`)}
              >
                <CardHeader className="pb-3">
                  <div className="flex items-start justify-between">
                    <div className="flex-1">
                      <CardTitle className="text-lg mb-2">{assignment.interventions.name}</CardTitle>
                      <div className="flex items-center gap-2 mb-2">
                        <Badge className={getStatusColor(assignment.interventions.status)}>
                          {getStatusIcon(assignment.interventions.status)}
                          <span className="ml-1">{assignment.interventions.status}</span>
                        </Badge>
                        <Badge variant="outline">{assignment.role}</Badge>
                      </div>
                    </div>
                    <ChevronRight className="h-5 w-5 text-gray-400" />
                  </div>
                  <CardDescription className="line-clamp-2">
                    {assignment.interventions.description}
                  </CardDescription>
                </CardHeader>
                
                <CardContent className="space-y-4">
                  {/* Progress Bar for Active Interventions */}
                  {assignment.interventions.status === 'Active' && (
                    <div className="space-y-2">
                      <div className="flex justify-between text-sm">
                        <span className="text-gray-600">Progress</span>
                        <span className="font-medium">
                          {calculateProgress(assignment.interventions.start_date, assignment.interventions.end_date)}%
                        </span>
                      </div>
                      <Progress 
                        value={calculateProgress(assignment.interventions.start_date, assignment.interventions.end_date)} 
                        className="h-2"
                      />
                    </div>
                  )}

                  {/* Intervention Details */}
                  <div className="space-y-2 text-sm">
                    <div className="flex items-center text-gray-600">
                      <Calendar className="h-4 w-4 mr-2" />
                      <span>
                        {formatDate(assignment.interventions.start_date)} - {formatDate(assignment.interventions.end_date)}
                      </span>
                    </div>
                    
                    <div className="flex items-center text-gray-600">
                      <Users className="h-4 w-4 mr-2" />
                      <span>
                        Max {assignment.interventions.max_students} students
                      </span>
                    </div>
                  </div>

                  {/* Assigned Quadrants */}
                  <div className="space-y-2">
                    <h4 className="text-sm font-medium text-gray-900">Your Quadrants</h4>
                    <div className="flex flex-wrap gap-1">
                      {assignment.assigned_quadrants.map((quadrant) => (
                        <Badge key={quadrant} variant="secondary" className="text-xs capitalize">
                          {quadrant}
                        </Badge>
                      ))}
                    </div>
                  </div>

                  {/* Permissions */}
                  <div className="space-y-2">
                    <h4 className="text-sm font-medium text-gray-900">Permissions</h4>
                    <div className="flex flex-wrap gap-1">
                      {assignment.permissions.map((permission) => (
                        <Badge key={permission} variant="outline" className="text-xs">
                          {permission.replace('_', ' ')}
                        </Badge>
                      ))}
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

export default TeacherInterventions;
