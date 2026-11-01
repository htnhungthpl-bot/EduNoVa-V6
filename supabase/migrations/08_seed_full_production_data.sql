-- =============================================================================
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

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000001',
  'student',
  'hs4a8_01',
  'Phạm Duy Khánh',
  'HS4A8 -15',
  '1248',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '🎒',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000001',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000002',
  'student',
  'hs4a8_02',
  'Nguyễn Thế Anh',
  'HS4A8 -01',
  '1234',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👦',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000002',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000003',
  'student',
  'hs4a8_03',
  'Phạm Phương Anh',
  'HS4A8 -02',
  '1235',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000003',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000004',
  'student',
  'hs4a8_04',
  'Vũ Bảo Anh',
  'HS4A8 -03',
  '1236',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000004',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000005',
  'student',
  'hs4a8_05',
  'Lê Xuân Bách',
  'HS4A8 -04',
  '1237',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000005',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000006',
  'student',
  'hs4a8_06',
  'Kiều Duy Bảo',
  'HS4A8 -05',
  '1238',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👦',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000006',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000007',
  'student',
  'hs4a8_07',
  'Lưu Minh Châu',
  'HS4A8 -06',
  '1239',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000007',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000008',
  'student',
  'hs4a8_08',
  'Phạm Ngọc Linh Chi',
  'HS4A8 -07',
  '1240',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000008',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000009',
  'student',
  'hs4a8_09',
  'Vũ Hải Đăng',
  'HS4A8 -08',
  '1241',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👦',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000009',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000010',
  'student',
  'hs4a8_10',
  'Bùi Viết Đính',
  'HS4A8 -09',
  '1242',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👦',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000010',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000011',
  'student',
  'hs4a8_11',
  'Vũ Thiên Hương',
  'HS4A8 -10',
  '1243',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000011',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000012',
  'student',
  'hs4a8_12',
  'Bùi An Huy',
  'HS4A8 -11',
  '1244',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000012',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000013',
  'student',
  'hs4a8_13',
  'Phạm Bảo Huy',
  'HS4A8 -12',
  '1245',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000013',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000014',
  'student',
  'hs4a8_14',
  'Đào Minh Khang',
  'HS4A8 -13',
  '1246',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👦',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000014',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000015',
  'student',
  'hs4a8_15',
  'Phan Sỹ Duy Khang',
  'HS4A8 -14',
  '1247',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👦',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000015',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000016',
  'student',
  'hs4a8_16',
  'Tống Đăng Khôi',
  'HS4A8 -16',
  '1249',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👦',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000016',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000017',
  'student',
  'hs4a8_17',
  'Bàn Hiểu Lam',
  'HS4A8 -17',
  '1250',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000017',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000018',
  'student',
  'hs4a8_18',
  'Nguyễn Đức Tùng Lâm',
  'HS4A8 -18',
  '1251',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👦',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000018',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000019',
  'student',
  'hs4a8_19',
  'Nguyễn Nhật Minh',
  'HS4A8 -19',
  '1252',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000019',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000020',
  'student',
  'hs4a8_20',
  'Trần Gia Minh',
  'HS4A8 -20',
  '1253',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000020',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000021',
  'student',
  'hs4a8_21',
  'An Thiên Mỹ',
  'HS4A8 -21',
  '1254',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👦',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000021',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000022',
  'student',
  'hs4a8_22',
  'Phan Khánh Ngân',
  'HS4A8 -22',
  '1255',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000022',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000023',
  'student',
  'hs4a8_23',
  'Nguyễn Bảo Nhi',
  'HS4A8 -23',
  '1256',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000023',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000024',
  'student',
  'hs4a8_24',
  'Trần Tuệ Nhi',
  'HS4A8 -24',
  '1257',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000024',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000025',
  'student',
  'hs4a8_25',
  'Nguyễn Hải Phong',
  'HS4A8 -25',
  '1258',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000025',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000026',
  'student',
  'hs4a8_26',
  'Hoàng Gia Phúc',
  'HS4A8 -26',
  '1259',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000026',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000027',
  'student',
  'hs4a8_27',
  'Nguyễn Minh Quân',
  'HS4A8 -27',
  '1260',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000027',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000028',
  'student',
  'hs4a8_28',
  'Trần Diệu Sa',
  'HS4A8 -28',
  '1261',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000028',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000029',
  'student',
  'hs4a8_29',
  'Trần Vũ Hoàng Tân',
  'HS4A8 -29',
  '1262',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👦',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000029',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000030',
  'student',
  'hs4a8_30',
  'Hà Phương Thảo',
  'HS4A8 -30',
  '1263',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000030',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000031',
  'student',
  'hs4a8_31',
  'Lý Minh Thảo',
  'HS4A8 -31',
  '1264',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000031',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000032',
  'student',
  'hs4a8_32',
  'Vũ Thiên Trang',
  'HS4A8 -32',
  '1265',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👦',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000032',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000033',
  'student',
  'hs4a8_33',
  'Bùi Đỗ Diễm Uyên',
  'HS4A8 -33',
  '1266',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👦',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000033',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000034',
  'student',
  'hs4a8_34',
  'Nguyễn Ngọc Uy Vũ',
  'HS4A8 -34',
  '1267',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000034',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000035',
  'student',
  'hs4a8_35',
  'Nguyễn Bùi Tú Linh',
  'HS4A8 -35',
  '1268',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👦',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000035',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

INSERT INTO public.profiles (id, role, username, full_name, student_code, pin_hash, school_id, class_id, class_name, avatar, status)
VALUES (
  'd0000000-0000-0000-0000-000000000036',
  'student',
  'hs4a8_36',
  'Vương Thiên Phúc',
  'HS4A8 -36',
  '1269',
  'a0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Lớp 4A8',
  '👧',
  'active'
) ON CONFLICT (school_id, student_code) DO UPDATE SET full_name = EXCLUDED.full_name, pin_hash = EXCLUDED.pin_hash;

INSERT INTO public.class_members (class_id, profile_id, role_in_class, status)
VALUES (
  'c0000000-0000-0000-0000-0000000004a8',
  'd0000000-0000-0000-0000-000000000036',
  'student',
  'active'
) ON CONFLICT (class_id, profile_id) DO UPDATE SET status = 'active';

-- 5. SEED 36 BÀI VIẾT HỌC SINH LỚP 4A8 VÀO student_writing_attempts

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000001',
  'd0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Người thợ săn và chú vượn nhỏ',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Người thợ săn và chú vượn nhỏ" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Lòng trắc ẩn và tình mẫu tử thiêng liêng ở mọi loài sinh vật.

Em rất yêu thích câu chuyện "Người thợ săn và chú vượn nhỏ". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Người thợ săn và chú vượn nhỏ" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Lòng trắc ẩn và tình mẫu tử thiêng liêng ở mọi loài sinh vật.

Em rất yêu thích câu chuyện "Người thợ săn và chú vượn nhỏ". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  224,
  'submitted',
  NOW() - INTERVAL '36 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000001',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Người thợ săn và chú vượn nhỏ" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Lòng trắc ẩn và tình mẫu tử thiêng liêng ở mọi loài sinh vật.

Em rất yêu thích câu chuyện "Người thợ săn và chú vượn nhỏ". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  224,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000001'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000001',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Cô khen bài viết diễn đạt tự nhiên, chân thực và giàu cảm xúc!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '35 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000002',
  'd0000000-0000-0000-0000-000000000002',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Kiến và Ve sầu',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Kiến và Ve sầu" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Bài học về sự chăm chỉ, không lười biếng phung phí thời gian.

Em rất yêu thích câu chuyện "Kiến và Ve sầu". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Kiến và Ve sầu" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Bài học về sự chăm chỉ, không lười biếng phung phí thời gian.

Em rất yêu thích câu chuyện "Kiến và Ve sầu". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  217,
  'submitted',
  NOW() - INTERVAL '35 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000002',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Kiến và Ve sầu" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Bài học về sự chăm chỉ, không lười biếng phung phí thời gian.

Em rất yêu thích câu chuyện "Kiến và Ve sầu". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  217,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000002'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000002',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Cô khen bài viết diễn đạt tự nhiên, chân thực và giàu cảm xúc!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '34 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000003',
  'd0000000-0000-0000-0000-000000000003',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Thánh Gióng đánh giặc Ân',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Thánh Gióng đánh giặc Ân" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Sức mạnh quật khởi và tinh thần đoàn kết chống giặc ngoại xâm.

Em rất yêu thích câu chuyện "Thánh Gióng đánh giặc Ân". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Thánh Gióng đánh giặc Ân" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Sức mạnh quật khởi và tinh thần đoàn kết chống giặc ngoại xâm.

Em rất yêu thích câu chuyện "Thánh Gióng đánh giặc Ân". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  219,
  'submitted',
  NOW() - INTERVAL '34 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000003',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Thánh Gióng đánh giặc Ân" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Sức mạnh quật khởi và tinh thần đoàn kết chống giặc ngoại xâm.

Em rất yêu thích câu chuyện "Thánh Gióng đánh giặc Ân". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  219,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000003'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000003',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Cô khen bài viết diễn đạt tự nhiên, chân thực và giàu cảm xúc!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '33 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000004',
  'd0000000-0000-0000-0000-000000000004',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Người mẹ và Thần Chết',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Người mẹ và Thần Chết" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tình mẹ bao la sẵn sàng hy sinh tất cả vì con.

Em rất yêu thích câu chuyện "Người mẹ và Thần Chết". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Người mẹ và Thần Chết" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tình mẹ bao la sẵn sàng hy sinh tất cả vì con.

Em rất yêu thích câu chuyện "Người mẹ và Thần Chết". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  218,
  'submitted',
  NOW() - INTERVAL '33 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000004',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Người mẹ và Thần Chết" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tình mẹ bao la sẵn sàng hy sinh tất cả vì con.

Em rất yêu thích câu chuyện "Người mẹ và Thần Chết". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  218,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000004'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000004',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Cô khen bài viết diễn đạt tự nhiên, chân thực và giàu cảm xúc!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '32 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000005',
  'd0000000-0000-0000-0000-000000000005',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Sự tích chú Cuội cung trăng',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Sự tích chú Cuội cung trăng" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tình cảm gắn bó với cội nguồn và thế giới cổ tích nhiệm màu.

Em rất yêu thích câu chuyện "Sự tích chú Cuội cung trăng". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Sự tích chú Cuội cung trăng" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tình cảm gắn bó với cội nguồn và thế giới cổ tích nhiệm màu.

Em rất yêu thích câu chuyện "Sự tích chú Cuội cung trăng". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  222,
  'submitted',
  NOW() - INTERVAL '32 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000005',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Sự tích chú Cuội cung trăng" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tình cảm gắn bó với cội nguồn và thế giới cổ tích nhiệm màu.

Em rất yêu thích câu chuyện "Sự tích chú Cuội cung trăng". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  222,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000005'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000005',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Cô khen bài viết diễn đạt tự nhiên, chân thực và giàu cảm xúc!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '31 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000006',
  'd0000000-0000-0000-0000-000000000006',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Cậu bé chăn cừu và chó sói',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Cậu bé chăn cừu và chó sói" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Người hay nói dối sẽ không còn được ai tin tưởng.

Em rất yêu thích câu chuyện "Cậu bé chăn cừu và chó sói". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Cậu bé chăn cừu và chó sói" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Người hay nói dối sẽ không còn được ai tin tưởng.

