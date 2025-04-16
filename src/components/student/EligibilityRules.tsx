import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Badge } from '@/components/ui/badge';

const EligibilityRules: React.FC = () => {
  const eligibilityRules = [
    {
      quadrant: 'Persona',
      attendanceRequired: '80%',
      otherRequirements: 'Completion of all SHL competency assessments and Professional Readiness components'
    },
    {
      quadrant: 'Wellness',
      attendanceRequired: '80%',
      otherRequirements: 'Participation in all fitness tests and wellness activities'
    },
    {
      quadrant: 'Behavior',
      attendanceRequired: '80%',
      otherRequirements: 'Minimum score of 2 in each behavior component'
    },
    {
      quadrant: 'Discipline',
      attendanceRequired: '80%',
      otherRequirements: 'No disciplinary actions or violations of code of conduct'
    }
  ];

  const gradingScale = [
    { grade: 'A+', range: '80-100', description: 'Excellent' },
    { grade: 'A', range: '66-79', description: 'Good' },
    { grade: 'B', range: '50-65', description: 'Average' },
    { grade: 'C', range: '40-49', description: 'Marginal' },
    { grade: 'D', range: '34-39', description: 'Poor' },
    { grade: 'E', range: 'Below 34', description: 'Very Poor' },
    { grade: 'IC', range: 'N/A', description: 'Incomplete' }
  ];

  return (
    <div className="space-y-6">
      <Card>
        <CardHeader>
          <CardTitle>Eligibility Rules</CardTitle>
        </CardHeader>
        <CardContent>
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Quadrant</TableHead>
                <TableHead>Attendance Required</TableHead>
                <TableHead>Other Requirements</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {eligibilityRules.map((rule) => (
                <TableRow key={rule.quadrant}>
                  <TableCell className="font-medium">{rule.quadrant}</TableCell>
                  <TableCell>{rule.attendanceRequired}</TableCell>
                  <TableCell>{rule.otherRequirements}</TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle>Grading Scale</CardTitle>
        </CardHeader>
        <CardContent>
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Grade</TableHead>
                <TableHead>Score Range</TableHead>
                <TableHead>Description</TableHead>
                <TableHead>Status</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {gradingScale.map((grade) => (
                <TableRow key={grade.grade}>
                  <TableCell>
                    <Badge variant={
                      grade.grade === 'A+' ? "default" : 
                      grade.grade === 'A' ? "secondary" : 
                      grade.grade === 'B' ? "outline" : 
                      grade.grade === 'IC' ? "destructive" : 
                      "destructive"
                    }>
                      {grade.grade}
                    </Badge>
                  </TableCell>
                  <TableCell>{grade.range}</TableCell>
                  <TableCell>{grade.description}</TableCell>
                  <TableCell>
                    {grade.grade === 'IC' ? (
                      <Badge variant="destructive">Not Cleared</Badge>
                    ) : grade.grade === 'E' || grade.grade === 'D' ? (
                      <Badge variant="destructive">Not Cleared</Badge>
                    ) : (
                      <Badge variant="default">Cleared</Badge>
                    )}
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle>Attendance Policy</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            <p>
              <strong>Minimum Attendance Requirement:</strong> 80% attendance is mandatory for each quadrant.
            </p>
            <p>
              <strong>Attendance Shortage:</strong> Students with attendance below 80% in any quadrant will be marked as "Not Eligible" for that quadrant.
            </p>
            <p>
              <strong>Wellness Attendance:</strong> Special attention is given to wellness activities attendance, which is tracked separately.
            </p>
            <p>
              <strong>Make-up Sessions:</strong> Limited make-up sessions may be available for students with valid reasons for absence.
            </p>
          </div>
        </CardContent>
      </Card>
    </div>
  );
};

export default EligibilityRules;
