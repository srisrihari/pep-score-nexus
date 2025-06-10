# PEP Score Nexus - Complete API Documentation

## Overview

This document provides comprehensive API documentation for the PEP Score Nexus application, covering all endpoints, requests, and responses for every page and user action across all three user roles: Student, Teacher, and Admin.

## Base URL
```
https://api.pep-score-nexus.com/api/v1
```

## Authentication

### Login
**Endpoint:** `POST /auth/login`

**Request:**
```json
{
  "username": "string",
  "password": "string"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "token": "jwt_token_string",
    "refreshToken": "refresh_token_string",
    "user": {
      "id": "string",
      "username": "string",
      "role": "student|teacher|admin",
      "name": "string",
      "email": "string"
    }
  },
  "message": "Login successful"
}
```

**Error Response:**
```json
{
  "success": false,
  "error": {
    "code": "INVALID_CREDENTIALS",
    "message": "Invalid username or password"
  }
}
```

### Refresh Token
**Endpoint:** `POST /auth/refresh`

**Request:**
```json
{
  "refreshToken": "string"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "token": "new_jwt_token_string",
    "refreshToken": "new_refresh_token_string"
  }
}
```

### Logout
**Endpoint:** `POST /auth/logout`

**Request:**
```json
{
  "refreshToken": "string"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Logged out successfully"
}
```

## Student APIs

### Student Dashboard

#### Get Student Performance Data
**Endpoint:** `GET /students/{studentId}/performance`

**Query Parameters:**
- `termId` (optional): Specific term ID to fetch data for
- `includeHistory` (optional): Boolean to include historical data

**Response:**
```json
{
  "success": true,
  "data": {
    "student": {
      "id": "2024-Ajith",
      "name": "Ajith",
      "registrationNo": "2334",
      "course": "PGDM",
      "batch": "2024",
      "section": "A",
      "houseName": "Daredevils",
      "gender": "Male",
      "currentTerm": "Term1"
    },
    "currentTerm": {
      "termId": "Term1",
      "termName": "Term 1 / Level 0",
      "totalScore": 95,
      "grade": "A+",
      "overallStatus": "Good",
      "quadrants": [
        {
          "id": "persona",
          "name": "Persona",
          "weightage": 50,
          "obtained": 45,
          "status": "Cleared",
          "attendance": 90,
          "eligibility": "Eligible",
          "rank": 1,
          "components": [
            {
              "id": "anc",
              "name": "Analysis & Critical Thinking (A&C)",
              "score": 4,
              "maxScore": 5,
              "category": "SHL",
              "status": "Good"
            }
          ]
        }
      ],
      "tests": [
        {
          "id": "espa",
          "name": "ESPA (40 Marks)",
          "scores": [22, 10, 34, 22, 11, 18, 18, 16, 26],
          "total": 20,
          "maxScore": 40
        }
      ]
    },
    "allTerms": [
      // Array of all terms with similar structure
    ]
  }
}
```

#### Get Student Leaderboard Data
**Endpoint:** `GET /students/{studentId}/leaderboard`

**Query Parameters:**
- `termId` (optional): Specific term ID
- `quadrantId` (optional): Specific quadrant ID

**Response:**
```json
{
  "success": true,
  "data": {
    "overall": {
      "topStudents": [
        {
          "id": "2024-Student1",
          "name": "Rohan S",
          "score": 97
        }
      ],
      "userRank": 3,
      "batchAvg": 82,
      "batchBest": 97,
      "totalStudents": 120
    },
    "quadrants": {
      "persona": {
        "topStudents": [
          {
            "id": "2024-Student1",
            "name": "Rohan S",
            "score": 40
          }
        ],
        "userRank": 4,
        "batchAvg": 35,
        "batchBest": 40
      }
    }
  }
}
```

### Quadrant Detail Page

#### Get Quadrant Details
**Endpoint:** `GET /students/{studentId}/quadrants/{quadrantId}`

**Query Parameters:**
- `termId` (optional): Specific term ID
- `includeTimeSeriesData` (optional): Boolean to include historical performance

**Response:**
```json
{
  "success": true,
  "data": {
    "quadrant": {
      "id": "persona",
      "name": "Persona",
      "weightage": 50,
      "obtained": 45,
      "status": "Cleared",
      "attendance": 90,
      "eligibility": "Eligible",
      "rank": 1,
      "components": [
        {
          "id": "anc",
          "name": "Analysis & Critical Thinking (A&C)",
          "score": 4,
          "maxScore": 5,
          "category": "SHL",
          "status": "Good",
          "description": "Ability to analyze complex problems and think critically"
        }
      ]
    },
    "timeSeriesData": [
      {
        "term": "Term 1",
        "score": 45
      }
    ],
    "leaderboard": {
      "topStudents": [
        {
          "id": "2024-Student1",
          "name": "Rohan S",
          "score": 40
        }
      ],
      "userRank": 4,
      "batchAvg": 35,
      "batchBest": 40
    }
  }
}
```

### Student Feedback

#### Submit Feedback
**Endpoint:** `POST /students/{studentId}/feedback`

**Request:**
```json
{
  "subject": "string",
  "category": "general|academic|technical|wellness|behavior",
  "message": "string",
  "priority": "low|medium|high"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "feedbackId": "feedback_123",
    "submittedAt": "2024-01-15T10:30:00Z",
    "status": "submitted"
  },
  "message": "Feedback submitted successfully"
}
```

#### Get Feedback History
**Endpoint:** `GET /students/{studentId}/feedback`

**Query Parameters:**
- `page` (optional): Page number for pagination
- `limit` (optional): Number of items per page
- `status` (optional): Filter by status

**Response:**
```json
{
  "success": true,
  "data": {
    "feedbacks": [
      {
        "id": "feedback_123",
        "subject": "Technical Issue",
        "category": "technical",
        "message": "Having trouble accessing the portal",
        "status": "resolved",
        "submittedAt": "2024-01-15T10:30:00Z",
        "resolvedAt": "2024-01-16T14:20:00Z",
        "response": "Issue has been resolved. Please try again."
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 3,
      "totalItems": 25,
      "itemsPerPage": 10
    }
  }
}
```

### Student Settings

#### Get Student Profile
**Endpoint:** `GET /students/{studentId}/profile`

**Response:**
```json
{
  "success": true,
  "data": {
    "student": {
      "id": "2024-Ajith",
      "name": "Ajith",
      "email": "student@university.edu",
      "phone": "+1 234-567-8900",
      "registrationNo": "2334",
      "course": "PGDM",
      "batch": "2024",
      "section": "A",
      "houseName": "Daredevils",
      "gender": "Male"
    },
    "preferences": {
      "notifyScores": true,
      "notifyUpdates": false,
      "darkMode": false,
      "language": "en"
    }
  }
}
```

#### Update Student Profile
**Endpoint:** `PUT /students/{studentId}/profile`

**Request:**
```json
{
  "email": "string",
  "phone": "string",
  "preferences": {
    "notifyScores": true,
    "notifyUpdates": false,
    "darkMode": false
  }
}
```

**Response:**
```json
{
  "success": true,
  "message": "Profile updated successfully"
}
```

#### Change Password
**Endpoint:** `POST /students/{studentId}/change-password`

**Request:**
```json
{
  "currentPassword": "string",
  "newPassword": "string",
  "confirmPassword": "string"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Password changed successfully"
}
```

### Student Eligibility

#### Get Eligibility Rules
**Endpoint:** `GET /students/eligibility-rules`

**Response:**
```json
{
  "success": true,
  "data": {
    "rules": [
      {
        "quadrant": "Persona",
        "attendanceRequired": "80%",
        "otherRequirements": "Completion of all SHL competency assessments and Professional Readiness components",
        "gradingCriteria": {
          "A+": "90-100%",
          "A": "80-89%",
          "B": "70-79%",
          "C": "60-69%",
          "D": "50-59%",
          "E": "40-49%",
          "IC": "Below 40%"
        }
      }
    ],
    "generalRules": {
      "minimumAttendance": "80%",
      "eligibilityThreshold": "40%",
      "passingGrade": "D"
    }
  }
}
```

#### Check Student Eligibility
**Endpoint:** `GET /students/{studentId}/eligibility`

**Query Parameters:**
- `termId` (optional): Specific term ID

**Response:**
```json
{
  "success": true,
  "data": {
    "overall": {
      "eligible": true,
      "status": "Eligible",
      "reason": null
    },
    "quadrants": [
      {
        "id": "persona",
        "name": "Persona",
        "eligible": true,
        "status": "Eligible",
        "attendance": 90,
        "attendanceRequired": 80,
        "reason": null
      }
    ],
    "recommendations": [
      "Maintain current attendance levels",
      "Continue excellent performance in all quadrants"
    ]
  }
}
```

### Student Improvement Plan

#### Get Improvement Plan
**Endpoint:** `GET /students/{studentId}/improvement-plan`

**Query Parameters:**
- `termId` (optional): Specific term ID
- `quadrantId` (optional): Filter by specific quadrant

**Response:**
```json
{
  "success": true,
  "data": {
    "improvementAreas": [
      {
        "quadrantId": "wellness",
        "quadrantName": "Wellness",
        "componentId": "sit-reach",
        "componentName": "Sit & Reach",
        "score": 3,
        "maxScore": 5,
        "status": "Progress",
        "priority": "medium",
        "recommendations": {
          "shortTerm": [
            "Practice stretching exercises daily",
            "Focus on flexibility training"
          ],
          "longTerm": [
            "Join yoga or pilates classes",
            "Develop a consistent fitness routine"
          ],
          "resources": [
            "Flexibility training videos",
            "Campus fitness center access"
          ]
        }
      }
    ],
    "overallRecommendations": [
      "Focus on wellness components that need improvement",
      "Maintain strong performance in other quadrants"
    ],
    "progressTracking": {
      "goalsSet": 3,
      "goalsAchieved": 1,
      "nextReviewDate": "2024-02-15"
    }
  }
}
```

#### Update Improvement Goals
**Endpoint:** `POST /students/{studentId}/improvement-goals`

**Request:**
```json
{
  "goals": [
    {
      "componentId": "sit-reach",
      "targetScore": 4,
      "targetDate": "2024-02-15",
      "actions": [
        "Daily stretching routine",
        "Weekly yoga sessions"
      ]
    }
  ]
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "goalsCreated": 1,
    "nextReviewDate": "2024-02-15"
  },
  "message": "Improvement goals set successfully"
}
```

## Teacher APIs

### Teacher Dashboard

#### Get Teacher Overview
**Endpoint:** `GET /teachers/{teacherId}/dashboard`

**Query Parameters:**
- `termId` (optional): Specific term ID