Em rất yêu thích câu chuyện "Cậu bé chăn cừu và chó sói". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  221,
  'submitted',
  NOW() - INTERVAL '31 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000006',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Cậu bé chăn cừu và chó sói" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Người hay nói dối sẽ không còn được ai tin tưởng.

Em rất yêu thích câu chuyện "Cậu bé chăn cừu và chó sói". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  221,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000006'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000006',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Cô khen bài viết diễn đạt tự nhiên, chân thực và giàu cảm xúc!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '30 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000007',
  'd0000000-0000-0000-0000-000000000007',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Bầy chim thiên nga',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Bầy chim thiên nga" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tình thương yêu anh em và nghị lực phi thường vượt thử thách.

Em rất yêu thích câu chuyện "Bầy chim thiên nga". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Bầy chim thiên nga" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tình thương yêu anh em và nghị lực phi thường vượt thử thách.

Em rất yêu thích câu chuyện "Bầy chim thiên nga". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  217,
  'submitted',
  NOW() - INTERVAL '30 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000007',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Bầy chim thiên nga" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tình thương yêu anh em và nghị lực phi thường vượt thử thách.

Em rất yêu thích câu chuyện "Bầy chim thiên nga". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  217,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000007'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000007',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Cô khen bài viết diễn đạt tự nhiên, chân thực và giàu cảm xúc!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '29 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000008',
  'd0000000-0000-0000-0000-000000000008',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Chị Võ Thị Sáu - Người con gái Đất Đỏ',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Chị Võ Thị Sáu - Người con gái Đất Đỏ" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Lòng dũng cảm, kiên trung bất khuất trước kẻ thù.

Em rất yêu thích câu chuyện "Chị Võ Thị Sáu - Người con gái Đất Đỏ". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Chị Võ Thị Sáu - Người con gái Đất Đỏ" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Lòng dũng cảm, kiên trung bất khuất trước kẻ thù.

Em rất yêu thích câu chuyện "Chị Võ Thị Sáu - Người con gái Đất Đỏ". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  226,
  'submitted',
  NOW() - INTERVAL '29 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000008',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Chị Võ Thị Sáu - Người con gái Đất Đỏ" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Lòng dũng cảm, kiên trung bất khuất trước kẻ thù.

Em rất yêu thích câu chuyện "Chị Võ Thị Sáu - Người con gái Đất Đỏ". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  226,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000008'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000008',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Cô khen bài viết diễn đạt tự nhiên, chân thực và giàu cảm xúc!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '28 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000009',
  'd0000000-0000-0000-0000-000000000009',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Búp sen xanh thời niên thiếu Bác Hồ',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Búp sen xanh thời niên thiếu Bác Hồ" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Học tập tấm gương đạo đức sáng ngời và lòng thương dân của Bác.

Em rất yêu thích câu chuyện "Búp sen xanh thời niên thiếu Bác Hồ". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Búp sen xanh thời niên thiếu Bác Hồ" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Học tập tấm gương đạo đức sáng ngời và lòng thương dân của Bác.

Em rất yêu thích câu chuyện "Búp sen xanh thời niên thiếu Bác Hồ". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  226,
  'completed',
  NOW() - INTERVAL '28 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000009',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Búp sen xanh thời niên thiếu Bác Hồ" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Học tập tấm gương đạo đức sáng ngời và lòng thương dân của Bác.

Em rất yêu thích câu chuyện "Búp sen xanh thời niên thiếu Bác Hồ". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  226,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000009'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000009',
  'b0000000-0000-0000-0000-000000000001',
  9.5,
  'Cô khen ngợi Trần Diệu Sa! Bài viết kể lại câu chuyện "Búp sen xanh thời niên thiếu Bác Hồ" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '27 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000010',
  'd0000000-0000-0000-0000-000000000010',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Hũ bạc của người cha',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Hũ bạc của người cha" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Bàn tay lao động chân chính là của cải quý giá nhất.

Em rất yêu thích câu chuyện "Hũ bạc của người cha". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Hũ bạc của người cha" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Bàn tay lao động chân chính là của cải quý giá nhất.

Em rất yêu thích câu chuyện "Hũ bạc của người cha". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  218,
  'completed',
  NOW() - INTERVAL '27 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000010',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Hũ bạc của người cha" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Bàn tay lao động chân chính là của cải quý giá nhất.

Em rất yêu thích câu chuyện "Hũ bạc của người cha". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  218,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000010'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000010',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Cô khen ngợi Nguyễn Minh Quân! Bài viết kể lại câu chuyện "Hũ bạc của người cha" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '26 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000011',
  'd0000000-0000-0000-0000-000000000011',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Trần Quốc Toản bóp nát quả cam',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Trần Quốc Toản bóp nát quả cam" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Ý chí kiên cường và lòng yêu nước nồng nàn của tuổi trẻ.

Em rất yêu thích câu chuyện "Trần Quốc Toản bóp nát quả cam". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Trần Quốc Toản bóp nát quả cam" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Ý chí kiên cường và lòng yêu nước nồng nàn của tuổi trẻ.

Em rất yêu thích câu chuyện "Trần Quốc Toản bóp nát quả cam". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  223,
  'completed',
  NOW() - INTERVAL '26 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000011',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Trần Quốc Toản bóp nát quả cam" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Ý chí kiên cường và lòng yêu nước nồng nàn của tuổi trẻ.

Em rất yêu thích câu chuyện "Trần Quốc Toản bóp nát quả cam". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  223,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000011'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000011',
  'b0000000-0000-0000-0000-000000000001',
  8.5,
  'Cô khen ngợi Hoàng Gia Phúc! Bài viết kể lại câu chuyện "Trần Quốc Toản bóp nát quả cam" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '25 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000012',
  'd0000000-0000-0000-0000-000000000012',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Yết Kiêu đục thuyền giặc',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Yết Kiêu đục thuyền giặc" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Lòng dũng cảm và tinh thần hy sinh vì Tổ quốc.

Em rất yêu thích câu chuyện "Yết Kiêu đục thuyền giặc". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Yết Kiêu đục thuyền giặc" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Lòng dũng cảm và tinh thần hy sinh vì Tổ quốc.

Em rất yêu thích câu chuyện "Yết Kiêu đục thuyền giặc". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  217,
  'completed',
  NOW() - INTERVAL '25 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000012',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Yết Kiêu đục thuyền giặc" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Lòng dũng cảm và tinh thần hy sinh vì Tổ quốc.

Em rất yêu thích câu chuyện "Yết Kiêu đục thuyền giặc". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  217,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000012'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000012',
  'b0000000-0000-0000-0000-000000000001',
  9.5,
  'Cô khen ngợi Nguyễn Hải Phong! Bài viết kể lại câu chuyện "Yết Kiêu đục thuyền giặc" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '24 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000013',
  'd0000000-0000-0000-0000-000000000013',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Chiếc áo ấm của mùa đông',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Chiếc áo ấm của mùa đông" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Sự sẻ chia, tương thân tương ái giữa bạn bè cùng lớp.

Em rất yêu thích câu chuyện "Chiếc áo ấm của mùa đông". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Chiếc áo ấm của mùa đông" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Sự sẻ chia, tương thân tương ái giữa bạn bè cùng lớp.

Em rất yêu thích câu chuyện "Chiếc áo ấm của mùa đông". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  220,
  'completed',
  NOW() - INTERVAL '24 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000013',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Chiếc áo ấm của mùa đông" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Sự sẻ chia, tương thân tương ái giữa bạn bè cùng lớp.

Em rất yêu thích câu chuyện "Chiếc áo ấm của mùa đông". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  220,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000013'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000013',
  'b0000000-0000-0000-0000-000000000001',
  8.5,
  'Cô khen ngợi Trần Tuệ Nhi! Bài viết kể lại câu chuyện "Chiếc áo ấm của mùa đông" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '23 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000014',
  'd0000000-0000-0000-0000-000000000014',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Bác nông dân và ba người con trai',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Bác nông dân và ba người con trai" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Đoàn kết là sức mạnh giúp gia đình vững bền.

Em rất yêu thích câu chuyện "Bác nông dân và ba người con trai". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Bác nông dân và ba người con trai" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Đoàn kết là sức mạnh giúp gia đình vững bền.

Em rất yêu thích câu chuyện "Bác nông dân và ba người con trai". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  222,
  'completed',
  NOW() - INTERVAL '23 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000014',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Bác nông dân và ba người con trai" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Đoàn kết là sức mạnh giúp gia đình vững bền.

Em rất yêu thích câu chuyện "Bác nông dân và ba người con trai". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  222,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000014'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000014',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Cô khen ngợi Nguyễn Bảo Nhi! Bài viết kể lại câu chuyện "Bác nông dân và ba người con trai" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '22 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000015',
  'd0000000-0000-0000-0000-000000000015',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Tiếng cười là liều thuốc bổ',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Tiếng cười là liều thuốc bổ" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tinh thần lạc quan, vui vẻ giúp cuộc sống thêm ý nghĩa.

Em rất yêu thích câu chuyện "Tiếng cười là liều thuốc bổ". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Tiếng cười là liều thuốc bổ" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tinh thần lạc quan, vui vẻ giúp cuộc sống thêm ý nghĩa.

Em rất yêu thích câu chuyện "Tiếng cười là liều thuốc bổ". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  220,
  'completed',
  NOW() - INTERVAL '22 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000015',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Tiếng cười là liều thuốc bổ" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tinh thần lạc quan, vui vẻ giúp cuộc sống thêm ý nghĩa.

Em rất yêu thích câu chuyện "Tiếng cười là liều thuốc bổ". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  220,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000015'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000015',
  'b0000000-0000-0000-0000-000000000001',
  9.5,
  'Cô khen ngợi Phan Khánh Ngân! Bài viết kể lại câu chuyện "Tiếng cười là liều thuốc bổ" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '21 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000016',
  'd0000000-0000-0000-0000-000000000016',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Sự tích trầu cau',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Sự tích trầu cau" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tình nghĩa anh em ruột thịt và tình vợ chồng thủy chung.

Em rất yêu thích câu chuyện "Sự tích trầu cau". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Sự tích trầu cau" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tình nghĩa anh em ruột thịt và tình vợ chồng thủy chung.

Em rất yêu thích câu chuyện "Sự tích trầu cau". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  216,
  'completed',
  NOW() - INTERVAL '21 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000016',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Sự tích trầu cau" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tình nghĩa anh em ruột thịt và tình vợ chồng thủy chung.

Em rất yêu thích câu chuyện "Sự tích trầu cau". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  216,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000016'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000016',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Cô khen ngợi An Thiên Mỹ! Bài viết kể lại câu chuyện "Sự tích trầu cau" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '20 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000017',
  'd0000000-0000-0000-0000-000000000017',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Sự tích Bánh chưng, bánh giầy',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Sự tích Bánh chưng, bánh giầy" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Lòng hiếu kính tổ tiên và nét đẹp văn hóa truyền thống.

Em rất yêu thích câu chuyện "Sự tích Bánh chưng, bánh giầy". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Sự tích Bánh chưng, bánh giầy" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Lòng hiếu kính tổ tiên và nét đẹp văn hóa truyền thống.

Em rất yêu thích câu chuyện "Sự tích Bánh chưng, bánh giầy". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  220,
  'completed',
  NOW() - INTERVAL '20 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000017',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Sự tích Bánh chưng, bánh giầy" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Lòng hiếu kính tổ tiên và nét đẹp văn hóa truyền thống.

