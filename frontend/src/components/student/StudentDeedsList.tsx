import React, { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { studentDeedAPI, StudentDeed } from '@/lib/api';
import { useTerm } from '@/contexts/TermContext';
import { ThumbsUp, ThumbsDown, Calendar } from 'lucide-react';
import { format } from 'date-fns';

interface StudentDeedsListProps {
  studentId: string;
}

const StudentDeedsList: React.FC<StudentDeedsListProps> = ({ studentId }) => {
  const { selectedTerm, currentTerm } = useTerm();
  const activeTerm = selectedTerm || currentTerm;
  const [deeds, setDeeds] = useState<StudentDeed[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (activeTerm) {
      fetchDeeds();
    }
  }, [activeTerm, studentId]);

  const fetchDeeds = async () => {
    if (!activeTerm) return;
    try {
      setLoading(true);
      const response = await studentDeedAPI.getOwnDeeds(activeTerm.id);
      setDeeds(response.data || []);
    } catch (error) {
      console.error('Error fetching deeds:', error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <div className="text-center py-8 text-muted-foreground">
        Loading deeds...
      </div>
    );
  }

  const goodDeeds = deeds.filter(d => d.deed_type === 'good');
  const badDeeds = deeds.filter(d => d.deed_type === 'bad');
  const netScore = deeds.reduce((sum, deed) => {
    return sum + (deed.deed_type === 'good' ? parseFloat(deed.score.toString()) : -parseFloat(deed.score.toString()));
  }, 0);

  return (
    <Card>
      <CardHeader>
        <CardTitle>My Good & Bad Deeds</CardTitle>
        <div className="flex items-center gap-4 mt-2">
          <Badge variant="default" className="bg-green-100 text-green-800">
            Good: +{goodDeeds.reduce((sum, d) => sum + parseFloat(d.score.toString()), 0).toFixed(1)}
          </Badge>
          <Badge variant="destructive">
            Bad: -{badDeeds.reduce((sum, d) => sum + parseFloat(d.score.toString()), 0).toFixed(1)}
          </Badge>
          <Badge variant={netScore >= 0 ? "default" : "destructive"}>
            Net Impact: {netScore >= 0 ? '+' : ''}{netScore.toFixed(1)} HPS
          </Badge>
        </div>
      </CardHeader>
      <CardContent>
        {deeds.length === 0 ? (
          <p className="text-muted-foreground text-center py-8">
            No deeds recorded yet
          </p>
        ) : (
          <div className="space-y-4">
            {deeds.map((deed) => (
              <div
                key={deed.id}
                className={`p-4 rounded-lg border ${
                  deed.deed_type === 'good'
                    ? 'bg-green-50 border-green-200'
                    : 'bg-red-50 border-red-200'
                }`}
              >
                <div className="flex items-start justify-between">
                  <div className="flex items-start gap-3 flex-1">
                    {deed.deed_type === 'good' ? (
                      <ThumbsUp className="h-5 w-5 text-green-600 mt-0.5 flex-shrink-0" />
                    ) : (
                      <ThumbsDown className="h-5 w-5 text-red-600 mt-0.5 flex-shrink-0" />
                    )}
                    <div className="flex-1">
                      <div className="flex items-center gap-2 mb-1">
                        <Badge
                          variant={
                            deed.deed_type === 'good' ? 'default' : 'destructive'
                          }
                        >
                          {deed.deed_type === 'good' ? '+' : '-'}
                          {deed.score}
                        </Badge>
                        <span className="text-sm font-medium">
                          {deed.teacher?.name || 'Unknown Teacher'}
                        </span>
                      </div>
                      {deed.comment && (
                        <p className="text-sm text-muted-foreground mt-2">{deed.comment}</p>
                      )}
                      <div className="flex items-center gap-2 mt-2 text-xs text-muted-foreground">
                        <Calendar className="h-3 w-3" />
                        {format(new Date(deed.created_at), 'MMM dd, yyyy HH:mm')}
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}
      </CardContent>
    </Card>
  );
};

export default StudentDeedsList;

