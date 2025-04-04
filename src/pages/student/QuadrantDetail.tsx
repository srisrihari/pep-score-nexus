
import React from "react";
import { useParams, useNavigate } from "react-router-dom";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import StatusBadge from "@/components/common/StatusBadge";
import LeaderboardCard from "@/components/common/LeaderboardCard";
import { studentData, leaderboardData, timeSeriesData } from "@/data/mockData";
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
} from "recharts";
import { ArrowLeft } from "lucide-react";

const QuadrantDetail: React.FC = () => {
  const { quadrantId } = useParams<{ quadrantId: string }>();
  const navigate = useNavigate();

  const quadrant = studentData.quadrants.find((q) => q.id === quadrantId);
  const leaderboard = leaderboardData.quadrants[quadrantId || ""];
  const chartData = timeSeriesData[quadrantId as keyof typeof timeSeriesData] || [];

  if (!quadrant || !leaderboard) {
    return (
      <div className="flex flex-col items-center justify-center h-screen">
        <h1 className="text-2xl font-bold mb-4">Quadrant not found</h1>
        <Button onClick={() => navigate("/student")}>Back to Dashboard</Button>
      </div>
    );
  }

  const getGradientClass = () => {
    switch (quadrantId) {
      case "persons":
        return "card-gradient-primary";
      case "wellness":
        return "card-gradient-secondary";
      case "behavior":
        return "card-gradient-indigo";
      case "discipline":
        return "card-gradient-purple";
      default:
        return "card-gradient-primary";
    }
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
          <h1 className="text-2xl font-bold">{quadrant.name} Quadrant</h1>
          <p className="text-muted-foreground">
            Detailed breakdown of your performance in {quadrant.name.toLowerCase()}
          </p>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <Card className={`col-span-1 ${getGradientClass()} text-white`}>
          <CardContent className="pt-6">
            <div className="text-center">
              <h2 className="text-xl font-bold mb-1">Your Score</h2>
              <div className="text-4xl font-bold mb-4">
                {quadrant.obtained}/{quadrant.weightage}
              </div>
              <div className="inline-flex">
                <StatusBadge 
                  status={quadrant.status} 
                  className="border border-white/20" 
                />
              </div>
            </div>

            <div className="mt-4 pt-4 border-t border-white/20">
              <div className="grid grid-cols-2 gap-2">
                <div>
                  <p className="text-xs text-white/70">Batch Average</p>
                  <p className="font-bold">{leaderboard.batchAvg}/{quadrant.weightage}</p>
                </div>
                <div>
                  <p className="text-xs text-white/70">Batch Best</p>
                  <p className="font-bold">{leaderboard.batchBest}/{quadrant.weightage}</p>
                </div>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card className="md:col-span-2">
          <CardHeader className="pb-2">
            <CardTitle className="text-lg">Progress Over Time</CardTitle>
          </CardHeader>
          <CardContent className="h-[220px]">
            <ResponsiveContainer width="100%" height="100%">
              <LineChart
                data={chartData}
                margin={{ top: 10, right: 30, left: 0, bottom: 0 }}
              >
                <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                <XAxis dataKey="month" />
                <YAxis domain={[0, quadrant.weightage]} />
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

      <h2 className="text-xl font-semibold mt-8">Component Breakdown</h2>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        {quadrant.components.map((component) => (
          <Card key={component.id}>
            <CardContent className="pt-6">
              <div className="flex justify-between items-start mb-2">
                <h3 className="font-medium">{component.name}</h3>
                {component.status && (
                  <StatusBadge status={component.status} />
                )}
              </div>
              <div className="mt-2">
                <div className="flex justify-between text-sm mb-1">
                  <span>Score</span>
                  <span className="font-bold">
                    {component.score}/{component.maxScore}
                  </span>
                </div>
                <div className="w-full bg-muted h-2 rounded-full overflow-hidden">
                  <div
                    className="h-full bg-primary rounded-full"
                    style={{
                      width: `${(component.score / component.maxScore) * 100}%`,
                    }}
                  />
                </div>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      <div className="mt-8 grid grid-cols-1 md:grid-cols-2 gap-6">
        <LeaderboardCard
          leaders={leaderboard.topStudents}
          userRank={leaderboard.userRank}
          maxScore={quadrant.weightage}
        />
        
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-lg">Improvement Tips</CardTitle>
          </CardHeader>
          <CardContent>
            <ul className="space-y-2">
              {quadrant.components
                .filter(c => c.status === "Progress" || c.status === "Deteriorate")
                .slice(0, 3)
                .map(component => (
                  <li key={component.id} className="flex items-start gap-2">
                    <div className={`w-2 h-2 mt-2 rounded-full ${component.status === 'Deteriorate' ? 'bg-red-500' : 'bg-yellow-500'}`}></div>
                    <p>
                      <span className="font-medium">{component.name}:</span>{" "}
                      {component.status === "Deteriorate"
                        ? `Focus on improving your ${component.name.toLowerCase()} skills as this area shows significant decline.`
                        : `Continue working on your ${component.name.toLowerCase()} abilities to reach the optimal score.`}
                    </p>
                  </li>
                ))}
                
                {quadrant.components.filter(c => c.status === "Progress" || c.status === "Deteriorate").length === 0 && (
                  <li className="text-green-600 flex items-center gap-2">
                    <div className="w-2 h-2 mt-1 rounded-full bg-green-500"></div>
                    <p>All components are in good standing. Keep up the excellent work!</p>
                  </li>
                )}
            </ul>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default QuadrantDetail;