Em rất yêu thích câu chuyện "Sự tích Bánh chưng, bánh giầy". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  220,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000017'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000017',
  'b0000000-0000-0000-0000-000000000001',
  8.5,
  'Cô khen ngợi Trần Gia Minh! Bài viết kể lại câu chuyện "Sự tích Bánh chưng, bánh giầy" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '19 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000018',
  'd0000000-0000-0000-0000-000000000018',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Sơn Tinh - Thủy Tinh',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Sơn Tinh - Thủy Tinh" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Sức mạnh kiên cường của nhân dân ta chống chọi với thiên tai.

Em rất yêu thích câu chuyện "Sơn Tinh - Thủy Tinh". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Sơn Tinh - Thủy Tinh" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Sức mạnh kiên cường của nhân dân ta chống chọi với thiên tai.

Em rất yêu thích câu chuyện "Sơn Tinh - Thủy Tinh". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  219,
  'completed',
  NOW() - INTERVAL '19 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000018',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Sơn Tinh - Thủy Tinh" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Sức mạnh kiên cường của nhân dân ta chống chọi với thiên tai.

Em rất yêu thích câu chuyện "Sơn Tinh - Thủy Tinh". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  219,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000018'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000018',
  'b0000000-0000-0000-0000-000000000001',
  9.5,
  'Cô khen ngợi Nguyễn Nhật Minh! Bài viết kể lại câu chuyện "Sơn Tinh - Thủy Tinh" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '18 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000019',
  'd0000000-0000-0000-0000-000000000019',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Con Rồng cháu Tiên',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Con Rồng cháu Tiên" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Niềm tự hào về cội nguồn dân tộc và tình nghĩa đồng bào.

Em rất yêu thích câu chuyện "Con Rồng cháu Tiên". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Con Rồng cháu Tiên" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Niềm tự hào về cội nguồn dân tộc và tình nghĩa đồng bào.

Em rất yêu thích câu chuyện "Con Rồng cháu Tiên". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  217,
  'completed',
  NOW() - INTERVAL '18 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000019',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Con Rồng cháu Tiên" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Niềm tự hào về cội nguồn dân tộc và tình nghĩa đồng bào.

Em rất yêu thích câu chuyện "Con Rồng cháu Tiên". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  217,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000019'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000019',
  'b0000000-0000-0000-0000-000000000001',
  8.5,
  'Cô khen ngợi Nguyễn Đức Tùng Lâm! Bài viết kể lại câu chuyện "Con Rồng cháu Tiên" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '17 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000020',
  'd0000000-0000-0000-0000-000000000020',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Cô bé bán diêm',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Cô bé bán diêm" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Lòng trắc ẩn, sự đồng cảm với những mảnh đời bất hạnh.

Em rất yêu thích câu chuyện "Cô bé bán diêm". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Cô bé bán diêm" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Lòng trắc ẩn, sự đồng cảm với những mảnh đời bất hạnh.

Em rất yêu thích câu chuyện "Cô bé bán diêm". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  216,
  'completed',
  NOW() - INTERVAL '17 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000020',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Cô bé bán diêm" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Lòng trắc ẩn, sự đồng cảm với những mảnh đời bất hạnh.

Em rất yêu thích câu chuyện "Cô bé bán diêm". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  216,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000020'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000020',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Cô khen ngợi Bàn Hiểu Lam! Bài viết kể lại câu chuyện "Cô bé bán diêm" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '16 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000021',
  'd0000000-0000-0000-0000-000000000021',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Ông lão đánh cá và con cá vàng',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Ông lão đánh cá và con cá vàng" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Thói tham lam vô độ sẽ đánh mất tất cả những gì đang có.

Em rất yêu thích câu chuyện "Ông lão đánh cá và con cá vàng". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Ông lão đánh cá và con cá vàng" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Thói tham lam vô độ sẽ đánh mất tất cả những gì đang có.

Em rất yêu thích câu chuyện "Ông lão đánh cá và con cá vàng". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  226,
  'completed',
  NOW() - INTERVAL '16 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000021',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Ông lão đánh cá và con cá vàng" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Thói tham lam vô độ sẽ đánh mất tất cả những gì đang có.

Em rất yêu thích câu chuyện "Ông lão đánh cá và con cá vàng". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  226,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000021'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000021',
  'b0000000-0000-0000-0000-000000000001',
  9.5,
  'Cô khen ngợi Tống Đăng Khôi! Bài viết kể lại câu chuyện "Ông lão đánh cá và con cá vàng" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '15 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000022',
  'd0000000-0000-0000-0000-000000000022',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Sự tích cây vú sữa',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Sự tích cây vú sữa" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Bài học đắt giá về việc yêu thương, kính trọng cha mẹ khi còn có thể.

Em rất yêu thích câu chuyện "Sự tích cây vú sữa". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Sự tích cây vú sữa" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Bài học đắt giá về việc yêu thương, kính trọng cha mẹ khi còn có thể.

Em rất yêu thích câu chuyện "Sự tích cây vú sữa". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  222,
  'completed',
  NOW() - INTERVAL '15 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000022',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Sự tích cây vú sữa" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Bài học đắt giá về việc yêu thương, kính trọng cha mẹ khi còn có thể.

Em rất yêu thích câu chuyện "Sự tích cây vú sữa". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  222,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000022'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000022',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Cô khen ngợi Phạm Duy Khánh! Bài viết kể lại câu chuyện "Sự tích cây vú sữa" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '14 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000023',
  'd0000000-0000-0000-0000-000000000023',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Ba lưỡi rìu',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Ba lưỡi rìu" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tính trung thực là phẩm chất đáng quý nhất của con người.

Em rất yêu thích câu chuyện "Ba lưỡi rìu". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Ba lưỡi rìu" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tính trung thực là phẩm chất đáng quý nhất của con người.

Em rất yêu thích câu chuyện "Ba lưỡi rìu". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  214,
  'completed',
  NOW() - INTERVAL '14 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000023',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Ba lưỡi rìu" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tính trung thực là phẩm chất đáng quý nhất của con người.

Em rất yêu thích câu chuyện "Ba lưỡi rìu". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  214,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000023'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000023',
  'b0000000-0000-0000-0000-000000000001',
  8.5,
  'Cô khen ngợi Phan Sỹ Duy Khang! Bài viết kể lại câu chuyện "Ba lưỡi rìu" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '13 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000024',
  'd0000000-0000-0000-0000-000000000024',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Ông Trạng thả diều (Nguyễn Hiền)',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Ông Trạng thả diều (Nguyễn Hiền)" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tinh thần hiếu học, vượt khó vươn lên thành tài.

Em rất yêu thích câu chuyện "Ông Trạng thả diều (Nguyễn Hiền)". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Ông Trạng thả diều (Nguyễn Hiền)" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tinh thần hiếu học, vượt khó vươn lên thành tài.

Em rất yêu thích câu chuyện "Ông Trạng thả diều (Nguyễn Hiền)". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  218,
  'completed',
  NOW() - INTERVAL '13 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000024',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Ông Trạng thả diều (Nguyễn Hiền)" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tinh thần hiếu học, vượt khó vươn lên thành tài.

Em rất yêu thích câu chuyện "Ông Trạng thả diều (Nguyễn Hiền)". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  218,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000024'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000024',
  'b0000000-0000-0000-0000-000000000001',
  9.5,
  'Cô khen ngợi Đào Minh Khang! Bài viết kể lại câu chuyện "Ông Trạng thả diều (Nguyễn Hiền)" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '12 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000025',
  'd0000000-0000-0000-0000-000000000025',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Vua tàu thủy Bạch Thái Bưởi',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Vua tàu thủy Bạch Thái Bưởi" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Nghị lực vươn lên và tinh thần tự hào dân tộc.

Em rất yêu thích câu chuyện "Vua tàu thủy Bạch Thái Bưởi". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Vua tàu thủy Bạch Thái Bưởi" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Nghị lực vươn lên và tinh thần tự hào dân tộc.

Em rất yêu thích câu chuyện "Vua tàu thủy Bạch Thái Bưởi". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  219,
  'completed',
  NOW() - INTERVAL '12 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000025',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Vua tàu thủy Bạch Thái Bưởi" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Nghị lực vươn lên và tinh thần tự hào dân tộc.

Em rất yêu thích câu chuyện "Vua tàu thủy Bạch Thái Bưởi". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  219,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000025'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000025',
  'b0000000-0000-0000-0000-000000000001',
  8.5,
  'Cô khen ngợi Phạm Bảo Huy! Bài viết kể lại câu chuyện "Vua tàu thủy Bạch Thái Bưởi" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '11 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000026',
  'd0000000-0000-0000-0000-000000000026',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Người ăn xin',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Người ăn xin" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Sự đồng cảm và tôn trọng con người quý giá hơn mọi của cải.

Em rất yêu thích câu chuyện "Người ăn xin". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Người ăn xin" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Sự đồng cảm và tôn trọng con người quý giá hơn mọi của cải.

Em rất yêu thích câu chuyện "Người ăn xin". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  216,
  'completed',
  NOW() - INTERVAL '11 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000026',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Người ăn xin" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Sự đồng cảm và tôn trọng con người quý giá hơn mọi của cải.

Em rất yêu thích câu chuyện "Người ăn xin". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  216,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000026'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000026',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Cô khen ngợi Bùi An Huy! Bài viết kể lại câu chuyện "Người ăn xin" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '10 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000027',
  'd0000000-0000-0000-0000-000000000027',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Lời ước dưới trăng',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Lời ước dưới trăng" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Ước nguyện cao đẹp nhất là ước cho hạnh phúc của người khác.

Em rất yêu thích câu chuyện "Lời ước dưới trăng". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Lời ước dưới trăng" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Ước nguyện cao đẹp nhất là ước cho hạnh phúc của người khác.

Em rất yêu thích câu chuyện "Lời ước dưới trăng". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  217,
  'completed',
  NOW() - INTERVAL '10 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000027',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Lời ước dưới trăng" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Ước nguyện cao đẹp nhất là ước cho hạnh phúc của người khác.

Em rất yêu thích câu chuyện "Lời ước dưới trăng". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  217,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000027'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000027',
  'b0000000-0000-0000-0000-000000000001',
  9.5,
  'Cô khen ngợi Vũ Thiên Hương! Bài viết kể lại câu chuyện "Lời ước dưới trăng" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '9 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000028',
  'd0000000-0000-0000-0000-000000000028',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Hai anh em và bông lúa vàng',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Hai anh em và bông lúa vàng" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tình cảm anh em gắn bó, luôn biết sẻ chia và nghĩ cho nhau.

Em rất yêu thích câu chuyện "Hai anh em và bông lúa vàng". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Hai anh em và bông lúa vàng" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tình cảm anh em gắn bó, luôn biết sẻ chia và nghĩ cho nhau.

Em rất yêu thích câu chuyện "Hai anh em và bông lúa vàng". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  224,
  'completed',
  NOW() - INTERVAL '9 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000028',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Hai anh em và bông lúa vàng" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tình cảm anh em gắn bó, luôn biết sẻ chia và nghĩ cho nhau.

Em rất yêu thích câu chuyện "Hai anh em và bông lúa vàng". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  224,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000028'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000028',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Cô khen ngợi Bùi Viết Đính! Bài viết kể lại câu chuyện "Hai anh em và bông lúa vàng" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '8 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000029',
  'd0000000-0000-0000-0000-000000000029',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Sự tích hồ Ba Bể',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Sự tích hồ Ba Bể" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Lòng nhân ái, giúp đỡ người hoạn nạn sẽ được bảo bọc bình an.

