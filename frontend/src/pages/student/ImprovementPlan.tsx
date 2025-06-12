import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Badge } from '@/components/ui/badge';
import { Progress } from '@/components/ui/progress';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { ArrowLeft, TrendingDown, AlertTriangle, Target, CheckCircle2, Calendar, Clock, BookOpen, Award } from 'lucide-react';
import { studentData } from '@/data/mockData';

const ImprovementPlan: React.FC = () => {
  const navigate = useNavigate();
  const [selectedTermId, setSelectedTermId] = useState<string>(studentData.currentTerm);
  const [selectedQuadrant, setSelectedQuadrant] = useState<string>('all');
  
  // Get the current term data
  const currentTerm = studentData.terms.find(term => term.termId === selectedTermId) || studentData.terms[0];
  
  // Find components that need improvement across all quadrants
  const improvementAreas: {
    quadrantId: string;
    quadrantName: string;
    componentId: string;
    componentName: string;
    score: number;
    maxScore: number;
    status?: string;
    priority: 'high' | 'medium' | 'low';
  }[] = [];
  
  // Helper function to determine priority
  const determinePriority = (component: any, quadrant: any): 'high' | 'medium' | 'low' => {
    if (component.status === 'Deteriorate') return 'high';
    if (component.score / component.maxScore < 0.6) return 'high';
    if (component.score / component.maxScore < 0.7) return 'medium';
    return 'low';
  };
  
  // Collect improvement areas from all quadrants
  currentTerm.quadrants.forEach(quadrant => {
    // Skip if filtering by quadrant and this isn't the selected one
    if (selectedQuadrant !== 'all' && quadrant.id !== selectedQuadrant) return;
    
    // Check if the quadrant has eligibility issues
    if (quadrant.eligibility === 'Not Eligible') {
      improvementAreas.push({
        quadrantId: quadrant.id,
        quadrantName: quadrant.name,
        componentId: 'attendance',
        componentName: 'Attendance',
        score: quadrant.attendance || 0,
        maxScore: 100,
        status: 'Attendance Shortage',
        priority: 'high'
      });
    }
    
    // Check individual components
    quadrant.components.forEach(component => {
      if (
        component.status === 'Progress' || 
        component.status === 'Deteriorate' || 
        (component.score / component.maxScore < 0.7)
      ) {
        improvementAreas.push({
          quadrantId: quadrant.id,
          quadrantName: quadrant.name,
          componentId: component.id,
          componentName: component.name,
          score: component.score,
          maxScore: component.maxScore,
          status: component.status,
          priority: determinePriority(component, quadrant)
        });
      }
    });
  });
  
  // Sort by priority (high to low)
  improvementAreas.sort((a, b) => {
    const priorityOrder = { high: 0, medium: 1, low: 2 };
    return priorityOrder[a.priority] - priorityOrder[b.priority];
  });
  
  // Generate improvement recommendations with detailed steps
  const getDetailedRecommendations = (area: typeof improvementAreas[0]): {
    shortTerm: string[];
    longTerm: string[];
    resources: string[];
  } => {
    const recommendations = {
      shortTerm: [] as string[],
      longTerm: [] as string[],
      resources: [] as string[]
    };
    
    if (area.status === 'Attendance Shortage') {
      recommendations.shortTerm = [
        'Set daily reminders for all scheduled classes and activities',
        'Arrive 10 minutes early to all sessions',
        'Request make-up sessions for any unavoidable absences'
      ];
      recommendations.longTerm = [
        'Develop a consistent routine to improve overall attendance',
        'Address any underlying issues affecting your attendance',
        'Build a support system to help maintain accountability'
      ];
      recommendations.resources = [
        'Attendance tracking app or calendar',
        'Academic counseling services',
        'Time management workshops'
      ];
      return recommendations;
    }
    
    if (area.quadrantId === 'persona') {
      if (area.componentName.includes('Critical Thinking')) {
        recommendations.shortTerm = [
          'Complete one analytical exercise daily',
          'Participate actively in class discussions',
          'Practice breaking down complex problems into smaller parts'
        ];
        recommendations.longTerm = [
          'Join debate clubs or discussion forums',
          'Take additional courses in logic and reasoning',
          'Develop a habit of questioning assumptions'
        ];
        recommendations.resources = [
          'Critical thinking workbooks and online courses',
          'Logic puzzle apps and games',
          'Recommended reading list from faculty'
        ];
      } else if (area.componentName.includes('Communication')) {
        recommendations.shortTerm = [
          'Practice public speaking for 10 minutes daily',
          'Record yourself speaking and analyze areas for improvement',
          'Volunteer to present in class whenever possible'
        ];
        recommendations.longTerm = [
          'Join Toastmasters or similar public speaking groups',
          'Take a communication skills workshop',
          'Seek opportunities for formal presentations'
        ];
        recommendations.resources = [
          'Public speaking apps and videos',
          'Communication skills books',
          'Speech coaching services'
        ];
      } else if (area.componentName.includes('Leadership')) {
        recommendations.shortTerm = [
          'Volunteer to lead small group discussions',
          'Take initiative in team projects',
          'Practice decision-making in low-stakes situations'
        ];
        recommendations.longTerm = [
          'Run for student government or club leadership positions',
          'Attend leadership development workshops',
          'Seek mentorship from established leaders'
        ];
        recommendations.resources = [
          'Leadership books and podcasts',
          'Student leadership programs',
          'Leadership assessment tools'
        ];
      }
    } else if (area.quadrantId === 'wellness') {
      recommendations.shortTerm = [
        'Establish a daily 30-minute exercise routine',
        'Focus on proper technique rather than intensity',
        'Track your progress using a fitness app'
      ];
      recommendations.longTerm = [
        'Gradually increase workout intensity and duration',
        'Set specific fitness goals with deadlines',
        'Consider working with a fitness trainer'
      ];
      recommendations.resources = [
        'Campus fitness facilities',
        'Online workout videos and tutorials',
        'Fitness tracking apps'
      ];
    } else if (area.quadrantId === 'behavior') {
      recommendations.shortTerm = [
        'Create a pre-class preparation checklist',
        'Set a goal to contribute at least once in every class',
        'Review your behavior self-assessment weekly'
      ];
      recommendations.longTerm = [
        'Develop habits that reinforce positive classroom behavior',
        'Seek regular feedback from instructors',
        'Practice self-reflection on behavioral patterns'
      ];
      recommendations.resources = [
        'Behavior tracking apps',
        'Academic success workshops',
        'Peer accountability partnerships'
      ];
    } else if (area.quadrantId === 'discipline') {
      recommendations.shortTerm = [
        'Use a planner to track all deadlines and commitments',
        'Implement a time-blocking system for your schedule',
        'Set up accountability check-ins with peers'
      ];
      recommendations.longTerm = [
        'Develop a personal system for maintaining discipline',
        'Practice techniques to overcome procrastination',
        'Build resilience through consistent follow-through'
      ];
      recommendations.resources = [
        'Time management apps and tools',
        'Productivity books and courses',
        'Academic coaching services'
      ];
    }
    
    // Default recommendations if none of the specific cases match
    if (recommendations.shortTerm.length === 0) {
      recommendations.shortTerm = [
        'Set specific, measurable goals for improvement',
        'Seek feedback from instructors on your current performance',
        'Dedicate regular time to practice and improvement'
      ];
      recommendations.longTerm = [
        'Develop a comprehensive improvement plan',
        'Track your progress over time',
        'Seek additional resources and support'
      ];
      recommendations.resources = [
        'Academic support services',
        'Online learning resources',
        'Peer study groups'
      ];
    }
    
    return recommendations;
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center">
        <Button
          variant="ghost"
          size="icon"
          onClick={() => navigate("/student")}
          className="mr-2"
        >
          <ArrowLeft className="h-5 w-5" />
        </Button>
        <div>
          <h1 className="text-2xl font-bold">Personalized Improvement Plan</h1>
          <p className="text-muted-foreground">
            Detailed recommendations to help you improve your PEP performance
          </p>
        </div>
      </div>
      
      <div className="flex flex-col md:flex-row gap-4 md:items-center">
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
        
        <div className="flex items-center space-x-2">
          <span className="text-sm font-medium">Quadrant:</span>
          <Select value={selectedQuadrant} onValueChange={setSelectedQuadrant}>
            <SelectTrigger className="w-[180px]">
              <SelectValue placeholder="Select Quadrant" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">All Quadrants</SelectItem>
              {currentTerm.quadrants.map((quadrant) => (
                <SelectItem key={quadrant.id} value={quadrant.id}>
                  {quadrant.name}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
      </div>
      
      <Card>
        <CardHeader>
          <CardTitle>Improvement Areas Overview</CardTitle>
          <CardDescription>
            Based on your current performance, we've identified the following areas for improvement
          </CardDescription>
        </CardHeader>
        <CardContent>
          {improvementAreas.length > 0 ? (
            <div className="space-y-6">
              {improvementAreas.map((area) => (
                <div key={`${area.quadrantId}-${area.componentId}`} className="border rounded-lg p-4">
                  <div className="flex justify-between items-center mb-3">
                    <div className="flex items-center gap-2">
                      {area.priority === 'high' ? (
                        <TrendingDown className="h-5 w-5 text-red-500" />
                      ) : (
                        <AlertTriangle className="h-5 w-5 text-amber-500" />
                      )}
                      <h3 className="font-medium">
                        {area.quadrantName}: {area.componentName}
                      </h3>
                    </div>
                    <Badge variant={area.priority === 'high' ? 'destructive' : area.priority === 'medium' ? 'secondary' : 'outline'}>
                      {area.priority.charAt(0).toUpperCase() + area.priority.slice(1)} Priority
                    </Badge>
                  </div>
                  
                  <div className="mb-3">
                    <div className="flex justify-between mb-1 text-sm">
                      <span>Current Score</span>
                      <span className="font-medium">{area.score}/{area.maxScore}</span>
                    </div>
                    <Progress 
                      value={(area.score / area.maxScore) * 100} 
                      className={`h-2 ${area.priority === 'high' ? 'bg-red-100' : area.priority === 'medium' ? 'bg-amber-100' : 'bg-slate-100'}`} 
                    />
                  </div>
                  
                  <Tabs defaultValue="short-term">
                    <TabsList className="grid w-full grid-cols-3">
                      <TabsTrigger value="short-term">
                        <Clock className="h-4 w-4 mr-2" />
                        Short-term
                      </TabsTrigger>
                      <TabsTrigger value="long-term">
                        <Calendar className="h-4 w-4 mr-2" />
                        Long-term
                      </TabsTrigger>
                      <TabsTrigger value="resources">
                        <BookOpen className="h-4 w-4 mr-2" />
                        Resources
                      </TabsTrigger>
                    </TabsList>
                    
                    {(() => {
                      const recommendations = getDetailedRecommendations(area);
                      
                      return (
                        <>
                          <TabsContent value="short-term" className="pt-4">
                            <h4 className="text-sm font-medium mb-2">Short-term Actions (Next 2-4 weeks)</h4>
                            <ul className="space-y-2">
                              {recommendations.shortTerm.map((rec, idx) => (
                                <li key={idx} className="flex items-start gap-2 text-sm">
                                  <Target className="h-4 w-4 mt-0.5 text-primary flex-shrink-0" />
                                  <span>{rec}</span>
                                </li>
                              ))}
                            </ul>
                          </TabsContent>
                          
                          <TabsContent value="long-term" className="pt-4">
                            <h4 className="text-sm font-medium mb-2">Long-term Strategy (Next 2-3 months)</h4>
                            <ul className="space-y-2">
                              {recommendations.longTerm.map((rec, idx) => (
                                <li key={idx} className="flex items-start gap-2 text-sm">
                                  <Award className="h-4 w-4 mt-0.5 text-primary flex-shrink-0" />
                                  <span>{rec}</span>
                                </li>
                              ))}
                            </ul>
                          </TabsContent>
                          
                          <TabsContent value="resources" className="pt-4">
                            <h4 className="text-sm font-medium mb-2">Recommended Resources</h4>
                            <ul className="space-y-2">
                              {recommendations.resources.map((rec, idx) => (
                                <li key={idx} className="flex items-start gap-2 text-sm">
                                  <BookOpen className="h-4 w-4 mt-0.5 text-primary flex-shrink-0" />
                                  <span>{rec}</span>
                                </li>
                              ))}
                            </ul>
                          </TabsContent>
                        </>
                      );
                    })()}
                  </Tabs>
                  
                  <div className="mt-4 pt-4 border-t">
                    <Button 
                      variant="outline" 
                      size="sm" 
                      className="w-full" 
                      onClick={() => navigate(`/student/quadrant/${area.quadrantId}`)}
                    >
                      View {area.quadrantName} Details
                    </Button>
                  </div>
                </div>
              ))}
            </div>
          ) : (
            <div className="py-12 text-center">
              <CheckCircle2 className="h-12 w-12 text-green-500 mx-auto mb-4" />
              <h3 className="text-xl font-medium text-green-600 mb-2">Great job!</h3>
              <p className="text-muted-foreground">
                No critical areas for improvement identified. Continue maintaining your excellent performance.
              </p>
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
};

export default ImprovementPlan;
