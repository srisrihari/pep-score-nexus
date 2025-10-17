/**
 * Wrapper for Supabase queries to handle errors consistently
 * @param {Promise} queryBuilder - Supabase query builder
 * @returns {Promise} - Query result
 * @throws {Error} - If query fails
 */
const query = async (queryBuilder) => {
    try {
        const { data, error } = await queryBuilder;
        if (error) throw error;
        return { data };
    } catch (error) {
        console.error('Database query error:', error);
        throw new Error(error.message);
    }
};

module.exports = { query };