Em rất yêu thích câu chuyện "Sự tích hồ Ba Bể". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Sự tích hồ Ba Bể" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Lòng nhân ái, giúp đỡ người hoạn nạn sẽ được bảo bọc bình an.

Em rất yêu thích câu chuyện "Sự tích hồ Ba Bể". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  220,
  'completed',
  NOW() - INTERVAL '8 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000029',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Sự tích hồ Ba Bể" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Lòng nhân ái, giúp đỡ người hoạn nạn sẽ được bảo bọc bình an.

Em rất yêu thích câu chuyện "Sự tích hồ Ba Bể". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  220,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000029'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000029',
  'b0000000-0000-0000-0000-000000000001',
  8.5,
  'Cô khen ngợi Vũ Hải Đăng! Bài viết kể lại câu chuyện "Sự tích hồ Ba Bể" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '7 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000030',
  'd0000000-0000-0000-0000-000000000030',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Nàng Bạch Tuyết và bảy chú lùn',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Nàng Bạch Tuyết và bảy chú lùn" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Cái thiện luôn chiến thắng cái ác, lòng tốt được đền đáp.

Em rất yêu thích câu chuyện "Nàng Bạch Tuyết và bảy chú lùn". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Nàng Bạch Tuyết và bảy chú lùn" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Cái thiện luôn chiến thắng cái ác, lòng tốt được đền đáp.

Em rất yêu thích câu chuyện "Nàng Bạch Tuyết và bảy chú lùn". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  222,
  'completed',
  NOW() - INTERVAL '7 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000030',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Nàng Bạch Tuyết và bảy chú lùn" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Cái thiện luôn chiến thắng cái ác, lòng tốt được đền đáp.

Em rất yêu thích câu chuyện "Nàng Bạch Tuyết và bảy chú lùn". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  222,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000030'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000030',
  'b0000000-0000-0000-0000-000000000001',
  9.5,
  'Cô khen ngợi Phạm Ngọc Linh Chi! Bài viết kể lại câu chuyện "Nàng Bạch Tuyết và bảy chú lùn" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '6 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000031',
  'd0000000-0000-0000-0000-000000000031',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Bông hoa cúc trắng',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Bông hoa cúc trắng" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tình mẫu tử thiêng liêng và sức mạnh của lòng hiếu thảo.

Em rất yêu thích câu chuyện "Bông hoa cúc trắng". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Bông hoa cúc trắng" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tình mẫu tử thiêng liêng và sức mạnh của lòng hiếu thảo.

Em rất yêu thích câu chuyện "Bông hoa cúc trắng". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  216,
  'completed',
  NOW() - INTERVAL '6 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000031',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Bông hoa cúc trắng" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Tình mẫu tử thiêng liêng và sức mạnh của lòng hiếu thảo.

Em rất yêu thích câu chuyện "Bông hoa cúc trắng". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  216,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000031'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000031',
  'b0000000-0000-0000-0000-000000000001',
  8.5,
  'Cô khen ngợi Lưu Minh Châu! Bài viết kể lại câu chuyện "Bông hoa cúc trắng" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '5 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000032',
  'd0000000-0000-0000-0000-000000000032',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Cậu bé thông minh',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Cậu bé thông minh" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Trí tuệ, sự bình tĩnh giúp vượt qua mọi thử thách hiểm nghèo.

Em rất yêu thích câu chuyện "Cậu bé thông minh". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Cậu bé thông minh" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Trí tuệ, sự bình tĩnh giúp vượt qua mọi thử thách hiểm nghèo.

Em rất yêu thích câu chuyện "Cậu bé thông minh". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  217,
  'completed',
  NOW() - INTERVAL '5 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000032',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Cậu bé thông minh" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Trí tuệ, sự bình tĩnh giúp vượt qua mọi thử thách hiểm nghèo.

Em rất yêu thích câu chuyện "Cậu bé thông minh". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  217,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000032'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000032',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Cô khen ngợi Kiều Duy Bảo! Bài viết kể lại câu chuyện "Cậu bé thông minh" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '4 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000033',
  'd0000000-0000-0000-0000-000000000033',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Thạch Sanh đánh chằn tinh',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Thạch Sanh đánh chằn tinh" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Chính nghĩa luôn chiến thắng gian tà, người ở hiền gặp lành.

Em rất yêu thích câu chuyện "Thạch Sanh đánh chằn tinh". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Thạch Sanh đánh chằn tinh" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Chính nghĩa luôn chiến thắng gian tà, người ở hiền gặp lành.

Em rất yêu thích câu chuyện "Thạch Sanh đánh chằn tinh". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  218,
  'completed',
  NOW() - INTERVAL '4 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000033',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Thạch Sanh đánh chằn tinh" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Chính nghĩa luôn chiến thắng gian tà, người ở hiền gặp lành.

Em rất yêu thích câu chuyện "Thạch Sanh đánh chằn tinh". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  218,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000033'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000033',
  'b0000000-0000-0000-0000-000000000001',
  9.5,
  'Cô khen ngợi Lê Xuân Bách! Bài viết kể lại câu chuyện "Thạch Sanh đánh chằn tinh" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '3 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000034',
  'd0000000-0000-0000-0000-000000000034',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Rùa và Thỏ chạy thi',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Rùa và Thỏ chạy thi" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Kiên trì, nhẫn nại sẽ chiến thắng thói chủ quan kiêu ngạo.

Em rất yêu thích câu chuyện "Rùa và Thỏ chạy thi". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Rùa và Thỏ chạy thi" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Kiên trì, nhẫn nại sẽ chiến thắng thói chủ quan kiêu ngạo.

Em rất yêu thích câu chuyện "Rùa và Thỏ chạy thi". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  218,
  'completed',
  NOW() - INTERVAL '3 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000034',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Rùa và Thỏ chạy thi" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Kiên trì, nhẫn nại sẽ chiến thắng thói chủ quan kiêu ngạo.

Em rất yêu thích câu chuyện "Rùa và Thỏ chạy thi". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  218,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000034'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000034',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Cô khen ngợi Vũ Bảo Anh! Bài viết kể lại câu chuyện "Rùa và Thỏ chạy thi" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '2 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000035',
  'd0000000-0000-0000-0000-000000000035',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Sự tích hoa cúc trắng',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Sự tích hoa cúc trắng" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Ca ngợi lòng hiếu thảo vô bờ bến của người con dành cho mẹ.

Em rất yêu thích câu chuyện "Sự tích hoa cúc trắng". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Sự tích hoa cúc trắng" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Ca ngợi lòng hiếu thảo vô bờ bến của người con dành cho mẹ.

Em rất yêu thích câu chuyện "Sự tích hoa cúc trắng". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  220,
  'completed',
  NOW() - INTERVAL '2 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000035',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Sự tích hoa cúc trắng" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Ca ngợi lòng hiếu thảo vô bờ bến của người con dành cho mẹ.

Em rất yêu thích câu chuyện "Sự tích hoa cúc trắng". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  220,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000035'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000035',
  'b0000000-0000-0000-0000-000000000001',
  8.5,
  'Cô khen ngợi Phạm Phương Anh! Bài viết kể lại câu chuyện "Sự tích hoa cúc trắng" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '1 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000036',
  'd0000000-0000-0000-0000-000000000036',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kể lại câu chuyện: Cây khế (Ăn khế trả vàng)',
  'essay',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Cây khế (Ăn khế trả vàng)" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Bài học về lòng nhân hậu, không tham lam và sống biết ơn.

Em rất yêu thích câu chuyện "Cây khế (Ăn khế trả vàng)". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Cây khế (Ăn khế trả vàng)" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Bài học về lòng nhân hậu, không tham lam và sống biết ơn.

Em rất yêu thích câu chuyện "Cây khế (Ăn khế trả vàng)". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  6,
  221,
  'completed',
  NOW() - INTERVAL '1 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000036',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong kho tàng truyện cổ mà em đã được đọc và được nghe kể, câu chuyện "Cây khế (Ăn khế trả vàng)" đã để lại trong em ấn tượng sâu sắc và nhiều bài học bổ ích nhất.

Mở đầu câu chuyện, khung cảnh và các nhân vật hiện lên vô cùng sống động. Nhân vật chính trong truyện trải qua những thử thách cam go nhưng luôn giữ vững phẩm chất tốt đẹp. Từng tình tiết diễn ra nối tiếp nhau vừa lôi cuốn, vừa chứa đựng những bất ngờ thú vị khiến người đọc không thể rời mắt. Khi mâu thuẫn được đẩy lên cao trào, sự việc đã được giải quyết một cách công bằng và thỏa đáng, đúng như quy luật "ở hiền gặp lành" của ông cha ta từ ngàn đời nay.

Kết thúc câu chuyện, người tốt được hưởng hạnh phúc viên mãn, còn kẻ xấu phải nhận bài học thích đáng. Qua câu chuyện này, em hiểu thêm rằng: Bài học về lòng nhân hậu, không tham lam và sống biết ơn.

Em rất yêu thích câu chuyện "Cây khế (Ăn khế trả vàng)". Câu chuyện không chỉ giúp em mở mang trí tưởng tượng mà còn dạy cho em cách sống nhân ái, trung thực và biết yêu thương những người xung quanh.',
  221,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000036'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000036',
  'b0000000-0000-0000-0000-000000000001',
  9.5,
  'Cô khen ngợi Nguyễn Thế Anh! Bài viết kể lại câu chuyện "Cây khế (Ăn khế trả vàng)" rất mạch lạc, bố cục rõ ràng và nêu bật được bài học ý nghĩa. Chữ viết và cách dùng từ tiến bộ rõ rệt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '0 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000037',
  'd0000000-0000-0000-0000-000000000037',
  'c0000000-0000-0000-0000-0000000004a8',
  'Chú chó Vàng trung thành của ông ngoại',
  'essay',
  'Mỗi lần về quê thăm ông bà ngoại, người đầu tiên chạy ra đón em ở cổng luôn là chú chó Vàng. Chú là người gác cổng trung thành và dũng cảm của gia đình ông ngoại.

Vàng có bộ lông màu vàng óng như tơ tằm, mịn màng và sạch sẽ. Đôi mắt màu nâu sẫm thông minh, luôn nhìn quanh để canh chừng người lạ. Đôi tai tam giác lúc nào cũng dựng đứng lên để nghe ngóng từng bước chân. Chiếc mũi đen bóng ươn ướt cực kỳ thính nhạy, chỉ cần một mùi hương quen là chú nhận ra ngay từ đằng xa. Bốn chân thon dài với những móng vuốt sắc nhọn giúp chú chạy nhảy rất nhanh. Chiếc đuôi cong cong hình lưỡi liềm mỗi khi thấy em về lại vẫy tít mù, miệng rên lên khe khẽ mừng rỡ. Ban đêm, Vàng nằm im bên hiên nhà nhưng chỉ cần có tiếng động lạ là chú lập tức cất tiếng sủa dõng dạc bảo vệ xóm làng.

Em rất quý chú chó Vàng. Chú không chỉ là loài vật nuôi có ích mà còn là người bạn bốn chân vô cùng tình cảm của gia đình em.',
  'Mỗi lần về quê thăm ông bà ngoại, người đầu tiên chạy ra đón em ở cổng luôn là chú chó Vàng. Chú là người gác cổng trung thành và dũng cảm của gia đình ông ngoại.

