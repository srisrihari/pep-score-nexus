import React from 'react';
import { useCalculateBatchHPS, useProcessHPSQueue } from '../hooks/useHPS';
import { Button } from './ui/button';
import { Card, CardContent, CardHeader, CardTitle } from './ui/card';
import { Loader2Icon } from 'lucide-react';
import { useToast } from './ui/use-toast';

interface HPSBatchCalculationProps {
    termId: string;
}

export const HPSBatchCalculation: React.FC<HPSBatchCalculationProps> = ({ termId }) => {
    const { mutate: calculateBatch, isPending: isCalculating } = useCalculateBatchHPS();
    const { mutate: processQueue, isPending: isProcessing } = useProcessHPSQueue();
    const { toast } = useToast();

    const handleCalculateBatch = () => {
        calculateBatch(termId, {
            onSuccess: () => {
                toast({
                    title: 'Success',
                    description: 'Batch HPS calculation has been queued.',
                });
            },
            onError: (error) => {
                toast({
                    title: 'Error',
                    description: 'Failed to queue batch calculation. Please try again.',
                    variant: 'destructive',
                });
            },
        });
    };

    const handleProcessQueue = () => {
        processQueue(undefined, {
            onSuccess: () => {
                toast({
                    title: 'Success',
                    description: 'HPS calculation queue is being processed.',
                });
            },
            onError: (error) => {
                toast({
                    title: 'Error',
                    description: 'Failed to process queue. Please try again.',
                    variant: 'destructive',
                });
            },
        });
    };

    return (
        <Card>
            <CardHeader>
                <CardTitle>Batch HPS Calculation</CardTitle>
            </CardHeader>
            <CardContent>
                <div className="space-y-4">
                    <div className="flex gap-4">
                        <Button
                            onClick={handleCalculateBatch}
                            disabled={isCalculating}
                            className="flex-1"
                        >
                            {isCalculating && (
                                <Loader2Icon className="mr-2 h-4 w-4 animate-spin" />
                            )}
                            Calculate Term HPS
                        </Button>
                        <Button
                            onClick={handleProcessQueue}
                            disabled={isProcessing}
                            variant="secondary"
                            className="flex-1"
                        >
                            {isProcessing && (
                                <Loader2Icon className="mr-2 h-4 w-4 animate-spin" />
                            )}
                            Process Queue
                        </Button>
                    </div>
                    <div className="text-sm text-gray-500">
                        This will recalculate HPS scores for all students in the selected term.
                        The calculation will be performed in the background.
                    </div>
                </div>
            </CardContent>
        </Card>
    );
};
