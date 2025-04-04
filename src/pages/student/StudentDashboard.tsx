
import React from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import ScoreRing from "@/components/common/ScoreRing";
import QuadrantCard from "@/components/common/QuadrantCard";
import LeaderboardCard from "@/components/common/LeaderboardCard";
import { studentData, leaderboardData } from "@/data/mockData";
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from "recharts";
import StatusBadge from "@/components/common/StatusBadge";

const StudentDashboard: React.FC = () => {
  const { quadrants, totalScore, overallStatus } = studentData;
  const { overall: overallLeaderboard } = leaderboardData;

  const summaryMetrics = [
    { label: "Previous Avg Score", value: 88, maxValue: 100 },
    { label: "Previous Best Score", value: 92, maxValue: 100 },
    { label: "Batch Avg Score", value: overallLeaderboard.batchAvg, maxValue: 100 },
    { label: "Batch Best Score", value: overallLeaderboard.batchBest, maxValue: 100 },
  ];

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold mb-1">Student Dashboard</h1>
        <p className="text-muted-foreground">
          Welcome back, {studentData.name}! Here's your latest PEP performance.
        </p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <Card className="md:col-span-1 flex flex-col items-center justify-center py-6">
          <h2 className="text-lg font-medium mb-4">Overall HPS Score</h2>
          <ScoreRing score={totalScore} maxScore={100} size="lg" />
          <div className="mt-4 flex items-center">
            <span className="mr-2">Status:</span>
            <StatusBadge status={overallStatus} />
          </div>
        </Card>

        <Card className="md:col-span-3">
          <CardHeader className="pb-2">
            <CardTitle className="text-lg">Score Progress</CardTitle>
          </CardHeader>
          <CardContent className="h-[230px]">
            <ResponsiveContainer width="100%" height="100%">
              <LineChart
                data={[
                  { month: "Jan", score: 75 },
                  { month: "Feb", score: 80 },
                  { month: "Mar", score: 86 },
                  { month: "Apr", score: 90 },
                  { month: "May", score: 95 },
                ]}
                margin={{ top: 10, right: 30, left: 0, bottom: 0 }}
              >
                <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                <XAxis dataKey="month" />
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

      <h2 className="text-xl font-semibold mt-8">Quadrant Scores</h2>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {quadrants.map((quadrant, index) => (
          <QuadrantCard
            key={quadrant.id}
            quadrant={quadrant}
            batchAvg={leaderboardData.quadrants[quadrant.id].batchAvg}
            batchBest={leaderboardData.quadrants[quadrant.id].batchBest}
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

      <div className="mt-8">
        <LeaderboardCard
          leaders={overallLeaderboard.topStudents}
          userRank={overallLeaderboard.userRank}
          maxScore={100}
          className="max-w-md mx-auto"
        />
      </div>
    </div>
  );
};

export default StudentDashboard;
