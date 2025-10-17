const request = require('supertest');
const app = require('../../src/server');
const { supabase } = require('../../src/config/supabaseClient');
const { query } = require('../../src/utils/queryWrapper');
const enhancedHPSCalculationService = require('../../src/services/enhancedHPSCalculationService');

jest.mock('../../src/config/supabaseClient');
jest.mock('../../src/utils/queryWrapper');

describe('HPS API Integration Tests', () => {
    let authToken;

    beforeAll(async () => {
        // Mock authentication
        authToken = 'test-token';
    });

    beforeEach(() => {
        jest.clearAllMocks();
    });

    describe('GET /hps/details/:studentId/:termId', () => {
        it('should return HPS details for a student', async () => {
            const mockHPSData = {
                totalHPS: 85.5,
                quadrantScores: {
                    Persona: { score: 80 },
                    Wellness: { score: 90 },
                    Behavior: { score: 85 },
                    Discipline: { score: 87 }
                },
                isPartial: false
            };

            // Mock cache check
            query.mockImplementationOnce(() => ({ data: null }));

            // Mock HPS calculation
            jest.spyOn(enhancedHPSCalculationService, 'calculateStudentHPS')
                .mockResolvedValueOnce(mockHPSData);

            const response = await request(app)
                .get('/api/v1/hps/details/student1/term1')
                .set('Authorization', `Bearer ${authToken}`);

            expect(response.status).toBe(200);
            expect(response.body.success).toBe(true);
            expect(response.body.data).toEqual(mockHPSData);
        });

        it('should return cached HPS details if available', async () => {
            const mockCachedData = {
                totalHPS: 85.5,
                quadrantScores: {
                    Persona: { score: 80 }
                },
                isPartial: false,
                source: 'cache'
            };

            query.mockImplementationOnce(() => ({
                data: mockCachedData,
                expires_at: new Date(Date.now() + 3600000).toISOString()
            }));

            const response = await request(app)
                .get('/api/v1/hps/details/student1/term1')
                .set('Authorization', `Bearer ${authToken}`);

            expect(response.status).toBe(200);
            expect(response.body.success).toBe(true);
            expect(response.body.data.source).toBe('cache');
        });

        it('should handle calculation errors gracefully', async () => {
            jest.spyOn(enhancedHPSCalculationService, 'calculateStudentHPS')
                .mockRejectedValueOnce(new Error('Calculation failed'));

            const response = await request(app)
                .get('/api/v1/hps/details/student1/term1')
                .set('Authorization', `Bearer ${authToken}`);

            expect(response.status).toBe(500);
            expect(response.body.success).toBe(false);
            expect(response.body.error).toBeDefined();
        });
    });

    describe('POST /hps/calculate/:studentId/:termId', () => {
        it('should trigger HPS calculation for a student', async () => {
            const mockResult = {
                totalHPS: 85.5,
                quadrantScores: {
                    Persona: { score: 80 }
                },
                isPartial: false
            };

            jest.spyOn(enhancedHPSCalculationService, 'calculateStudentHPS')
                .mockResolvedValueOnce(mockResult);

            const response = await request(app)
                .post('/api/v1/hps/calculate/student1/term1')
                .set('Authorization', `Bearer ${authToken}`);

            expect(response.status).toBe(200);
            expect(response.body.success).toBe(true);
            expect(response.body.data).toEqual(mockResult);
        });

        it('should handle calculation errors', async () => {
            jest.spyOn(enhancedHPSCalculationService, 'calculateStudentHPS')
                .mockRejectedValueOnce(new Error('Calculation failed'));

            const response = await request(app)
                .post('/api/v1/hps/calculate/student1/term1')
                .set('Authorization', `Bearer ${authToken}`);

            expect(response.status).toBe(500);
            expect(response.body.success).toBe(false);
            expect(response.body.error).toBeDefined();
        });
    });

    describe('POST /hps/calculate-batch/:termId', () => {
        it('should queue batch calculation for a term', async () => {
            const mockStudents = [
                { student_id: 'student1' },
                { student_id: 'student2' }
            ];

            query.mockImplementationOnce(() => ({ data: mockStudents }));

            const response = await request(app)
                .post('/api/v1/hps/calculate-batch/term1')
                .set('Authorization', `Bearer ${authToken}`);

            expect(response.status).toBe(200);
            expect(response.body.success).toBe(true);
            expect(response.body.message).toContain('Queued HPS calculation');
        });

        it('should handle database errors in batch calculation', async () => {
            query.mockRejectedValueOnce(new Error('Database error'));

            const response = await request(app)
                .post('/api/v1/hps/calculate-batch/term1')
                .set('Authorization', `Bearer ${authToken}`);

            expect(response.status).toBe(500);
            expect(response.body.success).toBe(false);
            expect(response.body.error).toBeDefined();
        });
    });

    describe('GET /hps/history/:studentId/:termId', () => {
        it('should return HPS calculation history', async () => {
            const mockHistory = [
                {
                    id: 'history1',
                    student_id: 'student1',
                    term_id: 'term1',
                    old_hps: 80,
                    new_hps: 85,
                    trigger_type: 'calculation',
                    calculated_at: new Date().toISOString()
                }
            ];

            query.mockImplementationOnce(() => ({ data: mockHistory }));

            const response = await request(app)
                .get('/api/v1/hps/history/student1/term1')
                .set('Authorization', `Bearer ${authToken}`);

            expect(response.status).toBe(200);
            expect(response.body.success).toBe(true);
            expect(response.body.data).toHaveLength(1);
            expect(response.body.data[0].id).toBe('history1');
        });

        it('should handle database errors in history retrieval', async () => {
            query.mockRejectedValueOnce(new Error('Database error'));

            const response = await request(app)
                .get('/api/v1/hps/history/student1/term1')
                .set('Authorization', `Bearer ${authToken}`);

            expect(response.status).toBe(500);
            expect(response.body.success).toBe(false);
            expect(response.body.error).toBeDefined();
        });
    });

    describe('POST /hps/process-queue', () => {
        it('should process the HPS calculation queue', async () => {
            query.mockImplementationOnce(() => ({
                data: { processed_count: 5, error_count: 0 }
            }));

            const response = await request(app)
                .post('/api/v1/hps/process-queue')
                .set('Authorization', `Bearer ${authToken}`);

            expect(response.status).toBe(200);
            expect(response.body.success).toBe(true);
            expect(response.body.data.processed_count).toBe(5);
        });

        it('should handle queue processing errors', async () => {
            query.mockRejectedValueOnce(new Error('Queue processing failed'));

            const response = await request(app)
                .post('/api/v1/hps/process-queue')
                .set('Authorization', `Bearer ${authToken}`);

            expect(response.status).toBe(500);
            expect(response.body.success).toBe(false);
            expect(response.body.error).toBeDefined();
        });
    });
});
