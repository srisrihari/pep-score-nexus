
import React, { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Badge } from "@/components/ui/badge";
import { studentList, termComparisonData } from "@/data/mockData";
import { Search } from "lucide-react";
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, BarChart, Bar, Legend, PieChart, Pie, Cell } from "recharts";

const batchSummary = {
  totalStudents: 120,
  avgScore: 82,
  highScore: 97,
  lowScore: 68
};

const quadrantAverages = [
  { name: "Persona", value: 35, max: 50 }, // Updated to match Excel (50 instead of 40)
  { name: "Wellness", value: 26, max: 30 },
  { name: "Behavior", value: 8, max: 10 }, // Updated to match Excel (10 instead of 20)
  { name: "Discipline", value: 8, max: 10 },
];

const termAvgScores = [
  { term: "Term 1", score: 75 },
  { term: "Term 2", score: 77 },
  { term: "Term 3", score: 79 },
  { term: "Term 4", score: 81 },
  { term: "Term 5", score: 82 },
];

// Grade distribution data
const gradeDistribution = [
  { name: "A+", value: 25, color: "#4CAF50" },
  { name: "A", value: 35, color: "#8BC34A" },
  { name: "B", value: 20, color: "#FFEB3B" },
  { name: "C", value: 10, color: "#FF9800" },
  { name: "D", value: 5, color: "#F44336" },
  { name: "E", value: 3, color: "#9C27B0" },
  { name: "IC", value: 2, color: "#607D8B" },
];

// Attendance issues data
const attendanceIssues = [
  { name: "Suresh L", regNo: "2350", attendance: 65, quadrants: ["Persona", "Wellness"] },
  { name: "Maya P", regNo: "2361", attendance: 70, quadrants: ["Persona"] },
  { name: "Vikram S", regNo: "2342", attendance: 75, quadrants: ["Wellness"] },
];

const recentlyAddedScores = [
  { name: "Rohan S", date: "2023-05-01", score: 97 },
  { name: "Priya M", date: "2023-05-01", score: 96 },
  { name: "Ajith", date: "2023-05-01", score: 95 },
  { name: "Kavita R", date: "2023-05-01", score: 94 },
  { name: "Arjun K", date: "2023-04-30", score: 93 },
];

const redFlagStudents = [
  { name: "Suresh L", regNo: "2350", issue: "Score dropped by 12%" },
  { name: "Maya P", regNo: "2361", issue: "Missing 3 assessments" },
  { name: "Vikram S", regNo: "2342", issue: "Discipline score critical" },
];