Vàng có bộ lông màu vàng óng như tơ tằm, mịn màng và sạch sẽ. Đôi mắt màu nâu sẫm thông minh, luôn nhìn quanh để canh chừng người lạ. Đôi tai tam giác lúc nào cũng dựng đứng lên để nghe ngóng từng bước chân. Chiếc mũi đen bóng ươn ướt cực kỳ thính nhạy, chỉ cần một mùi hương quen là chú nhận ra ngay từ đằng xa. Bốn chân thon dài với những móng vuốt sắc nhọn giúp chú chạy nhảy rất nhanh. Chiếc đuôi cong cong hình lưỡi liềm mỗi khi thấy em về lại vẫy tít mù, miệng rên lên khe khẽ mừng rỡ. Ban đêm, Vàng nằm im bên hiên nhà nhưng chỉ cần có tiếng động lạ là chú lập tức cất tiếng sủa dõng dạc bảo vệ xóm làng.

Em rất quý chú chó Vàng. Chú không chỉ là loài vật nuôi có ích mà còn là người bạn bốn chân vô cùng tình cảm của gia đình em.',
  6,
  1,
  'completed',
  NOW() - INTERVAL '0 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000037',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Mỗi lần về quê thăm ông bà ngoại, người đầu tiên chạy ra đón em ở cổng luôn là chú chó Vàng. Chú là người gác cổng trung thành và dũng cảm của gia đình ông ngoại.

Vàng có bộ lông màu vàng óng như tơ tằm, mịn màng và sạch sẽ. Đôi mắt màu nâu sẫm thông minh, luôn nhìn quanh để canh chừng người lạ. Đôi tai tam giác lúc nào cũng dựng đứng lên để nghe ngóng từng bước chân. Chiếc mũi đen bóng ươn ướt cực kỳ thính nhạy, chỉ cần một mùi hương quen là chú nhận ra ngay từ đằng xa. Bốn chân thon dài với những móng vuốt sắc nhọn giúp chú chạy nhảy rất nhanh. Chiếc đuôi cong cong hình lưỡi liềm mỗi khi thấy em về lại vẫy tít mù, miệng rên lên khe khẽ mừng rỡ. Ban đêm, Vàng nằm im bên hiên nhà nhưng chỉ cần có tiếng động lạ là chú lập tức cất tiếng sủa dõng dạc bảo vệ xóm làng.

Em rất quý chú chó Vàng. Chú không chỉ là loài vật nuôi có ích mà còn là người bạn bốn chân vô cùng tình cảm của gia đình em.',
  1,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000037'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000037',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Duy Khánh miêu tả chú chó Vàng rất chân thực và tình cảm. Câu văn giàu cảm xúc và hình ảnh so sánh sinh động!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '-1 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000038',
  'd0000000-0000-0000-0000-000000000038',
  'c0000000-0000-0000-0000-0000000004a8',
  'Chiếc bút máy mực tím đồng hành mỗi ngày',
  'essay',
  'Bước sang năm học lớp 4, em bắt đầu làm quen với việc luyện viết chữ đẹp bằng chiếc bút máy mực tím do bố tặng. Đây là món đồ dùng học tập mà em nâng niu và trân trọng nhất.

Chiếc bút có thân hình thon dài khoảng mười lăm xăng-ti-mét, khoác chiếc áo màu xanh coban bóng loáng. Nắp bút làm bằng kim loại mạ vàng sáng lấp lánh, có chiếc cài bút tiện lợi để em cài vào túi áo hoặc mép vở. Khi mở nắp bút ra, ngòi bút hình mũi tên bằng thép sáng bóng lộ ra kiêu hãnh. Bên trong thân bút là chiếc ruột đựng mực dạng xoắn ốc bằng nhựa dẻo, giúp em dễ dàng bơm mực khi hết. Mỗi khi đặt bút viết lên trang giấy trắng, dòng mực tím chảy đều đặn, tạo nên những nét chữ thanh đậm mềm mại và ngay ngắn.

Chiếc bút máy đã cùng em viết nên bao bài toán khó, bao bài văn giàu cảm xúc. Em luôn giữ gìn bút cẩn thận, viết xong đậy nắp ngay để ngòi bút không bị cong hỏng.',
  'Bước sang năm học lớp 4, em bắt đầu làm quen với việc luyện viết chữ đẹp bằng chiếc bút máy mực tím do bố tặng. Đây là món đồ dùng học tập mà em nâng niu và trân trọng nhất.

Chiếc bút có thân hình thon dài khoảng mười lăm xăng-ti-mét, khoác chiếc áo màu xanh coban bóng loáng. Nắp bút làm bằng kim loại mạ vàng sáng lấp lánh, có chiếc cài bút tiện lợi để em cài vào túi áo hoặc mép vở. Khi mở nắp bút ra, ngòi bút hình mũi tên bằng thép sáng bóng lộ ra kiêu hãnh. Bên trong thân bút là chiếc ruột đựng mực dạng xoắn ốc bằng nhựa dẻo, giúp em dễ dàng bơm mực khi hết. Mỗi khi đặt bút viết lên trang giấy trắng, dòng mực tím chảy đều đặn, tạo nên những nét chữ thanh đậm mềm mại và ngay ngắn.

Chiếc bút máy đã cùng em viết nên bao bài toán khó, bao bài văn giàu cảm xúc. Em luôn giữ gìn bút cẩn thận, viết xong đậy nắp ngay để ngòi bút không bị cong hỏng.',
  6,
  1,
  'submitted',
  NOW() - INTERVAL '-1 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000038',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Bước sang năm học lớp 4, em bắt đầu làm quen với việc luyện viết chữ đẹp bằng chiếc bút máy mực tím do bố tặng. Đây là món đồ dùng học tập mà em nâng niu và trân trọng nhất.

Chiếc bút có thân hình thon dài khoảng mười lăm xăng-ti-mét, khoác chiếc áo màu xanh coban bóng loáng. Nắp bút làm bằng kim loại mạ vàng sáng lấp lánh, có chiếc cài bút tiện lợi để em cài vào túi áo hoặc mép vở. Khi mở nắp bút ra, ngòi bút hình mũi tên bằng thép sáng bóng lộ ra kiêu hãnh. Bên trong thân bút là chiếc ruột đựng mực dạng xoắn ốc bằng nhựa dẻo, giúp em dễ dàng bơm mực khi hết. Mỗi khi đặt bút viết lên trang giấy trắng, dòng mực tím chảy đều đặn, tạo nên những nét chữ thanh đậm mềm mại và ngay ngắn.

Chiếc bút máy đã cùng em viết nên bao bài toán khó, bao bài văn giàu cảm xúc. Em luôn giữ gìn bút cẩn thận, viết xong đậy nắp ngay để ngòi bút không bị cong hỏng.',
  1,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000038'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000038',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Cô khen bài viết diễn đạt tự nhiên, chân thực và giàu cảm xúc!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '-2 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000039',
  'd0000000-0000-0000-0000-000000000039',
  'c0000000-0000-0000-0000-0000000004a8',
  'Cánh đồng lúa chín vàng quê ngoại',
  'essay',
  'Kỳ nghỉ hè vừa qua, em được bố mẹ cho về thăm quê ngoại ở vùng đồng bằng Bắc Bộ. Nơi đây đã để lại trong em ấn tượng sâu sắc nhất chính là vẻ đẹp trù phú của cánh đồng lúa chín vàng ươm.

Đứng trên triền đê nhìn xuống, cánh đồng lúa trải rộng mênh mông như một dải lụa vàng óng ả bất tận. Từng bông lúa trĩu hạt uốn cong như lưỡi liềm, hạt nào hạt nấy đều căng tròn mẩy mẩy. Khi những làn gió sớm thổi qua, cả biển lúa dập dờn gợn sóng nhấp nhô, tỏa ra hương lúa thơm ngào ngạt phảng phất khắp xóm làng. Xa xa, từng đàn cò trắng muốt chao liệng rồi nhẹ nhàng sà xuống bờ mương tìm mồi. Trên bờ ruộng, các bác nông dân nón trắng nhấp nhô, tay thoăn thoắt gặt lúa với nụ cười rạng rỡ mừng vụ mùa bội thu.

Cảnh cánh đồng lúa quê ngoại vừa thanh bình, vừa ấm no đã khắc sâu vào tâm trí em. Em thêm yêu quê hương đất nước và biết ơn nỗi vất vả của các bác nông dân làm ra hạt gạo trắng trong.',
  'Kỳ nghỉ hè vừa qua, em được bố mẹ cho về thăm quê ngoại ở vùng đồng bằng Bắc Bộ. Nơi đây đã để lại trong em ấn tượng sâu sắc nhất chính là vẻ đẹp trù phú của cánh đồng lúa chín vàng ươm.

Đứng trên triền đê nhìn xuống, cánh đồng lúa trải rộng mênh mông như một dải lụa vàng óng ả bất tận. Từng bông lúa trĩu hạt uốn cong như lưỡi liềm, hạt nào hạt nấy đều căng tròn mẩy mẩy. Khi những làn gió sớm thổi qua, cả biển lúa dập dờn gợn sóng nhấp nhô, tỏa ra hương lúa thơm ngào ngạt phảng phất khắp xóm làng. Xa xa, từng đàn cò trắng muốt chao liệng rồi nhẹ nhàng sà xuống bờ mương tìm mồi. Trên bờ ruộng, các bác nông dân nón trắng nhấp nhô, tay thoăn thoắt gặt lúa với nụ cười rạng rỡ mừng vụ mùa bội thu.

Cảnh cánh đồng lúa quê ngoại vừa thanh bình, vừa ấm no đã khắc sâu vào tâm trí em. Em thêm yêu quê hương đất nước và biết ơn nỗi vất vả của các bác nông dân làm ra hạt gạo trắng trong.',
  6,
  1,
  'completed',
  NOW() - INTERVAL '-2 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000039',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Kỳ nghỉ hè vừa qua, em được bố mẹ cho về thăm quê ngoại ở vùng đồng bằng Bắc Bộ. Nơi đây đã để lại trong em ấn tượng sâu sắc nhất chính là vẻ đẹp trù phú của cánh đồng lúa chín vàng ươm.

Đứng trên triền đê nhìn xuống, cánh đồng lúa trải rộng mênh mông như một dải lụa vàng óng ả bất tận. Từng bông lúa trĩu hạt uốn cong như lưỡi liềm, hạt nào hạt nấy đều căng tròn mẩy mẩy. Khi những làn gió sớm thổi qua, cả biển lúa dập dờn gợn sóng nhấp nhô, tỏa ra hương lúa thơm ngào ngạt phảng phất khắp xóm làng. Xa xa, từng đàn cò trắng muốt chao liệng rồi nhẹ nhàng sà xuống bờ mương tìm mồi. Trên bờ ruộng, các bác nông dân nón trắng nhấp nhô, tay thoăn thoắt gặt lúa với nụ cười rạng rỡ mừng vụ mùa bội thu.

