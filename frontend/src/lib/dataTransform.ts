import { Grade, StatusType, Student, QuadrantData, Component, TermData, Leaderboard } from '@/data/mockData';

// Helper function to calculate grade based on score
const calculateGrade = (score: number): Grade => {
  if (score >= 80) return 'A+';
  if (score >= 70) return 'A';
  if (score >= 60) return 'B';
  if (score >= 50) return 'C';
  if (score >= 40) return 'D';
  if (score >= 30) return 'E';
  return 'IC';
};

// Helper function to calculate status based on score and threshold
const calculateStatus = (score: number, threshold: number): StatusType => {
  if (score >= threshold * 0.8) return 'Good';
  if (score >= threshold * 0.6) return 'Progress';
  return 'Deteriorate';
};

// Transform API student data to UI format
export const transformStudentData = (
  apiStudent: any,
  apiScoreSummary: any,
  apiQuadrants: any[]
): Student => {
  const student = apiStudent.data;
  const summary = apiScoreSummary?.data?.summary || {};
  
  // Get the actual overall score from API - use calculated percentage or stored score
  const actualOverallScore = summary.overall_percentage || apiScoreSummary?.data?.student?.current_overall_score || 0;
  const actualGrade = summary.calculated_grade || apiScoreSummary?.data?.student?.current_grade || 'IC';
  
  // Transform quadrant scores to UI format
  const quadrants: QuadrantData[] = summary.quadrants && summary.quadrants.length > 0 ? 
    summary.quadrants.map((qs: any) => {
      const quadrant = apiQuadrants.find(q => q.id === qs.quadrant_id);
      
      return {
        id: qs.quadrant_id,
        name: qs.quadrant_name,
        weightage: qs.weightage,
        obtained: Math.round((qs.average_percentage || 0) * qs.weightage / 100),
        status: calculateStatus(qs.average_percentage || 0, 75) as StatusType,
        attendance: 85, // Mock attendance for now - will be replaced with real data later
        eligibility: 'Eligible' as const,
        rank: 1, // Mock rank for now
        components: [] // Will be populated from detailed scores if needed
      };
    }) :
    // When no scores exist, show quadrants with 0 scores (not mock data)
    apiQuadrants.map((q) => ({
      id: q.id,
      name: q.name,
      weightage: q.weightage,
      obtained: 0, // Show actual 0 instead of mock scores
      status: 'IC' as StatusType, // Incomplete status when no scores
      attendance: 0, // No attendance data
      eligibility: 'Not Eligible' as const,
      rank: 0,
      components: []
    }));

  // Create term data
  const termData: TermData = {
    termId: summary.term?.id || student.current_term || 'term-1',
    termName: summary.term?.name || 'Current Term',
    quadrants,
    tests: [], // Mock tests for now
    totalScore: actualOverallScore, // Use actual score, no fallback
    grade: actualGrade as Grade,
    overallStatus: calculateStatus(actualOverallScore, 75) as StatusType
  };

  return {
    id: student.id,
    name: student.name,
    registrationNo: student.registration_no,
    course: student.course || 'PGDM',
    batch: student.batch_name || student.batches?.name || 'Unknown Batch',
    section: student.section_name || student.sections?.name || 'Unknown Section',
    houseName: student.house_name || student.houses?.name || 'Unknown House',
    gender: student.gender || 'Male',
    currentTerm: summary.term?.id || student.current_term || 'term-1',
    terms: [termData], // Single term for now
    totalScore: actualOverallScore, // Use actual score, no fallback
    grade: actualGrade as Grade,
    overallStatus: calculateStatus(actualOverallScore, 75) as StatusType,
    quadrants,
    tests: [] // Mock tests
  };
};

// Transform detailed scores to components
export const transformScoresToComponents = (apiScores: any[]): Component[] => {
  return apiScores.map(score => ({
    id: score.component.id,
    name: score.component.name,
    score: score.obtained_score,
    maxScore: score.max_score,
    status: score.status as StatusType,
    category: score.component.category as 'SHL' | 'Professional'
  }));
};

