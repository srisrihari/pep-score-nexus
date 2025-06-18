
import React, { useState, useEffect } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { Button } from "@/components/ui/button";
import ScoreRing from "@/components/common/ScoreRing";
import QuadrantCard from "@/components/common/QuadrantCard";
import LeaderboardCard from "@/components/common/LeaderboardCard";
import AreasForImprovement from "@/components/student/AreasForImprovement";
import { Student, Leaderboard } from "@/data/mockData";
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, BarChart, Bar, Legend } from "recharts";
import StatusBadge from "@/components/common/StatusBadge";
import { Link } from "react-router-dom";
import { InfoIcon } from "lucide-react";
import { studentAPI } from "@/lib/api";
import {
  transformStudentPerformanceData,
  transformLeaderboardData,
  transformAttendanceData,
  generateMockLeaderboard,
  generateMockTimeSeriesData,
  generateMockTermComparisonData,
  generateMockAttendanceData
} from "@/lib/dataTransform";
// Import all necessary types

const StudentDashboard: React.FC = () => {
  const [studentData, setStudentData] = useState<Student | null>(null);
  const [leaderboardData, setLeaderboardData] = useState<Leaderboard | null>(null);
  const [timeSeriesData, setTimeSeriesData] = useState<any>(null);
  const [termComparisonData, setTermComparisonData] = useState<any[]>([]);
  const [attendanceData, setAttendanceData] = useState<any>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [selectedTermId, setSelectedTermId] = useState<string>("");

  // Load data from API
  useEffect(() => {
    const loadStudentData = async () => {
      try {
        setLoading(true);
        setError(null);

        // First get current student to get their ID
        const currentStudentResponse = await studentAPI.getCurrentStudent();
        const studentId = currentStudentResponse.data.id;

        // Fetch all required data using the new comprehensive APIs
        const [
          performanceResponse,
          leaderboardResponse,
          attendanceResponse
        ] = await Promise.all([
          studentAPI.getStudentPerformance(studentId, undefined, true).catch((error) => {
            console.error('Performance API failed:', error);
            return null;
          }),
          studentAPI.getStudentLeaderboard(studentId).catch(() => null), // Optional
          studentAPI.getStudentAttendance(studentId).catch(() => null) // Optional
        ]);

        // Check if we have the minimum required data
        if (!performanceResponse) {
          throw new Error('Unable to load student performance data. The API may be unavailable.');
        }

        // Transform API data to UI format
        const transformedStudent = transformStudentPerformanceData(performanceResponse);

        // Use real leaderboard data if available, otherwise generate mock
        const leaderboard = leaderboardResponse
          ? transformLeaderboardData(leaderboardResponse)
          : generateMockLeaderboard(transformedStudent.totalScore);

        // Use real attendance data if available, otherwise generate mock
        const attendance = attendanceResponse
          ? transformAttendanceData(attendanceResponse)
          : generateMockAttendanceData([]);

        // Data loaded successfully

        // Generate time series and term comparison from performance history
        const timeSeries = transformedStudent.terms.length > 1
          ? {
              overall: transformedStudent.terms.map(term => ({
                term: term.termName,
                score: term.totalScore
              }))
            }
          : generateMockTimeSeriesData(transformedStudent.totalScore);

        const termComparison = transformedStudent.terms.length > 1
          ? transformedStudent.terms.map(term => ({
              termName: term.termName,
              overall: term.totalScore
            }))
          : generateMockTermComparisonData(transformedStudent.totalScore);

        // Validate data before setting state
        if (!transformedStudent || !transformedStudent.terms || transformedStudent.terms.length === 0) {
          throw new Error('Invalid student data structure');
        }

        // Set all state
        setStudentData(transformedStudent);
        setLeaderboardData(leaderboard);
        setTimeSeriesData(timeSeries);
        setTermComparisonData(termComparison);
        setAttendanceData(attendance);
        setSelectedTermId(transformedStudent.currentTerm);

      } catch (err) {
        console.error('Failed to load student data:', err);
        const errorMessage = err instanceof Error ? err.message : 'Failed to load data';

        // If student profile not found, show a specific message
        if (errorMessage.includes('Student profile not found')) {
          setError('Student profile not found. Please contact your administrator to set up your student profile.');
        } else {
          setError(errorMessage);
        }
      } finally {
        setLoading(false);
      }
    };

    loadStudentData();
  }, []);

  // Show loading state
  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="text-center">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary mx-auto mb-4"></div>
          <p className="text-muted-foreground">Loading your dashboard...</p>
        </div>
      </div>
    );
  }

  // Show error state
  if (error || !studentData || !leaderboardData) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="text-center">
          <p className="text-destructive mb-4">Failed to load dashboard data</p>
          <p className="text-muted-foreground text-sm">{error}</p>
          <Button 
            onClick={() => window.location.reload()} 
            variant="outline" 
            className="mt-4"
          >
            Retry
          </Button>
        </div>
      </div>
    );
  }

  // Find the selected term data
  const selectedTerm = studentData.terms.find(term => term.termId === selectedTermId) || studentData.terms[0];
  const { quadrants, totalScore, overallStatus, grade } = selectedTerm;
  const overallLeaderboard = leaderboardData?.overall || { batchAvg: 0, batchBest: 0, topStudents: [], userRank: 0 };

  const summaryMetrics = [
    {
      label: "Previous Term Score",
      value: studentData.terms.length > 1 ? studentData.terms[studentData.terms.length - 2].totalScore : "-",
      maxValue: 100
    },
    {
      label: "Best Term Score",
      value: studentData.terms.length > 0 ? Math.max(...studentData.terms.map(term => term.totalScore)) : 0,
      maxValue: 100
    },
    {
      label: "Batch Avg Score",
      value: typeof overallLeaderboard.batchAvg === 'number' ? overallLeaderboard.batchAvg : 0,
      maxValue: 100
    },
    {
      label: "Batch Best Score",
      value: typeof overallLeaderboard.batchBest === 'number' ? overallLeaderboard.batchBest : 0,
      maxValue: 100
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-2xl font-bold mb-1">Student Dashboard</h1>
          <p className="text-muted-foreground">
            Welcome back, {studentData.name}! Here's your PEP performance.
          </p>
        </div>
        <div className="flex items-center space-x-2">
          <span className="text-sm font-medium">Term:</span>
          <Select value={selectedTermId} onValueChange={setSelectedTermId}>
            <SelectTrigger className="w-[180px]">
              <SelectValue placeholder="Select Term" />
            </SelectTrigger>
            <SelectContent>
              {studentData.terms.map((term) => (
                <SelectItem key={term.termId} value={term.termId}>
                  {term.termName}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <Card className="md:col-span-1 flex flex-col items-center justify-center py-6">
          <h2 className="text-lg font-medium mb-4">Overall HPS Score</h2>
          <ScoreRing score={totalScore} maxScore={100} size="lg" />
          <div className="mt-4 flex flex-col items-center space-y-2">
            <div className="flex items-center">
              <span className="mr-2">Status:</span>
              <StatusBadge status={overallStatus} />
            </div>
            <div className="flex items-center">
              <span className="mr-2">Grade:</span>
              <Badge variant={grade === 'A+' ? "default" : grade === 'A' ? "secondary" : grade === 'B' ? "outline" : "destructive"}>
                {grade}
              </Badge>
            </div>
          </div>
        </Card>

        <Card className="md:col-span-3">
          <CardHeader className="pb-2">
            <CardTitle className="text-lg">Score Progress Across Terms</CardTitle>
          </CardHeader>
          <CardContent className="h-[230px]">
            <ResponsiveContainer width="100%" height="100%">
              <LineChart
                data={timeSeriesData?.overall || []}
                margin={{ top: 10, right: 30, left: 0, bottom: 0 }}
              >
                <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                <XAxis dataKey="term" />
                <YAxis domain={[0, 100]} />
                <Tooltip />
                <Line
                  type="monotone"
                  dataKey="score"
                  stroke="hsl(var(--primary))"
                  strokeWidth={2}
                  activeDot={{ r: 8 }}
                />
              </LineChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <Card>
          <CardHeader>
            <CardTitle>Attendance Status</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              <div>
                <div className="flex justify-between mb-1">
                  <span className="text-sm font-medium">Overall Attendance</span>
                  <span className="text-sm font-medium">{attendanceData?.overall || 0}%</span>
                </div>
                <Progress value={attendanceData?.overall || 0} className="h-2" />
              </div>
              <div>
                <div className="flex justify-between mb-1">
                  <span className="text-sm font-medium">Wellness Attendance</span>
                  <span className="text-sm font-medium">{attendanceData?.wellness || 0}%</span>
                </div>
                <Progress value={attendanceData?.wellness || 0} className="h-2" />
              </div>
              <div className="flex items-center mt-4">
                <span className="mr-2">Eligibility Status:</span>
                <Badge variant={
                  (typeof attendanceData?.eligibility === 'string' && attendanceData.eligibility === "Eligible")
                    ? "outline"
                    : "destructive"
                }>
                  {typeof attendanceData?.eligibility === 'string' ? attendanceData.eligibility : "Unknown"}
                </Badge>
              </div>
              <div className="flex items-center justify-between text-xs text-muted-foreground mt-2">
                <span>Note: Minimum 80% attendance required for eligibility in Persona and Wellness quadrants.</span>
                <Button variant="link" size="sm" className="p-0 h-auto" asChild>
                  <Link to="/student/eligibility" className="flex items-center">
                    <InfoIcon className="h-3 w-3 mr-1" />
                    View Rules
                  </Link>
                </Button>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Term Comparison</CardTitle>
          </CardHeader>
          <CardContent className="h-[220px]">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart
                data={termComparisonData}
                margin={{ top: 10, right: 30, left: 0, bottom: 0 }}
              >
                <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                <XAxis dataKey="termName" />
                <YAxis domain={[0, 100]} />
                <Tooltip />
                <Legend />
                <Bar dataKey="overall" fill="hsl(var(--primary))" name="Overall Score" />
              </BarChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        {summaryMetrics.map((metric, index) => (
          <Card key={index}>
            <CardContent className="pt-6">
              <div className="text-center">
                <h3 className="text-sm font-medium text-muted-foreground mb-2">
                  {metric.label}
                </h3>
                <p className="text-2xl font-bold">
                  {metric.value}
                  <span className="text-sm text-muted-foreground font-normal">
                    /{metric.maxValue}
                  </span>
                </p>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      <Tabs defaultValue="quadrants">
        <TabsList className="grid w-full grid-cols-2 mb-4">
          <TabsTrigger value="quadrants">Quadrant Scores</TabsTrigger>
          <TabsTrigger value="components">Component Details</TabsTrigger>
        </TabsList>

        <TabsContent value="quadrants" className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            {quadrants.map((quadrant, index) => (
              <QuadrantCard
                key={quadrant.id}
                quadrant={quadrant}
                batchAvg={leaderboardData?.quadrants[quadrant.id]?.batchAvg || 0}
                batchBest={leaderboardData?.quadrants[quadrant.id]?.batchBest || 0}
                gradientClass={
                  index === 0
                    ? "card-gradient-primary"
                    : index === 1
                    ? "card-gradient-secondary"
                    : index === 2
                    ? "card-gradient-indigo"
                    : "card-gradient-purple"
                }
              />
            ))}
          </div>
        </TabsContent>

        <TabsContent value="components">
          <div className="space-y-6">
            {quadrants.map((quadrant) => (
              <Card key={quadrant.id}>
                <CardHeader>
                  <CardTitle className="flex justify-between">
                    <span>{quadrant.name} Components</span>
                    <Badge variant="outline">{quadrant.obtained}/{quadrant.weightage}</Badge>
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    {quadrant.components.map((component) => (
                      <div key={component.id} className="flex justify-between items-center">
                        <div className="flex-1">
                          <div className="flex justify-between mb-1">
                            <span className="text-sm font-medium">{component.name}</span>
                            <span className="text-sm font-medium">{component.score}/{component.maxScore}</span>
                          </div>
                          <Progress value={(component.score / component.maxScore) * 100} className="h-2" />
                        </div>
                        {component.status && (
                          <div className="ml-4">
                            <StatusBadge status={component.status} />
                          </div>
                        )}
                      </div>
                    ))}
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </TabsContent>
      </Tabs>

      <div className="mt-8 grid grid-cols-1 md:grid-cols-2 gap-6">
        <LeaderboardCard
          leaders={overallLeaderboard.topStudents}
          userRank={overallLeaderboard.userRank}
          maxScore={100}
        />

        <AreasForImprovement studentData={studentData} />
      </div>
    </div>
  );
};

export default StudentDashboard;