Cảnh cánh đồng lúa quê ngoại vừa thanh bình, vừa ấm no đã khắc sâu vào tâm trí em. Em thêm yêu quê hương đất nước và biết ơn nỗi vất vả của các bác nông dân làm ra hạt gạo trắng trong.',
  1,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000039'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000039',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Bức tranh đồng quê hiện lên thật bình yên với hương lúa thơm nồng và cánh cò trắng. Bài văn rất giàu chất thơ!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '-3 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000040',
  'd0000000-0000-0000-0000-000000000040',
  'c0000000-0000-0000-0000-0000000004a8',
  'Chiếc đồng hồ báo thức hình chú gà trống',
  'essay',
  'Trên chiếc bàn học nhỏ nhắn của em, có một đồ vật vô cùng quan trọng luôn cần mẫn làm việc suốt ngày đêm, đó là chiếc đồng hồ báo thức hình chú gà trống dũng mãnh.

Chiếc đồng hồ được làm bằng nhựa cao cấp màu vàng tươi bắt mắt. Mặt đồng hồ hình tròn trong suốt, in các chữ số từ một đến mười hai màu đen rõ nét. Bên trong có ba chiếc kim với nhiệm vụ khác nhau: kim giờ ngắn và to béo bước đi chậm rãi; kim phút thon dài bước đi nhanh hơn một chút; còn kim giây mảnh mai màu đỏ thì thoăn thoắt chạy vòng quanh không mệt mỏi. Phía trên đỉnh đồng hồ là mô hình chú gà trống đang ưỡn ngực chuẩn bị cất tiếng gáy. Mỗi sáng đúng sáu giờ, đồng hồ lại reo vang giai điệu vui tươi "ò ó o" để đánh thức em thức dậy chuẩn bị đến trường.

Nhờ có chiếc đồng hồ báo thức này, em không bao giờ bị muộn học. Chiếc đồng hồ như một người bạn nhắc nhở em phải biết quý trọng thời gian và luôn sống có kế hoạch.',
  'Trên chiếc bàn học nhỏ nhắn của em, có một đồ vật vô cùng quan trọng luôn cần mẫn làm việc suốt ngày đêm, đó là chiếc đồng hồ báo thức hình chú gà trống dũng mãnh.

Chiếc đồng hồ được làm bằng nhựa cao cấp màu vàng tươi bắt mắt. Mặt đồng hồ hình tròn trong suốt, in các chữ số từ một đến mười hai màu đen rõ nét. Bên trong có ba chiếc kim với nhiệm vụ khác nhau: kim giờ ngắn và to béo bước đi chậm rãi; kim phút thon dài bước đi nhanh hơn một chút; còn kim giây mảnh mai màu đỏ thì thoăn thoắt chạy vòng quanh không mệt mỏi. Phía trên đỉnh đồng hồ là mô hình chú gà trống đang ưỡn ngực chuẩn bị cất tiếng gáy. Mỗi sáng đúng sáu giờ, đồng hồ lại reo vang giai điệu vui tươi "ò ó o" để đánh thức em thức dậy chuẩn bị đến trường.

Nhờ có chiếc đồng hồ báo thức này, em không bao giờ bị muộn học. Chiếc đồng hồ như một người bạn nhắc nhở em phải biết quý trọng thời gian và luôn sống có kế hoạch.',
  6,
  1,
  'completed',
  NOW() - INTERVAL '-3 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000040',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trên chiếc bàn học nhỏ nhắn của em, có một đồ vật vô cùng quan trọng luôn cần mẫn làm việc suốt ngày đêm, đó là chiếc đồng hồ báo thức hình chú gà trống dũng mãnh.

Chiếc đồng hồ được làm bằng nhựa cao cấp màu vàng tươi bắt mắt. Mặt đồng hồ hình tròn trong suốt, in các chữ số từ một đến mười hai màu đen rõ nét. Bên trong có ba chiếc kim với nhiệm vụ khác nhau: kim giờ ngắn và to béo bước đi chậm rãi; kim phút thon dài bước đi nhanh hơn một chút; còn kim giây mảnh mai màu đỏ thì thoăn thoắt chạy vòng quanh không mệt mỏi. Phía trên đỉnh đồng hồ là mô hình chú gà trống đang ưỡn ngực chuẩn bị cất tiếng gáy. Mỗi sáng đúng sáu giờ, đồng hồ lại reo vang giai điệu vui tươi "ò ó o" để đánh thức em thức dậy chuẩn bị đến trường.

Nhờ có chiếc đồng hồ báo thức này, em không bao giờ bị muộn học. Chiếc đồng hồ như một người bạn nhắc nhở em phải biết quý trọng thời gian và luôn sống có kế hoạch.',
  1,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000040'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000040',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Linh Chi miêu tả từng chi tiết chiếc đồng hồ rất rõ nét. Bài học quý giá về việc đúng giờ rất ý nghĩa!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '-4 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000041',
  'd0000000-0000-0000-0000-000000000041',
  'c0000000-0000-0000-0000-0000000004a8',
  'Kỷ niệm buổi cắm trại mùa thu đáng nhớ',
  'essay',
  'Mùa thu năm nay, trường em đã tổ chức một buổi cắm trại dã ngoại đầy ý nghĩa tại công viên sinh thái. Đó là một kỷ niệm vô cùng tươi đẹp mà em sẽ không bao giờ quên.

Sáng sớm hôm ấy, thời tiết mùa thu thật mát mẻ và dễ chịu. Bầu trời cao trong xanh, từng làn gió thu nhẹ nhàng thổi qua mang theo hương hoa cỏ ngát thơm. Đúng bảy giờ, chiếc xe buýt chở lớp 4A8 lăn bánh trong tiếng hát rộn ràng của chúng em. Khi đến nơi, chúng em cùng nhau chung tay dựng lều bạt. Các bạn nam khiêng cọc, các bạn nữ trải thảm và trang trí cờ hoa nhiều màu sắc. Buổi trưa, cả lớp cùng quây quần thưởng thức những món ăn ngon do cô giáo và phụ huynh chuẩn bị. Buổi chiều là phần sôi động nhất với các trò chơi dân gian như kéo co, nhảy bao bố và đố vui có thưởng. Cả sân trại ngập tràn tiếng cười giòn giã.

Chuyến đi không chỉ giúp em mở mang hiểu biết về thiên nhiên mà còn thắt chặt thêm tình đoàn kết giữa các thành viên lớp 4A8. Em mong trường sẽ tổ chức thêm nhiều hoạt động bổ ích như vậy.',
  'Mùa thu năm nay, trường em đã tổ chức một buổi cắm trại dã ngoại đầy ý nghĩa tại công viên sinh thái. Đó là một kỷ niệm vô cùng tươi đẹp mà em sẽ không bao giờ quên.

Sáng sớm hôm ấy, thời tiết mùa thu thật mát mẻ và dễ chịu. Bầu trời cao trong xanh, từng làn gió thu nhẹ nhàng thổi qua mang theo hương hoa cỏ ngát thơm. Đúng bảy giờ, chiếc xe buýt chở lớp 4A8 lăn bánh trong tiếng hát rộn ràng của chúng em. Khi đến nơi, chúng em cùng nhau chung tay dựng lều bạt. Các bạn nam khiêng cọc, các bạn nữ trải thảm và trang trí cờ hoa nhiều màu sắc. Buổi trưa, cả lớp cùng quây quần thưởng thức những món ăn ngon do cô giáo và phụ huynh chuẩn bị. Buổi chiều là phần sôi động nhất với các trò chơi dân gian như kéo co, nhảy bao bố và đố vui có thưởng. Cả sân trại ngập tràn tiếng cười giòn giã.

Chuyến đi không chỉ giúp em mở mang hiểu biết về thiên nhiên mà còn thắt chặt thêm tình đoàn kết giữa các thành viên lớp 4A8. Em mong trường sẽ tổ chức thêm nhiều hoạt động bổ ích như vậy.',
  6,
  1,
  'completed',
  NOW() - INTERVAL '-4 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000041',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Mùa thu năm nay, trường em đã tổ chức một buổi cắm trại dã ngoại đầy ý nghĩa tại công viên sinh thái. Đó là một kỷ niệm vô cùng tươi đẹp mà em sẽ không bao giờ quên.

Sáng sớm hôm ấy, thời tiết mùa thu thật mát mẻ và dễ chịu. Bầu trời cao trong xanh, từng làn gió thu nhẹ nhàng thổi qua mang theo hương hoa cỏ ngát thơm. Đúng bảy giờ, chiếc xe buýt chở lớp 4A8 lăn bánh trong tiếng hát rộn ràng của chúng em. Khi đến nơi, chúng em cùng nhau chung tay dựng lều bạt. Các bạn nam khiêng cọc, các bạn nữ trải thảm và trang trí cờ hoa nhiều màu sắc. Buổi trưa, cả lớp cùng quây quần thưởng thức những món ăn ngon do cô giáo và phụ huynh chuẩn bị. Buổi chiều là phần sôi động nhất với các trò chơi dân gian như kéo co, nhảy bao bố và đố vui có thưởng. Cả sân trại ngập tràn tiếng cười giòn giã.

Chuyến đi không chỉ giúp em mở mang hiểu biết về thiên nhiên mà còn thắt chặt thêm tình đoàn kết giữa các thành viên lớp 4A8. Em mong trường sẽ tổ chức thêm nhiều hoạt động bổ ích như vậy.',
  1,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000041'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000041',
  'b0000000-0000-0000-0000-000000000001',
  9.5,
  'Câu chuyện có mở đầu, diễn biến và kết thúc rất lôi cuốn. Lời văn trong trẻo và thể hiện tinh thần đoàn kết tuyệt vời!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '-5 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000042',
  'd0000000-0000-0000-0000-000000000042',
  'c0000000-0000-0000-0000-0000000004a8',
  'Người bạn thân chăm chỉ cùng bàn',
  'essay',
  'Ở lớp 4A8, người bạn thân thiết nhất của em là bạn Minh Tuấn. Chúng em ngồi cùng bàn và đã gắn bó với nhau suốt từ những ngày đầu bước vào lớp một.

Tuấn có dáng người dong dỏng cao, nước da ngăm đen khỏe khoắn. Gương mặt bạn tròn trĩnh với vầng trán cao toát lên vẻ thông minh, nhanh nhẹn. Đôi mắt sáng long lanh ẩn sau cặp kính cận lúc nào cũng chăm chú lắng nghe cô giáo giảng bài. Tuấn là một học sinh rất gương mẫu và chăm chỉ. Trong giờ học, bạn luôn tích cực giơ tay phát biểu xây dựng bài. Những bài toán khó, Tuấn kiên nhẫn suy nghĩ tìm ra cách giải hay rồi tận tình hướng dẫn lại cho em và các bạn khác trong tổ. Giờ ra chơi, Tuấn rất hòa đồng, thường rủ các bạn cùng chơi đá cầu hoặc đọc sách tại góc thư viện lớp.

Em rất tự hào khi có một người bạn tốt như Minh Tuấn. Tình bạn của chúng em ngày càng thêm gắn bó, cùng nhau phấn đấu học tập thật giỏi để trở thành con ngoan trò giỏi.',
  'Ở lớp 4A8, người bạn thân thiết nhất của em là bạn Minh Tuấn. Chúng em ngồi cùng bàn và đã gắn bó với nhau suốt từ những ngày đầu bước vào lớp một.

