import React from 'react';
import { useHPSHistory } from '../hooks/useHPS';
import { formatHPSScore, calculatePercentageChange } from '../utils/hpsUtils';
import { Card, CardContent, CardHeader, CardTitle } from './ui/card';
import { Skeleton } from './ui/skeleton';
import { Alert, AlertDescription } from './ui/alert';
import { format } from 'date-fns';

interface HPSHistoryProps {
    studentId: string;
    termId: string;
}

export const HPSHistory: React.FC<HPSHistoryProps> = ({ studentId, termId }) => {
    const { data, isLoading, error } = useHPSHistory(studentId, termId);

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
                        {[1, 2, 3].map((i) => (
                            <Skeleton key={i} className="h-16 w-full" />
                        ))}
                    </div>
                </CardContent>
            </Card>
        );
    }

    if (error || !data) {
        return (
            <Alert variant="destructive">
                <AlertDescription>
                    Failed to load HPS history. Please try again later.
                </AlertDescription>
            </Alert>
        );
    }

    return (
        <Card>
            <CardHeader>
                <CardTitle>Score History</CardTitle>
            </CardHeader>
            <CardContent>
                <div className="space-y-4">
                    {data.data.map((entry) => (
                        <div
                            key={entry.id}
                            className="p-4 rounded-lg border border-gray-200 hover:bg-gray-50 transition-colors"
                        >
                            <div className="flex justify-between items-start">
                                <div>
                                    <div className="text-sm text-gray-500">
                                        {format(new Date(entry.calculatedAt), 'PPp')}
                                    </div>
                                    <div className="text-lg font-semibold">
                                        {formatHPSScore(entry.oldHPS)} → {formatHPSScore(entry.newHPS)}
                                    </div>
                                </div>
                                <div className={`text-sm font-medium ${entry.percentageChange >= 0 ? 'text-green-600' : 'text-red-600'}`}>
                                    {entry.percentageChange >= 0 ? '+' : ''}
                                    {formatHPSScore(entry.percentageChange)}%
                                </div>
                            </div>
                            <div className="mt-2 text-sm text-gray-500">
                                Trigger: {entry.triggerType}
                            </div>
                            {entry.metadata && entry.metadata.quadrant_scores && (
                                <div className="mt-2 grid grid-cols-2 gap-2">
                                    {Object.entries(entry.metadata.quadrant_scores).map(([quadrant, data]: [string, any]) => (
                                        <div key={quadrant} className="text-sm">
                                            <span className="text-gray-500">{quadrant}:</span>{' '}
                                            <span className="font-medium">{formatHPSScore(data.score)}</span>
                                        </div>
                                    ))}
                                </div>
                            )}
                        </div>
                    ))}

                    {data.data.length === 0 && (
                        <div className="text-center text-gray-500">
                            No score history available
                        </div>
                    )}
                </div>
            </CardContent>
        </Card>
    );
};
