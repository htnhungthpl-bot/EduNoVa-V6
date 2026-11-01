-- =============================================================================
-- EDUNOVA Writing Coach - Supabase PostgreSQL Migration
-- File 05: Row Level Security (RLS) & Fine-Grained Authorization Policies
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1. CÁC HÀM TIỆN ÍCH HỖ TRỢ KIỂM TRA QUYỀN TRUY CẬP (SECURITY DEFINER)
-- -----------------------------------------------------------------------------

-- Lấy profile_id của người dùng hiện tại đang đăng nhập qua Supabase Auth
CREATE OR REPLACE FUNCTION public.current_profile_id()
RETURNS UUID AS $$
    SELECT id FROM public.profiles WHERE auth_user_id = auth.uid() LIMIT 1;
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- Lấy vai trò (role: student, teacher, school, admin) của người dùng hiện tại
CREATE OR REPLACE FUNCTION public.current_user_role()
RETURNS VARCHAR AS $$
    SELECT role FROM public.profiles WHERE auth_user_id = auth.uid() LIMIT 1;
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- Kiểm tra xem người dùng hiện tại có phải là Quản trị viên hệ thống không
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS BOOLEAN AS $$
    SELECT EXISTS (
        SELECT 1 FROM public.profiles
        WHERE auth_user_id = auth.uid() AND role = 'admin'
    );
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- Kiểm tra xem người dùng hiện tại có phải là Giáo viên phụ trách lớp học cụ thể không
CREATE OR REPLACE FUNCTION public.is_teacher_of_class(target_class_id UUID)
RETURNS BOOLEAN AS $$
    SELECT EXISTS (
        SELECT 1 FROM public.profiles p
        JOIN public.class_members cm ON cm.profile_id = p.id
        WHERE p.auth_user_id = auth.uid()
          AND p.role IN ('teacher', 'school')
          AND cm.class_id = target_class_id
    ) OR public.is_admin();
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- Kiểm tra xem người dùng hiện tại có phải là Học sinh thuộc lớp học cụ thể không
CREATE OR REPLACE FUNCTION public.is_student_in_class(target_class_id UUID)
RETURNS BOOLEAN AS $$
    SELECT EXISTS (
        SELECT 1 FROM public.profiles p
        JOIN public.class_members cm ON cm.profile_id = p.id
        WHERE p.auth_user_id = auth.uid()
          AND p.role = 'student'
          AND cm.class_id = target_class_id
    );
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- -----------------------------------------------------------------------------
-- 2. TRIGGER CHỐNG LEO THANG ĐẶC QUYỀN (PREVENT ROLE ESCALATION)
-- Người dùng tuyệt đối không được tự ý sửa trường 'role' của chính mình
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.check_profile_role_update()
RETURNS TRIGGER AS $$
BEGIN
    IF (OLD.role IS DISTINCT FROM NEW.role) AND NOT public.is_admin() THEN
        RAISE EXCEPTION 'Quyền bị từ chối: Người dùng không được phép tự thay đổi vai trò tài khoản!';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_prevent_role_change ON public.profiles;
CREATE TRIGGER trg_prevent_role_change
BEFORE UPDATE ON public.profiles
FOR EACH ROW EXECUTE FUNCTION public.check_profile_role_update();

-- -----------------------------------------------------------------------------
-- 3. BẬT ROW LEVEL SECURITY (RLS) TRÊN TẤT CẢ 17 BẢNG
-- -----------------------------------------------------------------------------
ALTER TABLE public.schools ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.classes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.class_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.curriculum_lessons ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lesson_stages ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lesson_rubrics ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.learning_resources ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.writing_assignments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.student_writing_attempts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.writing_revisions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ai_feedback ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.teacher_feedback ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.games ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.game_attempts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.audit_logs ENABLE ROW LEVEL SECURITY;

-- -----------------------------------------------------------------------------
-- 4. CHÍNH SÁCH BẢO MẬT: BẢNG profiles
-- -----------------------------------------------------------------------------
DROP POLICY IF EXISTS "profiles_select_policy" ON public.profiles;
CREATE POLICY "profiles_select_policy" ON public.profiles
FOR SELECT USING (
    auth.uid() = auth_user_id                       -- Xem chính mình
    OR public.is_admin()                            -- Admin xem tất cả
    OR public.current_user_role() IN ('teacher', 'school') -- Giáo viên xem học sinh trường/lớp
    OR class_id IN (                                -- Học sinh cùng lớp thấy danh sách bạn học
        SELECT cm.class_id FROM public.class_members cm
        WHERE cm.profile_id = public.current_profile_id()
    )
);