**Response:**
```json
{
  "success": true,
  "data": {
    "teacher": {
      "id": "teacher-001",
      "name": "Dr. Smith",
      "specialization": "wellness",
      "email": "teacher@university.edu"
    },
    "summary": {
      "totalStudents": 45,
      "pendingAssessments": 12,
      "completedAssessments": 28,
      "incompleteAssessments": 5
    },
    "recentActivity": [
      {
        "type": "assessment_completed",
        "studentName": "Ajith",
        "quadrant": "wellness",
        "timestamp": "2024-01-15T14:30:00Z"
      }
    ],
    "upcomingDeadlines": [
      {
        "type": "assessment_due",
        "description": "Wellness assessments for Section A",
        "dueDate": "2024-01-20T23:59:59Z",
        "studentsCount": 12
      }
    ]
  }
}
```

### Teacher Students Management

#### Get Assigned Students
**Endpoint:** `GET /teachers/{teacherId}/students`

**Query Parameters:**
- `status` (optional): Filter by assessment status (pending|completed|incomplete)
- `section` (optional): Filter by section
- `batch` (optional): Filter by batch
- `search` (optional): Search by name or registration number

**Response:**
```json
{
  "success": true,
  "data": {
    "students": [
      {
        "id": "2024-Ajith",
        "name": "Ajith",
        "registrationNo": "2334",
        "course": "PGDM",
        "batch": "2024",
        "section": "A",
        "status": "pending",
        "lastAssessment": "2024-01-10T10:00:00Z",
        "quadrant": "wellness",
        "currentScore": 28,
        "maxScore": 30
      }
    ],
    "summary": {
      "total": 45,
      "pending": 12,
      "completed": 28,
      "incomplete": 5
    }
  }
}
```

### Intervention Scoring

#### Get Student Assessment Details
**Endpoint:** `GET /teachers/{teacherId}/students/{studentId}/assessment`

**Query Parameters:**
- `quadrant` (optional): Specific quadrant to assess
- `termId` (optional): Specific term ID

**Response:**
```json
{
  "success": true,
  "data": {
    "student": {
      "id": "2024-Ajith",
      "name": "Ajith",
      "registrationNo": "2334",
      "course": "PGDM",
      "batch": "2024",
      "section": "A"
    },
    "quadrant": {
      "id": "wellness",
      "name": "Wellness",
      "weightage": 30,
      "components": [
        {
          "id": "push-ups",
          "name": "Push Ups",
          "maxScore": 5,
          "description": "Upper body strength assessment",
          "currentScore": 4,
          "lastAssessed": "2024-01-10T10:00:00Z"
        }
      ]
    },
    "previousAssessments": [
      {
        "date": "2024-01-10T10:00:00Z",
        "totalScore": 28,
        "components": [
          {
            "id": "push-ups",
            "score": 4,
            "feedback": "Good improvement shown"
          }
        ]
      }
    ]
  }
}
```

#### Submit Student Assessment
**Endpoint:** `POST /teachers/{teacherId}/students/{studentId}/assessment`

**Request:**
```json
{
  "quadrant": "wellness",
  "termId": "Term1",
  "scores": {
    "push-ups": {
      "score": 4,
      "feedback": "Good improvement shown"
    },
    "sit-ups": {
      "score": 4,
      "feedback": "Excellent form"
    }
  },
  "overallFeedback": "Student shows consistent improvement in all areas",
  "isDraft": false
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "assessmentId": "assessment_123",
    "totalScore": 28,
    "maxScore": 30,
    "submittedAt": "2024-01-15T14:30:00Z",
    "status": "completed"
  },
  "message": "Assessment submitted successfully"
}
```

#### Save Assessment as Draft
**Endpoint:** `POST /teachers/{teacherId}/students/{studentId}/assessment/draft`

**Request:**
```json
{
  "quadrant": "wellness",
  "termId": "Term1",
  "scores": {
    "push-ups": {
      "score": 4,
      "feedback": "Good improvement shown"
    }
  },
  "overallFeedback": "Work in progress"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "draftId": "draft_123",
    "savedAt": "2024-01-15T14:30:00Z"
  },
  "message": "Assessment saved as draft"
}
```

### Teacher Feedback Management

#### Get Feedback List
**Endpoint:** `GET /teachers/{teacherId}/feedback`

**Query Parameters:**
- `status` (optional): Filter by status (sent|pending|resolved)
- `studentId` (optional): Filter by specific student
- `quadrant` (optional): Filter by quadrant
- `page` (optional): Page number for pagination
- `limit` (optional): Number of items per page

**Response:**
```json
{
  "success": true,
  "data": {
    "feedbacks": [
      {
        "id": "feedback_123",
        "studentId": "2024-Ajith",
        "studentName": "Ajith",
        "registrationNo": "2334",
        "subject": "Wellness Improvement",
        "quadrant": "wellness",
        "message": "Focus on flexibility exercises",
        "status": "sent",
        "sentAt": "2024-01-15T10:30:00Z",
        "readAt": "2024-01-15T11:00:00Z"
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 3,
      "totalItems": 25,
      "itemsPerPage": 10
    }
  }
}
```

#### Send Feedback to Student
**Endpoint:** `POST /teachers/{teacherId}/feedback`

**Request:**
```json
{
  "studentId": "2024-Ajith",
  "subject": "Wellness Improvement",
  "quadrant": "wellness",
  "message": "Focus on flexibility exercises to improve your sit & reach scores",
  "priority": "medium"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "feedbackId": "feedback_123",
    "sentAt": "2024-01-15T10:30:00Z"
  },
  "message": "Feedback sent successfully"
}
```

#### Get Teacher Reports
**Endpoint:** `GET /teachers/{teacherId}/reports`

**Query Parameters:**
- `termId` (optional): Specific term ID
- `quadrant` (optional): Specific quadrant
- `reportType` (optional): Type of report (summary|detailed|progress)

**Response:**
```json
{
  "success": true,
  "data": {
    "summary": {
      "totalStudentsAssessed": 45,
      "averageScore": 26.5,
      "improvementRate": 15.2,
      "completionRate": 89.5
    },
    "quadrantPerformance": [
      {
        "quadrant": "wellness",
        "averageScore": 26.5,
        "maxScore": 30,
        "studentsAssessed": 45,
        "topPerformers": [
          {
            "studentId": "2024-Ajith",
            "studentName": "Ajith",
            "score": 28
          }
        ]
      }
    ],
    "progressTrends": [
      {
        "term": "Term 1",
        "averageScore": 24.2
      },
      {
        "term": "Term 2",
        "averageScore": 26.5
      }
    ]
  }
}
```

## Admin APIs

### Admin Dashboard

#### Get Admin Overview
**Endpoint:** `GET /admin/dashboard`

**Query Parameters:**
- `termId` (optional): Specific term ID
- `batch` (optional): Filter by batch

**Response:**
```json
{
  "success": true,
  "data": {
    "summary": {
      "totalStudents": 120,
      "totalTeachers": 12,
      "avgScore": 82,
      "highScore": 97,
      "lowScore": 68,
      "completionRate": 89.5
    },
    "quadrantAverages": [
      {
        "name": "Persona",
        "value": 35,
        "max": 50,
        "percentage": 70
      },
      {
        "name": "Wellness",
        "value": 26,
        "max": 30,
        "percentage": 86.7
      }
    ],
    "termProgress": [
      {
        "term": "Term 1",
        "score": 75
      },
      {
        "term": "Term 2",
        "score": 77
      }
    ],
    "gradeDistribution": [
      {
        "grade": "A+",
        "count": 25,
        "percentage": 20.8
      },
      {
        "grade": "A",
        "count": 30,
        "percentage": 25.0
      }
    ],
    "recentActivity": [
      {
        "type": "score_updated",
        "description": "Scores updated for 15 students",
        "timestamp": "2024-01-15T14:30:00Z"
      }
    ]
  }
}
```

#### Search Students
**Endpoint:** `GET /admin/students/search`

**Query Parameters:**
- `query`: Search term (name or registration number)
- `batch` (optional): Filter by batch
- `section` (optional): Filter by section
- `status` (optional): Filter by status
- `limit` (optional): Number of results to return

**Response:**
```json
{
  "success": true,
  "data": {
    "students": [
      {
        "id": "2024-Ajith",
        "name": "Ajith",
        "registrationNo": "2334",
        "course": "PGDM",
        "batch": "2024",
        "section": "A",
        "totalScore": 95,
        "grade": "A+",
        "overallStatus": "Good"
      }
    ],
    "totalResults": 1
  }
}
```

### Student Management

#### Get All Students
**Endpoint:** `GET /admin/students`

**Query Parameters:**
- `page` (optional): Page number for pagination
- `limit` (optional): Number of items per page
- `batch` (optional): Filter by batch
- `section` (optional): Filter by section
- `status` (optional): Filter by status
- `sortBy` (optional): Sort field (name|score|registrationNo)
- `sortOrder` (optional): Sort order (asc|desc)

**Response:**
```json
{
  "success": true,
  "data": {
    "students": [
      {
        "id": "2024-Ajith",
        "name": "Ajith",
        "registrationNo": "2334",
        "course": "PGDM",
        "batch": "2024",
        "section": "A",
        "houseName": "Daredevils",
        "gender": "Male",
        "totalScore": 95,
        "grade": "A+",
        "overallStatus": "Good",
        "currentTerm": "Term1"
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 12,
      "totalItems": 120,
      "itemsPerPage": 10
    }
  }
}
```

#### Get Student Details
**Endpoint:** `GET /admin/students/{studentId}`

**Response:**
```json
{
  "success": true,
  "data": {
    "student": {
      "id": "2024-Ajith",
      "name": "Ajith",
      "registrationNo": "2334",
      "course": "PGDM",
      "batch": "2024",
      "section": "A",
      "houseName": "Daredevils",
      "gender": "Male",
      "email": "student@university.edu",
      "phone": "+1 234-567-8900",
      "currentTerm": "Term1"
    },
    "performance": {
      "currentTerm": {
        "termId": "Term1",
        "termName": "Term 1 / Level 0",
        "totalScore": 95,
        "grade": "A+",
        "overallStatus": "Good",
        "quadrants": [
          {
            "id": "persona",
            "name": "Persona",
            "obtained": 45,
            "weightage": 50,
            "status": "Cleared"
          }
        ]
      },
      "allTerms": [
        // Array of all terms
      ]
    }
  }
}
```

#### Add New Student
**Endpoint:** `POST /admin/students`

**Request:**
```json
{
  "name": "string",
  "registrationNo": "string",
  "course": "string",
  "batch": "string",
  "section": "string",
  "houseName": "string",
  "gender": "Male|Female|Other",
  "email": "string",
  "phone": "string"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "studentId": "2024-NewStudent",
    "createdAt": "2024-01-15T14:30:00Z"
  },
  "message": "Student added successfully"
}
```

#### Update Student
**Endpoint:** `PUT /admin/students/{studentId}`

**Request:**
```json
{
  "name": "string",
  "email": "string",
  "phone": "string",
  "section": "string",
  "houseName": "string"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Student updated successfully"
}
```

