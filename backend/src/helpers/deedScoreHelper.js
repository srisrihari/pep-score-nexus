const { supabase, query } = require('../config/supabase');

/**
 * Calculate the net deed score (good deeds add, bad deeds subtract)
 * @param {string} studentId
 * @param {string} termId
 * @returns {Promise<number>}
 */
const getNetDeedScore = async (studentId, termId) => {
  if (!studentId || !termId) {
    return 0;
  }

  const result = await query(
    supabase
      .from('student_deeds')
      .select('deed_type, score')
      .eq('student_id', studentId)
      .eq('term_id', termId)
  );

  const deeds = result.rows || [];

  return deeds.reduce((net, deed) => {
    const score = parseFloat(deed.score);
    if (isNaN(score)) return net;
    return deed.deed_type === 'good' ? net + score : net - score;
  }, 0);
};

module.exports = {
  getNetDeedScore
};

