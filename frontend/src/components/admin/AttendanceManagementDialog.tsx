import React, { useState, useEffect } from 'react';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { 
  Calendar, 
  CheckCircle2, 
  XCircle, 
  Clock, 
  Users, 
  TrendingUp,
  Plus,
  Save,
  RotateCcw
} from 'lucide-react';
import { toast } from 'sonner';
import { attendanceAPI } from '@/lib/api';

interface Student {
  id: string;
  name: string;
  registration_no: string;
}

interface Term {
  id: string;
  name: string;
  start_date: string;
  end_date: string;
}

interface Quadrant {
  id: string;
  name: string;
  description: string;
}

interface AttendanceManagementDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  student: Student | null;
  selectedTerm: Term | null;
}

interface AttendanceStat {
  quadrant_id: string;
  quadrant_name: string;
  total_marked_days: number;
  present_days: number;
  absent_days: number;
  attendance_percentage: number;
  first_marked_date: string;
  last_marked_date: string;
}

interface BulkAttendanceRecord {
  attendanceDate: string;
  isPresent: boolean;
  reason?: string;
}

const AttendanceManagementDialog: React.FC<AttendanceManagementDialogProps> = ({
  open,
  onOpenChange,
  student,
  selectedTerm
}) => {
  const [activeTab, setActiveTab] = useState('overview');
  const [attendanceStats, setAttendanceStats] = useState<AttendanceStat[]>([]);
  const [loading, setLoading] = useState(false);
  const [selectedQuadrant, setSelectedQuadrant] = useState<string>('');
  const [markingMode, setMarkingMode] = useState<'single' | 'bulk'>('single');
  
  // Bulk marking state
  const [bulkStartDate, setBulkStartDate] = useState('');
  const [bulkEndDate, setBulkEndDate] = useState('');
  const [bulkAttendanceType, setBulkAttendanceType] = useState<'present' | 'absent'>('present');
  const [bulkReason, setBulkReason] = useState('');

  // Quadrants (hardcoded for now, could be fetched from API)
  const quadrants: Quadrant[] = [
    { id: 'persona', name: 'Persona', description: 'SHL Competencies and Professional Readiness' },
    { id: 'wellness', name: 'Wellness', description: 'Physical, Mental, and Social Wellness' },
    { id: 'behavior', name: 'Behavior', description: 'Professional Conduct and Interpersonal Skills' },
    { id: 'discipline', name: 'Discipline', description: 'Attendance, Code of Conduct, and Academic Discipline' }
  ];

  // Fetch attendance data when dialog opens
  useEffect(() => {
    if (open && student && selectedTerm) {
      fetchAttendanceData();
    }
  }, [open, student, selectedTerm]);

  const fetchAttendanceData = async () => {
    if (!student || !selectedTerm) return;

    setLoading(true);
    try {
      const statsResponse = await attendanceAPI.getStudentAttendanceStats(student.id, selectedTerm.id);
      
      if (statsResponse.success) {
        setAttendanceStats(statsResponse.data);
      } else {
        console.error('Failed to fetch attendance stats');
        toast.error('Failed to load attendance data');
      }
    } catch (error) {
      console.error('Error fetching attendance data:', error);
      toast.error('Error loading attendance data');
    } finally {
      setLoading(false);
    }
  };

  const handleBulkMarkAttendance = async () => {
    if (!student || !selectedTerm || !selectedQuadrant || !bulkStartDate || !bulkEndDate) {
      toast.error('Please fill in all required fields');
      return;
    }

    if (bulkStartDate > bulkEndDate) {
      toast.error('Start date must be before end date');
      return;
    }

    setLoading(true);
    try {
      // Generate date range
      const attendanceRecords: BulkAttendanceRecord[] = [];
      const currentDate = new Date(bulkStartDate);
      const endDate = new Date(bulkEndDate);

      while (currentDate <= endDate) {
        // Skip weekends (optional - you can remove this if weekend attendance is needed)
        const dayOfWeek = currentDate.getDay();
        if (dayOfWeek !== 0 && dayOfWeek !== 6) { // 0 = Sunday, 6 = Saturday
          attendanceRecords.push({
            attendanceDate: currentDate.toISOString().split('T')[0],
            isPresent: bulkAttendanceType === 'present',
            reason: bulkAttendanceType === 'absent' ? bulkReason : undefined
          });
        }
        currentDate.setDate(currentDate.getDate() + 1);
      }

      const response = await attendanceAPI.bulkMarkStudentAttendance(student.id, {
        termId: selectedTerm.id,
        quadrantId: selectedQuadrant,
        attendanceRecords
      });

      if (response.success) {
        toast.success(`Attendance marked successfully! ${response.data.successCount} records processed.`);
        if (response.data.errorCount > 0) {
          toast.warning(`${response.data.errorCount} records had errors.`);
        }
        
        // Reset form and refresh data
        setBulkStartDate('');
        setBulkEndDate('');
        setBulkReason('');
        await fetchAttendanceData();
      } else {
        toast.error('Failed to mark attendance');
      }
    } catch (error) {
      console.error('Error marking bulk attendance:', error);
      toast.error('Error marking attendance');
    } finally {
      setLoading(false);
    }
  };

  const getAttendanceStatusColor = (percentage: number) => {
    if (percentage >= 85) return 'text-green-600 bg-green-50';
    if (percentage >= 75) return 'text-yellow-600 bg-yellow-50';
    return 'text-red-600 bg-red-50';
  };

  const getAttendanceStatusBadge = (percentage: number) => {
    if (percentage >= 85) return <Badge variant="default" className="bg-green-500">Excellent</Badge>;
    if (percentage >= 75) return <Badge variant="secondary" className="bg-yellow-500">Adequate</Badge>;
    return <Badge variant="destructive">Below Required</Badge>;
  };

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString();
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-4xl max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2">
            <Users className="h-5 w-5" />
            Attendance Management - {student?.name} ({student?.registration_no})
          </DialogTitle>
          <p className="text-sm text-muted-foreground">
            Term: {selectedTerm?.name} | Managing attendance across all quadrants
          </p>
        </DialogHeader>

        <Tabs value={activeTab} onValueChange={setActiveTab}>
          <TabsList className="grid w-full grid-cols-3">
            <TabsTrigger value="overview">Overview</TabsTrigger>
            <TabsTrigger value="mark-attendance">Mark Attendance</TabsTrigger>
            <TabsTrigger value="history">History</TabsTrigger>
          </TabsList>

          <TabsContent value="overview" className="space-y-4">
            {loading ? (
              <div className="flex justify-center items-center h-32">
                <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
              </div>
            ) : (
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                {attendanceStats.length === 0 ? (
                  <div className="col-span-2 text-center py-8 text-muted-foreground">
                    <Calendar className="h-12 w-12 mx-auto mb-4 opacity-50" />
                    <p>No attendance data available for this student in the selected term.</p>
                    <Button 
                      onClick={() => setActiveTab('mark-attendance')} 
                      className="mt-4"
                      variant="outline"
                    >
                      Start Marking Attendance
                    </Button>
                  </div>
                ) : (
                  attendanceStats.map((stat) => (
                    <Card key={stat.quadrant_id}>
                      <CardHeader className="pb-3">
                        <CardTitle className="flex items-center justify-between text-base">
                          {stat.quadrant_name}
                          {getAttendanceStatusBadge(stat.attendance_percentage)}
                        </CardTitle>
                      </CardHeader>
                      <CardContent>
                        <div className="space-y-2">
                          <div className={`text-2xl font-bold p-2 rounded ${getAttendanceStatusColor(stat.attendance_percentage)}`}>
                            {stat.attendance_percentage.toFixed(1)}%
                          </div>
                          
                          <div className="grid grid-cols-2 gap-2 text-sm">
                            <div className="flex items-center gap-1">
                              <CheckCircle2 className="h-4 w-4 text-green-500" />
                              <span>Present: {stat.present_days}</span>
                            </div>
                            <div className="flex items-center gap-1">
                              <XCircle className="h-4 w-4 text-red-500" />
                              <span>Absent: {stat.absent_days}</span>
                            </div>
                          </div>

                          <div className="text-xs text-muted-foreground">
                            <div>Total Days: {stat.total_marked_days}</div>
                            {stat.first_marked_date && stat.last_marked_date && (
                              <div>
                                Period: {formatDate(stat.first_marked_date)} to {formatDate(stat.last_marked_date)}
                              </div>
                            )}
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                  ))
                )}
              </div>
            )}
          </TabsContent>

          <TabsContent value="mark-attendance" className="space-y-4">
            <div className="space-y-4">
              <div>
                <Label htmlFor="quadrant">Select Quadrant *</Label>
                <Select value={selectedQuadrant} onValueChange={setSelectedQuadrant}>
                  <SelectTrigger>
                    <SelectValue placeholder="Choose a quadrant to mark attendance for" />
                  </SelectTrigger>
                  <SelectContent>
                    {quadrants.map((quadrant) => (
                      <SelectItem key={quadrant.id} value={quadrant.id}>
                        {quadrant.name} - {quadrant.description}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>

              <div className="flex gap-2">
                <Button
                  variant={markingMode === 'single' ? 'default' : 'outline'}
                  onClick={() => setMarkingMode('single')}
                  size="sm"
                >
                  Single Day
                </Button>
                <Button
                  variant={markingMode === 'bulk' ? 'default' : 'outline'}
                  onClick={() => setMarkingMode('bulk')}
                  size="sm"
                >
                  Bulk Mark (Date Range)
                </Button>
              </div>

              {markingMode === 'bulk' && (
                <Card>
                  <CardHeader>
                    <CardTitle className="text-base">Bulk Mark Attendance</CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-4">
                    <div className="grid grid-cols-2 gap-4">
                      <div>
                        <Label htmlFor="start-date">Start Date *</Label>
                        <Input
                          id="start-date"
                          type="date"
                          value={bulkStartDate}
                          onChange={(e) => setBulkStartDate(e.target.value)}
                          max={new Date().toISOString().split('T')[0]}
                        />
                      </div>
                      <div>
                        <Label htmlFor="end-date">End Date *</Label>
                        <Input
                          id="end-date"
                          type="date"
                          value={bulkEndDate}
                          onChange={(e) => setBulkEndDate(e.target.value)}
                          max={new Date().toISOString().split('T')[0]}
                          min={bulkStartDate}
                        />
                      </div>
                    </div>

                    <div>
                      <Label>Attendance Status *</Label>
                      <Select 
                        value={bulkAttendanceType} 
                        onValueChange={(value: 'present' | 'absent') => setBulkAttendanceType(value)}
                      >
                        <SelectTrigger>
                          <SelectValue />
                        </SelectTrigger>
                        <SelectContent>
                          <SelectItem value="present">Mark as Present</SelectItem>
                          <SelectItem value="absent">Mark as Absent</SelectItem>
                        </SelectContent>
                      </Select>
                    </div>

                    {bulkAttendanceType === 'absent' && (
                      <div>
                        <Label htmlFor="bulk-reason">Reason for Absence</Label>
                        <Textarea
                          id="bulk-reason"
                          placeholder="Enter reason for absence (optional)"
                          value={bulkReason}
                          onChange={(e) => setBulkReason(e.target.value)}
                          rows={2}
                        />
                      </div>
                    )}

                    <div className="flex gap-2">
                      <Button
                        onClick={handleBulkMarkAttendance}
                        disabled={loading || !selectedQuadrant || !bulkStartDate || !bulkEndDate}
                        className="flex items-center gap-2"
                      >
                        {loading ? (
                          <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
                        ) : (
                          <Save className="h-4 w-4" />
                        )}
                        Mark Attendance
                      </Button>
                      <Button
                        variant="outline"
                        onClick={() => {
                          setBulkStartDate('');
                          setBulkEndDate('');
                          setBulkReason('');
                          setBulkAttendanceType('present');
                        }}
                      >
                        <RotateCcw className="h-4 w-4 mr-2" />
                        Reset
                      </Button>
                    </div>

                    <div className="text-sm text-muted-foreground">
                      <p><strong>Note:</strong> Weekends (Saturday & Sunday) are automatically excluded.</p>
                      <p>Existing attendance records for the same dates will be updated.</p>
                    </div>
                  </CardContent>
                </Card>
              )}
            </div>
          </TabsContent>

          <TabsContent value="history" className="space-y-4">
            <div className="text-center py-8 text-muted-foreground">
              <Clock className="h-12 w-12 mx-auto mb-4 opacity-50" />
              <p>Detailed attendance history will be available in the next update.</p>
              <p className="text-sm">Use the Overview tab to see current statistics.</p>
            </div>
          </TabsContent>
        </Tabs>
      </DialogContent>
    </Dialog>
  );
};

export default AttendanceManagementDialog;