#### Delete Student
**Endpoint:** `DELETE /admin/students/{studentId}`

**Response:**
```json
{
  "success": true,
  "message": "Student deleted successfully"
}
```

### Score Input Management

#### Get Student for Score Input
**Endpoint:** `GET /admin/students/{studentId}/scores`

**Query Parameters:**
- `termId` (optional): Specific term ID

**Response:**
```json
{
  "success": true,
  "data": {
    "student": {
      "id": "2024-Ajith",
      "name": "Ajith",
      "registrationNo": "2334",
      "course": "PGDM",
      "batch": "2024",
      "section": "A"
    },
    "currentScores": {
      "termId": "Term1",
      "quadrants": [
        {
          "id": "persona",
          "name": "Persona",
          "components": [
            {
              "id": "anc",
              "name": "Analysis & Critical Thinking (A&C)",
              "score": 4,
              "maxScore": 5
            }
          ]
        }
      ]
    }
  }
}
```

#### Submit Student Scores
**Endpoint:** `POST /admin/students/{studentId}/scores`

**Request:**
```json
{
  "termId": "Term1",
  "quadrantScores": {
    "persona": {
      "anc": 4,
      "c": 4,
      "e": 5
    },
    "wellness": {
      "push-ups": 4,
      "sit-ups": 4
    }
  }
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "totalScore": 95,
    "grade": "A+",
    "updatedAt": "2024-01-15T14:30:00Z"
  },
  "message": "Scores submitted successfully"
}
```

### Teacher Management

#### Get All Teachers
**Endpoint:** `GET /admin/teachers`

**Query Parameters:**
- `status` (optional): Filter by status (active|inactive)
- `specialization` (optional): Filter by specialization
- `search` (optional): Search by name or email

**Response:**
```json
{
  "success": true,
  "data": {
    "teachers": [
      {
        "id": "teacher-001",
        "name": "Dr. Smith",
        "email": "teacher@university.edu",
        "specialization": "wellness",
        "assignedStudents": 45,
        "status": "active",
        "joinDate": "2023-08-15T00:00:00Z"
      }
    ],
    "summary": {
      "total": 12,
      "active": 10,
      "inactive": 2
    }
  }
}
```

#### Add New Teacher
**Endpoint:** `POST /admin/teachers`

**Request:**
```json
{
  "name": "string",
  "email": "string",
  "specialization": "persona|wellness|behavior|discipline",
  "quadrantAccess": ["persona", "wellness"],
  "password": "string"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "teacherId": "teacher-002",
    "createdAt": "2024-01-15T14:30:00Z"
  },
  "message": "Teacher added successfully"
}
```

#### Update Teacher
**Endpoint:** `PUT /admin/teachers/{teacherId}`

**Request:**
```json
{
  "name": "string",
  "email": "string",
  "specialization": "persona|wellness|behavior|discipline",
  "quadrantAccess": ["persona", "wellness"],
  "status": "active|inactive"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Teacher updated successfully"
}
```

#### Delete Teacher
**Endpoint:** `DELETE /admin/teachers/{teacherId}`

**Response:**
```json
{
  "success": true,
  "message": "Teacher deleted successfully"
}
```

#### Assign Students to Teacher
**Endpoint:** `POST /admin/teachers/{teacherId}/assign-students`

**Request:**
```json
{
  "studentIds": ["2024-Ajith", "2024-Rohan"],
  "quadrant": "wellness",
  "termId": "Term1"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "assignedCount": 2
  },
  "message": "Students assigned successfully"
}
```

### Reports Management

#### Generate Reports
**Endpoint:** `GET /admin/reports`

**Query Parameters:**
- `reportType`: Type of report (overview|performance|attendance|quadrant)
- `batch` (optional): Filter by batch
- `termId` (optional): Specific term ID
- `format` (optional): Response format (json|pdf|excel)

**Response:**
```json
{
  "success": true,
  "data": {
    "reportType": "overview",
    "generatedAt": "2024-01-15T14:30:00Z",
    "summary": {
      "totalStudents": 120,
      "averageScore": 82,
      "gradeDistribution": [
        {
          "grade": "A+",
          "count": 25,
          "percentage": 20.8
        }
      ]
    },
    "scoreDistribution": [
      {
        "range": "90-100",
        "count": 25
      }
    ],
    "quadrantPerformance": [
      {
        "quadrant": "Persona",
        "average": 35,
        "max": 50
      }
    ],
    "termComparison": [
      {
        "term": "Term 1",
        "average": 75
      }
    ]
  }
}
```

#### Export Report
**Endpoint:** `POST /admin/reports/export`

**Request:**
```json
{
  "reportType": "overview|performance|attendance|quadrant",
  "format": "pdf|excel",
  "filters": {
    "batch": "2024",
    "termId": "Term1",
    "quadrant": "persona"
  }
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "downloadUrl": "https://api.pep-score-nexus.com/downloads/report_123.pdf",
    "expiresAt": "2024-01-16T14:30:00Z"
  },
  "message": "Report generated successfully"
}
```

### Data Import Management

#### Upload Excel File
**Endpoint:** `POST /admin/import/excel`

**Request:** (multipart/form-data)
- `file`: Excel file
- `importType`: Type of import (students|scores|attendance)
- `termId` (optional): Specific term ID for score imports

**Response:**
```json
{
  "success": true,
  "data": {
    "importId": "import_123",
    "fileName": "student_data.xlsx",
    "fileSize": 1024000,
    "importType": "students",
    "status": "processing",
    "uploadedAt": "2024-01-15T14:30:00Z"
  },
  "message": "File uploaded successfully and processing started"
}
```

#### Get Import Status
**Endpoint:** `GET /admin/import/{importId}/status`

**Response:**
```json
{
  "success": true,
  "data": {
    "importId": "import_123",
    "status": "completed|processing|failed",
    "progress": 100,
    "processedRecords": 120,
    "totalRecords": 120,
    "errors": [],
    "warnings": [
      {
        "row": 5,
        "message": "Missing phone number for student"
      }
    ],
    "completedAt": "2024-01-15T14:35:00Z"
  }
}
```

#### Get Import History
**Endpoint:** `GET /admin/import/history`

**Query Parameters:**
- `page` (optional): Page number for pagination
- `limit` (optional): Number of items per page
- `importType` (optional): Filter by import type

**Response:**
```json
{
  "success": true,
  "data": {
    "imports": [
      {
        "id": "import_123",
        "fileName": "student_data.xlsx",
        "importType": "students",
        "status": "completed",
        "processedRecords": 120,
        "totalRecords": 120,
        "uploadedAt": "2024-01-15T14:30:00Z",
        "completedAt": "2024-01-15T14:35:00Z"
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 5,
      "totalItems": 50,
      "itemsPerPage": 10
    }
  }
}
```

## Common APIs

### Attendance Management

#### Get Attendance Data
**Endpoint:** `GET /students/{studentId}/attendance`

**Query Parameters:**
- `termId` (optional): Specific term ID
- `quadrant` (optional): Specific quadrant

**Response:**
```json
{
  "success": true,
  "data": {
    "overall": {
      "attendance": 90,
      "eligibility": "Eligible",
      "required": 80
    },
    "quadrants": [
      {
        "id": "persona",
        "name": "Persona",
        "attendance": 90,
        "eligibility": "Eligible",
        "required": 80
      },
      {
        "id": "wellness",
        "name": "Wellness",
        "attendance": 85,
        "eligibility": "Eligible",
        "required": 80
      }
    ],
    "history": [
      {
        "term": "Term 1",
        "overall": 90,
        "wellness": 85
      }
    ]
  }
}
```

#### Update Attendance
**Endpoint:** `POST /admin/students/{studentId}/attendance`

**Request:**
```json
{
  "termId": "Term1",
  "quadrant": "wellness",
  "attendancePercentage": 85,
  "notes": "Missed 3 sessions due to illness"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Attendance updated successfully"
}
```

### Notification Management

#### Get Notifications
**Endpoint:** `GET /users/{userId}/notifications`

**Query Parameters:**
- `unreadOnly` (optional): Boolean to get only unread notifications
- `type` (optional): Filter by notification type
- `page` (optional): Page number for pagination

**Response:**
```json
{
  "success": true,
  "data": {
    "notifications": [
      {
        "id": "notif_123",
        "type": "score_update",
        "title": "New Score Available",
        "message": "Your wellness score has been updated",
        "isRead": false,
        "createdAt": "2024-01-15T14:30:00Z",
        "data": {
          "quadrant": "wellness",
          "score": 28
        }
      }
    ],
    "unreadCount": 3,
    "pagination": {
      "currentPage": 1,
      "totalPages": 2,
      "totalItems": 15,
      "itemsPerPage": 10
    }
  }
}
```

#### Mark Notification as Read
**Endpoint:** `PUT /users/{userId}/notifications/{notificationId}/read`

**Response:**
```json
{
  "success": true,
  "message": "Notification marked as read"
}
```

#### Mark All Notifications as Read
**Endpoint:** `PUT /users/{userId}/notifications/read-all`

**Response:**
```json
{
  "success": true,
  "data": {
    "markedCount": 5
  },
  "message": "All notifications marked as read"
}
```

### File Management

#### Upload File
**Endpoint:** `POST /files/upload`

**Request:** (multipart/form-data)
- `file`: File to upload
- `type`: File type (profile_picture|document|report)
- `entityId`: Related entity ID (studentId, teacherId, etc.)

**Response:**
```json
{
  "success": true,
  "data": {
    "fileId": "file_123",
    "fileName": "document.pdf",
    "fileSize": 1024000,
    "mimeType": "application/pdf",
    "url": "https://api.pep-score-nexus.com/files/file_123",
    "uploadedAt": "2024-01-15T14:30:00Z"
  },
  "message": "File uploaded successfully"
}
```

#### Download File
**Endpoint:** `GET /files/{fileId}/download`

**Response:** File download with appropriate headers

### System Configuration

#### Get System Settings
**Endpoint:** `GET /admin/settings`

**Response:**
```json
{
  "success": true,
  "data": {
    "grading": {
      "scales": {
        "A+": { "min": 90, "max": 100 },
        "A": { "min": 80, "max": 89 },
        "B": { "min": 70, "max": 79 },
        "C": { "min": 60, "max": 69 },
        "D": { "min": 50, "max": 59 },
        "E": { "min": 40, "max": 49 },
        "IC": { "min": 0, "max": 39 }
      }
    },
    "attendance": {
      "minimumRequired": 80,
      "eligibilityThreshold": 80
    },
    "quadrants": [
      {
        "id": "persona",
        "name": "Persona",
        "weightage": 50,
        "components": [
          {
            "id": "anc",
            "name": "Analysis & Critical Thinking (A&C)",
            "maxScore": 5,
            "category": "SHL"
          }
        ]
      }
    ]
  }
}
```

#### Update System Settings
**Endpoint:** `PUT /admin/settings`

