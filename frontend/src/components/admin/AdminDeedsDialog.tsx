import React, { useEffect, useState } from "react";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { ScrollArea } from "@/components/ui/scroll-area";
import { adminAPI, StudentDeed } from "@/lib/api";
import { useTerm } from "@/contexts/TermContext";
import { toast } from "sonner";
import { ThumbsUp, ThumbsDown, Trash2, Calendar, User } from "lucide-react";
import { format } from "date-fns";
import { Select, SelectTrigger, SelectValue, SelectContent, SelectItem } from "@/components/ui/select";

interface AdminDeedsDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  studentId: string;
  studentName: string;
}

const AdminDeedsDialog: React.FC<AdminDeedsDialogProps> = ({
  open,
  onOpenChange,
  studentId,
  studentName
}) => {
  const { selectedTerm, currentTerm, availableTerms } = useTerm();
  const [termFilter, setTermFilter] = useState<string>("current");
  const [loading, setLoading] = useState(false);
  const [deeds, setDeeds] = useState<StudentDeed[]>([]);
  const activeTermId =
    termFilter === "all"
      ? undefined
      : termFilter === "current"
        ? (selectedTerm?.id || currentTerm?.id)
        : termFilter;

  useEffect(() => {
    if (open && studentId) {
      fetchDeeds();
    }
  }, [open, studentId, termFilter, selectedTerm, currentTerm]);

  const fetchDeeds = async () => {
    if (!studentId) return;
    try {
      setLoading(true);
      const response = await adminAPI.getStudentDeeds(studentId, activeTermId);
      setDeeds(response.data || []);
    } catch (error) {
      console.error("Failed to fetch deeds:", error);
      toast.error("Failed to load deeds");
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (e: React.MouseEvent<HTMLButtonElement>, deedId: string) => {
    e.preventDefault();
    e.stopPropagation();
    try {
      await adminAPI.deleteStudentDeed(deedId);
      toast.success("Deed deleted");
      await fetchDeeds();
    } catch (error) {
      console.error("Failed to delete deed:", error);
      toast.error(error instanceof Error ? error.message : "Failed to delete deed");
    }
  };

  const totalGood = deeds
    .filter((d) => d.deed_type === "good")
    .reduce((sum, d) => sum + parseFloat(d.score.toString()), 0);
  const totalBad = deeds
    .filter((d) => d.deed_type === "bad")
    .reduce((sum, d) => sum + parseFloat(d.score.toString()), 0);
  const netImpact = totalGood - totalBad;

  const renderTermSelect = () => {
    const options = [
      { value: "current", label: "Current Term" },
      { value: "all", label: "All Terms" },
      ...availableTerms.map((term) => ({ value: term.id, label: term.name }))
    ];

    return (
      <Select value={termFilter} onValueChange={setTermFilter}>
        <SelectTrigger className="w-[200px]">
          <SelectValue />
        </SelectTrigger>
        <SelectContent>
          {options.map((option) => (
            <SelectItem key={option.value} value={option.value}>
              {option.label}
            </SelectItem>
          ))}
        </SelectContent>
      </Select>
    );
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-2xl max-h-[80vh] flex flex-col">
        <DialogHeader>
          <DialogTitle>Deeds for {studentName}</DialogTitle>
          <DialogDescription>
            View deeds recorded by teachers. Deleting a deed will automatically recalculate the student's HPS.
          </DialogDescription>
        </DialogHeader>

        <div className="flex items-center justify-between gap-4 py-2">
          <div className="text-sm text-muted-foreground">
            Showing {activeTermId ? "selected term" : "all terms"} deeds
          </div>
          {renderTermSelect()}
        </div>

        <div className="grid grid-cols-3 gap-4 p-4 bg-muted/50 rounded-lg">
          <div className="text-center">
            <div className="text-sm text-muted-foreground">Good (+)</div>
            <div className="text-2xl font-bold text-green-600">+{totalGood.toFixed(1)}</div>
          </div>
          <div className="text-center">
            <div className="text-sm text-muted-foreground">Bad (-)</div>
            <div className="text-2xl font-bold text-red-600">-{totalBad.toFixed(1)}</div>
          </div>
          <div className="text-center">
            <div className="text-sm text-muted-foreground">Net Impact</div>
            <div className={`text-2xl font-bold ${netImpact >= 0 ? "text-green-600" : "text-red-600"}`}>
              {netImpact >= 0 ? "+" : ""}
              {netImpact.toFixed(1)}
            </div>
          </div>
        </div>

        <ScrollArea className="flex-1 mt-4">
          {loading ? (
            <div className="text-center py-8 text-muted-foreground">Loading deeds...</div>
          ) : deeds.length === 0 ? (
            <div className="text-center py-8 text-muted-foreground">
              No deeds recorded for the selected term.
            </div>
          ) : (
            <div className="space-y-3 pr-2">
              {deeds.map((deed) => (
                <div
                  key={deed.id}
                  className={`p-4 rounded-lg border ${
                    deed.deed_type === "good"
                      ? "bg-green-50 border-green-200"
                      : "bg-red-50 border-red-200"
                  }`}
                >
                  <div className="flex items-start justify-between gap-3">
                    <div className="flex items-start gap-3 flex-1">
                      {deed.deed_type === "good" ? (
                        <ThumbsUp className="h-5 w-5 text-green-600 mt-0.5 flex-shrink-0" />
                      ) : (
                        <ThumbsDown className="h-5 w-5 text-red-600 mt-0.5 flex-shrink-0" />
                      )}
                      <div className="flex-1">
                        <div className="flex items-center gap-2 mb-1">
                          <Badge variant={deed.deed_type === "good" ? "default" : "destructive"}>
                            {deed.deed_type === "good" ? "+" : "-"}
                            {parseFloat(deed.score.toString()).toFixed(1)}
                          </Badge>
                          {deed.teacher && (
                            <span className="text-xs text-muted-foreground flex items-center gap-1">
                              <User className="h-3 w-3" />
                              {deed.teacher.name}
                            </span>
                          )}
                          {deed.term && (
                            <Badge variant="outline" className="text-xs">
                              {deed.term.name}
                            </Badge>
                          )}
                        </div>
                        {deed.comment && (
                          <p className="text-sm text-muted-foreground mb-2">{deed.comment}</p>
                        )}
                        <div className="flex items-center gap-2 text-xs text-muted-foreground">
                          <Calendar className="h-3 w-3" />
                          {format(new Date(deed.created_at), "MMM dd, yyyy HH:mm")}
                        </div>
                      </div>
                    </div>
                    <Button
                      variant="ghost"
                      size="sm"
                      className="text-red-600"
                      onClick={(e) => handleDelete(e, deed.id)}
                    >
                      <Trash2 className="h-4 w-4" />
                    </Button>
                  </div>
                </div>
              ))}
            </div>
          )}
        </ScrollArea>

        <div className="flex justify-end">
          <Button variant="outline" onClick={() => onOpenChange(false)}>
            Close
          </Button>
        </div>
      </DialogContent>
    </Dialog>
  );
};

export default AdminDeedsDialog;

