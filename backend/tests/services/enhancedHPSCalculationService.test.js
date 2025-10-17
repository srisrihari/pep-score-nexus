const enhancedHPSCalculationService = require('../../src/services/enhancedHPSCalculationService');
const { supabase } = require('../../src/config/supabaseClient');
const { query } = require('../../src/utils/queryWrapper');

// Mock supabase and query wrapper
jest.mock('../../src/config/supabaseClient');
jest.mock('../../src/utils/queryWrapper');

describe('EnhancedHPSCalculationService', () => {
    beforeEach(() => {
        jest.clearAllMocks();
    });

    describe('calculateMicrocompetencyAverages', () => {
        it('should calculate simple average when all weights are equal', () => {
            const scores = [
                {
                    microcompetency_id: 'mc1',
                    obtained_score: 8,
                    max_score: 10,
                    microcompetencies: {
                        weightage: 50,
                        component_id: 'comp1'
                    }
                },
                {
                    microcompetency_id: 'mc1',
                    obtained_score: 7,
                    max_score: 10,
                    microcompetencies: {
                        weightage: 50,
                        component_id: 'comp1'
                    }
                }
            ];

            const result = enhancedHPSCalculationService.calculateMicrocompetencyAverages(scores);
            expect(result.mc1.score).toBeCloseTo(75, 2); // (80 + 70) / 2
        });

        it('should calculate weighted average when weights are different', () => {
            const scores = [
                {
                    microcompetency_id: 'mc1',
                    obtained_score: 8,
                    max_score: 10,
                    microcompetencies: {
                        weightage: 70,
                        component_id: 'comp1'
                    }
                },
                {
                    microcompetency_id: 'mc1',
                    obtained_score: 7,
                    max_score: 10,
                    microcompetencies: {
                        weightage: 30,
                        component_id: 'comp1'
                    }
                }
            ];

            const result = enhancedHPSCalculationService.calculateMicrocompetencyAverages(scores);
            expect(result.mc1.score).toBeCloseTo(77, 2); // (80 * 0.7 + 70 * 0.3)
        });
    });

    describe('calculateComponentScores', () => {
        it('should calculate simple average when all weights are equal', () => {
            const microcompScores = {
                mc1: {
                    score: 80,
                    metadata: {
                        microcompetencies: {
                            weightage: 50,
                            components: {
                                id: 'comp1',
                                weightage: 50
                            }
                        }
                    }
                },
                mc2: {
                    score: 70,
                    metadata: {
                        microcompetencies: {
                            weightage: 50,
                            components: {
                                id: 'comp1',
                                weightage: 50
                            }
                        }
                    }
                }
            };

            const result = enhancedHPSCalculationService.calculateComponentScores(microcompScores);
            expect(result.comp1.score).toBeCloseTo(75, 2); // (80 + 70) / 2
        });

        it('should calculate weighted average when weights are different', () => {
            const microcompScores = {
                mc1: {
                    score: 80,
                    metadata: {
                        microcompetencies: {
                            weightage: 70,
                            components: {
                                id: 'comp1',
                                weightage: 70
                            }
                        }
                    }
                },
                mc2: {
                    score: 70,
                    metadata: {
                        microcompetencies: {
                            weightage: 30,
                            components: {
                                id: 'comp1',
                                weightage: 30
                            }
                        }
                    }
                }
            };

            const result = enhancedHPSCalculationService.calculateComponentScores(microcompScores);
            expect(result.comp1.score).toBeCloseTo(77, 2); // (80 * 0.7 + 70 * 0.3)
        });
    });

    describe('calculateFinalHPS', () => {
        it('should calculate simple average when all quadrant weights are equal', () => {
            const quadrantScores = {
                Persona: { score: 80 },
                Wellness: { score: 70 },
                Behavior: { score: 90 },
                Discipline: { score: 60 }
            };

            const result = enhancedHPSCalculationService.calculateFinalHPS(quadrantScores);
            expect(result).toBeCloseTo(75, 2); // (80 + 70 + 90 + 60) / 4
        });

        it('should calculate weighted average using predefined quadrant weights', () => {
            const quadrantScores = {
                Persona: { score: 80 },    // 50%
                Wellness: { score: 70 },    // 30%
                Behavior: { score: 90 },    // 10%
                Discipline: { score: 60 }    // 10%
            };

            const result = enhancedHPSCalculationService.calculateFinalHPS(quadrantScores);
            expect(result).toBeCloseTo(76, 2); // (80 * 0.5 + 70 * 0.3 + 90 * 0.1 + 60 * 0.1)
        });
    });

    describe('calculateGrade', () => {
        const testCases = [
            { score: 95, expected: 'A+' },
            { score: 92, expected: 'A' },
            { score: 85, expected: 'B' },
            { score: 75, expected: 'C' },
            { score: 65, expected: 'D' },
            { score: 45, expected: 'E' },
            { score: 35, expected: 'IC' }
        ];

        testCases.forEach(({ score, expected }) => {
            it(`should return ${expected} for score ${score}`, () => {
                expect(enhancedHPSCalculationService.calculateGrade(score)).toBe(expected);
            });
        });
    });

    describe('calculateStatus', () => {
        const testCases = [
            { score: 85, expected: 'Good' },
            { score: 65, expected: 'Progress' },
            { score: 35, expected: 'Deteriorate' }
        ];

        testCases.forEach(({ score, expected }) => {
            it(`should return ${expected} for score ${score}`, () => {
                expect(enhancedHPSCalculationService.calculateStatus(score)).toBe(expected);
            });
        });
    });

    describe('calculateStudentHPS', () => {
        it('should calculate and update student HPS correctly', async () => {
            // Mock microcompetency scores data
            const mockScores = [
                {
                    microcompetency_id: 'mc1',
                    obtained_score: 8,
                    max_score: 10,
                    microcompetencies: {
                        id: 'mc1',
                        weightage: 50,
                        component_id: 'comp1',
                        components: {
                            id: 'comp1',
                            weightage: 50,
                            sub_category_id: 'sub1',
                            sub_categories: {
                                id: 'sub1',
                                quadrant_id: 'Persona',
                                weightage: 50
                            }
                        }
                    }
                }
            ];

            // Mock supabase query responses
            query.mockImplementation((queryBuilder) => {
                if (queryBuilder.toString().includes('microcompetency_scores')) {
                    return { data: mockScores };
                }
                return { data: null };
            });

            const result = await enhancedHPSCalculationService.calculateStudentHPS('student1', 'term1');

            expect(result.totalHPS).toBeDefined();
            expect(result.quadrantScores).toBeDefined();
            expect(result.isPartial).toBeDefined();

            // Verify database updates were called
            expect(query).toHaveBeenCalledWith(
                expect.objectContaining({
                    toString: expect.any(Function)
                })
            );
        });

        it('should handle missing scores gracefully', async () => {
            query.mockImplementation(() => ({ data: [] }));

            const result = await enhancedHPSCalculationService.calculateStudentHPS('student1', 'term1');

            expect(result.totalHPS).toBe(0);
            expect(result.quadrantScores).toEqual({});
            expect(result.isPartial).toBe(true);
        });

        it('should handle database errors', async () => {
            query.mockRejectedValue(new Error('Database error'));

            await expect(
                enhancedHPSCalculationService.calculateStudentHPS('student1', 'term1')
            ).rejects.toThrow('Database error');
        });
    });
});
