import React, { useState, useEffect } from 'react';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
} from '@/components/ui/dialog';
import { Badge } from '@/components/ui/badge';
import { studentDeedAPI, StudentDeed } from '@/lib/api';
import { useTerm } from '@/contexts/TermContext';
import { ThumbsUp, ThumbsDown, Calendar, User } from 'lucide-react';
import { format } from 'date-fns';
import { toast } from 'sonner';

interface ViewDeedsDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  studentId: string;
  studentName: string;
}

const ViewDeedsDialog: React.FC<ViewDeedsDialogProps> = ({
  open,
  onOpenChange,
  studentId,
  studentName,
}) => {
  const { selectedTerm, currentTerm } = useTerm();
  const activeTerm = selectedTerm || currentTerm;
  const [deeds, setDeeds] = useState<StudentDeed[]>([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (open && studentId) {
      fetchDeeds();
    }
  }, [open, studentId, activeTerm]);

  const fetchDeeds = async () => {
    try {
      setLoading(true);
      const response = await studentDeedAPI.getMyDeedsForStudent(
        studentId,
        activeTerm?.id
      );
      setDeeds(response.data || []);
    } catch (error) {
      console.error('Error fetching deeds:', error);
      toast.error('Failed to load deeds');
      setDeeds([]);
    } finally {
      setLoading(false);
    }
  };

  const totalGoodScore = deeds
    .filter(d => d.deed_type === 'good')
    .reduce((sum, d) => sum + parseFloat(d.score.toString()), 0);
  
  const totalBadScore = deeds
    .filter(d => d.deed_type === 'bad')
    .reduce((sum, d) => sum + parseFloat(d.score.toString()), 0);
  
  const netScore = totalGoodScore - totalBadScore;

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] max-h-[80vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle>My Deeds for {studentName}</DialogTitle>
          <DialogDescription>
            View all good and bad deeds you've recorded for this student
            {activeTerm && ` in ${activeTerm.name}`}
          </DialogDescription>
        </DialogHeader>

        {loading ? (
          <div className="text-center py-8 text-muted-foreground">
            Loading deeds...
          </div>
        ) : (
          <div className="space-y-4">
            {/* Summary */}
            <div className="grid grid-cols-3 gap-4 p-4 bg-muted/50 rounded-lg">
              <div className="text-center">
                <div className="text-sm text-muted-foreground">Good Deeds</div>
                <div className="text-2xl font-bold text-green-600">+{totalGoodScore.toFixed(1)}</div>
              </div>
              <div className="text-center">
                <div className="text-sm text-muted-foreground">Bad Deeds</div>
                <div className="text-2xl font-bold text-red-600">-{totalBadScore.toFixed(1)}</div>
              </div>
              <div className="text-center">
                <div className="text-sm text-muted-foreground">Net Impact</div>
                <div className={`text-2xl font-bold ${netScore >= 0 ? 'text-green-600' : 'text-red-600'}`}>
                  {netScore >= 0 ? '+' : ''}{netScore.toFixed(1)}
                </div>
              </div>
            </div>

            {/* Deeds List */}
            {deeds.length === 0 ? (
              <div className="text-center py-8 text-muted-foreground">
                No deeds recorded yet for this student
                {activeTerm && ` in ${activeTerm.name}`}
              </div>
            ) : (
              <div className="space-y-3">
                {deeds.map((deed) => (
                  <div
                    key={deed.id}
                    className={`p-4 rounded-lg border ${
                      deed.deed_type === 'good'
                        ? 'bg-green-50 border-green-200'
                        : 'bg-red-50 border-red-200'
                    }`}
                  >
                    <div className="flex items-start justify-between gap-3">
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
                            {deed.term && (
                              <span className="text-xs text-muted-foreground">
                                {deed.term.name}
                              </span>
                            )}
                          </div>
                          {deed.comment && (
                            <p className="text-sm text-muted-foreground mt-2">
                              {deed.comment}
                            </p>
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
          </div>
        )}
      </DialogContent>
    </Dialog>
  );
};

export default ViewDeedsDialog;