**Request:**
```json
{
  "grading": {
    "scales": {
      "A+": { "min": 90, "max": 100 }
    }
  },
  "attendance": {
    "minimumRequired": 80
  }
}
```

**Response:**
```json
{
  "success": true,
  "message": "Settings updated successfully"
}
```

## Error Handling

### Standard Error Response Format

All API endpoints follow a consistent error response format:

```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Human readable error message",
    "details": {
      "field": "Specific field error details"
    }
  },
  "timestamp": "2024-01-15T14:30:00Z"
}
```

### Common Error Codes

| Code | HTTP Status | Description |
|------|-------------|-------------|
| `INVALID_CREDENTIALS` | 401 | Invalid username or password |
| `UNAUTHORIZED` | 401 | Authentication required |
| `FORBIDDEN` | 403 | Insufficient permissions |
| `NOT_FOUND` | 404 | Resource not found |
| `VALIDATION_ERROR` | 400 | Request validation failed |
| `DUPLICATE_ENTRY` | 409 | Resource already exists |
| `SERVER_ERROR` | 500 | Internal server error |
| `SERVICE_UNAVAILABLE` | 503 | Service temporarily unavailable |

### Validation Errors

For validation errors, the response includes detailed field-level errors:

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Request validation failed",
    "details": {
      "email": "Invalid email format",
      "score": "Score must be between 0 and 5"
    }
  }
}
```

## Rate Limiting

### Rate Limit Headers

All API responses include rate limiting headers:

```
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1642262400
```

### Rate Limits by Role

| Role | Requests per Hour | Burst Limit |
|------|------------------|-------------|
| Student | 500 | 50 |
| Teacher | 1000 | 100 |
| Admin | 2000 | 200 |

## Pagination

### Standard Pagination Parameters

- `page`: Page number (default: 1)
- `limit`: Items per page (default: 10, max: 100)

### Pagination Response Format

```json
{
  "pagination": {
    "currentPage": 1,
    "totalPages": 10,
    "totalItems": 100,
    "itemsPerPage": 10,
    "hasNextPage": true,
    "hasPreviousPage": false
  }
}
```

## Data Models

### Core Data Types

#### Student
```typescript
interface Student {
  id: string;
  name: string;
  registrationNo: string;
  course: string;
  batch: string;
  section: string;
  houseName?: string;
  gender: 'Male' | 'Female' | 'Other';
  email?: string;
  phone?: string;
  currentTerm: string;
  totalScore: number;
  grade: Grade;
  overallStatus: StatusType;
}
```

#### QuadrantData
```typescript
interface QuadrantData {
  id: string;
  name: string;
  weightage: number;
  obtained: number;
  components: Component[];
  status: StatusType;
  attendance?: number;
  eligibility?: 'Eligible' | 'Not Eligible';
  rank?: number;
}
```

#### Component
```typescript
interface Component {
  id: string;
  name: string;
  score: number;
  maxScore: number;
  status?: StatusType;
  category?: 'SHL' | 'Professional';
  description?: string;
}
```

#### TermData
```typescript
interface TermData {
  termId: string;
  termName: string;
  quadrants: QuadrantData[];
  tests: TestScore[];
  totalScore: number;
  grade: Grade;
  overallStatus: StatusType;
}
```

#### Teacher
```typescript
interface Teacher {
  id: string;
  name: string;
  email: string;
  specialization: 'persona' | 'wellness' | 'behavior' | 'discipline';
  assignedStudents: number;
  status: 'active' | 'inactive';
  joinDate: string;
  quadrantAccess: string[];
}
```

### Enums

#### Grade
```typescript
type Grade = 'A+' | 'A' | 'B' | 'C' | 'D' | 'E' | 'IC';
```

#### StatusType
```typescript
type StatusType = 'Good' | 'Progress' | 'Deteriorate' | 'Cleared' | 'Not Cleared' | 'Attendance Shortage';
```

#### UserRole
```typescript
type UserRole = 'student' | 'teacher' | 'admin';
```

## API Usage Examples

### Authentication Flow

```javascript
// Login
const loginResponse = await fetch('/api/v1/auth/login', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    username: 'student',
    password: 'password'
  })
});

const { data } = await loginResponse.json();
const { token, refreshToken } = data;

// Use token for subsequent requests
const studentData = await fetch('/api/v1/students/2024-Ajith/performance', {
  headers: { 'Authorization': `Bearer ${token}` }
});
```

### Student Dashboard Data Fetching

```javascript
// Get student performance data
const performance = await fetch('/api/v1/students/2024-Ajith/performance?includeHistory=true', {
  headers: { 'Authorization': `Bearer ${token}` }
});

// Get leaderboard data
const leaderboard = await fetch('/api/v1/students/2024-Ajith/leaderboard', {
  headers: { 'Authorization': `Bearer ${token}` }
});
```

### Teacher Assessment Submission

```javascript
// Submit assessment
const assessment = await fetch('/api/v1/teachers/teacher-001/students/2024-Ajith/assessment', {
  method: 'POST',
  headers: {
    'Authorization': `Bearer ${token}`,
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    quadrant: 'wellness',
    termId: 'Term1',
    scores: {
      'push-ups': { score: 4, feedback: 'Good improvement' },
      'sit-ups': { score: 4, feedback: 'Excellent form' }
    },
    overallFeedback: 'Student shows consistent improvement',
    isDraft: false
  })
});
```

### Admin Bulk Operations

```javascript
// Import student data
const formData = new FormData();
formData.append('file', excelFile);
formData.append('importType', 'students');

const importResponse = await fetch('/api/v1/admin/import/excel', {
  method: 'POST',
  headers: { 'Authorization': `Bearer ${token}` },
  body: formData
});

