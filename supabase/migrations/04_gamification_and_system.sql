-- =============================================================================
-- EDUNOVA Writing Coach - Supabase PostgreSQL Migration
-- File 04: Gamification, Games, Notifications & Audit Logs
-- Tables: games, game_attempts, notifications, audit_logs
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 14. BẢNG: games (Danh mục trò chơi học tập rèn luyện kỹ năng từ câu đến đoạn)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.games (
    id VARCHAR(100) PRIMARY KEY,        -- 'sentence-builder', 'spelling-detective', 'vivid-words', 'sentence-smith'
    title VARCHAR(255) NOT NULL,
    description TEXT,
    target_grade INT NOT NULL DEFAULT 4 CHECK (target_grade BETWEEN 1 AND 5),
    category VARCHAR(100) NOT NULL CHECK (category IN (
        'spelling',         -- Chính tả
        'vocabulary',       -- Mở rộng vốn từ
        'sentence_craft',   -- Đặt câu và mở rộng câu
        'rhetoric'          -- Biện pháp tu từ: So sánh, nhân hóa
    )),
    difficulty_levels JSONB NOT NULL DEFAULT '["Cơ bản", "Trung bình", "Thử thách"]'::jsonb,
    rules_and_guide TEXT,
    icon VARCHAR(100) DEFAULT '🎮',
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.games IS 'Danh mục trò chơi ngôn ngữ hỗ trợ phát triển kỹ năng viết theo chuẩn lớp 4';

-- -----------------------------------------------------------------------------
-- 15. BẢNG: game_attempts (Kết quả luyện tập trò chơi của học sinh)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.game_attempts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    game_id VARCHAR(100) NOT NULL REFERENCES public.games(id) ON DELETE CASCADE,
    score INT NOT NULL DEFAULT 0 CHECK (score >= 0),
    max_score INT NOT NULL DEFAULT 100 CHECK (max_score > 0),
    stars INT NOT NULL DEFAULT 0 CHECK (stars BETWEEN 0 AND 3),
    duration_seconds INT CHECK (duration_seconds >= 0),
    completed_level VARCHAR(50) DEFAULT 'Cơ bản',
    badges_earned JSONB DEFAULT '[]'::jsonb,
    metadata JSONB DEFAULT '{}'::jsonb,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.game_attempts IS 'Lưu kết quả lượt chơi của từng học sinh: điểm số, thời gian, số sao và huy hiệu';

-- -----------------------------------------------------------------------------
-- 16. BẢNG: notifications (Hệ thống thông báo cho người dùng)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    recipient_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    sender_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    type VARCHAR(50) NOT NULL CHECK (type IN (
        'assignment_new',       -- Có bài tập mới
        'assignment_due',       -- Sắp đến hạn nộp bài
        'ai_feedback',          -- AI đã có gợi ý bài viết
        'teacher_feedback',     -- Giáo viên đã chấm bài
        'revision_requested',   -- Yêu cầu chỉnh sửa bài viết
        'badge_unlocked',       -- Mở khóa huy hiệu mới
        'system_announcement'   -- Thông báo từ hệ thống
    )),
    link_url VARCHAR(255),      -- Đường dẫn tới bài viết hoặc tính năng tương ứng
    is_read BOOLEAN NOT NULL DEFAULT FALSE,
    read_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.notifications IS 'Hộp thư thông báo học tập dành cho học sinh và giáo viên';

-- -----------------------------------------------------------------------------
-- 17. BẢNG: audit_logs (Nhật ký kiểm toán hoạt động hệ thống)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.audit_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    username VARCHAR(100),
    user_role VARCHAR(50),
    action VARCHAR(100) NOT NULL,       -- CREATE, UPDATE, SUBMIT, APPROVE, REQUEST_EDIT, DELETE, LOGIN
    entity_type VARCHAR(100) NOT NULL,  -- Bảng hoặc đối tượng tác động (student_writing_attempts, profiles, writing_assignments...)
    entity_id UUID,
    details JSONB DEFAULT '{}'::jsonb,  -- Chi tiết thay đổi trước và sau
    ip_address VARCHAR(100),
    user_agent TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.audit_logs IS 'Nhật ký bảo mật và kiểm toán mọi thao tác thay đổi dữ liệu trong hệ thống';

-- -----------------------------------------------------------------------------
-- CHỈ MỤC TỐI ƯU TRUY VẤN
-- -----------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_game_attempts_student ON public.game_attempts(student_id);
CREATE INDEX IF NOT EXISTS idx_game_attempts_game ON public.game_attempts(game_id);
CREATE INDEX IF NOT EXISTS idx_notifications_recipient ON public.notifications(recipient_id, is_read);
CREATE INDEX IF NOT EXISTS idx_audit_logs_user ON public.audit_logs(user_id);
CREATE INDEX IF NOT EXISTS idx_audit_logs_action ON public.audit_logs(action);
CREATE INDEX IF NOT EXISTS idx_audit_logs_created_at ON public.audit_logs(created_at DESC);

-- -----------------------------------------------------------------------------
-- TRIGGERS CẬP NHẬT UPDATED_AT
-- -----------------------------------------------------------------------------
DROP TRIGGER IF EXISTS trg_games_updated_at ON public.games;
CREATE TRIGGER trg_games_updated_at
BEFORE UPDATE ON public.games
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
