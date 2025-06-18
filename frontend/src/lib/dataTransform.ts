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

// Transform API student performance data to UI format
export const transformStudentPerformanceData = (
  apiPerformance: any
): Student => {
  // Handle different API response structures
  const data = apiPerformance.data || apiPerformance;
  const { student, currentTerm, termHistory, batchStats } = data;

  // Validate required data
  if (!student || !currentTerm) {
    throw new Error('Invalid API response: missing student or currentTerm data');
  }

  // Transform current term data with safety checks
  const currentTermData: TermData = {
    termId: currentTerm.termId || 'current',
    termName: currentTerm.termName || 'Current Term',
    quadrants: Array.isArray(currentTerm.quadrants) ? currentTerm.quadrants.map((q: any) => ({
      id: q.id || 'unknown',
      name: q.name || 'Unknown Quadrant',
      weightage: typeof q.weightage === 'number' ? q.weightage : 0,
      obtained: typeof q.obtained === 'number' ? q.obtained : 0,
      status: q.status as StatusType || 'IC',
      attendance: typeof q.attendance === 'number' ? q.attendance : 0,
      eligibility: (q.eligibility === 'Eligible' || q.eligibility === 'Not Eligible') ? q.eligibility : 'Not Eligible',
      rank: typeof q.rank === 'number' ? q.rank : 0,
      components: Array.isArray(q.components) ? q.components.map((c: any) => ({
        id: c.id || 'unknown',
        name: c.name || 'Unknown Component',
        score: typeof c.score === 'number' ? c.score : 0,
        maxScore: typeof c.maxScore === 'number' ? c.maxScore : 100,
        status: c.status as StatusType || 'IC',
        category: (c.category === 'SHL' || c.category === 'Professional') ? c.category : undefined
      })) : []
    })) : [],
    tests: [], // Will be populated if needed
    totalScore: typeof currentTerm.totalScore === 'number' ? currentTerm.totalScore : 0,
    grade: currentTerm.grade as Grade || 'IC',
    overallStatus: currentTerm.overallStatus as StatusType || 'IC'
  };

  // Transform term history if available
  const allTerms = Array.isArray(termHistory) ?
    [currentTermData, ...termHistory.map((term: any) => ({
      termId: term.termId || 'unknown',
      termName: term.termName || 'Unknown Term',
      quadrants: Array.isArray(term.quadrants) ? term.quadrants : [],
      tests: Array.isArray(term.tests) ? term.tests : [],
      totalScore: typeof term.totalScore === 'number' ? term.totalScore : 0,
      grade: term.grade as Grade || 'IC',
      overallStatus: term.overallStatus as StatusType || 'IC'
    }))] :
    [currentTermData];

  return {
    id: student.id || 'unknown',
    name: student.name || 'Unknown Student',
    registrationNo: student.registrationNo || 'Unknown',
    course: student.course || 'Unknown Course',
    batch: student.batch || 'Unknown Batch',
    section: student.section || 'Unknown Section',
    houseName: student.houseName || 'Unknown House',
    gender: (student.gender === 'Male' || student.gender === 'Female' || student.gender === 'Other') ? student.gender : 'Male',
    currentTerm: student.currentTerm || currentTermData.termId,
    terms: allTerms,
    totalScore: currentTermData.totalScore,
    grade: currentTermData.grade,
    overallStatus: currentTermData.overallStatus,
    quadrants: currentTermData.quadrants,
    tests: []
  };
};

// Legacy transform function for backward compatibility
export const transformStudentData = (
  apiStudent: any,
  apiScoreSummary: any,
  apiQuadrants: any[]
): Student => {
  const student = apiStudent.data;
  const summary = apiScoreSummary?.summary || {};

  // Get the actual overall score from API
  const actualOverallScore = summary.total_score || summary.weighted_score || 0;
  const actualGrade = summary.overall_grade || 'IC';

  // Transform quadrant scores to UI format
  const quadrants: QuadrantData[] = summary.quadrant_scores && summary.quadrant_scores.length > 0 ?
    summary.quadrant_scores.map((qs: any) => ({
      id: qs.quadrant_id,
      name: qs.quadrant_name,
      weightage: qs.weight_percentage,
      obtained: qs.weighted_score,
      status: qs.status as StatusType,
      attendance: qs.attendance_percentage,
      eligibility: qs.is_attendance_met ? 'Eligible' : 'Not Eligible' as const,
      rank: 1, // Mock rank for now
      components: [] // Will be populated from detailed scores if needed
    })) :
    // When no scores exist, show quadrants with 0 scores
    apiQuadrants.map((q) => ({
      id: q.id,
      name: q.name,
      weightage: q.weightage,
      obtained: 0,
      status: 'IC' as StatusType,
      attendance: 0,
      eligibility: 'Not Eligible' as const,
      rank: 0,
      components: []
    }));

  // Create term data
  const termData: TermData = {
    termId: summary.term?.id || student.current_term || 'term-1',
    termName: summary.term?.name || 'Current Term',
    quadrants,
    tests: [],
    totalScore: actualOverallScore,
    grade: actualGrade as Grade,
    overallStatus: summary.overall_status as StatusType || calculateStatus(actualOverallScore, 75) as StatusType
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
    terms: [termData],
    totalScore: actualOverallScore,
    grade: actualGrade as Grade,
    overallStatus: termData.overallStatus,
    quadrants,
    tests: []
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

// Transform API leaderboard data to UI format
export const transformLeaderboardData = (apiLeaderboard: any): Leaderboard => {
  return {
    overall: {
      topStudents: apiLeaderboard.data.overall.topStudents,
      userRank: apiLeaderboard.data.overall.userRank,
      batchAvg: apiLeaderboard.data.overall.batchAvg,
      batchBest: apiLeaderboard.data.overall.batchBest
    },
    quadrants: apiLeaderboard.data.quadrants
  };
};

// Fallback: Generate mock leaderboard data when API is not available
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

// Transform API attendance data to UI format
export const transformAttendanceData = (apiAttendance: any) => {
  const data = apiAttendance.data || apiAttendance;

  return {
    overall: typeof data.overall === 'number' ? data.overall : 0,
    wellness: typeof data.wellness === 'number' ? data.wellness : 0,
    eligibility: typeof data.eligibility === 'string' ? data.eligibility : 'Unknown',
    history: Array.isArray(data.history) ? data.history : [],
    quadrantAttendance: Array.isArray(data.quadrantAttendance) ? data.quadrantAttendance : []
  };
};

// Fallback: Generate mock attendance data when API is not available
export const generateMockAttendanceData = (quadrantScores: any[]) => {
  const personaQuadrant = quadrantScores.find(q => q.quadrant_name?.toLowerCase().includes('persona'));
  const wellnessQuadrant = quadrantScores.find(q => q.quadrant_name?.toLowerCase().includes('wellness'));

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