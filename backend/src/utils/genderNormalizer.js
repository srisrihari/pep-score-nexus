/**
 * Normalizes gender values to match the database enum
 * @param {string|null} gender - The gender value to normalize
 * @returns {string|null} - The normalized gender value or null
 * @throws {Error} - If the gender value is invalid
 */
const normalizeGender = (gender) => {
  if (!gender) return null;

  // Convert to string and trim
  const normalizedGender = String(gender).trim();

  // Convert to title case
  const titleCaseGender = normalizedGender.charAt(0).toUpperCase() + normalizedGender.slice(1).toLowerCase();

  // Validate against enum values
  if (!['Male', 'Female', 'Other'].includes(titleCaseGender)) {
    throw new Error(`Invalid gender value: ${gender}. Must be one of: Male, Female, Other`);
  }

  return titleCaseGender;
};

module.exports = { normalizeGender };