// Generate mock leaderboard data (since we don't have this API yet)
export const generateMockLeaderboard = (studentScore: number): Leaderboard => {
  const generateTopStudents = (baseScore: number) => [
    { id: '1', name: 'Student A', score: Math.min(100, Math.max(0, baseScore + 5)) },
    { id: '2', name: 'Student B', score: Math.min(100, Math.max(0, baseScore + 3)) },
    { id: '3', name: 'Student C', score: Math.min(100, Math.max(0, baseScore + 1)) },
  ];

  return {
    overall: {
      topStudents: generateTopStudents(studentScore),
      userRank: studentScore > 0 ? 4 : 0,
      batchAvg: Math.max(0, studentScore > 0 ? studentScore - 10 : 0),
      batchBest: Math.min(100, Math.max(0, studentScore + 5))
    },
          quadrants: {
        persona: {
          topStudents: generateTopStudents(studentScore),
          userRank: studentScore > 0 ? 3 : 0,
          batchAvg: Math.max(0, studentScore > 0 ? studentScore - 8 : 0),
          batchBest: Math.min(100, Math.max(0, studentScore + 3))
        },
        wellness: {
          topStudents: generateTopStudents(studentScore),
          userRank: studentScore > 0 ? 5 : 0,
          batchAvg: Math.max(0, studentScore > 0 ? studentScore - 12 : 0),
          batchBest: Math.min(100, Math.max(0, studentScore + 7))
        },
        behavior: {
          topStudents: generateTopStudents(studentScore),
          userRank: studentScore > 0 ? 2 : 0,
          batchAvg: Math.max(0, studentScore > 0 ? studentScore - 5 : 0),
          batchBest: Math.min(100, Math.max(0, studentScore + 2))
        },
        discipline: {
          topStudents: generateTopStudents(studentScore),
          userRank: studentScore > 0 ? 1 : 0,
          batchAvg: Math.max(0, studentScore > 0 ? studentScore - 3 : 0),
          batchBest: Math.min(100, Math.max(0, studentScore + 1))
        }
      }
  };
};

// Generate mock time series data
export const generateMockTimeSeriesData = (currentScore: number) => {
  const terms = ['Term 1', 'Term 2', 'Term 3', 'Term 4'];
  const baseScore = Math.max(0, currentScore > 0 ? currentScore - 20 : 0);
  
  return {
    overall: terms.map((term, index) => ({
      term,
      score: currentScore > 0 ? Math.min(100, Math.max(0, baseScore + (index * 5) + Math.random() * 10)) : 0
    }))
  };
};

// Generate mock term comparison data
export const generateMockTermComparisonData = (currentScore: number) => {
  return [
    { termName: 'Term 1', overall: currentScore > 0 ? Math.max(0, currentScore - 15) : 0 },
    { termName: 'Term 2', overall: currentScore > 0 ? Math.max(0, currentScore - 10) : 0 },
    { termName: 'Term 3', overall: currentScore > 0 ? Math.max(0, currentScore - 5) : 0 },
    { termName: 'Current', overall: currentScore }
  ];
};

// Generate mock attendance data
export const generateMockAttendanceData = (quadrantScores: any[]) => {
  const personaQuadrant = quadrantScores.find(q => q.quadrant_name.toLowerCase().includes('persona'));
  const wellnessQuadrant = quadrantScores.find(q => q.quadrant_name.toLowerCase().includes('wellness'));
  
  const overallAttendance = Math.round(
    (personaQuadrant?.attendance_percentage || 85) * 0.6 + 
    (wellnessQuadrant?.attendance_percentage || 80) * 0.4
  );
  
  const isEligible = (personaQuadrant?.is_attendance_met && wellnessQuadrant?.is_attendance_met) || true;
  
  return {
    overall: overallAttendance,
    wellness: wellnessQuadrant?.attendance_percentage || 80,
    eligibility: isEligible ? 'Eligible' : 'Not Eligible'
  };
}; 