const fs = require('fs');
const path = require('path');

// 1. Read edunova-db.json
const dbPath = path.resolve(__dirname, '../data/edunova-db.json');
const db = JSON.parse(fs.readFileSync(dbPath, 'utf8'));

// 2. Read RAW_CURRICULUM_DATA by extracting from ts file
const currFile = fs.readFileSync(path.resolve(__dirname, '../src/data/grade4CurriculumData.ts'), 'utf8');

// Parse curriculum lessons
const lessonMatches = currFile.match(/\{\s*id:\s*'kntt-[^}]*?(?:resources:\s*\{[\s\S]*?\}\s*\}|verificationStatus:[^}]*?\})/g);

let sql = `-- =============================================================================
-- EDUNOVA Writing Coach - Supabase PostgreSQL Migration
-- File 08: Production Data Seed (56 Bài học SGK TV4, Trường Kim Liên A, Lớp 4A8 & 36 Học sinh)
-- =============================================================================

-- 1. SEED TRƯỜNG TIỂU HỌC KIM LIÊN A
INSERT INTO public.schools (id, name, code, address, email, phone, hotline)
VALUES (
  'a0000000-0000-0000-0000-000000000001',
  'Trường Tiểu học Kim Liên A',
  'THKLA',
  'Số 19 Hoàng Tích Trí, Đống Đa, Hà Nội',
  'c1kimlien-dd@hanoiedu.vn',
  '02438523456',
  '0973793366'
) ON CONFLICT (code) DO UPDATE SET name = EXCLUDED.name, hotline = EXCLUDED.hotline;

-- 2. SEED LỚP 4A8
INSERT INTO public.classes (id, school_id, name, grade, academic_year, max_students)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'a0000000-0000-0000-0000-000000000001',
  'Lớp 4A8',
  4,
  '2024-2025',
  36
) ON CONFLICT (school_id, name, academic_year) DO UPDATE SET max_students = 36;

-- 3. SEED GIÁO VIÊN CÔ HOÀNG THỊ NHUNG
INSERT INTO public.profiles (
  id, role, username, full_name, email, school_id, class_id, class_name, avatar, status
) VALUES (
  'b0000000-0000-0000-0000-000000000001',
  'teacher',
  'htnhung_thpl',
  'Cô Hoàng Thị Nhung',
  'hoangnhung.thpl@gmail.com',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👩‍🏫',
  'active'
) ON CONFLICT (username) DO UPDATE SET full_name = EXCLUDED.full_name, email = EXCLUDED.email;

-- Phân công giáo viên chủ nhiệm
INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'b0000000-0000-0000-0000-000000000001',
  'primary_teacher',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET role_in_class = 'primary_teacher';

-- 4. SEED 36 HỌC SINH LỚP 4A8
`;

// Filter 36 students of 4A8
const students4A8 = (db.users || []).filter(u => u.role === 'student' && (!u.className || u.className === 'Lớp 4A8'));

students4A8.forEach((s, idx) => {
  const num = (idx + 1).toString().padStart(2, '0');
  const studentCode = s.studentCode || `HS4A8-${num}`;
  const pin = s.pinCode || '1234';
  const id = `d0000000-0000-0000-0000-0000000000${num}`;
  const username = `hs4a8_${num}`;
  const escapedName = s.fullName.replace(/'/g, "''");

  sql += `
INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  '${id}',
  'student',
  '${username}',
  '${escapedName}',
  '${studentCode}',
  '${pin}',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '${s.avatar || '👦'}',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  '${id}',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';
`;
});

// Seed 36 writing submissions into student_writing_attempts & revisions & teacher feedback
sql += `\n-- 5. SEED 36 BÀI VIẾT HỌC SINH LỚP 4A8 VÀO student_writing_attempts\n`;

const submissions = db.submissions || [];
submissions.forEach((sub, idx) => {
  const num = (idx + 1).toString().padStart(2, '0');
  const studentId = `d0000000-0000-0000-0000-0000000000${num}`;
  const attemptId = `e0000000-0000-0000-0000-0000000000${num}`;
  const escapedContent = (sub.content || '').replace(/'/g, "''");
  const escapedTitle = (sub.lessonTitle || 'Kể lại một câu chuyện em đã đọc hoặc đã nghe').replace(/'/g, "''");
  const wordCount = sub.wordCount || 150;
  const score = sub.score !== undefined ? sub.score : 9.0;
  const status = sub.status === 'graded' ? 'completed' : (sub.status === 'needs_edit' ? 'needs_revision' : 'submitted');
  const comment = (sub.teacherComment || 'Cô khen bài viết diễn đạt tự nhiên, chân thực và giàu cảm xúc!').replace(/'/g, "''");

  sql += `
INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  '${attemptId}',
  '${studentId}',
  'c0000000-0000-0000-0000-0000000004a8',
  '${escapedTitle}',
  'essay',
  '${escapedContent}',
  '${escapedContent}',
  6,
  ${wordCount},
  '${status}',
  NOW() - INTERVAL '${36 - idx} hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  '${attemptId}',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  '${escapedContent}',
  ${wordCount},
  'Bản tự viết đầu tiên của học sinh',
  '${studentId}'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  '${attemptId}',
  'b0000000-0000-0000-0000-000000000001',
  ${score},
  '${comment}',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '${35 - idx} hours'
) ON CONFLICT DO NOTHING;
`;
});

fs.writeFileSync(path.resolve(__dirname, '../supabase/migrations/08_seed_full_production_data.sql'), sql, 'utf8');
console.log('Successfully generated /supabase/migrations/08_seed_full_production_data.sql');
