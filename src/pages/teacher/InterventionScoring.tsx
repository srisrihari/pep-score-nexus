import React, { useState, useEffect } from "react";
import { useNavigate, useParams } from "react-router-dom";
import { Card, CardContent, CardHeader, CardTitle, CardDescription, CardFooter } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { Slider } from "@/components/ui/slider";
import { Progress } from "@/components/ui/progress";
import { Separator } from "@/components/ui/separator";
import { toast } from "sonner";
import { 
  ArrowLeft, 
  Save, 
  Send, 
  User, 
  Calendar, 
  Clock, 
  FileText,
  CheckCircle,
  AlertCircle,
  Info,
  HelpCircle,
  Paperclip
} from "lucide-react";
import { studentData, studentList } from "@/data/mockData";

// Mock data for the wellness components
const wellnessComponents = [
  { id: "push-ups", name: "Push Ups", maxScore: 5, description: "Upper body strength assessment" },
  { id: "sit-ups", name: "Sit Ups", maxScore: 5, description: "Core strength assessment" },
  { id: "sit-reach", name: "Sit & Reach", maxScore: 5, description: "Flexibility assessment" },
  { id: "beep-test", name: "Beep Test", maxScore: 5, description: "Cardiovascular endurance assessment" },
  { id: "bca", name: "Body Composition Analysis", maxScore: 5, description: "Body fat percentage and muscle mass assessment" },
  { id: "run", name: "3KM Run", maxScore: 5, description: "Endurance assessment" }
];

