import React, { useState } from 'react';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
  DialogDescription,
} from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Label } from '@/components/ui/label';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { studentDeedAPI } from '@/lib/api';
import { useTerm } from '@/contexts/TermContext';
import { toast } from 'sonner';
import { ThumbsUp, ThumbsDown } from 'lucide-react';

interface AddDeedDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  studentId: string;
  studentName: string;
  onSuccess?: () => void;
}

const AddDeedDialog: React.FC<AddDeedDialogProps> = ({
  open,
  onOpenChange,
  studentId,
  studentName,
  onSuccess,
}) => {
  const { selectedTerm } = useTerm();
  const [deedType, setDeedType] = useState<'good' | 'bad'>('good');
  const [score, setScore] = useState<string>('0');
  const [comment, setComment] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async () => {
    if (!selectedTerm || !selectedTerm.id) {
      toast.error('Please select a term');
      return;
    }

    if (!studentId) {
      toast.error('Student ID is missing');
      return;
    }

    const scoreNum = parseFloat(score);
    if (isNaN(scoreNum) || scoreNum < 0 || scoreNum > 5) {
      toast.error('Score must be between 0 and 5');
      return;
    }

    try {
      setLoading(true);
      const response = await studentDeedAPI.addDeed(studentId, {
        termId: selectedTerm.id,
        deedType,
        score: scoreNum,
        comment: comment.trim() || undefined,
      });

      toast.success(
        `${deedType === 'good' ? 'Good' : 'Bad'} deed added successfully. HPS updated.`
      );
      setDeedType('good');
      setScore('0');
      setComment('');
      onOpenChange(false);
      onSuccess?.();
    } catch (error) {
      toast.error(
        error instanceof Error
          ? error.message
          : 'Failed to add deed'
      );
    } finally {
      setLoading(false);
    }
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[500px]">
        <DialogHeader>
          <DialogTitle>
            Add {deedType === 'good' ? 'Good' : 'Bad'} Deed
          </DialogTitle>
          <DialogDescription>
            Assign a positive or negative deed score (0-5) that adjusts the student's final HPS for the selected term.
          </DialogDescription>
        </DialogHeader>

        <div className="space-y-4 py-4">
          <div>
            <Label className="text-sm font-medium">Student</Label>
            <p className="text-sm text-muted-foreground mt-1">{studentName}</p>
          </div>

          <div>
            <Label htmlFor="deed-type">Deed Type *</Label>
            <Select
              value={deedType}
              onValueChange={(value) => setDeedType(value as 'good' | 'bad')}
            >
              <SelectTrigger id="deed-type">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="good">
                  <div className="flex items-center gap-2">
                    <ThumbsUp className="h-4 w-4 text-green-600" />
                    <span>Good Deed (+)</span>
                  </div>
                </SelectItem>
                <SelectItem value="bad">
                  <div className="flex items-center gap-2">
                    <ThumbsDown className="h-4 w-4 text-red-600" />
                    <span>Bad Deed (-)</span>
                  </div>
                </SelectItem>
              </SelectContent>
            </Select>
          </div>

          <div>
            <Label htmlFor="score">Score (0-5) *</Label>
            <Input
              id="score"
              type="number"
              min="0"
              max="5"
              step="0.1"
              value={score}
              onChange={(e) => setScore(e.target.value)}
              placeholder="Enter score"
            />
            <p className="text-xs text-muted-foreground mt-1">
              {deedType === 'good'
                ? 'This score will be added to the student\'s final HPS'
                : 'This score will be subtracted from the student\'s final HPS'}
            </p>
          </div>

          <div>
            <Label htmlFor="comment">Comment (Optional)</Label>
            <Textarea
              id="comment"
              value={comment}
              onChange={(e) => setComment(e.target.value)}
              placeholder="Add a comment describing the deed..."
              rows={4}
            />
          </div>
        </div>

        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)}>
            Cancel
          </Button>
          <Button onClick={handleSubmit} disabled={loading}>
            {loading ? 'Adding...' : 'Add Deed'}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
};

export default AddDeedDialog;