// Generate report
const report = await fetch('/api/v1/admin/reports?reportType=overview&batch=2024&format=pdf', {
  headers: { 'Authorization': `Bearer ${token}` }
});
```

## Additional APIs and Features

### Behavior Rating Scale

#### Get Behavior Rating Scale Data
**Endpoint:** `GET /students/{studentId}/behavior-rating-scale`

**Query Parameters:**
- `termId` (optional): Specific term ID

**Response:**
```json
{
  "success": true,
  "data": {
    "ratingScale": {
      "description": "Behavior assessment using standardized rating scale",
      "categories": [
        {
          "id": "social_skills",
          "name": "Social Skills",
          "components": [
            {
              "id": "communication",
              "name": "Communication",
              "rating": 4,
              "maxRating": 5,
              "description": "Ability to communicate effectively with peers and faculty"
            }
          ]
        }
      ],
      "overallRating": 4.2,
      "maxRating": 5.0,
      "lastUpdated": "2024-01-15T10:30:00Z"
    }
  }
}
```

### Toast Notifications System

#### Get System Notifications
**Endpoint:** `GET /system/notifications`

**Query Parameters:**
- `type` (optional): Filter by notification type (info|success|warning|error)
- `active` (optional): Boolean to get only active notifications

**Response:**
```json
{
  "success": true,
  "data": {
    "notifications": [
      {
        "id": "system_notif_123",
        "type": "info",
        "title": "System Maintenance",
        "message": "Scheduled maintenance on Sunday 2AM-4AM",
        "isActive": true,
        "startDate": "2024-01-20T00:00:00Z",
        "endDate": "2024-01-21T23:59:59Z",
        "targetRoles": ["student", "teacher", "admin"]
      }
    ]
  }
}
```

#### Create System Notification (Admin Only)
**Endpoint:** `POST /admin/system/notifications`

**Request:**
```json
{
  "type": "info|success|warning|error",
  "title": "string",
  "message": "string",
  "targetRoles": ["student", "teacher", "admin"],
  "startDate": "2024-01-20T00:00:00Z",
  "endDate": "2024-01-21T23:59:59Z",
  "isActive": true
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "notificationId": "system_notif_123",
    "createdAt": "2024-01-15T14:30:00Z"
  },
  "message": "System notification created successfully"
}
```

### Mobile Responsiveness APIs

#### Get Mobile App Configuration
**Endpoint:** `GET /mobile/config`

**Response:**
```json
{
  "success": true,
  "data": {
    "appVersion": "1.0.0",
    "minSupportedVersion": "1.0.0",
    "features": {
      "offlineMode": true,
      "pushNotifications": true,
      "biometricAuth": false
    },
    "breakpoints": {
      "mobile": 768,
      "tablet": 1024,
      "desktop": 1280
    }
  }
}
```

### Theme and UI Preferences

#### Get User Theme Preferences
**Endpoint:** `GET /users/{userId}/theme`

**Response:**
```json
{
  "success": true,
  "data": {
    "theme": "light|dark|system",
    "primaryColor": "#3b82f6",
    "fontSize": "medium",
    "compactMode": false,
    "animations": true
  }
}
```

#### Update User Theme Preferences
**Endpoint:** `PUT /users/{userId}/theme`

**Request:**
```json
{
  "theme": "light|dark|system",
  "primaryColor": "#3b82f6",
  "fontSize": "small|medium|large",
  "compactMode": false,
  "animations": true
}
```

**Response:**
```json
{
  "success": true,
  "message": "Theme preferences updated successfully"
}
```

### Batch and Section Management

#### Get All Batches
**Endpoint:** `GET /admin/batches`

**Response:**
```json
{
  "success": true,
  "data": {
    "batches": [
      {
        "id": "2024",
        "name": "Batch 2024",
        "startDate": "2024-08-01T00:00:00Z",
        "endDate": "2026-07-31T23:59:59Z",
        "totalStudents": 120,
        "sections": ["A", "B", "C"],
        "status": "active"
      }
    ]
  }
}
```

#### Get All Sections
**Endpoint:** `GET /admin/sections`

**Query Parameters:**
- `batchId` (optional): Filter by specific batch

**Response:**
```json
{
  "success": true,
  "data": {
    "sections": [
      {
        "id": "A",
        "name": "Section A",
        "batchId": "2024",
        "studentCount": 40,
        "classTeacher": "Dr. Smith",
        "room": "Room 101"
      }
    ]
  }
}
```

### House System Management

#### Get All Houses
**Endpoint:** `GET /admin/houses`

**Response:**
```json
{
  "success": true,
  "data": {
    "houses": [
      {
        "id": "daredevils",
        "name": "Daredevils",
        "color": "#ff6b6b",
        "studentCount": 30,
        "houseLeader": "Student Name",
        "points": 450
      },
      {
        "id": "warriors",
        "name": "Warriors",
        "color": "#4ecdc4",
        "studentCount": 28,
        "houseLeader": "Student Name",
        "points": 420
      }
    ]
  }
}
```

#### Update House Points
**Endpoint:** `POST /admin/houses/{houseId}/points`

**Request:**
```json
{
  "points": 50,
  "reason": "Excellence in sports competition",
  "awardedBy": "teacher-001"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "newTotal": 500,
    "pointsAdded": 50
  },
  "message": "House points updated successfully"
}
```

### Advanced Search and Filtering

#### Advanced Student Search
**Endpoint:** `POST /admin/students/advanced-search`

**Request:**
```json
{
  "filters": {
    "batch": ["2024", "2023"],
    "section": ["A", "B"],
    "house": ["daredevils", "warriors"],
    "gradeRange": {
      "min": "B",
      "max": "A+"
    },
    "scoreRange": {
      "min": 70,
      "max": 100
    },
    "attendanceRange": {
      "min": 80,
      "max": 100
    },
    "status": ["Good", "Progress"]
  },
  "sortBy": "score|name|attendance",
  "sortOrder": "asc|desc",
  "page": 1,
  "limit": 20
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "students": [
      {
        "id": "2024-Ajith",
        "name": "Ajith",
        "registrationNo": "2334",
        "batch": "2024",
        "section": "A",
        "house": "Daredevils",
        "totalScore": 95,
        "grade": "A+",
        "attendance": 90,
        "status": "Good"
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 5,
      "totalItems": 95,
      "itemsPerPage": 20
    },
    "summary": {
      "totalMatched": 95,
      "averageScore": 82.5,
      "averageAttendance": 87.2
    }
  }
}
```

### Audit and Logging APIs

#### Get Audit Logs (Admin Only)
**Endpoint:** `GET /admin/audit-logs`

**Query Parameters:**
- `userId` (optional): Filter by specific user
- `action` (optional): Filter by action type
- `startDate` (optional): Start date for log range
- `endDate` (optional): End date for log range
- `page` (optional): Page number for pagination
- `limit` (optional): Number of items per page

**Response:**
```json
{
  "success": true,
  "data": {
    "logs": [
      {
        "id": "audit_123",
        "userId": "2024-Ajith",
        "userRole": "student",
        "action": "LOGIN",
        "resource": "/student/dashboard",
        "ipAddress": "192.168.1.100",
        "userAgent": "Mozilla/5.0...",
        "timestamp": "2024-01-15T14:30:00Z",
        "details": {
          "sessionId": "session_456",
          "success": true
        }
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 50,
      "totalItems": 1000,
      "itemsPerPage": 20
    }
  }
}
```

### Backup and Data Export

#### Create System Backup (Admin Only)
**Endpoint:** `POST /admin/backup`

**Request:**
```json
{
  "backupType": "full|incremental",
  "includeFiles": true,
  "includeDatabase": true,
  "compression": true
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "backupId": "backup_123",
    "status": "initiated",
    "estimatedTime": "15 minutes",
    "backupSize": "2.5 GB"
  },
  "message": "Backup process initiated"
}
```

#### Get Backup Status
**Endpoint:** `GET /admin/backup/{backupId}/status`

**Response:**
```json
{
  "success": true,
  "data": {
    "backupId": "backup_123",
    "status": "completed|in_progress|failed",
    "progress": 100,
    "startTime": "2024-01-15T14:30:00Z",
    "endTime": "2024-01-15T14:45:00Z",
    "fileSize": "2.3 GB",
    "downloadUrl": "https://api.pep-score-nexus.com/downloads/backup_123.zip",
    "expiresAt": "2024-01-22T14:45:00Z"
  }
}
```

### Integration APIs

#### SHL API Integration
**Endpoint:** `POST /admin/integrations/shl/sync`

**Request:**
```json
{
  "studentIds": ["2024-Ajith", "2024-Rohan"],
  "assessmentType": "competency|personality",
  "forceUpdate": false
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "syncId": "sync_123",
    "studentsProcessed": 2,
    "studentsUpdated": 1,
    "studentsSkipped": 1,
    "errors": [],
    "completedAt": "2024-01-15T14:30:00Z"
  },
  "message": "SHL data sync completed"
}
```

#### Email Service Integration
**Endpoint:** `POST /admin/integrations/email/send-bulk`

**Request:**
```json
{
  "recipients": {
    "students": ["2024-Ajith"],
    "teachers": ["teacher-001"],
    "admins": ["admin-001"]
  },
  "template": "score_update|feedback_notification|system_alert",
  "subject": "Your PEP Scores Have Been Updated",
  "variables": {
    "studentName": "Ajith",
    "newScore": 95,
    "term": "Term 1"
  },
  "priority": "normal|high|urgent"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "emailJobId": "email_job_123",
    "totalRecipients": 3,
    "emailsQueued": 3,
    "estimatedDelivery": "2024-01-15T14:35:00Z"
  },
  "message": "Bulk email job queued successfully"
}
```

### Performance Analytics

#### Get System Performance Metrics (Admin Only)
**Endpoint:** `GET /admin/performance/metrics`

**Query Parameters:**
- `timeRange` (optional): Time range for metrics (1h|24h|7d|30d)
- `metric` (optional): Specific metric to retrieve

**Response:**
```json
{
  "success": true,
  "data": {
    "systemHealth": {
      "status": "healthy",
      "uptime": "99.9%",
      "lastDowntime": "2024-01-10T02:00:00Z"
    },
    "performance": {
      "averageResponseTime": 250,
      "peakResponseTime": 1200,
      "requestsPerMinute": 150,
      "errorRate": 0.1
    },
    "usage": {
      "activeUsers": 85,
      "peakConcurrentUsers": 120,
      "totalSessions": 450,
      "averageSessionDuration": "25 minutes"
    },
    "database": {
      "connectionPoolUsage": 65,
      "queryPerformance": "optimal",
      "storageUsed": "2.3 GB",
      "storageAvailable": "47.7 GB"
    }
  }
}
```

### Caching and Optimization

#### Clear Cache (Admin Only)
**Endpoint:** `POST /admin/cache/clear`

**Request:**
```json
{
  "cacheType": "all|user_sessions|student_data|reports|static_assets",
  "specificKeys": ["student_2024-Ajith", "leaderboard_Term1"]
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "clearedKeys": 150,
    "cacheSize": "45 MB",
    "clearTime": "2.3 seconds"
  },
  "message": "Cache cleared successfully"
}
```

#### Get Cache Statistics
**Endpoint:** `GET /admin/cache/stats`

**Response:**
```json
{
  "success": true,
  "data": {
    "totalSize": "128 MB",
    "hitRate": 89.5,
    "missRate": 10.5,
    "evictionRate": 2.1,
    "keyCount": 2450,
    "oldestEntry": "2024-01-14T10:00:00Z",
    "newestEntry": "2024-01-15T14:30:00Z"
  }
}
```

## Security and Compliance

### Security Headers
All API responses include security headers:

```
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
X-XSS-Protection: 1; mode=block
Strict-Transport-Security: max-age=31536000; includeSubDomains
Content-Security-Policy: default-src 'self'
```

### Data Privacy and GDPR Compliance

#### Request Data Export (GDPR)
**Endpoint:** `POST /users/{userId}/data-export`

**Request:**
```json
{
  "format": "json|csv|pdf",
  "includePersonalData": true,
  "includePerformanceData": true,
  "includeActivityLogs": false
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "exportId": "export_123",
    "status": "processing",
    "estimatedCompletion": "2024-01-15T15:00:00Z"
  },
  "message": "Data export request submitted"
}
```

#### Request Data Deletion (GDPR)
**Endpoint:** `POST /users/{userId}/data-deletion`

**Request:**
```json
{
  "reason": "User request|Account closure|GDPR compliance",
  "retainAcademicRecords": true,
  "confirmDeletion": true
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "deletionId": "deletion_123",
    "scheduledDate": "2024-01-30T00:00:00Z",
    "retentionPeriod": "7 years"
  },
  "message": "Data deletion request scheduled"
}
```

## Intervention System APIs

### Overview
The Intervention System allows admins to create structured courses/programs that span multiple quadrants, assign teachers and student batches, and manage comprehensive assessments with weighted scoring.

### Admin Intervention Management

#### Create Intervention
**Endpoint:** `POST /admin/interventions`

**Request:**
```json
{
  "name": "Leadership Development Program",
  "description": "Comprehensive leadership training combining persona and behavior development",
  "startDate": "2024-02-01T00:00:00Z",
  "endDate": "2024-05-31T23:59:59Z",
  "quadrants": [
    {
      "quadrantId": "persona",
      "weightage": 60,
      "components": ["leadership", "communication", "teamwork"]
    },
    {
      "quadrantId": "behavior",
      "weightage": 40,
      "components": ["participation", "manners", "preparation"]
    }
  ],
  "prerequisites": ["intervention_001"],
  "maxStudents": 50,
  "objectives": [
    "Develop leadership skills",
    "Improve communication abilities",
    "Enhance team collaboration"
  ]
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "interventionId": "intervention_123",
    "name": "Leadership Development Program",
    "status": "draft",
    "createdAt": "2024-01-15T14:30:00Z",
    "totalWeightage": 100
  },
  "message": "Intervention created successfully"
}
```

#### Get All Interventions
**Endpoint:** `GET /admin/interventions`

**Query Parameters:**
- `status` (optional): Filter by status (draft|active|completed|archived)
- `quadrant` (optional): Filter by quadrant involvement
- `startDate` (optional): Filter by start date range
- `endDate` (optional): Filter by end date range
- `page` (optional): Page number for pagination
- `limit` (optional): Number of items per page

**Response:**
```json
{
  "success": true,
  "data": {
    "interventions": [
      {
        "id": "intervention_123",
        "name": "Leadership Development Program",
        "description": "Comprehensive leadership training",
        "startDate": "2024-02-01T00:00:00Z",
        "endDate": "2024-05-31T23:59:59Z",
        "status": "active",
        "quadrants": [
          {
            "quadrantId": "persona",
            "quadrantName": "Persona",
            "weightage": 60
          },
          {
            "quadrantId": "behavior",
            "quadrantName": "Behavior",
            "weightage": 40
          }
        ],
        "assignedTeachers": 3,
        "enrolledStudents": 45,
        "maxStudents": 50,
        "completionRate": 78.5,
        "averageScore": 82.3
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 5,
      "totalItems": 25,
      "itemsPerPage": 10
    }
  }
}
```

#### Get Intervention Details
**Endpoint:** `GET /admin/interventions/{interventionId}`

**Response:**
```json
{
  "success": true,
  "data": {
    "intervention": {
      "id": "intervention_123",
      "name": "Leadership Development Program",
      "description": "Comprehensive leadership training combining persona and behavior development",
      "startDate": "2024-02-01T00:00:00Z",
      "endDate": "2024-05-31T23:59:59Z",
      "status": "active",
      "quadrants": [
        {
          "quadrantId": "persona",
          "quadrantName": "Persona",
          "weightage": 60,
          "components": ["leadership", "communication", "teamwork"]
        }
      ],
      "prerequisites": [
        {
          "interventionId": "intervention_001",
          "interventionName": "Basic Communication Skills"
        }
      ],
      "objectives": [
        "Develop leadership skills",
        "Improve communication abilities"
      ],
      "maxStudents": 50,
      "createdAt": "2024-01-15T14:30:00Z",
      "createdBy": "admin-001"
    },
    "assignments": {
      "teachers": [
        {
          "teacherId": "teacher-001",
          "teacherName": "Dr. Smith",
          "specialization": "persona",
          "assignedQuadrants": ["persona"],
          "assignedAt": "2024-01-16T10:00:00Z"
        }
      ],
      "batches": [
        {
          "batchId": "2024",
          "batchName": "Batch 2024",
          "enrolledStudents": 45,
          "assignedAt": "2024-01-16T11:00:00Z"
        }
      ]
    },
    "statistics": {
      "totalTasks": 12,
      "completedTasks": 8,
      "averageScore": 82.3,
      "completionRate": 78.5,
      "topPerformers": [
        {
          "studentId": "2024-Ajith",
          "studentName": "Ajith",
          "score": 95.2
        }
      ]
    }
  }
}
```

#### Update Intervention
**Endpoint:** `PUT /admin/interventions/{interventionId}`

**Request:**
```json
{
  "name": "Advanced Leadership Development Program",
  "description": "Updated comprehensive leadership training",
  "endDate": "2024-06-30T23:59:59Z",
  "quadrants": [
    {
      "quadrantId": "persona",
      "weightage": 70,
      "components": ["leadership", "communication", "teamwork", "negotiation"]
    },
    {
      "quadrantId": "behavior",
      "weightage": 30,
      "components": ["participation", "manners"]
    }
  ],
  "maxStudents": 60
}
```

**Response:**
```json
{
  "success": true,
  "message": "Intervention updated successfully"
}
```

#### Delete Intervention
**Endpoint:** `DELETE /admin/interventions/{interventionId}`

**Response:**
```json
{
  "success": true,
  "message": "Intervention deleted successfully"
}
```

### Teacher Assignment Management

#### Assign Teachers to Intervention
**Endpoint:** `POST /admin/interventions/{interventionId}/assign-teachers`

**Request:**
```json
{
  "assignments": [
    {
      "teacherId": "teacher-001",
      "quadrants": ["persona"],
      "role": "lead|assistant",
      "permissions": ["create_tasks", "score_tasks", "view_reports"]
    },
    {
      "teacherId": "teacher-002",
      "quadrants": ["behavior"],
      "role": "lead",
      "permissions": ["create_tasks", "score_tasks", "view_reports"]
    }
  ]
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "assignedTeachers": 2,
    "assignments": [
      {
        "teacherId": "teacher-001",
        "teacherName": "Dr. Smith",
        "quadrants": ["persona"],
        "role": "lead",
        "assignedAt": "2024-01-15T14:30:00Z"
      }
    ]
  },
  "message": "Teachers assigned successfully"
}
```

#### Remove Teacher from Intervention
**Endpoint:** `DELETE /admin/interventions/{interventionId}/teachers/{teacherId}`

**Response:**
```json
{
  "success": true,
  "message": "Teacher removed from intervention successfully"
}
```

### Student Batch Assignment Management

#### Assign Student Batches to Intervention
**Endpoint:** `POST /admin/interventions/{interventionId}/assign-batches`

**Request:**
```json
{
  "batches": [
    {
      "batchId": "2024",
      "sections": ["A", "B"],
      "enrollmentType": "mandatory|optional",
      "enrollmentDeadline": "2024-01-31T23:59:59Z"
    },
    {
      "batchId": "2023",
      "sections": ["A"],
      "enrollmentType": "optional",
      "enrollmentDeadline": "2024-02-15T23:59:59Z"
    }
  ]
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "assignedBatches": 2,
    "enrolledStudents": 78,
    "assignments": [
      {
        "batchId": "2024",
        "batchName": "Batch 2024",
        "sections": ["A", "B"],
        "enrolledStudents": 60,
        "enrollmentType": "mandatory",
        "assignedAt": "2024-01-15T14:30:00Z"
      }
    ]
  },
  "message": "Student batches assigned successfully"
}
```

#### Get Intervention Enrollments
**Endpoint:** `GET /admin/interventions/{interventionId}/enrollments`

**Query Parameters:**
- `batchId` (optional): Filter by specific batch
- `section` (optional): Filter by section
- `enrollmentStatus` (optional): Filter by status (enrolled|pending|dropped)

**Response:**
```json
{
  "success": true,
  "data": {
    "enrollments": [
      {
        "studentId": "2024-Ajith",
        "studentName": "Ajith",
        "registrationNo": "2334",
        "batch": "2024",
        "section": "A",
        "enrollmentDate": "2024-01-16T10:00:00Z",
        "enrollmentStatus": "enrolled",
        "progress": {
          "completedTasks": 5,
          "totalTasks": 8,
          "currentScore": 85.5,
          "lastActivity": "2024-01-20T14:30:00Z"
        }
      }
    ],
    "summary": {
      "totalEnrolled": 78,
      "activeStudents": 75,
      "droppedStudents": 3,
      "averageProgress": 67.8,
      "averageScore": 82.3
    }
  }
}
```

## Teacher Intervention APIs

### Teacher Intervention Dashboard

#### Get Assigned Interventions
**Endpoint:** `GET /teachers/{teacherId}/interventions`

**Query Parameters:**
- `status` (optional): Filter by status (active|upcoming|completed)
- `quadrant` (optional): Filter by assigned quadrant

**Response:**
```json
{
  "success": true,
  "data": {
    "interventions": [
      {
        "id": "intervention_123",
        "name": "Leadership Development Program",
        "description": "Comprehensive leadership training",
        "startDate": "2024-02-01T00:00:00Z",
        "endDate": "2024-05-31T23:59:59Z",
        "status": "active",
        "role": "lead",
        "assignedQuadrants": ["persona"],
        "enrolledStudents": 45,
        "pendingTasks": 3,
        "completedTasks": 5,
        "averageScore": 82.3,
        "lastActivity": "2024-01-20T14:30:00Z"
      }
    ],
    "summary": {
      "totalInterventions": 3,
      "activeInterventions": 2,
      "totalStudents": 120,
      "pendingAssessments": 15,
      "averageScore": 84.2
    }
  }
}
```

#### Get Intervention Details for Teacher
**Endpoint:** `GET /teachers/{teacherId}/interventions/{interventionId}`

**Response:**
```json
{
  "success": true,
  "data": {
    "intervention": {
      "id": "intervention_123",
      "name": "Leadership Development Program",
      "description": "Comprehensive leadership training",
      "startDate": "2024-02-01T00:00:00Z",
      "endDate": "2024-05-31T23:59:59Z",
      "status": "active",
      "assignedQuadrants": ["persona"],
      "role": "lead",
      "permissions": ["create_tasks", "score_tasks", "view_reports"]
    },
    "students": [
      {
        "studentId": "2024-Ajith",
        "studentName": "Ajith",
        "registrationNo": "2334",
        "batch": "2024",
        "section": "A",
        "progress": {
          "completedTasks": 5,
          "totalTasks": 8,
          "currentScore": 85.5,
          "lastSubmission": "2024-01-20T14:30:00Z"
        },
        "quadrantScores": {
          "persona": 42.5
        }
      }
    ],
    "tasks": [
      {
        "taskId": "task_001",
        "taskName": "Leadership Case Study",
        "quadrant": "persona",
        "component": "leadership",
        "maxScore": 10,
        "dueDate": "2024-02-15T23:59:59Z",
        "status": "active",
        "submissionsCount": 35,
        "totalStudents": 45
      }
    ]
  }
}
```

### Task Management

#### Create Task
**Endpoint:** `POST /teachers/{teacherId}/interventions/{interventionId}/tasks`

**Request:**
```json
{
  "taskName": "Leadership Case Study Analysis",
  "description": "Analyze a complex leadership scenario and provide solutions",
  "quadrant": "persona",
  "component": "leadership",
  "maxScore": 10,
  "dueDate": "2024-02-15T23:59:59Z",
  "instructions": "Read the provided case study and submit a 2-page analysis",
  "rubric": [
    {
      "criteria": "Analysis Quality",
      "maxPoints": 4,
      "description": "Depth and accuracy of analysis"
    },
    {
      "criteria": "Solution Viability",
      "maxPoints": 3,
      "description": "Practicality of proposed solutions"
    },
    {
      "criteria": "Communication",
      "maxPoints": 3,
      "description": "Clarity and structure of presentation"
    }
  ],
  "attachments": ["case_study.pdf"],
  "submissionType": "document|presentation|video",
  "allowLateSubmission": true,
  "latePenalty": 10
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "taskId": "task_001",
    "taskName": "Leadership Case Study Analysis",
    "status": "active",
    "createdAt": "2024-01-15T14:30:00Z",
    "assignedStudents": 45
  },
  "message": "Task created successfully"
}
```

#### Get Tasks for Intervention
**Endpoint:** `GET /teachers/{teacherId}/interventions/{interventionId}/tasks`

**Query Parameters:**
- `quadrant` (optional): Filter by quadrant
- `status` (optional): Filter by status (active|completed|draft)
- `dueDate` (optional): Filter by due date range

**Response:**
```json
{
  "success": true,
  "data": {
    "tasks": [
      {
        "taskId": "task_001",
        "taskName": "Leadership Case Study Analysis",
        "quadrant": "persona",
        "component": "leadership",
        "maxScore": 10,
        "dueDate": "2024-02-15T23:59:59Z",
        "status": "active",
        "createdAt": "2024-01-15T14:30:00Z",
        "submissions": {
          "total": 45,
          "submitted": 35,
          "pending": 10,
          "graded": 20,
          "averageScore": 7.8
        }
      }
    ]
  }
}
```

#### Update Task
**Endpoint:** `PUT /teachers/{teacherId}/interventions/{interventionId}/tasks/{taskId}`

**Request:**
```json
{
  "taskName": "Advanced Leadership Case Study Analysis",
  "description": "Updated analysis requirements",
  "dueDate": "2024-02-20T23:59:59Z",
  "maxScore": 15,
  "allowLateSubmission": false
}
```

**Response:**
```json
{
  "success": true,
  "message": "Task updated successfully"
}
```

#### Delete Task
**Endpoint:** `DELETE /teachers/{teacherId}/interventions/{interventionId}/tasks/{taskId}`

**Response:**
```json
{
  "success": true,
  "message": "Task deleted successfully"
}
```

### Task Scoring and Assessment

#### Get Task Submissions
**Endpoint:** `GET /teachers/{teacherId}/interventions/{interventionId}/tasks/{taskId}/submissions`

**Query Parameters:**
- `status` (optional): Filter by status (submitted|graded|pending)
- `studentId` (optional): Filter by specific student

**Response:**
```json
{
  "success": true,
  "data": {
    "task": {
      "taskId": "task_001",
      "taskName": "Leadership Case Study Analysis",
      "maxScore": 10,
      "dueDate": "2024-02-15T23:59:59Z"
    },
    "submissions": [
      {
        "submissionId": "sub_001",
        "studentId": "2024-Ajith",
        "studentName": "Ajith",
        "registrationNo": "2334",
        "submittedAt": "2024-02-14T16:30:00Z",
        "status": "submitted",
        "isLate": false,
        "attachments": ["ajith_analysis.pdf"],
        "score": null,
        "feedback": null,
        "gradedAt": null
      },
      {
        "submissionId": "sub_002",
        "studentId": "2024-Rohan",
        "studentName": "Rohan S",
        "registrationNo": "2335",
        "submittedAt": "2024-02-13T14:20:00Z",
        "status": "graded",
        "isLate": false,
        "attachments": ["rohan_analysis.pdf"],
        "score": 8.5,
        "feedback": "Excellent analysis with practical solutions",
        "gradedAt": "2024-02-16T10:00:00Z"
      }
    ],
    "statistics": {
      "totalSubmissions": 35,
      "pendingGrading": 15,
      "averageScore": 7.8,
      "onTimeSubmissions": 32,
      "lateSubmissions": 3
    }
  }
}
```

#### Submit Task Score
**Endpoint:** `POST /teachers/{teacherId}/interventions/{interventionId}/tasks/{taskId}/submissions/{submissionId}/score`

**Request:**
```json
{
  "score": 8.5,
  "maxScore": 10,
  "rubricScores": [
    {
      "criteria": "Analysis Quality",
      "score": 3.5,
      "maxPoints": 4,
      "feedback": "Good depth of analysis, could be more detailed"
    },
    {
      "criteria": "Solution Viability",
      "score": 3,
      "maxPoints": 3,
      "feedback": "Excellent practical solutions"
    },
    {
      "criteria": "Communication",
      "score": 2,
      "maxPoints": 3,
      "feedback": "Clear but could be better structured"
    }
  ],
  "overallFeedback": "Good work overall. Focus on improving structure and detail in analysis.",
  "privateNotes": "Student shows strong potential in leadership thinking"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "submissionId": "sub_001",
    "score": 8.5,
    "gradedAt": "2024-02-16T10:00:00Z",
    "studentNotified": true
  },
  "message": "Score submitted successfully"
}
```

#### Bulk Score Submissions
**Endpoint:** `POST /teachers/{teacherId}/interventions/{interventionId}/tasks/{taskId}/bulk-score`

**Request:**
```json
{
  "scores": [
    {
      "submissionId": "sub_001",
      "studentId": "2024-Ajith",
      "score": 8.5,
      "feedback": "Good analysis with room for improvement"
    },
    {
      "submissionId": "sub_002",
      "studentId": "2024-Rohan",
      "score": 9.0,
      "feedback": "Excellent work with innovative solutions"
    }
  ]
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "gradedSubmissions": 2,
    "averageScore": 8.75,
    "studentsNotified": 2
  },
  "message": "Bulk scoring completed successfully"
}
```

## Student Intervention APIs

### Student Intervention Dashboard

#### Get Student Interventions
**Endpoint:** `GET /students/{studentId}/interventions`

**Query Parameters:**
- `status` (optional): Filter by status (active|upcoming|completed)
- `quadrant` (optional): Filter by quadrant involvement

**Response:**
```json
{
  "success": true,
  "data": {
    "interventions": [
      {
        "id": "intervention_123",
        "name": "Leadership Development Program",
        "description": "Comprehensive leadership training",
        "startDate": "2024-02-01T00:00:00Z",
        "endDate": "2024-05-31T23:59:59Z",
        "status": "active",
        "enrollmentDate": "2024-01-16T10:00:00Z",
        "progress": {
          "completedTasks": 5,
          "totalTasks": 8,
          "completionPercentage": 62.5,
          "currentScore": 85.5,
          "lastActivity": "2024-01-20T14:30:00Z"
        },
        "quadrants": [
          {
            "quadrantId": "persona",
            "quadrantName": "Persona",
            "weightage": 60,
            "currentScore": 42.5,
            "maxScore": 60
          },
          {
            "quadrantId": "behavior",
            "quadrantName": "Behavior",
            "weightage": 40,
            "currentScore": 32.0,
            "maxScore": 40
          }
        ],
        "upcomingDeadlines": [
          {
            "taskId": "task_003",
            "taskName": "Team Leadership Exercise",
            "dueDate": "2024-02-25T23:59:59Z",
            "daysRemaining": 5
          }
        ]
      }
    ],
    "summary": {
      "totalInterventions": 3,
      "activeInterventions": 2,
      "completedInterventions": 1,
      "overallProgress": 67.8,
      "averageScore": 82.3,
      "pendingTasks": 6
    }
  }
}
```

#### Get Intervention Details for Student
**Endpoint:** `GET /students/{studentId}/interventions/{interventionId}`

**Response:**
```json
{
  "success": true,
  "data": {
    "intervention": {
      "id": "intervention_123",
      "name": "Leadership Development Program",
      "description": "Comprehensive leadership training combining persona and behavior development",
      "startDate": "2024-02-01T00:00:00Z",
      "endDate": "2024-05-31T23:59:59Z",
      "status": "active",
      "objectives": [
        "Develop leadership skills",
        "Improve communication abilities",
        "Enhance team collaboration"
      ],
      "enrollmentDate": "2024-01-16T10:00:00Z"
    },
    "progress": {
      "completedTasks": 5,
      "totalTasks": 8,
      "completionPercentage": 62.5,
      "currentScore": 85.5,
      "maxScore": 100,
      "rank": 3,
      "totalStudents": 45
    },
    "quadrantBreakdown": [
      {
        "quadrantId": "persona",
        "quadrantName": "Persona",
        "weightage": 60,
        "currentScore": 42.5,
        "maxScore": 60,
        "tasks": [
          {
            "taskId": "task_001",
            "taskName": "Leadership Case Study",
            "score": 8.5,
            "maxScore": 10,
            "submittedAt": "2024-02-14T16:30:00Z",
            "gradedAt": "2024-02-16T10:00:00Z",
            "feedback": "Good analysis with room for improvement"
          }
        ]
      }
    ],
    "teachers": [
      {
        "teacherId": "teacher-001",
        "teacherName": "Dr. Smith",
        "specialization": "persona",
        "quadrants": ["persona"]
      }
    ],
    "leaderboard": {
      "topStudents": [
        {
          "studentId": "2024-Rohan",
          "studentName": "Rohan S",
          "score": 92.5
        },
        {
          "studentId": "2024-Priya",
          "studentName": "Priya K",
          "score": 89.2
        },
        {
          "studentId": "2024-Ajith",
          "studentName": "Ajith",
          "score": 85.5
        }
      ],
      "userRank": 3,
      "batchAverage": 78.4
    }
  }
}
```

### Student Task Management

#### Get Student Tasks
**Endpoint:** `GET /students/{studentId}/interventions/{interventionId}/tasks`

**Query Parameters:**
- `status` (optional): Filter by status (pending|submitted|graded|overdue)
- `quadrant` (optional): Filter by quadrant

**Response:**
```json
{
  "success": true,
  "data": {
    "tasks": [
      {
        "taskId": "task_001",
        "taskName": "Leadership Case Study Analysis",
        "description": "Analyze a complex leadership scenario",
        "quadrant": "persona",
        "component": "leadership",
        "maxScore": 10,
        "dueDate": "2024-02-15T23:59:59Z",
        "status": "graded",
        "submission": {
          "submissionId": "sub_001",
          "submittedAt": "2024-02-14T16:30:00Z",
          "score": 8.5,
          "feedback": "Good analysis with room for improvement",
          "gradedAt": "2024-02-16T10:00:00Z"
        }
      },
      {
        "taskId": "task_003",
        "taskName": "Team Leadership Exercise",
        "description": "Lead a team project simulation",
        "quadrant": "persona",
        "component": "teamwork",
        "maxScore": 15,
        "dueDate": "2024-02-25T23:59:59Z",
        "status": "pending",
        "daysRemaining": 5,
        "instructions": "Form a team and complete the assigned project simulation",
        "attachments": ["project_brief.pdf"]
      }
    ]
  }
}
```

#### Submit Task
**Endpoint:** `POST /students/{studentId}/interventions/{interventionId}/tasks/{taskId}/submit`

**Request:** (multipart/form-data)
- `files`: Task submission files
- `notes`: Optional submission notes

**Response:**
```json
{
  "success": true,
  "data": {
    "submissionId": "sub_001",
    "taskId": "task_001",
    "submittedAt": "2024-02-14T16:30:00Z",
    "status": "submitted",
    "isLate": false,
    "files": ["ajith_analysis.pdf"]
  },
  "message": "Task submitted successfully"
}
```

### Intervention Score Integration

#### Get Intervention Impact on Quadrant Scores
**Endpoint:** `GET /students/{studentId}/interventions/quadrant-impact`

**Query Parameters:**
- `termId` (optional): Specific term ID
- `quadrant` (optional): Specific quadrant

**Response:**
```json
{
  "success": true,
  "data": {
    "quadrantScores": [
      {
        "quadrantId": "persona",
        "quadrantName": "Persona",
        "baseScore": 35.0,
        "interventionContribution": 12.5,
        "totalScore": 47.5,
        "maxScore": 50,
        "interventions": [
          {
            "interventionId": "intervention_123",
            "interventionName": "Leadership Development Program",
            "contribution": 8.5,
            "weightage": 60,
            "status": "active"
          },
          {
            "interventionId": "intervention_124",
            "interventionName": "Communication Skills Workshop",
            "contribution": 4.0,
            "weightage": 40,
            "status": "completed"
          }
        ]
      }
    ],
    "overallImpact": {
      "totalBaseScore": 70.0,
      "totalInterventionContribution": 25.0,
      "finalScore": 95.0,
      "improvementPercentage": 35.7
    }
  }
}
```

## Intervention Reporting and Analytics

### Admin Intervention Reports

#### Get Intervention Performance Report
**Endpoint:** `GET /admin/interventions/{interventionId}/reports`

**Query Parameters:**
- `reportType`: Type of report (overview|detailed|progress|comparison)
- `format` (optional): Response format (json|pdf|excel)

**Response:**
```json
{
  "success": true,
  "data": {
    "intervention": {
      "id": "intervention_123",
      "name": "Leadership Development Program",
      "startDate": "2024-02-01T00:00:00Z",
      "endDate": "2024-05-31T23:59:59Z",
      "status": "active"
    },
    "performance": {
      "enrolledStudents": 45,
      "activeStudents": 43,
      "droppedStudents": 2,
      "averageScore": 82.3,
      "completionRate": 78.5,
      "averageProgress": 67.8
    },
    "quadrantPerformance": [
      {
        "quadrantId": "persona",
        "quadrantName": "Persona",
        "weightage": 60,
        "averageScore": 42.5,
        "maxScore": 60,
        "topPerformers": [
          {
            "studentId": "2024-Rohan",
            "studentName": "Rohan S",
            "score": 55.5
          }
        ],
        "improvementAreas": [
          {
            "component": "leadership",
            "averageScore": 7.2,
            "maxScore": 10,
            "studentsNeedingHelp": 12
          }
        ]
      }
    ],
    "taskAnalysis": [
      {
        "taskId": "task_001",
        "taskName": "Leadership Case Study",
        "averageScore": 7.8,
        "maxScore": 10,
        "submissionRate": 95.6,
        "onTimeSubmissionRate": 88.9
      }
    ],
    "teacherPerformance": [
      {
        "teacherId": "teacher-001",
        "teacherName": "Dr. Smith",
        "quadrants": ["persona"],
        "studentsAssigned": 45,
        "averageScore": 82.3,
        "gradingEfficiency": 95.2,
        "studentSatisfaction": 4.6
      }
    ]
  }
}
```

#### Compare Interventions
**Endpoint:** `GET /admin/interventions/compare`

**Query Parameters:**
- `interventionIds`: Comma-separated list of intervention IDs
- `metrics`: Comma-separated list of metrics to compare

**Response:**
```json
{
  "success": true,
  "data": {
    "comparison": [
      {
        "interventionId": "intervention_123",
        "interventionName": "Leadership Development Program",
        "metrics": {
          "averageScore": 82.3,
          "completionRate": 78.5,
          "studentSatisfaction": 4.6,
          "enrollmentCount": 45
        }
      },
      {
        "interventionId": "intervention_124",
        "interventionName": "Communication Skills Workshop",
        "metrics": {
          "averageScore": 79.1,
          "completionRate": 85.2,
          "studentSatisfaction": 4.4,
          "enrollmentCount": 38
        }
      }
    ],
    "insights": [
      "Leadership Development Program has higher average scores",
      "Communication Skills Workshop has better completion rates",
      "Both interventions show high student satisfaction"
    ]
  }
}
```

## Intervention Data Models

### Core Intervention Types

#### Intervention
```typescript
interface Intervention {
  id: string;
  name: string;
  description: string;
  startDate: string;
  endDate: string;
  status: 'draft' | 'active' | 'completed' | 'archived';
  quadrants: InterventionQuadrant[];
  prerequisites: string[];
  maxStudents: number;
  objectives: string[];
  createdAt: string;
  createdBy: string;
}
```

#### InterventionQuadrant
```typescript
interface InterventionQuadrant {
  quadrantId: string;
  quadrantName: string;
  weightage: number;
  components: string[];
}
```

#### InterventionAssignment
```typescript
interface InterventionAssignment {
  interventionId: string;
  teachers: TeacherAssignment[];
  batches: BatchAssignment[];
  createdAt: string;
}
```

#### TeacherAssignment
```typescript
interface TeacherAssignment {
  teacherId: string;
  teacherName: string;
  quadrants: string[];
  role: 'lead' | 'assistant';
  permissions: string[];
  assignedAt: string;
}
```

#### BatchAssignment
```typescript
interface BatchAssignment {
  batchId: string;
  batchName: string;
  sections: string[];
  enrollmentType: 'mandatory' | 'optional';
  enrollmentDeadline: string;
  enrolledStudents: number;
  assignedAt: string;
}
```

#### Task
```typescript
interface Task {
  taskId: string;
  taskName: string;
  description: string;
  interventionId: string;
  quadrant: string;
  component: string;
  maxScore: number;
  dueDate: string;
  instructions: string;
  rubric: RubricCriteria[];
  attachments: string[];
  submissionType: 'document' | 'presentation' | 'video';
  allowLateSubmission: boolean;
  latePenalty: number;
  status: 'draft' | 'active' | 'completed';
  createdBy: string;
  createdAt: string;
}
```

#### RubricCriteria
```typescript
interface RubricCriteria {
  criteria: string;
  maxPoints: number;
  description: string;
}
```

#### TaskSubmission
```typescript
interface TaskSubmission {
  submissionId: string;
  taskId: string;
  studentId: string;
  submittedAt: string;
  status: 'submitted' | 'graded' | 'pending';
  isLate: boolean;
  attachments: string[];
  score?: number;
  rubricScores?: RubricScore[];
  feedback?: string;
  privateNotes?: string;
  gradedAt?: string;
  gradedBy?: string;
}
```

#### RubricScore
```typescript
interface RubricScore {
  criteria: string;
  score: number;
  maxPoints: number;
  feedback: string;
}
```

#### InterventionEnrollment
```typescript
interface InterventionEnrollment {
  enrollmentId: string;
  interventionId: string;
  studentId: string;
  enrollmentDate: string;
  enrollmentStatus: 'enrolled' | 'pending' | 'dropped';
  progress: StudentProgress;
}
```

#### StudentProgress
```typescript
interface StudentProgress {
  completedTasks: number;
  totalTasks: number;
  completionPercentage: number;
  currentScore: number;
  maxScore: number;
  lastActivity: string;
  quadrantScores: Record<string, number>;
}
```

## Intervention System Integration

### Integration with Existing Quadrant System

The intervention system seamlessly integrates with the existing quadrant-based assessment system:

1. **Score Aggregation**: Intervention scores contribute to overall quadrant scores
2. **Weighted Calculation**: Final scores use intervention weightages and quadrant weightages
3. **Dashboard Integration**: Student dashboards show both intervention-specific and overall performance
4. **Historical Tracking**: All intervention participation and scores are tracked historically

### Score Calculation Formula

```
Final Quadrant Score = (Base Quadrant Score × Base Weight) + (Intervention Contributions × Intervention Weights)

