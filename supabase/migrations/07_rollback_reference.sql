-- =============================================================================
-- EDUNOVA Writing Coach - Supabase PostgreSQL Migration
-- File 07: Rollback & Downgrade Reference (Kế hoạch hoàn tác an toàn)
-- =============================================================================
-- LƯU Ý BẢO VỆ DỮ LIỆU:
-- 1. Tuyệt đối KHÔNG tự động chạy file này trong quá trình nâng cấp bình thường.
-- 2. Chỉ tham khảo khi cần khôi phục lại trạng thái ban đầu của hệ thống nếu gặp lỗi cấu trúc nghiêm trọng.
-- 3. Thứ tự hoàn tác được sắp xếp ngược lại theo cây phụ thuộc Khóa ngoại (Foreign Keys).
-- =============================================================================

-- BƯỚC 1: XÓA CHÍNH SÁCH BẢO MẬT VÀ TRIGGER RLS (NẾU CẦN HOÀN TÁC BẢO MẬT)
/*
DROP TRIGGER IF EXISTS trg_prevent_role_change ON public.profiles;
DROP FUNCTION IF EXISTS public.check_profile_role_update();
DROP FUNCTION IF EXISTS public.is_student_in_class(UUID);
DROP FUNCTION IF EXISTS public.is_teacher_of_class(UUID);
DROP FUNCTION IF EXISTS public.is_admin();
DROP FUNCTION IF EXISTS public.current_user_role();
DROP FUNCTION IF EXISTS public.current_profile_id();
*/

-- BƯỚC 2: HOÀN TÁC CÁC BẢNG THEO THỨ TỰ NGƯỢC (TỪ BẢNG CON ĐẾN BẢNG CHA)
/*
-- Nhóm 4: Gamification, Audit Logs, Thông báo
DROP TABLE IF EXISTS public.audit_logs CASCADE;
DROP TABLE IF EXISTS public.notifications CASCADE;
DROP TABLE IF EXISTS public.game_attempts CASCADE;
DROP TABLE IF EXISTS public.games CASCADE;
DROP TABLE IF EXISTS public.system_configs CASCADE;

-- Nhóm 3: Feedback, Lịch sử phiên bản, Bài viết học sinh, Bài tập
DROP TABLE IF EXISTS public.teacher_feedback CASCADE;
DROP TABLE IF EXISTS public.ai_feedback CASCADE;
DROP TABLE IF EXISTS public.writing_revisions CASCADE;
DROP TABLE IF EXISTS public.student_writing_attempts CASCADE;
DROP TABLE IF EXISTS public.writing_assignments CASCADE;

-- Nhóm 2: Kho học liệu, Rubric, Chặng học, Bài học chương trình
DROP TABLE IF EXISTS public.learning_resources CASCADE;
DROP TABLE IF EXISTS public.lesson_rubrics CASCADE;
DROP TABLE IF EXISTS public.lesson_stages CASCADE;
DROP TABLE IF EXISTS public.curriculum_lessons CASCADE;

-- Nhóm 1: Thành viên lớp, Hồ sơ người dùng, Lớp học, Trường học
DROP TABLE IF EXISTS public.class_members CASCADE;
DROP TABLE IF EXISTS public.profiles CASCADE;
DROP TABLE IF EXISTS public.classes CASCADE;
DROP TABLE IF EXISTS public.schools CASCADE;

DROP FUNCTION IF EXISTS update_updated_at_column();
*/
