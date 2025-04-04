
import React, { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
} from "@/components/ui/dialog";
import StatusBadge from "@/components/common/StatusBadge";
import { studentList } from "@/data/mockData";
import { Search, ArrowUpDown, Eye } from "lucide-react";

const ManageStudents: React.FC = () => {
  const [searchQuery, setSearchQuery] = useState("");
  const [filteredStudents, setFilteredStudents] = useState(studentList);
  const [sortOrder, setSortOrder] = useState<"asc" | "desc">("desc");
  const [sortField, setSortField] = useState<"name" | "totalScore">("totalScore");
  const [selectedStudent, setSelectedStudent] = useState<typeof studentList[0] | null>(null);
  const [isDialogOpen, setIsDialogOpen] = useState(false);

  const handleSearch = () => {
    if (!searchQuery.trim()) {
      setFilteredStudents(studentList);
      return;
    }

    const query = searchQuery.toLowerCase();
    const results = studentList.filter(
      (student) =>
        student.name.toLowerCase().includes(query) ||
        student.registrationNo.includes(query)
    );
    setFilteredStudents(results);
  };

  const handleSort = (field: "name" | "totalScore") => {
    const newSortOrder = field === sortField && sortOrder === "asc" ? "desc" : "asc";
    
    const sorted = [...filteredStudents].sort((a, b) => {
      if (field === "name") {
        return newSortOrder === "asc"
          ? a.name.localeCompare(b.name)
          : b.name.localeCompare(a.name);
      } else {
        return newSortOrder === "asc"
          ? a.totalScore - b.totalScore
          : b.totalScore - a.totalScore;
      }
    });

    setSortField(field);
    setSortOrder(newSortOrder);
    setFilteredStudents(sorted);
  };

  const handleViewStudent = (student: typeof studentList[0]) => {
    setSelectedStudent(student);
    setIsDialogOpen(true);
  };

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold mb-1">Manage Students</h1>
        <p className="text-muted-foreground">
          View and manage student profiles and performance data.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Student Directory</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="flex gap-2 mb-6">
            <Input
              placeholder="Search by name or registration no."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="flex-1"
            />
            <Button onClick={handleSearch}>
              <Search className="h-4 w-4 mr-2" />
              Search
            </Button>
          </div>

          <div className="overflow-x-auto">
            <table className="w-full text-left text-sm">
              <thead className="bg-muted">
                <tr>
                  <th className="p-3">
                    <Button
                      variant="ghost"
                      size="sm"
                      className="p-0 h-auto font-bold"
                      onClick={() => handleSort("name")}
                    >
                      Name
                      <ArrowUpDown className="h-3 w-3 ml-1" />
                    </Button>
                  </th>
                  <th className="p-3">Reg No.</th>
                  <th className="p-3">Batch</th>
                  <th className="p-3">Course</th>
                  <th className="p-3">
                    <Button
                      variant="ghost"
                      size="sm"
                      className="p-0 h-auto font-bold"
                      onClick={() => handleSort("totalScore")}
                    >
                      Score
                      <ArrowUpDown className="h-3 w-3 ml-1" />
                    </Button>
                  </th>
                  <th className="p-3">Status</th>
                  <th className="p-3">Actions</th>
                </tr>
              </thead>
              <tbody>
                {filteredStudents.map((student) => (
                  <tr key={student.id} className="border-b">
                    <td className="p-3 font-medium">{student.name}</td>
                    <td className="p-3">{student.registrationNo}</td>
                    <td className="p-3">{student.batch}</td>
                    <td className="p-3">{student.course}</td>
                    <td className="p-3">{student.totalScore}/100</td>
                    <td className="p-3">
                      <StatusBadge status={student.overallStatus} />
                    </td>
                    <td className="p-3">
                      <Button
                        size="sm"
                        variant="outline"
                        onClick={() => handleViewStudent(student)}
                      >
                        <Eye className="h-3 w-3 mr-1" />
                        View
                      </Button>
                    </td>
                  </tr>
                ))}
                {filteredStudents.length === 0 && (
                  <tr>
                    <td colSpan={7} className="p-3 text-center text-muted-foreground">
                      No students found
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </CardContent>
      </Card>

      <Dialog open={isDialogOpen} onOpenChange={setIsDialogOpen}>
        <DialogContent className="max-w-2xl">
          <DialogHeader>
            <DialogTitle>Student Profile</DialogTitle>
            <DialogDescription>
              Detailed information about the selected student.
            </DialogDescription>
          </DialogHeader>

          {selectedStudent && (
            <div className="space-y-4">
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <p className="text-sm text-muted-foreground">Name</p>
                  <p className="font-medium">{selectedStudent.name}</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">
                    Registration Number
                  </p>
                  <p className="font-medium">{selectedStudent.registrationNo}</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Course</p>
                  <p className="font-medium">{selectedStudent.course}</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Batch</p>
                  <p className="font-medium">{selectedStudent.batch}</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Total Score</p>
                  <p className="font-medium">{selectedStudent.totalScore}/100</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Status</p>
                  <StatusBadge status={selectedStudent.overallStatus} />
                </div>
              </div>

              {selectedStudent.quadrants.length > 0 && (
                <>
                  <h3 className="font-medium mt-4">Quadrant Scores</h3>
                  <div className="grid grid-cols-2 gap-4">
                    {selectedStudent.quadrants.map((quadrant) => (
                      <div
                        key={quadrant.id}
                        className="bg-muted p-3 rounded-md"
                      >
                        <div className="flex justify-between items-center">
                          <h4 className="font-medium">{quadrant.name}</h4>
                          <StatusBadge status={quadrant.status} />
                        </div>
                        <p className="mt-1">
                          Score: {quadrant.obtained}/{quadrant.weightage}
                        </p>
                      </div>
                    ))}
                  </div>
                </>
              )}

              <div className="flex justify-end gap-2 mt-4">
                <Button variant="outline" onClick={() => setIsDialogOpen(false)}>
                  Close
                </Button>
                <Button>Edit Profile</Button>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>
    </div>
  );
};

export default ManageStudents;