DROP POLICY IF EXISTS "profiles_update_policy" ON public.profiles;
CREATE POLICY "profiles_update_policy" ON public.profiles
FOR UPDATE USING (
    auth.uid() = auth_user_id OR public.is_admin()
) WITH CHECK (
    auth.uid() = auth_user_id OR public.is_admin()
);

-- -----------------------------------------------------------------------------
-- 5. CHÍNH SÁCH BẢO MẬT: BẢNG classes & class_members
-- -----------------------------------------------------------------------------
DROP POLICY IF EXISTS "classes_select_policy" ON public.classes;
CREATE POLICY "classes_select_policy" ON public.classes
FOR SELECT USING (
    public.is_admin()
    OR public.is_teacher_of_class(id)
    OR public.is_student_in_class(id)
    OR auth.role() = 'authenticated' -- Xem danh mục lớp để đăng ký
);

DROP POLICY IF EXISTS "classes_write_policy" ON public.classes;
CREATE POLICY "classes_write_policy" ON public.classes
FOR ALL USING (
    public.is_admin() OR public.current_user_role() IN ('school', 'teacher')
);

DROP POLICY IF EXISTS "class_members_select_policy" ON public.class_members;
CREATE POLICY "class_members_select_policy" ON public.class_members
FOR SELECT USING (
    profile_id = public.current_profile_id()
    OR public.is_teacher_of_class(class_id)
    OR public.is_admin()
);

-- -----------------------------------------------------------------------------
-- 6. CHÍNH SÁCH BẢO MẬT: CHƯƠNG TRÌNH & HỌC LIỆU (curriculum, rubrics, resources)
-- -----------------------------------------------------------------------------
DROP POLICY IF EXISTS "curriculum_read_all" ON public.curriculum_lessons;
CREATE POLICY "curriculum_read_all" ON public.curriculum_lessons
FOR SELECT USING (true); -- Học liệu được công khai cho mọi người dùng tham khảo

DROP POLICY IF EXISTS "lesson_stages_read_all" ON public.lesson_stages;
CREATE POLICY "lesson_stages_read_all" ON public.lesson_stages
FOR SELECT USING (true);

DROP POLICY IF EXISTS "lesson_rubrics_read_all" ON public.lesson_rubrics;
CREATE POLICY "lesson_rubrics_read_all" ON public.lesson_rubrics
FOR SELECT USING (true);

DROP POLICY IF EXISTS "learning_resources_read_all" ON public.learning_resources;
CREATE POLICY "learning_resources_read_all" ON public.learning_resources
FOR SELECT USING (verification_status = 'verified' OR public.is_admin() OR public.current_user_role() IN ('teacher', 'school'));

DROP POLICY IF EXISTS "curriculum_write_admin_teacher" ON public.curriculum_lessons;
CREATE POLICY "curriculum_write_admin_teacher" ON public.curriculum_lessons
FOR ALL USING (public.is_admin() OR public.current_user_role() IN ('teacher', 'school'));

-- -----------------------------------------------------------------------------
-- 7. CHÍNH SÁCH BẢO MẬT: BÀI TẬP (writing_assignments)
-- -----------------------------------------------------------------------------
DROP POLICY IF EXISTS "assignments_select_policy" ON public.writing_assignments;
CREATE POLICY "assignments_select_policy" ON public.writing_assignments
FOR SELECT USING (
    public.is_teacher_of_class(class_id)
    OR public.is_student_in_class(class_id)
    OR public.is_admin()
);

DROP POLICY IF EXISTS "assignments_modify_policy" ON public.writing_assignments;
CREATE POLICY "assignments_modify_policy" ON public.writing_assignments
FOR ALL USING (
    teacher_id = public.current_profile_id() OR public.is_admin()
);

-- -----------------------------------------------------------------------------
-- 8. CHÍNH SÁCH BẢO MẬT: BÀI VIẾT HỌC SINH (student_writing_attempts)
-- Học sinh chỉ truy cập bài của mình. Giáo viên chỉ truy cập lớp được phân công.
-- -----------------------------------------------------------------------------
DROP POLICY IF EXISTS "attempts_select_policy" ON public.student_writing_attempts;
CREATE POLICY "attempts_select_policy" ON public.student_writing_attempts
FOR SELECT USING (
    student_id = public.current_profile_id()        -- Học sinh xem bài mình
    OR public.is_teacher_of_class(class_id)         -- Giáo viên phụ trách lớp xem bài nộp
    OR public.is_admin()                            -- Quản trị viên
);

DROP POLICY IF EXISTS "attempts_insert_policy" ON public.student_writing_attempts;
CREATE POLICY "attempts_insert_policy" ON public.student_writing_attempts
FOR INSERT WITH CHECK (
    student_id = public.current_profile_id() OR public.is_admin()
);