Tuấn có dáng người dong dỏng cao, nước da ngăm đen khỏe khoắn. Gương mặt bạn tròn trĩnh với vầng trán cao toát lên vẻ thông minh, nhanh nhẹn. Đôi mắt sáng long lanh ẩn sau cặp kính cận lúc nào cũng chăm chú lắng nghe cô giáo giảng bài. Tuấn là một học sinh rất gương mẫu và chăm chỉ. Trong giờ học, bạn luôn tích cực giơ tay phát biểu xây dựng bài. Những bài toán khó, Tuấn kiên nhẫn suy nghĩ tìm ra cách giải hay rồi tận tình hướng dẫn lại cho em và các bạn khác trong tổ. Giờ ra chơi, Tuấn rất hòa đồng, thường rủ các bạn cùng chơi đá cầu hoặc đọc sách tại góc thư viện lớp.

Em rất tự hào khi có một người bạn tốt như Minh Tuấn. Tình bạn của chúng em ngày càng thêm gắn bó, cùng nhau phấn đấu học tập thật giỏi để trở thành con ngoan trò giỏi.',
  6,
  1,
  'completed',
  NOW() - INTERVAL '-5 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000042',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Ở lớp 4A8, người bạn thân thiết nhất của em là bạn Minh Tuấn. Chúng em ngồi cùng bàn và đã gắn bó với nhau suốt từ những ngày đầu bước vào lớp một.

Tuấn có dáng người dong dỏng cao, nước da ngăm đen khỏe khoắn. Gương mặt bạn tròn trĩnh với vầng trán cao toát lên vẻ thông minh, nhanh nhẹn. Đôi mắt sáng long lanh ẩn sau cặp kính cận lúc nào cũng chăm chú lắng nghe cô giáo giảng bài. Tuấn là một học sinh rất gương mẫu và chăm chỉ. Trong giờ học, bạn luôn tích cực giơ tay phát biểu xây dựng bài. Những bài toán khó, Tuấn kiên nhẫn suy nghĩ tìm ra cách giải hay rồi tận tình hướng dẫn lại cho em và các bạn khác trong tổ. Giờ ra chơi, Tuấn rất hòa đồng, thường rủ các bạn cùng chơi đá cầu hoặc đọc sách tại góc thư viện lớp.

Em rất tự hào khi có một người bạn tốt như Minh Tuấn. Tình bạn của chúng em ngày càng thêm gắn bó, cùng nhau phấn đấu học tập thật giỏi để trở thành con ngoan trò giỏi.',
  1,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000042'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000042',
  'b0000000-0000-0000-0000-000000000001',
  8.5,
  'Bài văn ấm áp tình bạn. Duy Bảo chú ý thêm dấu phẩy ngắt câu để câu văn thêm mượt mà hơn nhé.',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '-6 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000043',
  'd0000000-0000-0000-0000-000000000043',
  'c0000000-0000-0000-0000-0000000004a8',
  'Cây hoa phượng vĩ đỏ rực ngày hè',
  'essay',
  'Khi tiếng ve râm ran bắt đầu vang lên trong vòm lá, cũng là lúc cây hoa phượng vĩ giữa sân trường em bung nở rực rỡ báo hiệu mùa hè đã về.

Cây phượng cao lớn, vươn những cành dài tỏa bóng che mát một góc sân. Thân cây to, vỏ cây màu nâu xám sần sùi với những đường gân nổi rõ. Lá phượng nhỏ li ti như lá me non, xếp đối xứng nhau thành từng hàng thẳng tắp. Đẹp nhất là những chùm hoa phượng đỏ rực như muôn ngàn đốm lửa bập bùng giữa nền trời trong xanh. Mỗi bông hoa phượng có năm cánh mỏng manh, trong đó có một cánh điểm những đốm trắng phớt hồng rất đặc biệt. Nhị hoa dài, uốn cong duyên dáng như chiếc râu bướm. Mỗi làn gió nhẹ thổi qua, những cánh hoa phượng đỏ thắm lả tả bay trong gió rồi nhẹ nhàng đậu xuống vai áo học trò.

Hoa phượng không chỉ mang vẻ đẹp tươi thắm mà còn gắn liền với biết bao kỷ niệm vui buồn của tuổi học trò. Ngắm cây phượng trổ hoa, em càng thêm yêu quý mái trường thân yêu của mình.',
  'Khi tiếng ve râm ran bắt đầu vang lên trong vòm lá, cũng là lúc cây hoa phượng vĩ giữa sân trường em bung nở rực rỡ báo hiệu mùa hè đã về.

Cây phượng cao lớn, vươn những cành dài tỏa bóng che mát một góc sân. Thân cây to, vỏ cây màu nâu xám sần sùi với những đường gân nổi rõ. Lá phượng nhỏ li ti như lá me non, xếp đối xứng nhau thành từng hàng thẳng tắp. Đẹp nhất là những chùm hoa phượng đỏ rực như muôn ngàn đốm lửa bập bùng giữa nền trời trong xanh. Mỗi bông hoa phượng có năm cánh mỏng manh, trong đó có một cánh điểm những đốm trắng phớt hồng rất đặc biệt. Nhị hoa dài, uốn cong duyên dáng như chiếc râu bướm. Mỗi làn gió nhẹ thổi qua, những cánh hoa phượng đỏ thắm lả tả bay trong gió rồi nhẹ nhàng đậu xuống vai áo học trò.

Hoa phượng không chỉ mang vẻ đẹp tươi thắm mà còn gắn liền với biết bao kỷ niệm vui buồn của tuổi học trò. Ngắm cây phượng trổ hoa, em càng thêm yêu quý mái trường thân yêu của mình.',
  6,
  1,
  'completed',
  NOW() - INTERVAL '-6 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000043',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Khi tiếng ve râm ran bắt đầu vang lên trong vòm lá, cũng là lúc cây hoa phượng vĩ giữa sân trường em bung nở rực rỡ báo hiệu mùa hè đã về.

Cây phượng cao lớn, vươn những cành dài tỏa bóng che mát một góc sân. Thân cây to, vỏ cây màu nâu xám sần sùi với những đường gân nổi rõ. Lá phượng nhỏ li ti như lá me non, xếp đối xứng nhau thành từng hàng thẳng tắp. Đẹp nhất là những chùm hoa phượng đỏ rực như muôn ngàn đốm lửa bập bùng giữa nền trời trong xanh. Mỗi bông hoa phượng có năm cánh mỏng manh, trong đó có một cánh điểm những đốm trắng phớt hồng rất đặc biệt. Nhị hoa dài, uốn cong duyên dáng như chiếc râu bướm. Mỗi làn gió nhẹ thổi qua, những cánh hoa phượng đỏ thắm lả tả bay trong gió rồi nhẹ nhàng đậu xuống vai áo học trò.

Hoa phượng không chỉ mang vẻ đẹp tươi thắm mà còn gắn liền với biết bao kỷ niệm vui buồn của tuổi học trò. Ngắm cây phượng trổ hoa, em càng thêm yêu quý mái trường thân yêu của mình.',
  1,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000043'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000043',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Hình ảnh chùm hoa phượng như những đốm lửa bập bùng rất ấn tượng. Em dùng từ ngữ gợi tả rất tốt!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '-7 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000044',
  'd0000000-0000-0000-0000-000000000044',
  'c0000000-0000-0000-0000-0000000004a8',
  'Chú mèo Miu tinh nghịch và đáng yêu',
  'essay',
  'Trong gia đình em, thành viên nhỏ tuổi và đáng yêu nhất chính là chú mèo Miu. Chú được bố em xin về nuôi từ khi chú mới chỉ nhỏ bằng nắm tay.

Miu khoác lên mình bộ lông màu vàng cam xen kẽ những vệt trắng muốt mềm như nhung. Cái đầu tròn xoe với đôi tai hình tam giác lúc nào cũng vểnh lên để lắng nghe mọi âm thanh lạ. Đôi mắt Miu trong veo và xanh biếc như hai hòn bi ve, vào ban đêm mắt chú sáng rực lên trông rất oai vệ. Chiếc mũi hồng ươn ướt lúc nào cũng khịt khịt đánh hơi, bên cạnh là hàng ria mép trắng như cước rung rinh mỗi khi chú ngáp. Bốn chiếc chân thon thả có đệm thịt êm ái giúp Miu di chuyển nhẹ nhàng không hề phát ra tiếng động. Khi nằm sưởi nắng ngoài hiên, chiếc đuôi dài thướt tha cứ ngoe nguẩy qua lại trông thật ngộ nghĩnh.

Mỗi khi em đi học về, Miu liền chạy ùa ra cửa, cọ đầu vào chân em và kêu "meo meo" nũng nịu. Em coi Miu như một người bạn nhỏ thân thiết và luôn chăm sóc chú thật chu đáo.',
  'Trong gia đình em, thành viên nhỏ tuổi và đáng yêu nhất chính là chú mèo Miu. Chú được bố em xin về nuôi từ khi chú mới chỉ nhỏ bằng nắm tay.

Miu khoác lên mình bộ lông màu vàng cam xen kẽ những vệt trắng muốt mềm như nhung. Cái đầu tròn xoe với đôi tai hình tam giác lúc nào cũng vểnh lên để lắng nghe mọi âm thanh lạ. Đôi mắt Miu trong veo và xanh biếc như hai hòn bi ve, vào ban đêm mắt chú sáng rực lên trông rất oai vệ. Chiếc mũi hồng ươn ướt lúc nào cũng khịt khịt đánh hơi, bên cạnh là hàng ria mép trắng như cước rung rinh mỗi khi chú ngáp. Bốn chiếc chân thon thả có đệm thịt êm ái giúp Miu di chuyển nhẹ nhàng không hề phát ra tiếng động. Khi nằm sưởi nắng ngoài hiên, chiếc đuôi dài thướt tha cứ ngoe nguẩy qua lại trông thật ngộ nghĩnh.

Mỗi khi em đi học về, Miu liền chạy ùa ra cửa, cọ đầu vào chân em và kêu "meo meo" nũng nịu. Em coi Miu như một người bạn nhỏ thân thiết và luôn chăm sóc chú thật chu đáo.',
  6,
  1,
  'completed',
  NOW() - INTERVAL '-7 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000044',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Trong gia đình em, thành viên nhỏ tuổi và đáng yêu nhất chính là chú mèo Miu. Chú được bố em xin về nuôi từ khi chú mới chỉ nhỏ bằng nắm tay.

Miu khoác lên mình bộ lông màu vàng cam xen kẽ những vệt trắng muốt mềm như nhung. Cái đầu tròn xoe với đôi tai hình tam giác lúc nào cũng vểnh lên để lắng nghe mọi âm thanh lạ. Đôi mắt Miu trong veo và xanh biếc như hai hòn bi ve, vào ban đêm mắt chú sáng rực lên trông rất oai vệ. Chiếc mũi hồng ươn ướt lúc nào cũng khịt khịt đánh hơi, bên cạnh là hàng ria mép trắng như cước rung rinh mỗi khi chú ngáp. Bốn chiếc chân thon thả có đệm thịt êm ái giúp Miu di chuyển nhẹ nhàng không hề phát ra tiếng động. Khi nằm sưởi nắng ngoài hiên, chiếc đuôi dài thướt tha cứ ngoe nguẩy qua lại trông thật ngộ nghĩnh.

Mỗi khi em đi học về, Miu liền chạy ùa ra cửa, cọ đầu vào chân em và kêu "meo meo" nũng nịu. Em coi Miu như một người bạn nhỏ thân thiết và luôn chăm sóc chú thật chu đáo.',
  1,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000044'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000044',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Tả đôi mắt mèo và động tác bắt chuột rất sinh động. Giọng văn hồn nhiên, đáng khen!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '-8 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000045',
  'd0000000-0000-0000-0000-000000000045',
  'c0000000-0000-0000-0000-0000000004a8',
  'Chiếc cặp sách màu hồng gắn bó cùng em',
  'essay',
  'Nhân dịp bước vào năm học lớp 4, mẹ đã tặng em một chiếc cặp sách màu hồng phấn vô cùng xinh xắn. Chiếc cặp đã trở thành người bạn đồng hành trung thành của em trên mỗi bước đường đến trường.