const InterventionScoring: React.FC = () => {
  const navigate = useNavigate();
  const { studentId } = useParams<{ studentId: string }>();
  const [selectedTerm, setSelectedTerm] = useState("Term1");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [isDraft, setIsDraft] = useState(false);
  const [overallFeedback, setOverallFeedback] = useState("");
  
  // Find student data
  const student = studentList.find(s => s.id === studentId) || studentData;
  
  // Initialize scores state
  const [scores, setScores] = useState<{
    [key: string]: {
      score: number;
      feedback: string;
    };
  }>({});
  
  // Initialize scores on component mount
  useEffect(() => {
    const initialScores: { [key: string]: { score: number; feedback: string } } = {};
    wellnessComponents.forEach(component => {
      // Get existing score from student data if available
      const existingComponent = student.quadrants.find(q => q.id === "wellness")?.components.find(c => c.id === component.id);
      initialScores[component.id] = {
        score: existingComponent?.score || 0,
        feedback: ""
      };
    });
    setScores(initialScores);
  }, [student, studentId]);
  
  // Calculate total score
  const totalScore = Object.values(scores).reduce((sum, item) => sum + item.score, 0);
  const maxPossibleScore = wellnessComponents.reduce((sum, component) => sum + component.maxScore, 0);
  const scorePercentage = (totalScore / maxPossibleScore) * 100;
  
  // Handle score change
  const handleScoreChange = (componentId: string, value: number[]) => {
    setScores(prev => ({
      ...prev,
      [componentId]: {
        ...prev[componentId],
        score: value[0]
      }
    }));
  };
  
  // Handle feedback change
  const handleFeedbackChange = (componentId: string, feedback: string) => {
    setScores(prev => ({
      ...prev,
      [componentId]: {
        ...prev[componentId],
        feedback
      }
    }));
  };
  
  // Handle save as draft
  const handleSaveDraft = () => {
    setIsSubmitting(true);
    setIsDraft(true);
    
    // Simulate API call
    setTimeout(() => {
      toast.success("Assessment saved as draft");
      setIsSubmitting(false);
    }, 1000);
  };
  
  // Handle submit
  const handleSubmit = () => {
    setIsSubmitting(true);
    
    // Validate if all components have scores
    const hasAllScores = Object.keys(scores).every(key => scores[key].score > 0);
    
    if (!hasAllScores) {
      toast.error("Please provide scores for all components");
      setIsSubmitting(false);
      return;
    }
    
    // Simulate API call
    setTimeout(() => {
      toast.success("Assessment submitted successfully");
      setIsSubmitting(false);
      navigate("/teacher/students");
    }, 1500);
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center">
        <Button
          variant="ghost"
          size="icon"
          onClick={() => navigate("/teacher/students")}
          className="mr-2"
        >
          <ArrowLeft className="h-5 w-5" />
        </Button>
        <div>
          <h1 className="text-2xl font-bold">Wellness Assessment</h1>
          <p className="text-muted-foreground">
            Score and provide feedback for {student.name}
          </p>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div>
          <Card>
            <CardHeader>
              <CardTitle>Student Information</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="flex items-start gap-3">
                <User className="h-5 w-5 text-muted-foreground mt-0.5" />
                <div>
                  <p className="font-medium">{student.name}</p>
                  <p className="text-sm text-muted-foreground">Registration: {student.registrationNo}</p>
                </div>
              </div>
              
              <div className="flex items-start gap-3">
                <Calendar className="h-5 w-5 text-muted-foreground mt-0.5" />
                <div>
                  <p className="font-medium">Current Term</p>
                  <Select value={selectedTerm} onValueChange={setSelectedTerm}>
                    <SelectTrigger className="w-full mt-1">
                      <SelectValue placeholder="Select Term" />
                    </SelectTrigger>
                    <SelectContent>
                      {student.terms.map(term => (
                        <SelectItem key={term.termId} value={term.termId}>
                          {term.termName}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
              </div>
              
              <div className="flex items-start gap-3">
                <Info className="h-5 w-5 text-muted-foreground mt-0.5" />
                <div>
                  <p className="font-medium">Previous Score</p>
                  <p className="text-sm text-muted-foreground">
                    {student.quadrants.find(q => q.id === "wellness")?.obtained || 0}/
                    {student.quadrants.find(q => q.id === "wellness")?.weightage || 30}
                  </p>
                </div>
              </div>
              
              <div className="flex items-start gap-3">
                <Clock className="h-5 w-5 text-muted-foreground mt-0.5" />
                <div>
                  <p className="font-medium">Assessment Date</p>
                  <p className="text-sm text-muted-foreground">{new Date().toLocaleDateString()}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          
          <Card className="mt-4">
            <CardHeader>
              <CardTitle>Assessment Summary</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div>
                <div className="flex justify-between mb-2">
                  <span className="text-sm font-medium">Total Score</span>
                  <span className="text-sm font-medium">{totalScore}/{maxPossibleScore}</span>
                </div>
                <Progress value={scorePercentage} className="h-2" />
              </div>
              
              <div className="space-y-2">
                {wellnessComponents.map(component => (
                  <div key={component.id} className="flex justify-between items-center">
                    <span className="text-sm">{component.name}</span>
                    <Badge variant={scores[component.id]?.score > 0 ? "outline" : "secondary"}>
                      {scores[component.id]?.score || 0}/{component.maxScore}
                    </Badge>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </div>
        
        <div className="md:col-span-2">
          <Card>
            <CardHeader>
              <CardTitle>Component Scoring</CardTitle>
              <CardDescription>
                Score each component and provide specific feedback
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-6">
                {wellnessComponents.map(component => (
                  <div key={component.id} className="space-y-3">
                    <div className="flex justify-between items-center">
                      <div className="space-y-1">
                        <Label htmlFor={`score-${component.id}`} className="text-base font-medium">
                          {component.name}
                        </Label>
                        <p className="text-sm text-muted-foreground">{component.description}</p>
                      </div>
                      <Badge variant="outline" className="ml-2">
                        {scores[component.id]?.score || 0}/{component.maxScore}
                      </Badge>
                    </div>
                    
                    <div className="flex items-center gap-4">
                      <div className="flex-1">
                        <Slider
                          id={`score-${component.id}`}
                          defaultValue={[scores[component.id]?.score || 0]}
                          max={component.maxScore}
                          step={0.5}
                          onValueChange={(value) => handleScoreChange(component.id, value)}
                        />
                      </div>
                      <div className="w-12 text-center">
                        <Input
                          type="number"
                          value={scores[component.id]?.score || 0}
                          min={0}
                          max={component.maxScore}
                          step={0.5}
                          onChange={(e) => handleScoreChange(component.id, [parseFloat(e.target.value) || 0])}
                          className="h-8"
                        />
                      </div>
                    </div>
                    
                    <div>
                      <Label htmlFor={`feedback-${component.id}`} className="text-sm">
                        Component Feedback
                      </Label>
                      <Textarea
                        id={`feedback-${component.id}`}
                        placeholder={`Provide specific feedback for ${component.name.toLowerCase()}...`}
                        value={scores[component.id]?.feedback || ""}
                        onChange={(e) => handleFeedbackChange(component.id, e.target.value)}
                        className="mt-1"
                      />
                    </div>
                    
                    <Separator />
                  </div>
                ))}
                
                <div className="space-y-3">
                  <Label htmlFor="overall-feedback" className="text-base font-medium">
                    Overall Feedback
                  </Label>
                  <Textarea
                    id="overall-feedback"
                    placeholder="Provide overall feedback and recommendations..."
                    value={overallFeedback}
                    onChange={(e) => setOverallFeedback(e.target.value)}
                    className="min-h-[100px]"
                  />
                </div>
                
                <div className="flex items-center gap-2">
                  <Paperclip className="h-4 w-4 text-muted-foreground" />
                  <span className="text-sm text-muted-foreground">Attach supporting documents (optional)</span>
                  <Button variant="outline" size="sm">
                    Upload
                  </Button>
                </div>
              </div>
            </CardContent>
            <CardFooter className="flex justify-between">
              <Button
                variant="outline"
                onClick={handleSaveDraft}
                disabled={isSubmitting}
              >
                <Save className="mr-2 h-4 w-4" />
                Save as Draft
              </Button>
              <Button
                onClick={handleSubmit}
                disabled={isSubmitting}
              >
                <Send className="mr-2 h-4 w-4" />
                {isSubmitting ? "Submitting..." : "Submit Assessment"}
              </Button>
            </CardFooter>
          </Card>
        </div>
      </div>
    </div>
  );
};

export default InterventionScoring;
