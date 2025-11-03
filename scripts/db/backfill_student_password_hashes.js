#!/usr/bin/env node
/*
 Backfill bcrypt password hashes for student users whose passwords were stored in plain text.
 Rule: For users.role = 'student' where password_hash does not start with '$2b$'
       set password_hash = bcrypt(registration_no) joined via students(user_id).
*/
const bcrypt = require('bcryptjs');
const { supabase, query } = require('../../backend/src/config/supabase');

async function run() {
  const BATCH_SIZE = 200;
  let offset = 0;
  let totalUpdated = 0;

  // Fetch candidate users by joining students to users
  while (true) {
    const res = await query(
      supabase
        .from('students')
        .select(`user_id, registration_no, users:user_id(id, role, password_hash)`) // join users
        .order('user_id', { ascending: true })
        .range(offset, offset + BATCH_SIZE - 1)
    );

    const rows = res.rows || [];
    if (rows.length === 0) break;

    for (const r of rows) {
      const u = r.users;
      if (!u || u.role !== 'student') continue;
      const hash = u.password_hash || '';
      // Skip if already bcrypt (starts with $2b$)
      if (typeof hash === 'string' && hash.startsWith('$2b$')) continue;
      if (!r.registration_no) continue;

      const hashed = await bcrypt.hash(String(r.registration_no), 12);
      await query(
        supabase
          .from('users')
          .update({ password_hash: hashed })
          .eq('id', u.id)
      );
      totalUpdated += 1;
    }

    offset += rows.length;
  }

  console.log(`✅ Backfill complete. Updated ${totalUpdated} student password hashes.`);
}

run().catch((e) => {
  console.error('❌ Backfill failed:', e);
  process.exit(1);
});


