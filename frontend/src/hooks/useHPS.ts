import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { HPSScore, HPSHistory, HPSResponse } from '../types/hps';
import { api } from '../lib/api';

export const useHPSScore = (studentId: string, termId: string) => {
    return useQuery<HPSResponse<HPSScore>>({
        queryKey: ['hps', studentId, termId],
        queryFn: () => api.get(`/hps/details/${studentId}/${termId}`),
        staleTime: 1000 * 60 * 5, // 5 minutes
        cacheTime: 1000 * 60 * 30, // 30 minutes
    });
};

export const useHPSHistory = (studentId: string, termId: string) => {
    return useQuery<HPSResponse<HPSHistory[]>>({
        queryKey: ['hps-history', studentId, termId],
        queryFn: () => api.get(`/hps/history/${studentId}/${termId}`),
        staleTime: 1000 * 60 * 15, // 15 minutes
        cacheTime: 1000 * 60 * 60, // 1 hour
    });
};

export const useCalculateHPS = () => {
    const queryClient = useQueryClient();

    return useMutation({
        mutationFn: ({ studentId, termId }: { studentId: string; termId: string }) =>
            api.post(`/hps/calculate/${studentId}/${termId}`),
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
        mutationFn: (termId: string) => api.post(`/hps/calculate-batch/${termId}`),
        onSuccess: () => {
            queryClient.invalidateQueries({ queryKey: ['hps'] });
            queryClient.invalidateQueries({ queryKey: ['hps-history'] });
        },
    });
};

export const useProcessHPSQueue = () => {
    const queryClient = useQueryClient();

    return useMutation({
        mutationFn: () => api.post('/hps/process-queue'),
        onSuccess: () => {
            queryClient.invalidateQueries({ queryKey: ['hps'] });
            queryClient.invalidateQueries({ queryKey: ['hps-history'] });
        },
    });
};