Where:
- Base Quadrant Score: Traditional quadrant assessment scores
- Intervention Contributions: Sum of all intervention scores for that quadrant
- Weights: Configurable weightages for base vs intervention scores
```

### API Usage Examples

#### Creating and Managing an Intervention

```javascript
// Create intervention
const intervention = await fetch('/api/v1/admin/interventions', {
  method: 'POST',
  headers: {
    'Authorization': `Bearer ${token}`,
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    name: 'Leadership Development Program',
    description: 'Comprehensive leadership training',
    startDate: '2024-02-01T00:00:00Z',
    endDate: '2024-05-31T23:59:59Z',
    quadrants: [
      { quadrantId: 'persona', weightage: 60, components: ['leadership', 'communication'] },
      { quadrantId: 'behavior', weightage: 40, components: ['participation', 'manners'] }
    ],
    maxStudents: 50
  })
});

// Assign teachers
await fetch(`/api/v1/admin/interventions/${interventionId}/assign-teachers`, {
  method: 'POST',
  headers: {
    'Authorization': `Bearer ${token}`,
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    assignments: [
      {
        teacherId: 'teacher-001',
        quadrants: ['persona'],
        role: 'lead',
        permissions: ['create_tasks', 'score_tasks', 'view_reports']
      }
    ]
  })
});

