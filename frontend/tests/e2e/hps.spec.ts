import { test, expect } from '@playwright/test';

test.describe('HPS Score Display', () => {
    test.beforeEach(async ({ page }) => {
        // Login and navigate to student details
        await page.goto('/login');
        await page.fill('input[name="email"]', 'admin@example.com');
        await page.fill('input[name="password"]', 'admin123');
        await page.click('button[type="submit"]');
        await page.waitForURL('/dashboard');
    });

    test('displays student HPS score correctly', async ({ page }) => {
        // Navigate to student details
        await page.goto('/students/student1');
        
        // Check HPS score card is present
        const scoreCard = await page.getByTestId('hps-score-card');
        await expect(scoreCard).toBeVisible();

        // Check total score is displayed
        const totalScore = await scoreCard.getByTestId('total-score');
        await expect(totalScore).toBeVisible();
        await expect(totalScore).toContainText('/100');

        // Check quadrant scores are displayed
        const quadrantScores = await page.getByTestId('quadrant-scores');
        await expect(quadrantScores).toBeVisible();
        
        // Check all quadrants are present
        const quadrants = ['Persona', 'Wellness', 'Behavior', 'Discipline'];
        for (const quadrant of quadrants) {
            const quadrantScore = await quadrantScores.getByText(quadrant);
            await expect(quadrantScore).toBeVisible();
        }
    });

    test('shows partial score indicator when applicable', async ({ page }) => {
        // Navigate to student with partial scores
        await page.goto('/students/student2');
        
        // Check partial score indicator is present
        const partialIndicator = await page.getByTestId('partial-score-indicator');
        await expect(partialIndicator).toBeVisible();
        await expect(partialIndicator).toContainText('Partial');
    });

    test('recalculates HPS score on demand', async ({ page }) => {
        await page.goto('/students/student1');
        
        // Click recalculate button
        const recalculateButton = await page.getByRole('button', { name: 'Recalculate HPS' });
        await recalculateButton.click();

        // Check loading state
        await expect(page.getByTestId('loading-indicator')).toBeVisible();

        // Wait for success message
        const toast = await page.getByTestId('toast');
        await expect(toast).toBeVisible();
        await expect(toast).toContainText('HPS score has been recalculated');
    });

    test('displays HPS history', async ({ page }) => {
        await page.goto('/students/student1');
        
        // Open history tab/section
        const historyTab = await page.getByRole('tab', { name: 'History' });
        await historyTab.click();

        // Check history entries
        const historyEntries = await page.getByTestId('history-entry');
        await expect(historyEntries).toHaveCount(1);

        // Check history entry content
        const firstEntry = historyEntries.first();
        await expect(firstEntry).toContainText('Score Change');
        await expect(firstEntry).toContainText('Trigger');
    });

    test('handles batch HPS calculation (admin only)', async ({ page }) => {
        await page.goto('/admin/hps');
        
        // Click batch calculate button
        const batchButton = await page.getByRole('button', { name: 'Calculate Term HPS' });
        await batchButton.click();

        // Check confirmation dialog
        const dialog = await page.getByRole('dialog');
        await expect(dialog).toBeVisible();
        await expect(dialog).toContainText('This will recalculate HPS scores');

        // Confirm batch calculation
        await page.getByRole('button', { name: 'Confirm' }).click();

        // Check success message
        const toast = await page.getByTestId('toast');
        await expect(toast).toBeVisible();
        await expect(toast).toContainText('Batch HPS calculation has been queued');
    });

    test('processes HPS queue (admin only)', async ({ page }) => {
        await page.goto('/admin/hps');
        
        // Click process queue button
        const processButton = await page.getByRole('button', { name: 'Process Queue' });
        await processButton.click();

        // Check loading state
        await expect(page.getByTestId('loading-indicator')).toBeVisible();

        // Check success message
        const toast = await page.getByTestId('toast');
        await expect(toast).toBeVisible();
        await expect(toast).toContainText('HPS calculation queue is being processed');
    });

    test('displays correct grade colors', async ({ page }) => {
        await page.goto('/students/student1');
        
        const grade = await page.getByTestId('grade');
        const gradeText = await grade.textContent();
        
        // Check grade color based on value
        switch (gradeText) {
            case 'A+':
            case 'A':
                await expect(grade).toHaveClass(/text-emerald-[56]00/);
                break;
            case 'B':
                await expect(grade).toHaveClass('text-blue-500');
                break;
            case 'C':
                await expect(grade).toHaveClass('text-yellow-500');
                break;
            case 'D':
                await expect(grade).toHaveClass('text-orange-500');
                break;
            case 'E':
                await expect(grade).toHaveClass('text-red-500');
                break;
            case 'IC':
                await expect(grade).toHaveClass('text-gray-500');
                break;
        }
    });

    test('shows different information based on user role', async ({ page }) => {
        // Test as admin
        await page.goto('/students/student1');
        const adminView = await page.getByTestId('admin-only-info');
        await expect(adminView).toBeVisible();

        // Logout
        await page.getByRole('button', { name: 'Logout' }).click();

        // Login as teacher
        await page.fill('input[name="email"]', 'teacher@example.com');
        await page.fill('input[name="password"]', 'teacher123');
        await page.click('button[type="submit"]');

        // Check teacher view
        await page.goto('/students/student1');
        await expect(adminView).not.toBeVisible();
        const teacherView = await page.getByTestId('teacher-only-info');
        await expect(teacherView).toBeVisible();
    });
});