DROP POLICY IF EXISTS "attempts_update_policy" ON public.student_writing_attempts;
CREATE POLICY "attempts_update_policy" ON public.student_writing_attempts
FOR UPDATE USING (
    student_id = public.current_profile_id()
    OR public.is_teacher_of_class(class_id)
    OR public.is_admin()
);

-- -----------------------------------------------------------------------------
-- 9. CHÍNH SÁCH BẢO MẬT: LỊCH SỬ CHỈNH SỬA & NHẬN XÉT (revisions & ai/teacher feedback)
-- -----------------------------------------------------------------------------
DROP POLICY IF EXISTS "revisions_select_policy" ON public.writing_revisions;
CREATE POLICY "revisions_select_policy" ON public.writing_revisions
FOR SELECT USING (
    EXISTS (
        SELECT 1 FROM public.student_writing_attempts a
        WHERE a.id = attempt_id
          AND (a.student_id = public.current_profile_id()
               OR public.is_teacher_of_class(a.class_id)
               OR public.is_admin())
    )
);

DROP POLICY IF EXISTS "revisions_insert_policy" ON public.writing_revisions;
CREATE POLICY "revisions_insert_policy" ON public.writing_revisions
FOR INSERT WITH CHECK (
    EXISTS (
        SELECT 1 FROM public.student_writing_attempts a
        WHERE a.id = attempt_id
          AND (a.student_id = public.current_profile_id() OR public.is_admin())
    )
);

DROP POLICY IF EXISTS "ai_feedback_select_policy" ON public.ai_feedback;
CREATE POLICY "ai_feedback_select_policy" ON public.ai_feedback
FOR SELECT USING (
    EXISTS (
        SELECT 1 FROM public.student_writing_attempts a
        WHERE a.id = attempt_id
          AND (a.student_id = public.current_profile_id()
               OR public.is_teacher_of_class(a.class_id)
               OR public.is_admin())
    )
);

DROP POLICY IF EXISTS "teacher_feedback_select_policy" ON public.teacher_feedback;
CREATE POLICY "teacher_feedback_select_policy" ON public.teacher_feedback
FOR SELECT USING (
    EXISTS (
        SELECT 1 FROM public.student_writing_attempts a
        WHERE a.id = attempt_id
          AND (
               (a.student_id = public.current_profile_id() AND status = 'published')
               OR public.is_teacher_of_class(a.class_id)
               OR public.is_admin()
          )
    )
);

DROP POLICY IF EXISTS "teacher_feedback_write_policy" ON public.teacher_feedback;
CREATE POLICY "teacher_feedback_write_policy" ON public.teacher_feedback
FOR ALL USING (
    teacher_id = public.current_profile_id() OR public.is_admin()
);

-- -----------------------------------------------------------------------------
-- 10. CHÍNH SÁCH BẢO MẬT: TRÒ CHƠI & LƯỢT CHƠI (games, game_attempts)
-- -----------------------------------------------------------------------------
DROP POLICY IF EXISTS "games_read_all" ON public.games;
CREATE POLICY "games_read_all" ON public.games
FOR SELECT USING (true);

DROP POLICY IF EXISTS "game_attempts_select_policy" ON public.game_attempts;
CREATE POLICY "game_attempts_select_policy" ON public.game_attempts
FOR SELECT USING (
    student_id = public.current_profile_id()
    OR public.current_user_role() IN ('teacher', 'school')
    OR public.is_admin()
);

DROP POLICY IF EXISTS "game_attempts_insert_policy" ON public.game_attempts;
CREATE POLICY "game_attempts_insert_policy" ON public.game_attempts
FOR INSERT WITH CHECK (
    student_id = public.current_profile_id() OR public.is_admin()
);

-- -----------------------------------------------------------------------------
-- 11. CHÍNH SÁCH BẢO MẬT: THÔNG BÁO & NHẬT KÝ (notifications, audit_logs)
-- -----------------------------------------------------------------------------
DROP POLICY IF EXISTS "notifications_user_policy" ON public.notifications;
CREATE POLICY "notifications_user_policy" ON public.notifications
FOR ALL USING (
    recipient_id = public.current_profile_id() OR public.is_admin()
);

DROP POLICY IF EXISTS "audit_logs_read_admin" ON public.audit_logs;
CREATE POLICY "audit_logs_read_admin" ON public.audit_logs
FOR SELECT USING (public.is_admin());

DROP POLICY IF EXISTS "audit_logs_insert_all" ON public.audit_logs;
CREATE POLICY "audit_logs_insert_all" ON public.audit_logs
FOR INSERT WITH CHECK (true);
