import React from 'react';
import { useHPSScore } from '../hooks/useHPS';
import { formatHPSScore, getGradeColor, getStatusColor, getDisplayConfig, getPartialScoreWarning } from '../utils/hpsUtils';
import { Card, CardContent, CardHeader, CardTitle } from './ui/card';
import { Badge } from './ui/badge';
import { Skeleton } from './ui/skeleton';
import { Alert, AlertDescription } from './ui/alert';
import { InfoIcon } from 'lucide-react';

interface HPSScoreProps {
    studentId: string;
    termId: string;
    userRole: string;
}

export const HPSScore: React.FC<HPSScoreProps> = ({ studentId, termId, userRole }) => {
    const { data, isLoading, error } = useHPSScore(studentId, termId);
    const displayConfig = getDisplayConfig(userRole);

    if (isLoading) {
        return (
            <Card>
                <CardHeader>
                    <CardTitle>
                        <Skeleton className="h-6 w-32" />
                    </CardTitle>
                </CardHeader>
                <CardContent>
                    <div className="space-y-4">
                        <Skeleton className="h-12 w-full" />
                        <div className="grid grid-cols-2 gap-4">
                            <Skeleton className="h-8 w-full" />
                            <Skeleton className="h-8 w-full" />
                        </div>
                    </div>
                </CardContent>
            </Card>
        );
    }

    if (error || !data) {
        return (
            <Alert variant="destructive">
                <AlertDescription>
                    Failed to load HPS score. Please try again later.
                </AlertDescription>
            </Alert>
        );
    }

    const { totalHPS, quadrantScores, isPartial } = data.data;
    const grade = calculateGrade(totalHPS);
    const status = calculateStatus(totalHPS);
    const partialWarning = getPartialScoreWarning(data.data);

    return (
        <Card>
            <CardHeader>
                <CardTitle className="flex items-center justify-between">
                    <span>Holistic Performance Score</span>
                    {isPartial && (
                        <Badge variant="outline" className="text-yellow-500">
                            Partial
                        </Badge>
                    )}
                </CardTitle>
            </CardHeader>
            <CardContent>
                <div className="space-y-4">
                    {/* Main Score */}
                    <div className="text-4xl font-bold text-center">
                        {formatHPSScore(totalHPS, displayConfig.showDecimalPlaces)}/100
                    </div>

                    {/* Grade and Status */}
                    <div className="grid grid-cols-2 gap-4 text-center">
                        {displayConfig.showGrade && (
                            <div>
                                <div className="text-sm text-gray-500">Grade</div>
                                <div className={`text-xl font-semibold ${getGradeColor(grade)}`}>
                                    {grade}
                                </div>
                            </div>
                        )}
                        {displayConfig.showStatus && (
                            <div>
                                <div className="text-sm text-gray-500">Status</div>
                                <div className={`text-xl font-semibold ${getStatusColor(status)}`}>
                                    {status}
                                </div>
                            </div>
                        )}
                    </div>

                    {/* Quadrant Scores */}
                    <div className="grid grid-cols-2 gap-4">
                        {Object.entries(quadrantScores).map(([quadrant, data]) => (
                            <div key={quadrant} className="p-2 rounded-lg bg-gray-50">
                                <div className="text-sm text-gray-500">{quadrant}</div>
                                <div className="text-lg font-semibold">
                                    {formatHPSScore(data.score, displayConfig.showDecimalPlaces)}
                                </div>
                            </div>
                        ))}
                    </div>

                    {/* Partial Score Warning */}
                    {partialWarning && (
                        <Alert>
                            <InfoIcon className="h-4 w-4" />
                            <AlertDescription>{partialWarning}</AlertDescription>
                        </Alert>
                    )}

                    {/* Additional Info for Admin */}
                    {userRole === 'admin' && displayConfig.showCalculationVersion && (
                        <div className="text-sm text-gray-500 text-right">
                            v{data.data.calculationVersion || 3}
                        </div>
                    )}
                </div>
            </CardContent>
        </Card>
    );
};
