
import React, { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { studentList } from "@/data/mockData";
import { Search } from "lucide-react";
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, BarChart, Bar, Legend } from "recharts";

const batchSummary = {
  totalStudents: 120,
  avgScore: 82,
  highScore: 97,
  lowScore: 68
};

const quadrantAverages = [
  { name: "Persons", value: 35, max: 40 },
  { name: "Wellness", value: 26, max: 30 },
  { name: "Behavior", value: 17, max: 20 },
  { name: "Discipline", value: 8, max: 10 },
];

const monthlyAvgScores = [
  { month: "Jan", score: 75 },
  { month: "Feb", score: 77 },
  { month: "Mar", score: 79 },
  { month: "Apr", score: 81 },
  { month: "May", score: 82 },
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
      <div>
        <h1 className="text-2xl font-bold mb-1">Admin Dashboard</h1>
        <p className="text-muted-foreground">
          Manage students and monitor overall PEP program performance.
        </p>
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
                data={monthlyAvgScores}
                margin={{ top: 10, right: 30, left: 0, bottom: 0 }}
              >
                <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                <XAxis dataKey="month" />
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
