import React, { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from "@/components/ui/dialog";
import { Badge } from "@/components/ui/badge";
import { toast } from "sonner";
import { Upload, Download, FileText, Users, CheckCircle, AlertCircle, X } from "lucide-react";
import { uploadAPI, adminAPI, apiRequest } from "@/lib/api";

interface StudentPreview {
  rowNumber: number;
  name: string;
  email: string;
  registration_no: string;
  phone?: string;
  gender: string;
}

interface PreviewData {
  totalRows: number;
  validRows: number;
  invalidRows: number;
  errors: string[];
  students: StudentPreview[];
  tempFileId: string;
}

interface BatchAssignment {
  batchId: string;
  sectionId: string;
  course: string;
}

interface EnhancedStudentImportProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  onImportComplete: () => void;
}

interface BatchOption {
  id: string;
  name: string;
}

interface SectionOption {
  id: string;
  name: string;
}

const EnhancedStudentImport: React.FC<EnhancedStudentImportProps> = ({
  open,
  onOpenChange,
  onImportComplete
}) => {
  const [step, setStep] = useState<1 | 2>(1);
  const [selectedFile, setSelectedFile] = useState<File | null>(null);
  const [previewData, setPreviewData] = useState<PreviewData | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [isImporting, setIsImporting] = useState(false);
  
  // Batch assignment form data
  const [batchAssignment, setBatchAssignment] = useState<BatchAssignment>({
    batchId: '',
    sectionId: '',
    course: ''
  });
  
  // Options data
  const [batches, setBatches] = useState<BatchOption[]>([]);
  const [sections, setSections] = useState<SectionOption[]>([]);
  const [courses, setCourses] = useState<string[]>([]);
  const [loadingOptions, setLoadingOptions] = useState(false);

  // Load batches and sections when component opens
  React.useEffect(() => {
    if (open && step === 2) {
      loadOptions();
    }
  }, [open, step]);

  const loadOptions = async () => {
    setLoadingOptions(true);
    try {
      // Use the same APIs as the management dialogs for consistency
      const [filterOptionsResponse, coursesResponse] = await Promise.all([
        adminAPI.getStudentFilterOptions(), // For batches and sections
        apiRequest('/api/v1/admin/course-management/courses', { method: 'GET' }) // For courses (same as CourseManagementDialog)
      ]);

      if (filterOptionsResponse.success) {
        const { batches, sections } = filterOptionsResponse.data;
        setBatches(batches || []);
        setSections(sections || []);
      }

      // Extract course names from the course management API
      if (coursesResponse.data && Array.isArray(coursesResponse.data)) {
        const courseNames = coursesResponse.data
          .filter(course => course.is_active) // Only show active courses
          .map(course => course.name);
        setCourses(courseNames);
      }
    } catch (error) {
      console.error('Error loading options:', error);
      toast.error('Failed to load course, batch, and section options');
    } finally {
      setLoadingOptions(false);
    }
  };

  const handleFileChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (file) {
      // Validate file type
      const allowedTypes = [
        'application/vnd.ms-excel',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      ];
      
      if (!allowedTypes.includes(file.type)) {
        toast.error('Please select a valid Excel file (.xls or .xlsx)');
        return;
      }
      
      setSelectedFile(file);
    }
  };

  const handlePreviewUpload = async () => {
    if (!selectedFile) {
      toast.error('Please select a file first');
      return;
    }

    setIsLoading(true);
    try {
      const formData = new FormData();
      formData.append('file', selectedFile);
      formData.append('importType', 'students');

      const response = await uploadAPI.previewExcelData(formData);

      if (response.success) {
        setPreviewData(response.data);
        setStep(2);
        toast.success(`Excel file processed: ${response.data.validRows} valid students found`);
      } else {
        toast.error('Failed to preview Excel file');
      }
    } catch (error: any) {
      console.error('Error previewing file:', error);
      toast.error(error.message || 'Failed to preview Excel file');
    } finally {
      setIsLoading(false);
    }
  };

  const handleImport = async () => {
    if (!previewData || !batchAssignment.batchId || !batchAssignment.sectionId || !batchAssignment.course) {
      toast.error('Please fill in all required fields');
      return;
    }

    setIsImporting(true);
    try {
      const response = await uploadAPI.importExcelData({
        tempFileId: previewData.tempFileId,
        batchAssignment
      });

      if (response.success) {
        toast.success(
          `Import completed! ${response.data.successCount}/${response.data.totalRows} students imported successfully`
        );
        
        if (response.data.errorCount > 0) {
          console.warn('Import errors:', response.data.errors);
          toast.warning(`${response.data.errorCount} students failed to import. Check console for details.`);
        }
        
        onImportComplete();
        handleReset();
        onOpenChange(false);
      } else {
        toast.error('Import failed');
      }
    } catch (error: any) {
      console.error('Error importing students:', error);
      toast.error(error.message || 'Failed to import students');
    } finally {
      setIsImporting(false);
    }
  };

  const handleReset = () => {
    setStep(1);
    setSelectedFile(null);
    setPreviewData(null);
    setBatchAssignment({ batchId: '', sectionId: '', course: '' });
  };

  const downloadTemplate = () => {
    // Create a simple CSV template
    const headers = ['name', 'email', 'registration_no', 'phone', 'gender'];
    const sampleData = [
      'John Doe,john.doe@example.com,REG001,1234567890,male',
      'Jane Smith,jane.smith@example.com,REG002,0987654321,female'
    ];
    
    const csvContent = [headers.join(','), ...sampleData].join('\n');
    const blob = new Blob([csvContent], { type: 'text/csv' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'student_import_template.csv';
    a.click();
    window.URL.revokeObjectURL(url);
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-4xl max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2">
            <Upload className="h-5 w-5" />
            Enhanced Student Import
          </DialogTitle>
          <DialogDescription>
            {step === 1 
              ? "Upload an Excel file with basic student information (name, email, registration_no, phone, gender)"
              : "Review students and assign batch, section, and course"
            }
          </DialogDescription>
        </DialogHeader>

        {step === 1 && (
          <div className="space-y-6">
            {/* File Upload Section */}
            <Card>
              <CardHeader>
                <CardTitle className="text-lg flex items-center gap-2">
                  <FileText className="h-5 w-5" />
                  Step 1: Upload Excel File
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="flex items-center justify-between">
                  <Button
                    variant="outline"
                    onClick={downloadTemplate}
                    className="flex items-center gap-2"
                  >
                    <Download className="h-4 w-4" />
                    Download Template
                  </Button>
                </div>
                
                <div className="space-y-2">
                  <Label htmlFor="excel-file">Select Excel File</Label>
                  <Input
                    id="excel-file"
                    type="file"
                    accept=".xlsx,.xls"
                    onChange={handleFileChange}
                    className="cursor-pointer"
                  />
                  {selectedFile && (
                    <p className="text-sm text-muted-foreground">
                      Selected: {selectedFile.name} ({(selectedFile.size / 1024).toFixed(1)} KB)
                    </p>
                  )}
                </div>

                <div className="bg-muted p-4 rounded-md">
                  <h4 className="font-medium mb-2">Required Excel Columns:</h4>
                  <ul className="text-sm space-y-1 text-muted-foreground">
                    <li>• <strong>name</strong> - Student's full name</li>
                    <li>• <strong>email</strong> - Student's email address</li>
                    <li>• <strong>registration_no</strong> - Unique registration number</li>
                    <li>• <strong>phone</strong> - Mobile number (optional)</li>
                    <li>• <strong>gender</strong> - male/female</li>
                  </ul>
                  <p className="text-xs mt-2 text-muted-foreground">
                    Note: Password will be automatically set to registration number
                  </p>
                </div>
              </CardContent>
            </Card>

            <DialogFooter>
              <Button variant="outline" onClick={() => onOpenChange(false)}>
                Cancel
              </Button>
              <Button
                onClick={handlePreviewUpload}
                disabled={!selectedFile || isLoading}
                className="flex items-center gap-2"
              >
                {isLoading ? "Processing..." : "Preview Students"}
              </Button>
            </DialogFooter>
          </div>
        )}

        {step === 2 && previewData && (
          <div className="space-y-6">
            {/* Preview Summary */}
            <Card>
              <CardHeader>
                <CardTitle className="text-lg flex items-center gap-2">
                  <Users className="h-5 w-5" />
                  Step 2: Review and Assign
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="grid grid-cols-3 gap-4">
                  <div className="text-center">
                    <div className="text-2xl font-bold text-green-600">{previewData.validRows}</div>
                    <div className="text-sm text-muted-foreground">Valid Students</div>
                  </div>
                  <div className="text-center">
                    <div className="text-2xl font-bold text-red-600">{previewData.invalidRows}</div>
                    <div className="text-sm text-muted-foreground">Invalid Rows</div>
                  </div>
                  <div className="text-center">
                    <div className="text-2xl font-bold">{previewData.totalRows}</div>
                    <div className="text-sm text-muted-foreground">Total Rows</div>
                  </div>
                </div>

                {previewData.errors.length > 0 && (
                  <div className="bg-red-50 p-3 rounded-md">
                    <h4 className="font-medium text-red-800 mb-2 flex items-center gap-2">
                      <AlertCircle className="h-4 w-4" />
                      Validation Errors
                    </h4>
                    <div className="max-h-32 overflow-y-auto">
                      {previewData.errors.map((error, index) => (
                        <p key={index} className="text-sm text-red-700">• {error}</p>
                      ))}
                    </div>
                  </div>
                )}

                {/* Batch Assignment Form */}
                <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mt-6">
                  <div className="space-y-2">
                    <Label htmlFor="course">Course *</Label>
                    <Select
                      value={batchAssignment.course}
                      onValueChange={(value) => setBatchAssignment(prev => ({ ...prev, course: value }))}
                    >
                      <SelectTrigger>
                        <SelectValue placeholder="Select course" />
                      </SelectTrigger>
                      <SelectContent>
                        {loadingOptions ? (
                          <SelectItem value="loading">Loading...</SelectItem>
                        ) : (
                          courses.map((course) => (
                            <SelectItem key={course} value={course}>
                              {course}
                            </SelectItem>
                          ))
                        )}
                      </SelectContent>
                    </Select>
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="batch">Batch *</Label>
                    <Select
                      value={batchAssignment.batchId}
                      onValueChange={(value) => setBatchAssignment(prev => ({ ...prev, batchId: value }))}
                    >
                      <SelectTrigger>
                        <SelectValue placeholder="Select batch" />
                      </SelectTrigger>
                      <SelectContent>
                        {loadingOptions ? (
                          <SelectItem value="loading">Loading...</SelectItem>
                        ) : (
                          batches.map((batch) => (
                            <SelectItem key={batch.id} value={batch.id}>
                              {batch.name}
                            </SelectItem>
                          ))
                        )}
                      </SelectContent>
                    </Select>
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="section">Section *</Label>
                    <Select
                      value={batchAssignment.sectionId}
                      onValueChange={(value) => setBatchAssignment(prev => ({ ...prev, sectionId: value }))}
                    >
                      <SelectTrigger>
                        <SelectValue placeholder="Select section" />
                      </SelectTrigger>
                      <SelectContent>
                        {loadingOptions ? (
                          <SelectItem value="loading">Loading...</SelectItem>
                        ) : (
                          sections.map((section) => (
                            <SelectItem key={section.id} value={section.id}>
                              {section.name}
                            </SelectItem>
                          ))
                        )}
                      </SelectContent>
                    </Select>
                  </div>
                </div>

                {/* Student Preview Table */}
                {previewData.students.length > 0 && (
                  <div className="mt-6">
                    <h4 className="font-medium mb-3">Student Preview (showing first 10)</h4>
                    <div className="border rounded-md max-h-60 overflow-y-auto">
                      <table className="w-full text-sm">
                        <thead className="bg-muted">
                          <tr>
                            <th className="p-2 text-left">Name</th>
                            <th className="p-2 text-left">Email</th>
                            <th className="p-2 text-left">Registration No.</th>
                            <th className="p-2 text-left">Gender</th>
                          </tr>
                        </thead>
                        <tbody>
                          {previewData.students.slice(0, 10).map((student) => (
                            <tr key={student.rowNumber} className="border-t">
                              <td className="p-2">{student.name}</td>
                              <td className="p-2">{student.email}</td>
                              <td className="p-2">{student.registration_no}</td>
                              <td className="p-2">
                                <Badge variant="outline">{student.gender}</Badge>
                              </td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                    {previewData.students.length > 10 && (
                      <p className="text-sm text-muted-foreground mt-2">
                        ... and {previewData.students.length - 10} more students
                      </p>
                    )}
                  </div>
                )}
              </CardContent>
            </Card>

            <DialogFooter>
              <Button variant="outline" onClick={handleReset}>
                Back
              </Button>
              <Button variant="outline" onClick={() => onOpenChange(false)}>
                Cancel
              </Button>
              <Button
                onClick={handleImport}
                disabled={isImporting || !batchAssignment.batchId || !batchAssignment.sectionId || !batchAssignment.course}
                className="flex items-center gap-2"
              >
                {isImporting ? "Importing..." : `Import ${previewData.validRows} Students`}
                <CheckCircle className="h-4 w-4" />
              </Button>
            </DialogFooter>
          </div>
        )}
      </DialogContent>
    </Dialog>
  );
};

export default EnhancedStudentImport;