const AdminDashboard: React.FC = () => {
  const [searchQuery, setSearchQuery] = useState("");
  const [searchResults, setSearchResults] = useState<typeof studentList>([]);
  const [selectedTerm, setSelectedTerm] = useState("Term1");

  const handleSearch = () => {
    if (!searchQuery.trim()) {
      setSearchResults([]);
      return;
    }

    const query = searchQuery.toLowerCase();
    const results = studentList.filter(
      (student) =>
        student.name.toLowerCase().includes(query) ||
        student.registrationNo.includes(query)
    );
    setSearchResults(results);
  };

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-2xl font-bold mb-1">Admin Dashboard</h1>
          <p className="text-muted-foreground">
            Manage students and monitor overall PEP program performance.
          </p>
        </div>
        <div className="flex items-center space-x-2">
          <span className="text-sm font-medium">Term:</span>
          <Select value={selectedTerm} onValueChange={setSelectedTerm}>
            <SelectTrigger className="w-[180px]">
              <SelectValue placeholder="Select Term" />
            </SelectTrigger>
            <SelectContent>
              {termComparisonData.map((term) => (
                <SelectItem key={term.termId} value={term.termId}>
                  {term.termName}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
      </div>

      <Card>
        <CardContent className="pt-6">
          <div className="flex flex-col md:flex-row gap-4">
            <div className="flex gap-2 flex-1">
              <Input
                placeholder="Search student by name or registration no."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="flex-1"
              />
              <Button onClick={handleSearch}>
                <Search className="h-4 w-4 mr-2" />
                Search
              </Button>
            </div>
          </div>

          {searchResults.length > 0 && (
            <div className="mt-4">
              <h3 className="font-medium mb-2">Search Results</h3>
              <div className="overflow-x-auto">
                <table className="w-full text-left text-sm">
                  <thead className="bg-muted">
                    <tr>
                      <th className="p-2">Name</th>
                      <th className="p-2">Reg No.</th>
                      <th className="p-2">Score</th>
                      <th className="p-2">Grade</th>
                      <th className="p-2">Status</th>
                      <th className="p-2">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    {searchResults.map((student) => (
                      <tr key={student.id} className="border-b">
                        <td className="p-2">{student.name}</td>
                        <td className="p-2">{student.registrationNo}</td>
                        <td className="p-2 font-medium">{student.totalScore}/100</td>
                        <td className="p-2">
                          <Badge variant={student.grade === 'A+' ? "default" : student.grade === 'A' ? "secondary" : student.grade === 'B' ? "outline" : "destructive"}>
                            {student.grade}
                          </Badge>
                        </td>
                        <td className="p-2">
                          <Badge variant={student.overallStatus === 'Good' ? "default" : student.overallStatus === 'Progress' ? "secondary" : "destructive"} className="bg-opacity-20">
                            {student.overallStatus}
                          </Badge>
                        </td>
                        <td className="p-2">
                          <Button variant="link" className="p-0 h-auto" onClick={() => console.log("View student", student.id)}>
                            View Profile
                          </Button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}
        </CardContent>
      </Card>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <Card>
          <CardContent className="pt-6">
            <div className="text-center">
              <h3 className="text-sm font-medium text-muted-foreground mb-1">
                Total Students
              </h3>
              <p className="text-3xl font-bold">{batchSummary.totalStudents}</p>
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="pt-6">
            <div className="text-center">
              <h3 className="text-sm font-medium text-muted-foreground mb-1">
                Average Score
              </h3>
              <p className="text-3xl font-bold">{batchSummary.avgScore}/100</p>
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="pt-6">
            <div className="text-center">
              <h3 className="text-sm font-medium text-muted-foreground mb-1">
                Highest Score
              </h3>
              <p className="text-3xl font-bold">{batchSummary.highScore}/100</p>
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="pt-6">
            <div className="text-center">
              <h3 className="text-sm font-medium text-muted-foreground mb-1">
                Lowest Score
              </h3>
              <p className="text-3xl font-bold">{batchSummary.lowScore}/100</p>
            </div>
          </CardContent>
        </Card>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-lg">Average Score Trend</CardTitle>
          </CardHeader>
          <CardContent className="h-[300px]">
            <ResponsiveContainer width="100%" height="100%">
              <LineChart
                data={termAvgScores}
                margin={{ top: 10, right: 30, left: 0, bottom: 0 }}
              >
                <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                <XAxis dataKey="term" />
                <YAxis domain={[60, 100]} />
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

        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-lg">Quadrant Performance</CardTitle>
          </CardHeader>
          <CardContent className="h-[300px]">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart
                data={quadrantAverages}
                margin={{ top: 20, right: 30, left: 0, bottom: 5 }}
              >
                <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                <XAxis dataKey="name" />
                <YAxis />
                <Tooltip />
                <Legend />
                <Bar
                  dataKey="value"
                  name="Average Score"
                  fill="hsl(var(--primary))"
                />
                <Bar dataKey="max" name="Max Score" fill="#ddd" />
              </BarChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <Card>
          <CardHeader>
            <CardTitle className="text-lg">Grade Distribution</CardTitle>
          </CardHeader>
          <CardContent className="h-[300px]">
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie
                  data={gradeDistribution}
                  cx="50%"
                  cy="50%"
                  labelLine={false}
                  outerRadius={80}
                  fill="#8884d8"
                  dataKey="value"
                  label={({ name, percent }) => `${name} ${(percent * 100).toFixed(0)}%`}
                >
                  {gradeDistribution.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={entry.color} />
                  ))}
                </Pie>
                <Tooltip />
                <Legend />
              </PieChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="text-lg">Recently Added Scores</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead className="bg-muted text-left">
                  <tr>
                    <th className="p-2">Student</th>
                    <th className="p-2">Date</th>
                    <th className="p-2">Score</th>
                  </tr>
                </thead>
                <tbody>
                  {recentlyAddedScores.map((entry, index) => (
                    <tr key={index} className="border-b">
                      <td className="p-2">{entry.name}</td>
                      <td className="p-2">{entry.date}</td>
                      <td className="p-2 font-medium">{entry.score}/100</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </CardContent>
        </Card>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <Card className="bg-amber-50 dark:bg-amber-900/10 border-amber-100 dark:border-amber-800">
          <CardHeader>
            <CardTitle className="text-lg text-amber-700 dark:text-amber-400">Attendance Issues</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {attendanceIssues.map((student, index) => (
                <div key={index} className="flex justify-between border-b border-amber-100 dark:border-amber-800/50 pb-2">
                  <div>
                    <p className="font-medium">{student.name}</p>
                    <p className="text-xs text-amber-700/70 dark:text-amber-400/70">
                      Reg No: {student.regNo} | Attendance: {student.attendance}%
                    </p>
                  </div>
                  <div className="text-sm font-medium text-amber-700 dark:text-amber-400">
                    Not eligible for: {student.quadrants.join(", ")}
                  </div>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>

        <Card className="bg-red-50 dark:bg-red-900/10 border-red-100 dark:border-red-800">
          <CardHeader>
            <CardTitle className="text-lg text-red-700 dark:text-red-400">Red Flags</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {redFlagStudents.map((student, index) => (
                <div key={index} className="flex justify-between border-b border-red-100 dark:border-red-800/50 pb-2">
                  <div>
                    <p className="font-medium">{student.name}</p>
                    <p className="text-xs text-red-700/70 dark:text-red-400/70">
                      Reg No: {student.regNo}
                    </p>
                  </div>
                  <div className="text-sm font-medium text-red-700 dark:text-red-400">
                    {student.issue}
                  </div>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default AdminDashboard;