// Assign student batches
await fetch(`/api/v1/admin/interventions/${interventionId}/assign-batches`, {
  method: 'POST',
  headers: {
    'Authorization': `Bearer ${token}`,
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    batches: [
      {
        batchId: '2024',
        sections: ['A', 'B'],
        enrollmentType: 'mandatory'
      }
    ]
  })
});
```

## Conclusion

This comprehensive API documentation now covers all endpoints, requests, and responses for the complete PEP Score Nexus application, including the new **Intervention System**. The APIs are designed to be RESTful, consistent, and provide comprehensive data for all application features including:

### Core Features:
- **Authentication & Authorization**: JWT-based auth with role-based access control
- **Student Management**: Complete student lifecycle management
- **Performance Tracking**: Multi-quadrant assessment and scoring system
- **Teacher Tools**: Assessment submission and student management
- **Admin Controls**: System administration and reporting

### Advanced Features:
- **Intervention System**: Complete course/program management with multi-quadrant integration
- **Task Management**: Structured task creation, submission, and scoring
- **Behavior Rating Scales**: Standardized behavior assessment tools
- **House System**: Student house management and point tracking
- **Mobile Responsiveness**: Mobile-optimized API responses
- **Theme Management**: User interface customization
- **Audit Logging**: Comprehensive activity tracking
- **Data Export/Import**: Bulk operations and GDPR compliance
- **System Integration**: SHL API and email service integration
- **Performance Monitoring**: System health and usage analytics
- **Caching**: Optimized data retrieval and performance

### New Intervention System Features:
- **Course/Program Creation**: Admin-managed intervention programs
- **Multi-Teacher Assignment**: Collaborative teaching assignments
- **Batch Enrollment**: Cohort-based student participation
- **Cross-Quadrant Integration**: Programs spanning multiple assessment areas
- **Task-Based Assessment**: Structured task creation and scoring
- **Weighted Score Calculation**: Complex scoring algorithms with multiple weightages
- **Progress Tracking**: Detailed student progress monitoring
- **Intervention Analytics**: Comprehensive reporting and comparison tools

### Security & Compliance:
- **Data Privacy**: GDPR-compliant data handling
- **Security Headers**: Comprehensive security measures
- **Audit Trails**: Complete activity logging
- **Backup & Recovery**: System backup and restoration

### Total API Coverage:
- **Authentication**: 3 endpoints
- **Student APIs**: 25+ endpoints (including intervention features)
- **Teacher APIs**: 30+ endpoints (including task management)
- **Admin APIs**: 45+ endpoints (including intervention management)
- **Common APIs**: 15+ endpoints
- **Advanced Features**: 30+ endpoints
- **Security & Compliance**: 10+ endpoints

**Grand Total: 150+ comprehensive API endpoints** covering every aspect of the PEP Score Nexus application, including the complete intervention system.

The API design follows REST principles, includes comprehensive error handling, supports pagination, implements rate limiting, and provides extensive documentation for all endpoints to ensure seamless integration and development. The intervention system adds a powerful layer of structured course management while maintaining full integration with the existing quadrant-based assessment framework.

### Core Features:
- **Authentication & Authorization**: JWT-based auth with role-based access control
- **Student Management**: Complete student lifecycle management
- **Performance Tracking**: Multi-quadrant assessment and scoring system
- **Teacher Tools**: Assessment submission and student management
- **Admin Controls**: System administration and reporting

### Advanced Features:
- **Behavior Rating Scales**: Standardized behavior assessment tools
- **House System**: Student house management and point tracking
- **Mobile Responsiveness**: Mobile-optimized API responses
- **Theme Management**: User interface customization
- **Audit Logging**: Comprehensive activity tracking
- **Data Export/Import**: Bulk operations and GDPR compliance
- **System Integration**: SHL API and email service integration
- **Performance Monitoring**: System health and usage analytics
- **Caching**: Optimized data retrieval and performance

### Security & Compliance:
- **Data Privacy**: GDPR-compliant data handling
- **Security Headers**: Comprehensive security measures
- **Audit Trails**: Complete activity logging
- **Backup & Recovery**: System backup and restoration

The API design follows REST principles, includes comprehensive error handling, supports pagination, implements rate limiting, and provides extensive documentation for all endpoints to ensure seamless integration and development.