Chiếc cặp có hình chữ nhật đứng, làm bằng vải dù chống thấm nước rất êm và nhẹ. Mặt trước của cặp in hình một chú gấu nhỏ đang ôm đóa hoa rực rỡ. Cặp có hai quai đeo dày dặn, lót lớp đệm mềm giúp đôi vai em không bị mỏi khi mang nhiều sách vở. Chiếc khóa kéo màu bạc sáng loáng, mỗi khi mở ra khép lại nghe tiếng "xoẹt xoẹt" rất êm tai. Bên trong cặp gồm có ba ngăn rộng rãi. Ngăn lớn nhất em để sách giáo khoa và vở bài tập sạch sẽ. Ngăn thứ hai em đựng hộp bút màu, bảng con và thước kẻ. Ngăn phụ nhỏ bên ngoài em để khăn tay và chiếc thẻ học sinh. Hai bên sườn cặp còn có hai chiếc túi lưới tiện lợi để đựng bình nước.

Em rất yêu quý chiếc cặp sách này. Mỗi ngày đi học về, em đều đặt cặp ngay ngắn trên bàn học và lau chùi cẩn thận để chiếc cặp luôn sạch đẹp và bền lâu.',
  'Nhân dịp bước vào năm học lớp 4, mẹ đã tặng em một chiếc cặp sách màu hồng phấn vô cùng xinh xắn. Chiếc cặp đã trở thành người bạn đồng hành trung thành của em trên mỗi bước đường đến trường.

Chiếc cặp có hình chữ nhật đứng, làm bằng vải dù chống thấm nước rất êm và nhẹ. Mặt trước của cặp in hình một chú gấu nhỏ đang ôm đóa hoa rực rỡ. Cặp có hai quai đeo dày dặn, lót lớp đệm mềm giúp đôi vai em không bị mỏi khi mang nhiều sách vở. Chiếc khóa kéo màu bạc sáng loáng, mỗi khi mở ra khép lại nghe tiếng "xoẹt xoẹt" rất êm tai. Bên trong cặp gồm có ba ngăn rộng rãi. Ngăn lớn nhất em để sách giáo khoa và vở bài tập sạch sẽ. Ngăn thứ hai em đựng hộp bút màu, bảng con và thước kẻ. Ngăn phụ nhỏ bên ngoài em để khăn tay và chiếc thẻ học sinh. Hai bên sườn cặp còn có hai chiếc túi lưới tiện lợi để đựng bình nước.

Em rất yêu quý chiếc cặp sách này. Mỗi ngày đi học về, em đều đặt cặp ngay ngắn trên bàn học và lau chùi cẩn thận để chiếc cặp luôn sạch đẹp và bền lâu.',
  6,
  1,
  'completed',
  NOW() - INTERVAL '-8 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000045',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Nhân dịp bước vào năm học lớp 4, mẹ đã tặng em một chiếc cặp sách màu hồng phấn vô cùng xinh xắn. Chiếc cặp đã trở thành người bạn đồng hành trung thành của em trên mỗi bước đường đến trường.

Chiếc cặp có hình chữ nhật đứng, làm bằng vải dù chống thấm nước rất êm và nhẹ. Mặt trước của cặp in hình một chú gấu nhỏ đang ôm đóa hoa rực rỡ. Cặp có hai quai đeo dày dặn, lót lớp đệm mềm giúp đôi vai em không bị mỏi khi mang nhiều sách vở. Chiếc khóa kéo màu bạc sáng loáng, mỗi khi mở ra khép lại nghe tiếng "xoẹt xoẹt" rất êm tai. Bên trong cặp gồm có ba ngăn rộng rãi. Ngăn lớn nhất em để sách giáo khoa và vở bài tập sạch sẽ. Ngăn thứ hai em đựng hộp bút màu, bảng con và thước kẻ. Ngăn phụ nhỏ bên ngoài em để khăn tay và chiếc thẻ học sinh. Hai bên sườn cặp còn có hai chiếc túi lưới tiện lợi để đựng bình nước.

Em rất yêu quý chiếc cặp sách này. Mỗi ngày đi học về, em đều đặt cặp ngay ngắn trên bàn học và lau chùi cẩn thận để chiếc cặp luôn sạch đẹp và bền lâu.',
  1,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000045'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000045',
  'b0000000-0000-0000-0000-000000000001',
  9,
  'Cách diễn đạt tự nhiên, câu văn gãy gọn và tình cảm em dành cho chiếc cặp sách rất chân thành. Chữ viết trong bài rất sáng sủa!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '-9 hours'
) ON CONFLICT DO NOTHING;

INSERT INTO public.student_writing_attempts (
  id, student_id, class_id, prompt_title, writing_level, original_content, current_content, current_step, word_count, status, submitted_at
) VALUES (
  'e0000000-0000-0000-0000-000000000046',
  'd0000000-0000-0000-0000-000000000046',
  'c0000000-0000-0000-0000-0000000004a8',
  'Cây bàng thân yêu nơi góc sân trường',
  'essay',
  'Nơi góc sân trường em, có một cây bàng sừng sững đã gắn bó với biết bao thế hệ học trò. Nhìn từ xa, cây bàng giống như một chiếc ô xanh khổng lồ che rợp cả một khoảng sân rộng lớn.

Thân cây to chừng một vòng tay người lớn ôm không xuể, lớp vỏ màu nâu xám sần sùi với nhiều mắt cây nổi lên như dấu tích của thời gian. Dưới gốc, những chiếc rễ lớn trồi lên mặt đất ngoằn ngoèo như những con trăn nhỏ đang say ngủ. Vào mùa xuân, cây bàng đâm chồi nảy lộc, những búp non xanh biếc như những ngọn nến lung linh trong nắng ấm. Sang hè, tán lá ken dày xanh mướt, tạo bóng râm mát rượi cho chúng em vui chơi, đọc sách sau mỗi giờ học căng thẳng. Thu sang, lá bàng ngả dần sang màu đỏ đồng rực rỡ, rồi lặng lẽ rụng xuống trải thảm trên sân trường. Mùa đông, cây chỉ còn trơ những cành khẳng khiu nhưng tràn đầy sức sống tiềm tàng đợi ngày đơm lộc mới.

Cây bàng không chỉ làm đẹp cho mái trường Kim Liên A mà còn là người bạn thân thiết chứng kiến bao kỷ niệm đẹp đẽ của tuổi thơ chúng em. Mai này dù đi đâu xa, em vẫn luôn nhớ về bóng hình cây bàng thân thương nơi góc sân trường.',
  'Nơi góc sân trường em, có một cây bàng sừng sững đã gắn bó với biết bao thế hệ học trò. Nhìn từ xa, cây bàng giống như một chiếc ô xanh khổng lồ che rợp cả một khoảng sân rộng lớn.

Thân cây to chừng một vòng tay người lớn ôm không xuể, lớp vỏ màu nâu xám sần sùi với nhiều mắt cây nổi lên như dấu tích của thời gian. Dưới gốc, những chiếc rễ lớn trồi lên mặt đất ngoằn ngoèo như những con trăn nhỏ đang say ngủ. Vào mùa xuân, cây bàng đâm chồi nảy lộc, những búp non xanh biếc như những ngọn nến lung linh trong nắng ấm. Sang hè, tán lá ken dày xanh mướt, tạo bóng râm mát rượi cho chúng em vui chơi, đọc sách sau mỗi giờ học căng thẳng. Thu sang, lá bàng ngả dần sang màu đỏ đồng rực rỡ, rồi lặng lẽ rụng xuống trải thảm trên sân trường. Mùa đông, cây chỉ còn trơ những cành khẳng khiu nhưng tràn đầy sức sống tiềm tàng đợi ngày đơm lộc mới.

Cây bàng không chỉ làm đẹp cho mái trường Kim Liên A mà còn là người bạn thân thiết chứng kiến bao kỷ niệm đẹp đẽ của tuổi thơ chúng em. Mai này dù đi đâu xa, em vẫn luôn nhớ về bóng hình cây bàng thân thương nơi góc sân trường.',
  6,
  1,
  'completed',
  NOW() - INTERVAL '-9 hours'
) ON CONFLICT (id) DO UPDATE SET current_content = EXCLUDED.current_content, status = EXCLUDED.status;

-- Lưu phiên bản gốc riêng biệt vào writing_revisions
INSERT INTO public.writing_revisions (attempt_id, revision_number, step_number, step_name, content, word_count, changes_summary, created_by)
VALUES (
  'e0000000-0000-0000-0000-000000000046',
  1,
  3,
  'Bản thảo ban đầu (Bước 3)',
  'Nơi góc sân trường em, có một cây bàng sừng sững đã gắn bó với biết bao thế hệ học trò. Nhìn từ xa, cây bàng giống như một chiếc ô xanh khổng lồ che rợp cả một khoảng sân rộng lớn.

Thân cây to chừng một vòng tay người lớn ôm không xuể, lớp vỏ màu nâu xám sần sùi với nhiều mắt cây nổi lên như dấu tích của thời gian. Dưới gốc, những chiếc rễ lớn trồi lên mặt đất ngoằn ngoèo như những con trăn nhỏ đang say ngủ. Vào mùa xuân, cây bàng đâm chồi nảy lộc, những búp non xanh biếc như những ngọn nến lung linh trong nắng ấm. Sang hè, tán lá ken dày xanh mướt, tạo bóng râm mát rượi cho chúng em vui chơi, đọc sách sau mỗi giờ học căng thẳng. Thu sang, lá bàng ngả dần sang màu đỏ đồng rực rỡ, rồi lặng lẽ rụng xuống trải thảm trên sân trường. Mùa đông, cây chỉ còn trơ những cành khẳng khiu nhưng tràn đầy sức sống tiềm tàng đợi ngày đơm lộc mới.

Cây bàng không chỉ làm đẹp cho mái trường Kim Liên A mà còn là người bạn thân thiết chứng kiến bao kỷ niệm đẹp đẽ của tuổi thơ chúng em. Mai này dù đi đâu xa, em vẫn luôn nhớ về bóng hình cây bàng thân thương nơi góc sân trường.',
  1,
  'Bản tự viết đầu tiên của học sinh',
  'd0000000-0000-0000-0000-000000000046'
) ON CONFLICT (attempt_id, revision_number) DO NOTHING;

-- Lưu nhận xét và điểm số của Giáo viên
INSERT INTO public.teacher_feedback (attempt_id, teacher_id, score, overall_comment, praise_points, status, published_at)
VALUES (
  'e0000000-0000-0000-0000-000000000046',
  'b0000000-0000-0000-0000-000000000001',
  9.5,
  'Bài viết rất giàu cảm xúc, em quan sát tỉ mỉ từng tán lá qua bốn mùa và sử dụng biện pháp so sánh rất sinh động. Cô khen Thế Anh nhé!',
  'Biết sắp xếp câu chuyện theo trình tự thời gian mạch lạc, dùng từ gợi tả sinh động.',
  'published',
  NOW() - INTERVAL '-10 hours'
) ON CONFLICT DO NOTHING;
