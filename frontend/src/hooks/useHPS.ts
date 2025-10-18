import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { HPSScore, HPSHistory, HPSResponse } from '../types/hps';
import { unifiedScoreAPI } from '../lib/api';

export const useHPSScore = (studentId: string, termId: string) => {
    return useQuery({
        queryKey: ['hps', studentId, termId],
        queryFn: () => unifiedScoreAPI.getScoreBreakdown(studentId, termId),
        staleTime: 1000 * 60 * 5, // 5 minutes
        gcTime: 1000 * 60 * 30, // 30 minutes
    });
};

export const useHPSHistory = (studentId: string, termId: string) => {
    // Note: HPS History endpoint doesn't exist yet in unified API
    // This will return empty data until history endpoint is implemented
    return useQuery({
        queryKey: ['hps-history', studentId, termId],
        queryFn: async () => ({ success: true, data: [] as HPSHistory[] }),
        staleTime: 1000 * 60 * 15, // 15 minutes
        gcTime: 1000 * 60 * 60, // 1 hour
        enabled: false // Disable until backend endpoint exists
    });
};

export const useCalculateHPS = () => {
    const queryClient = useQueryClient();

    return useMutation({
        mutationFn: ({ studentId, termId }: { studentId: string; termId: string }) =>
            unifiedScoreAPI.calculateStudentHPS(studentId, termId),
        onSuccess: (_, variables) => {
            queryClient.invalidateQueries({
                queryKey: ['hps', variables.studentId, variables.termId],
            });
            queryClient.invalidateQueries({
                queryKey: ['hps-history', variables.studentId, variables.termId],
            });
        },
    });
};

export const useCalculateBatchHPS = () => {
    const queryClient = useQueryClient();

    return useMutation({
        mutationFn: (termId: string) => {
            // Note: Batch HPS calculation not implemented in unified API yet
            // This is a placeholder that will need backend implementation
            throw new Error('Batch HPS calculation not implemented in unified API');
        },
        onSuccess: () => {
            queryClient.invalidateQueries({ queryKey: ['hps'] });
            queryClient.invalidateQueries({ queryKey: ['hps-history'] });
        },
    });
};

export const useProcessHPSQueue = () => {
    const queryClient = useQueryClient();

    return useMutation({
        mutationFn: () => {
            // Note: HPS queue processing not implemented in unified API yet
            // This is a placeholder that will need backend implementation
            throw new Error('HPS queue processing not implemented in unified API');
        },
        onSuccess: () => {
            queryClient.invalidateQueries({ queryKey: ['hps'] });
            queryClient.invalidateQueries({ queryKey: ['hps-history'] });
        },
    });
};
