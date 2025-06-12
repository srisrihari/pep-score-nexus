
import React, { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Label } from "@/components/ui/label";
import { toast } from "sonner";
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer, LineChart, Line, PieChart, Pie, Cell } from "recharts";
import { Download, FileBarChart } from "lucide-react";

const quadrantDistribution = [
  { name: "Persona", value: 50 }, // Updated to match Excel (50 instead of 40)
  { name: "Wellness", value: 30 },
  { name: "Behavior", value: 10 }, // Updated to match Excel (10 instead of 20)
  { name: "Discipline", value: 10 },
];

const scoreDistribution = [
  { range: "A+", count: 25, label: "Excellent (>80)" },
  { range: "A", count: 35, label: "Good (66-79)" },
  { range: "B", count: 20, label: "Average (50-65)" },
  { range: "C/D", count: 15, label: "Marginal (34-49)" },
  { range: "E", count: 3, label: "Poor (<34)" },
  { range: "IC", count: 2, label: "Incomplete" },
];

// Attendance distribution data
const attendanceDistribution = [
  { range: "90-100%", count: 45, status: "Excellent" },
  { range: "80-89%", count: 35, status: "Good" },
  { range: "70-79%", count: 15, status: "At Risk" },
  { range: "Below 70%", count: 5, status: "Critical" },
];

const termProgress = [
  { term: "Term 1", avgScore: 75 },
  { term: "Term 2", avgScore: 79 },
  { term: "Term 3", avgScore: 82 },
  { term: "Term 4", avgScore: 84 },
  { term: "Term 5", avgScore: 86 },
];

const quadrantPerformance = [
  { name: "Persona", actual: 42, target: 50 }, // Updated to match Excel (50 instead of 40)
  { name: "Wellness", actual: 26, target: 30 },
  { name: "Behavior", actual: 8, target: 10 }, // Updated to match Excel (10 instead of 20)
  { name: "Discipline", actual: 8, target: 10 },
];

// Eligibility status data
const eligibilityStatus = [
  { status: "Eligible", count: 95 },
  { status: "Not Eligible", count: 5 },
];

const COLORS = ['#7e3af2', '#0694a2', '#6875f5', '#8c6dfd'];

