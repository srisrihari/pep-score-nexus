
export interface Component {
  id: string;
  name: string;
  score: number;
  maxScore: number;
  status?: 'Good' | 'Progress' | 'Deteriorate';
}

export interface QuadrantData {
  id: string;
  name: string;
  weightage: number;
  obtained: number;
  components: Component[];
  status: 'Good' | 'Progress' | 'Deteriorate';
}

export interface TestScore {
  id: string;
  name: string;
  scores: number[];
  total: number;
  maxScore: number;
}

export interface Student {
  id: string;
  name: string;
  registrationNo: string;
  course: string;
  batch: string;
  term: string;
  totalScore: number;
  overallStatus: 'Good' | 'Progress' | 'Deteriorate';
  quadrants: QuadrantData[];
  tests: TestScore[];
}

export interface Leaderboard {
  overall: {
    topStudents: { id: string; name: string; score: number }[];
    userRank: number;
    batchAvg: number;
    batchBest: number;
  };
  quadrants: Record<string, {
    topStudents: { id: string; name: string; score: number }[];
    userRank: number;
    batchAvg: number;
    batchBest: number;
  }>;
}

// Mock data based on the provided PDF
export const studentData: Student = {
  id: "2024-Ajith",
  name: "Ajith",
  registrationNo: "2334",
  course: "PGDM",
  batch: "2024",
  term: "Term / Semester",
  totalScore: 95,
  overallStatus: "Good",
  quadrants: [
    {
      id: "persons",
      name: "Persons",
      weightage: 40,
      obtained: 38,
      status: "Good",
      components: [
        { id: "communication", name: "Communication", score: 5, maxScore: 5 },
        { id: "problem-solving", name: "Problem Solving", score: 5, maxScore: 5 },
        { id: "critical-thinking", name: "Critical & Analytical Thinking", score: 2, maxScore: 5 },
        { id: "empathy", name: "Empathy", score: 10, maxScore: 10 },
        { id: "leadership", name: "Leadership", score: 10, maxScore: 10 },
        { id: "team-work", name: "Team Work", score: 6, maxScore: 5 }
      ]
    },
    {
      id: "wellness",
      name: "Wellness",
      weightage: 30,
      obtained: 28,
      status: "Good",
      components: [
        { id: "endurance", name: "Endurance", score: 8, maxScore: 10, status: "Progress" },
        { id: "agility", name: "Agility", score: 5, maxScore: 5 },
        { id: "muscle-upper", name: "Muscle Endurance - Upper", score: 6, maxScore: 10, status: "Deteriorate" },
        { id: "muscle-core", name: "Muscle Endurance - Core", score: 3, maxScore: 5, status: "Progress" },
        { id: "flexibility", name: "Flexibility", score: 4, maxScore: 5, status: "Progress" },
        { id: "body-composition", name: "Body Composition", score: 7, maxScore: 10, status: "Progress" }
      ]
    },
    {
      id: "behavior",
      name: "Behavior",
      weightage: 20,
      obtained: 20,
      status: "Good",
      components: [
        { id: "misdmeanours", name: "Misdemeanours", score: 1, maxScore: 5 },
        { id: "behavior-rating", name: "Behavior Rating Tool", score: 4, maxScore: 5 },
        { id: "attitude-rating", name: "Attitude Rating Tool", score: 3, maxScore: 5 },
        { id: "workplace-behavior", name: "Workplace Behaviour", score: 2, maxScore: 5 }
      ]
    },
    {
      id: "discipline",
      name: "Discipline",
      weightage: 10,
      obtained: 9,
      status: "Good",
      components: [
        { id: "attendance", name: "Attendance across all", score: 66, maxScore: 100 },
        { id: "regularity", name: "Regularity", score: 11, maxScore: 20 },
        { id: "meeting-deadlines", name: "Meeting Deadlines", score: 55, maxScore: 100 },
        { id: "preparation-effort", name: "Preparation & Effort", score: 10, maxScore: 10 }
      ]
    }
  ],
  tests: [
    {
      id: "espa",
      name: "ESPA (40 Marks)",
      scores: [22, 10, 34, 22, 11, 18, 18, 16, 26],
      total: 20,
      maxScore: 40
    },
    {
      id: "tech",
      name: "Tech Readiness (100)",
      scores: [67, 33, 27, 65, 47, 32, 78, 44, 12],
      total: 45,
      maxScore: 100
    },
    {
      id: "case",
      name: "Case Analysis (100)",
      scores: [33, 53, 23, 25, 35, 40, 44, 34, 67],
      total: 40,
      maxScore: 100
    },
    {
      id: "functional",
      name: "Functional Knowledge (100)",
      scores: [31, 14, 14, 0, 23, 12, 45, 32, 67],
      total: 26,
      maxScore: 100
    }
  ]
};

