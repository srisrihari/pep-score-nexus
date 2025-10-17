import React from 'react';
import { useCalculateHPS } from '../hooks/useHPS';
import { Button } from './ui/button';
import { Loader2Icon } from 'lucide-react';
import { useToast } from './ui/use-toast';

interface HPSCalculationButtonProps {
    studentId: string;
    termId: string;
    variant?: 'default' | 'outline' | 'secondary' | 'ghost' | 'link' | 'destructive';
    className?: string;
}

export const HPSCalculationButton: React.FC<HPSCalculationButtonProps> = ({
    studentId,
    termId,
    variant = 'default',
    className
}) => {
    const { mutate, isPending } = useCalculateHPS();
    const { toast } = useToast();

    const handleCalculate = () => {
        mutate(
            { studentId, termId },
            {
                onSuccess: () => {
                    toast({
                        title: 'Success',
                        description: 'HPS score has been recalculated.',
                    });
                },
                onError: (error) => {
                    toast({
                        title: 'Error',
                        description: 'Failed to recalculate HPS score. Please try again.',
                        variant: 'destructive',
                    });
                },
            }
        );
    };

    return (
        <Button
            variant={variant}
            onClick={handleCalculate}
            disabled={isPending}
            className={className}
        >
            {isPending && <Loader2Icon className="mr-2 h-4 w-4 animate-spin" />}
            Recalculate HPS
        </Button>
    );
};