const Reports: React.FC = () => {
  const [batchFilter, setBatchFilter] = useState("all");
  const [periodFilter, setPeriodFilter] = useState("2023-2024");
  const [reportType, setReportType] = useState("overview");
  const [termFilter, setTermFilter] = useState("all");

  const handleDownload = (format: "pdf" | "excel") => {
    toast.success(`Downloading report in ${format.toUpperCase()} format`);
  };

  const renderReportContent = () => {
    switch (reportType) {
      case "overview":
        return (
          <>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
              <Card>
                <CardHeader>
                  <CardTitle>PEP Score Distribution</CardTitle>
                </CardHeader>
                <CardContent className="h-[300px]">
                  <ResponsiveContainer width="100%" height="100%">
                    <BarChart data={scoreDistribution}>
                      <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                      <XAxis dataKey="range" />
                      <YAxis />
                      <Tooltip />
                      <Bar dataKey="count" fill="hsl(var(--primary))" />
                    </BarChart>
                  </ResponsiveContainer>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle>Term Progress</CardTitle>
                </CardHeader>
                <CardContent className="h-[300px]">
                  <ResponsiveContainer width="100%" height="100%">
                    <LineChart data={termProgress}>
                      <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                      <XAxis dataKey="term" />
                      <YAxis domain={[60, 100]} />
                      <Tooltip />
                      <Line
                        type="monotone"
                        dataKey="avgScore"
                        stroke="hsl(var(--primary))"
                        strokeWidth={2}
                      />
                    </LineChart>
                  </ResponsiveContainer>
                </CardContent>
              </Card>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <Card>
                <CardHeader>
                  <CardTitle>PEP Quadrant Distribution</CardTitle>
                </CardHeader>
                <CardContent className="h-[300px]">
                  <ResponsiveContainer width="100%" height="100%">
                    <PieChart>
                      <Pie
                        data={quadrantDistribution}
                        cx="50%"
                        cy="50%"
                        outerRadius={80}
                        fill="#8884d8"
                        dataKey="value"
                        label={({ name, percent }) =>
                          `${name} ${(percent * 100).toFixed(0)}%`
                        }
                      >
                        {quadrantDistribution.map((entry, index) => (
                          <Cell
                            key={`cell-${index}`}
                            fill={COLORS[index % COLORS.length]}
                          />
                        ))}
                      </Pie>
                      <Tooltip />
                    </PieChart>
                  </ResponsiveContainer>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle>Quadrant Performance</CardTitle>
                </CardHeader>
                <CardContent className="h-[300px]">
                  <ResponsiveContainer width="100%" height="100%">
                    <BarChart
                      data={quadrantPerformance}
                      layout="vertical"
                      margin={{ top: 5, right: 30, left: 20, bottom: 5 }}
                    >
                      <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                      <XAxis type="number" />
                      <YAxis dataKey="name" type="category" />
                      <Tooltip />
                      <Legend />
                      <Bar dataKey="actual" fill="hsl(var(--primary))" name="Actual" />
                      <Bar dataKey="target" fill="#ddd" name="Target" />
                    </BarChart>
                  </ResponsiveContainer>
                </CardContent>
              </Card>
            </div>
          </>
        );
      case "detailed":
        return (
          <>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
              <Card>
                <CardHeader>
                  <CardTitle>Attendance Distribution</CardTitle>
                </CardHeader>
                <CardContent className="h-[300px]">
                  <ResponsiveContainer width="100%" height="100%">
                    <BarChart data={attendanceDistribution}>
                      <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                      <XAxis dataKey="range" />
                      <YAxis />
                      <Tooltip />
                      <Bar dataKey="count" fill="hsl(var(--primary))" />
                    </BarChart>
                  </ResponsiveContainer>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle>Eligibility Status</CardTitle>
                </CardHeader>
                <CardContent className="h-[300px]">
                  <ResponsiveContainer width="100%" height="100%">
                    <PieChart>
                      <Pie
                        data={eligibilityStatus}
                        cx="50%"
                        cy="50%"
                        outerRadius={80}
                        fill="#8884d8"
                        dataKey="count"
                        label={({ status, percent }) =>
                          `${status} ${(percent * 100).toFixed(0)}%`
                        }
                      >
                        <Cell fill="#4CAF50" />
                        <Cell fill="#F44336" />
                      </Pie>
                      <Tooltip />
                    </PieChart>
                  </ResponsiveContainer>
                </CardContent>
              </Card>
            </div>

            <Card>
              <CardHeader>
                <CardTitle>Term-wise Performance Analysis</CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-center text-muted-foreground py-8">
                  Detailed term-wise analysis is currently being processed.
                  <br />
                  Please check back later or select another report type.
                </p>
              </CardContent>
            </Card>
          </>
        );
      default:
        return null;
    }
  };

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold mb-1">Reports</h1>
        <p className="text-muted-foreground">
          Generate and view performance reports for the PEP program.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-lg">Report Configuration</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            <div className="space-y-2">
              <Label htmlFor="batch-filter">Batch</Label>
              <Select value={batchFilter} onValueChange={setBatchFilter}>
                <SelectTrigger id="batch-filter">
                  <SelectValue placeholder="Select batch" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All Batches</SelectItem>
                  <SelectItem value="2024">2024</SelectItem>
                  <SelectItem value="2023">2023</SelectItem>
                  <SelectItem value="2022">2022</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <div className="space-y-2">
              <Label htmlFor="period-filter">Academic Period</Label>
              <Select value={periodFilter} onValueChange={setPeriodFilter}>
                <SelectTrigger id="period-filter">
                  <SelectValue placeholder="Select period" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="2023-2024">2023-2024</SelectItem>
                  <SelectItem value="2022-2023">2022-2023</SelectItem>
                  <SelectItem value="2021-2022">2021-2022</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <div className="space-y-2">
              <Label htmlFor="term-filter">Term</Label>
              <Select value={termFilter} onValueChange={setTermFilter}>
                <SelectTrigger id="term-filter">
                  <SelectValue placeholder="Select term" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="all">All Terms</SelectItem>
                  <SelectItem value="term1">Term 1</SelectItem>
                  <SelectItem value="term2">Term 2</SelectItem>
                  <SelectItem value="term3">Term 3</SelectItem>
                  <SelectItem value="term4">Term 4</SelectItem>
                  <SelectItem value="term5">Term 5</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <div className="space-y-2">
              <Label htmlFor="report-type">Report Type</Label>
              <Select value={reportType} onValueChange={setReportType}>
                <SelectTrigger id="report-type">
                  <SelectValue placeholder="Select report type" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="overview">Overview</SelectItem>
                  <SelectItem value="detailed">Detailed Analysis</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <div className="space-y-2 flex items-end">
              <Button className="w-full">
                <FileBarChart className="h-4 w-4 mr-2" />
                Generate Report
              </Button>
            </div>
          </div>
        </CardContent>
      </Card>

      {renderReportContent()}

      <Card>
        <CardHeader>
          <CardTitle className="text-lg">Export Options</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="flex flex-wrap gap-4">
            <Button variant="outline" onClick={() => handleDownload("pdf")}>
              <Download className="h-4 w-4 mr-2" />
              Download as PDF
            </Button>
            <Button variant="outline" onClick={() => handleDownload("excel")}>
              <Download className="h-4 w-4 mr-2" />
              Download as Excel
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  );
};

export default Reports;
