
import React, { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Tabs,
  TabsContent,
  TabsList,
  TabsTrigger,
} from "@/components/ui/tabs";
import { Label } from "@/components/ui/label";
import { toast } from "sonner";
import { studentList, studentData } from "@/data/mockData";
import { Upload } from "lucide-react";

const InputScores: React.FC = () => {
  const [selectedStudent, setSelectedStudent] = useState<string>("");
  const [quadrantScores, setQuadrantScores] = useState({
    persona: {} as Record<string, number>,
    wellness: {} as Record<string, number>,
    behavior: {} as Record<string, number>,
    discipline: {} as Record<string, number>,
  });
  const [currentTab, setCurrentTab] = useState("persona");
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleScoreChange = (
    quadrant: keyof typeof quadrantScores,
    componentId: string,
    value: string
  ) => {
    const numValue = Number(value);
    setQuadrantScores((prev) => ({
      ...prev,
      [quadrant]: {
        ...prev[quadrant],
        [componentId]: isNaN(numValue) ? 0 : numValue,
      },
    }));
  };

  const handleSubmit = () => {
    setIsSubmitting(true);

    // Simulate API call
    setTimeout(() => {
      toast.success("Scores submitted successfully");
      setIsSubmitting(false);
      
      // Reset form
      setSelectedStudent("");
      setQuadrantScores({
        persona: {},
        wellness: {},
        behavior: {},
        discipline: {},
      });
    }, 1500);
  };

  const getComponentMaxScore = (quadrantId: string, componentId: string) => {
    const quadrant = studentData.quadrants.find((q) => q.id === quadrantId);
    if (!quadrant) return 0;
    const component = quadrant.components.find((c) => c.id === componentId);
    return component ? component.maxScore : 0;
  };

  const renderQuadrantInputs = (quadrantId: string) => {
    const quadrant = studentData.quadrants.find((q) => q.id === quadrantId);
    if (!quadrant) return null;

    return (
      <div className="space-y-4">
        {quadrant.components.map((component) => (
          <div key={component.id} className="grid grid-cols-2 gap-4 items-center">
            <Label htmlFor={`${quadrantId}-${component.id}`}>
              {component.name} (0-{component.maxScore})
            </Label>
            <div className="flex items-center">
              <Input
                id={`${quadrantId}-${component.id}`}
                type="number"
                min="0"
                max={component.maxScore}
                value={
                  quadrantScores[quadrantId as keyof typeof quadrantScores][
                    component.id
                  ] || ""
                }
                onChange={(e) =>
                  handleScoreChange(
                    quadrantId as keyof typeof quadrantScores,
                    component.id,
                    e.target.value
                  )
                }
                placeholder={`0-${component.maxScore}`}
              />
              <span className="ml-2">/ {component.maxScore}</span>
            </div>
          </div>
        ))}
      </div>
    );
  };

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold mb-1">Input Scores</h1>
        <p className="text-muted-foreground">
          Enter or update student PEP scores by quadrant.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-lg">Score Input Form</CardTitle>
        </CardHeader>
        <CardContent className="space-y-6">
          <div className="space-y-2">
            <Label htmlFor="student-select">Select Student</Label>
            <Select
              value={selectedStudent}
              onValueChange={setSelectedStudent}
            >
              <SelectTrigger id="student-select" className="w-full">
                <SelectValue placeholder="Select a student" />
              </SelectTrigger>
              <SelectContent>
                {studentList.map((student) => (
                  <SelectItem key={student.id} value={student.id}>
                    {student.name} ({student.registrationNo})
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          {selectedStudent && (
            <>
              <Tabs
                value={currentTab}
                onValueChange={setCurrentTab}
                className="w-full"
              >
                <TabsList className="grid grid-cols-4 w-full">
                  <TabsTrigger value="persona">Persona</TabsTrigger>
                  <TabsTrigger value="wellness">Wellness</TabsTrigger>
                  <TabsTrigger value="behavior">Behavior</TabsTrigger>
                  <TabsTrigger value="discipline">Discipline</TabsTrigger>
                </TabsList>
                <TabsContent value="persona" className="mt-4">
                  {renderQuadrantInputs("persona")}
                </TabsContent>
                <TabsContent value="wellness" className="mt-4">
                  {renderQuadrantInputs("wellness")}
                </TabsContent>
                <TabsContent value="behavior" className="mt-4">
                  {renderQuadrantInputs("behavior")}
                </TabsContent>
                <TabsContent value="discipline" className="mt-4">
                  {renderQuadrantInputs("discipline")}
                </TabsContent>
              </Tabs>

              <div className="flex justify-end gap-4">
                <Button variant="outline" type="button" onClick={() => setSelectedStudent("")}>
                  Cancel
                </Button>
                <Button 
                  type="button" 
                  onClick={handleSubmit}
                  disabled={isSubmitting}
                >
                  {isSubmitting ? "Submitting..." : "Submit Scores"}
                </Button>
              </div>
            </>
          )}
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle className="text-lg">Bulk Upload</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="border-2 border-dashed border-gray-300 rounded-lg p-6 text-center">
            <Upload className="h-12 w-12 mx-auto text-muted-foreground mb-2" />
            <p className="text-muted-foreground mb-2">
              Drag and drop a CSV or Excel file, or click to browse
            </p>
            <Button variant="outline" className="mt-2">
              Browse Files
            </Button>
          </div>
          <p className="text-xs text-muted-foreground mt-4">
            Supported formats: .csv, .xlsx. Make sure the file follows the
            required template structure.
          </p>
        </CardContent>
      </Card>
    </div>
  );
};

export default InputScores;
