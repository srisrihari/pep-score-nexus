export interface HPSScore {
    totalHPS: number;
    quadrantScores: {
        [key: string]: {
            score: number;
        };
    };
    isPartial: boolean;
}

export interface HPSHistory {
    id: string;
    studentId: string;
    termId: string;
    oldHPS: number;
    newHPS: number;
    hpsDifference: number;
    percentageChange: number;
    triggerType: string;
    metadata: Record<string, any>;
    calculatedAt: string;
    createdAt: string;
}

export interface HPSCache {
    id: string;
    studentId: string;
    termId: string;
    totalHPS: number;
    quadrantScores: {
        [key: string]: {
            score: number;
        };
    };
    calculationVersion: number;
    isPartial: boolean;
    cacheKey: string;
    createdAt: string;
    expiresAt: string;
}

export interface HPSQueueItem {
    id: string;
    studentId: string;
    termId: string;
    triggerType: string;
    priority: number;
    status: 'pending' | 'processing' | 'completed' | 'failed';
    createdAt: string;
    processedAt: string | null;
}

export interface HPSCalculationRequest {
    studentId: string;
    termId: string;
}

export interface HPSBatchCalculationRequest {
    termId: string;
}

export interface HPSResponse<T> {
    success: boolean;
    data: T;
    error?: string;
}

export interface HPSDisplayConfig {
    student: {
        showDecimalPlaces: number;
        showGrade: boolean;
        showStatus: boolean;
    };
    teacher: {
        showDecimalPlaces: number;
        showGrade: boolean;
        showStatus: boolean;
        showWeightages: boolean;
    };
    admin: {
        showDecimalPlaces: number;
        showGrade: boolean;
        showStatus: boolean;
        showWeightages: boolean;
        showCalculationVersion: boolean;
        showAuditInfo: boolean;
    };
}

export interface HPSQuadrantScore {
    quadrantId: string;
    quadrantName: string;
    score: number;
    weightage: number;
    components: HPSComponentScore[];
}

export interface HPSComponentScore {
    componentId: string;
    componentName: string;
    score: number;
    weightage: number;
    subComponents: HPSSubComponentScore[];
}

export interface HPSSubComponentScore {
    subComponentId: string;
    subComponentName: string;
    score: number;
    weightage: number;
    microcompetencies: HPSMicrocompetencyScore[];
}

export interface HPSMicrocompetencyScore {
    microcompetencyId: string;
    microcompetencyName: string;
    score: number;
    weightage: number;
    interventions: HPSInterventionScore[];
}

export interface HPSInterventionScore {
    interventionId: string;
    interventionName: string;
    score: number;
    weightage: number;
}