// Mock leaderboard data
export const leaderboardData: Leaderboard = {
  overall: {
    topStudents: [
      { id: "2024-Student1", name: "Rohan S", score: 97 },
      { id: "2024-Student2", name: "Priya M", score: 96 },
      { id: "2024-Ajith", name: "Ajith", score: 95 }
    ],
    userRank: 3,
    batchAvg: 82,
    batchBest: 97
  },
  quadrants: {
    persons: {
      topStudents: [
        { id: "2024-Student1", name: "Rohan S", score: 40 },
        { id: "2024-Student2", name: "Priya M", score: 39 },
        { id: "2024-Student3", name: "Kavita R", score: 39 }
      ],
      userRank: 4,
      batchAvg: 35,
      batchBest: 40
    },
    wellness: {
      topStudents: [
        { id: "2024-Student4", name: "Arjun K", score: 30 },
        { id: "2024-Student5", name: "Divya P", score: 29 },
        { id: "2024-Student6", name: "Rahul M", score: 29 }
      ],
      userRank: 5,
      batchAvg: 26,
      batchBest: 30
    },
    behavior: {
      topStudents: [
        { id: "2024-Ajith", name: "Ajith", score: 20 },
        { id: "2024-Student7", name: "Karthik L", score: 20 },
        { id: "2024-Student8", name: "Meena S", score: 19 }
      ],
      userRank: 1,
      batchAvg: 17,
      batchBest: 20
    },
    discipline: {
      topStudents: [
        { id: "2024-Student9", name: "Vishal R", score: 10 },
        { id: "2024-Student10", name: "Ananya K", score: 10 },
        { id: "2024-Student11", name: "Suresh P", score: 9 }
      ],
      userRank: 4,
      batchAvg: 8,
      batchBest: 10
    }
  }
};

// Mock student list for admin search
export const studentList = [
  studentData,
  {
    id: "2024-Rohan",
    name: "Rohan S",
    registrationNo: "2335",
    course: "PGDM",
    batch: "2024",
    term: "Term / Semester",
    totalScore: 97,
    overallStatus: "Good",
    quadrants: [],
    tests: []
  },
  {
    id: "2024-Priya",
    name: "Priya M",
    registrationNo: "2336",
    course: "PGDM",
    batch: "2024",
    term: "Term / Semester",
    totalScore: 96,
    overallStatus: "Good",
    quadrants: [],
    tests: []
  },
  {
    id: "2024-Kavita",
    name: "Kavita R",
    registrationNo: "2337",
    course: "PGDM",
    batch: "2024",
    term: "Term / Semester",
    totalScore: 94,
    overallStatus: "Good",
    quadrants: [],
    tests: []
  },
  {
    id: "2024-Arjun",
    name: "Arjun K",
    registrationNo: "2338",
    course: "PGDM",
    batch: "2024",
    term: "Term / Semester",
    totalScore: 93,
    overallStatus: "Good",
    quadrants: [],
    tests: []
  }
];

// Mock time series data for graphs
export const timeSeriesData = {
  persons: [
    { month: 'Jan', score: 32 },
    { month: 'Feb', score: 34 },
    { month: 'Mar', score: 35 },
    { month: 'Apr', score: 37 },
    { month: 'May', score: 38 }
  ],
  wellness: [
    { month: 'Jan', score: 22 },
    { month: 'Feb', score: 23 },
    { month: 'Mar', score: 25 },
    { month: 'Apr', score: 26 },
    { month: 'May', score: 28 }
  ],
  behavior: [
    { month: 'Jan', score: 15 },
    { month: 'Feb', score: 16 },
    { month: 'Mar', score: 18 },
    { month: 'Apr', score: 19 },
    { month: 'May', score: 20 }
  ],
  discipline: [
    { month: 'Jan', score: 6 },
    { month: 'Feb', score: 7 },
    { month: 'Mar', score: 8 },
    { month: 'Apr', score: 8 },
    { month: 'May', score: 9 }
  ],
  overall: [
    { month: 'Jan', score: 75 },
    { month: 'Feb', score: 80 },
    { month: 'Mar', score: 86 },
    { month: 'Apr', score: 90 },
    { month: 'May', score: 95 }
  ]
};
