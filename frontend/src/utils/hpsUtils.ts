import { HPSScore, HPSDisplayConfig } from '../types/hps';

// Grade calculation utility functions
export type Grade = 'A+' | 'A' | 'B' | 'C' | 'D' | 'E' | 'IC';
export type StatusType = 'Good' | 'Progress' | 'Deteriorate';

// Constants for grading and weightage
export const GRADING_SCALE = [
  { grade: 'A+', min: 90, max: 100, color: 'bg-green-500' },
  { grade: 'A', min: 80, max: 89, color: 'bg-green-400' },
  { grade: 'B', min: 70, max: 79, color: 'bg-blue-400' },
  { grade: 'C', min: 60, max: 69, color: 'bg-yellow-400' },
  { grade: 'D', min: 40, max: 59, color: 'bg-orange-400' },
  { grade: 'E', min: 30, max: 39, color: 'bg-red-400' },
  { grade: 'IC', min: 0, max: 29, color: 'bg-red-500' }
];

export const QUADRANT_WEIGHTAGE = {
  persona: 50,
  wellness: 30,
  behavior: 10,
  discipline: 10
};

export const formatHPSScore = (score: number, decimals: number = 2): string => {
    return score.toFixed(decimals);
};

export const getGradeColor = (grade: string): string => {
    const colors = {
        'A+': 'text-emerald-600',
        'A': 'text-emerald-500',
        'B': 'text-blue-500',
        'C': 'text-yellow-500',
        'D': 'text-orange-500',
        'E': 'text-red-500',
        'IC': 'text-gray-500'
    };
    return colors[grade as keyof typeof colors] || 'text-gray-500';
};

export const getStatusColor = (status: string): string => {
    const colors = {
        'Good': 'text-emerald-600',
        'Progress': 'text-blue-500',
        'Deteriorate': 'text-red-500'
    };
    return colors[status as keyof typeof colors] || 'text-gray-500';
};

export const calculateGrade = (score: number): string => {
    if (score >= 95) return 'A+';
    if (score >= 90) return 'A';
    if (score >= 80) return 'B';
    if (score >= 70) return 'C';
    if (score >= 60) return 'D';
    if (score >= 40) return 'E';
    return 'IC';
};

export const calculateStatus = (score: number): string => {
    if (score >= 80) return 'Good';
    if (score >= 60) return 'Progress';
    return 'Deteriorate';
};

export const getDisplayConfig = (userRole: string): HPSDisplayConfig[keyof HPSDisplayConfig] => {
    const config: HPSDisplayConfig = {
        student: {
            showDecimalPlaces: 1,
            showGrade: true,
            showStatus: true
        },
        teacher: {
            showDecimalPlaces: 2,
            showGrade: true,
            showStatus: true,
            showWeightages: true
        },
        admin: {
            showDecimalPlaces: 2,
            showGrade: true,
            showStatus: true,
            showWeightages: true,
            showCalculationVersion: true,
            showAuditInfo: true
        }
    };
    return config[userRole as keyof HPSDisplayConfig] || config.student;
};

export const formatQuadrantName = (name: string): string => {
    return name.charAt(0).toUpperCase() + name.slice(1).toLowerCase();
};

export const calculatePercentageChange = (oldScore: number, newScore: number): number => {
    if (oldScore === 0) return newScore > 0 ? 100 : 0;
    return ((newScore - oldScore) / oldScore) * 100;
};

export const getScoreIndicatorColor = (score: number): string => {
    if (score >= 90) return 'bg-emerald-500';
    if (score >= 80) return 'bg-blue-500';
    if (score >= 70) return 'bg-yellow-500';
    if (score >= 60) return 'bg-orange-500';
    if (score >= 40) return 'bg-red-500';
    return 'bg-gray-500';
};

export const getPartialScoreWarning = (hpsScore: HPSScore): string | null => {
    if (!hpsScore.isPartial) return null;
    
    const missingQuadrants = ['Persona', 'Wellness', 'Behavior', 'Discipline'].filter(
        quadrant => !hpsScore.quadrantScores[quadrant]
    );
    
    if (missingQuadrants.length > 0) {
        return `Partial score: Missing data for ${missingQuadrants.join(', ')}`;
    }
    
    return 'Partial score: Some components are missing data';
};

export const validateWeightages = (weightages: number[]): boolean => {
    const sum = weightages.reduce((acc, val) => acc + val, 0);
    return Math.abs(sum - 100) < 0.01; // Allow for floating point imprecision
};

export const normalizeWeightages = (weightages: number[]): number[] => {
    const sum = weightages.reduce((acc, val) => acc + val, 0);
    return weightages.map(weight => (weight / sum) * 100);
};

export const calculateWeightedAverage = (scores: number[], weights: number[]): number => {
    if (scores.length !== weights.length) {
        throw new Error('Scores and weights arrays must have the same length');
    }
    
    const sum = scores.reduce((acc, score, i) => acc + score * weights[i], 0);
    const weightSum = weights.reduce((acc, weight) => acc + weight, 0);
    
    return sum / weightSum;
};
