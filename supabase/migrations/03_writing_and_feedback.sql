-- =============================================================================
-- EDUNOVA Writing Coach - Supabase PostgreSQL Migration
-- File 03: Writing Assignments, Student Attempts, Revisions & Feedback
-- Tables: writing_assignments, student_writing_attempts, writing_revisions, ai_feedback, teacher_feedback
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 9. BẢNG: writing_assignments (Bài tập luyện viết do Giáo viên giao cho Lớp)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.writing_assignments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    teacher_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    class_id UUID NOT NULL REFERENCES public.classes(id) ON DELETE CASCADE,
    lesson_id UUID REFERENCES public.curriculum_lessons(id) ON DELETE SET NULL,
    title VARCHAR(255) NOT NULL,
    prompt TEXT NOT NULL,               -- Đề bài / yêu cầu viết
    genre VARCHAR(100),                 -- Kiểu bài: Kể chuyện, Miêu tả, Viết đoạn...
    writing_level VARCHAR(50) NOT NULL DEFAULT 'paragraph' CHECK (writing_level IN ('sentence', 'paragraph', 'essay')),
    target_word_min INT NOT NULL DEFAULT 80 CHECK (target_word_min >= 0),
    target_word_max INT NOT NULL DEFAULT 350 CHECK (target_word_max >= target_word_min),
    due_date TIMESTAMPTZ,               -- Hạn nộp bài
    allow_ai BOOLEAN NOT NULL DEFAULT TRUE, -- Cho phép AI gợi ý trong quá trình viết
    rubric_levels JSONB DEFAULT '[]'::jsonb,
    status VARCHAR(20) NOT NULL DEFAULT 'published' CHECK (status IN ('published', 'draft', 'archived')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.writing_assignments IS 'Bài tập luyện viết do giáo viên chủ nhiệm hoặc bộ môn giao cho từng lớp học';

-- -----------------------------------------------------------------------------
-- 10. BẢNG: student_writing_attempts (Bài viết học sinh - Lưu nội dung gốc và hiện tại)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.student_writing_attempts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    class_id UUID NOT NULL REFERENCES public.classes(id) ON DELETE CASCADE,
    assignment_id UUID REFERENCES public.writing_assignments(id) ON DELETE SET NULL,
    lesson_id UUID REFERENCES public.curriculum_lessons(id) ON DELETE SET NULL,
    prompt_title VARCHAR(255) NOT NULL, -- Tiêu đề hoặc đề bài học sinh viết
    writing_level VARCHAR(50) NOT NULL DEFAULT 'paragraph' CHECK (writing_level IN ('sentence', 'paragraph', 'essay')),
    
    -- Yêu cầu cốt lõi: Lưu bài viết gốc và bài viết hiện tại
    original_content TEXT NOT NULL,     -- Nội dung gốc đầu tiên của học sinh (không bao giờ bị ghi đè)
    current_content TEXT NOT NULL,      -- Nội dung bài viết ở trạng thái hiện thời
    
    current_step INT NOT NULL DEFAULT 1 CHECK (current_step BETWEEN 1 AND 6), -- Chặng 1-6 trong quy trình
    step_data JSONB NOT NULL DEFAULT '{
        "step1_ideas": {},
        "step2_outline": {},
        "step6_self_assessment": {}
    }'::jsonb,                          -- Lưu dữ liệu tìm ý, dàn ý, tự đánh giá
    
    word_count INT NOT NULL DEFAULT 0 CHECK (word_count >= 0),
    status VARCHAR(30) NOT NULL DEFAULT 'draft' CHECK (status IN (
        'draft',            -- Đang tự viết / hoàn thiện
        'submitted',        -- Đã nộp bài cho giáo viên
        'reviewing',        -- Giáo viên đang chấm
        'needs_revision',   -- Giáo viên yêu cầu sửa đổi
        'completed'         -- Đã hoàn thành và công bố điểm
    )),
    
    rubric_results JSONB NOT NULL DEFAULT '[]'::jsonb, -- Kết quả tự đánh giá và đánh giá rubric
    submitted_at TIMESTAMPTZ,           -- Thời gian nộp bài
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.student_writing_attempts IS 'Bài viết của học sinh, đảm bảo lưu toàn vẹn nội dung gốc, nội dung hiện tại và tiến độ 6 bước';

-- -----------------------------------------------------------------------------
-- 11. BẢNG: writing_revisions (Lịch sử các phiên bản chỉnh sửa riêng biệt)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.writing_revisions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    attempt_id UUID NOT NULL REFERENCES public.student_writing_attempts(id) ON DELETE CASCADE,
    revision_number INT NOT NULL CHECK (revision_number >= 1),
    step_number INT NOT NULL CHECK (step_number BETWEEN 1 AND 6),
    step_name VARCHAR(100) NOT NULL,    -- Ví dụ: Bước 3 - Tự viết, Bước 5 - Tự sửa
    content TEXT NOT NULL,              -- Nội dung của phiên bản này (tuyệt đối không ghi đè bài viết gốc)
    word_count INT NOT NULL DEFAULT 0 CHECK (word_count >= 0),
    changes_summary TEXT,               -- Tóm tắt các điểm đã sửa (do học sinh hoặc AI tổng hợp)
    created_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_attempt_revision_seq UNIQUE (attempt_id, revision_number)
);

COMMENT ON TABLE public.writing_revisions IS 'Lịch sử lưu trữ từng phiên bản chỉnh sửa độc lập, không ghi đè bài viết gốc';

-- -----------------------------------------------------------------------------
-- 12. BẢNG: ai_feedback (Nhận xét AI & bằng chứng dẫn chứng trong bài)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.ai_feedback (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    attempt_id UUID NOT NULL REFERENCES public.student_writing_attempts(id) ON DELETE CASCADE,
    revision_id UUID REFERENCES public.writing_revisions(id) ON DELETE SET NULL,
    step_number INT CHECK (step_number BETWEEN 1 AND 6),
    feedback_type VARCHAR(50) NOT NULL DEFAULT 'overall_review' CHECK (feedback_type IN (
        'overall_review',   -- Nhận xét toàn diện
        'spelling_grammar', -- Chính tả và dấu câu
        'vocab_enhancement',-- Làm giàu từ ngữ / hình ảnh gợi tả
        'outline_review',   -- Góp ý dàn ý
        'rhetoric_review'   -- Biện pháp so sánh, nhân hóa
    )),
    overall_feedback TEXT NOT NULL,     -- Nhận xét chung, lời khen và định hướng
    strengths JSONB NOT NULL DEFAULT '[]'::jsonb,   -- Các điểm sáng trong bài viết
    suggestions JSONB NOT NULL DEFAULT '[]'::jsonb, -- Các gợi ý để học sinh tự nâng cấp bài
    evidence_snippets JSONB NOT NULL DEFAULT '[]'::jsonb, -- BẰNG CHỨNG TƯƠNG ỨNG trong bài (câu văn cụ thể và phân tích)
    detected_techniques JSONB DEFAULT '[]'::jsonb,  -- Kỹ thuật viết phát hiện (so sánh, từ láy...)
    rubric_scores JSONB DEFAULT '[]'::jsonb,        -- Điểm dự kiến theo từng tiêu chí
    stars_awarded INT CHECK (stars_awarded BETWEEN 1 AND 5),
    model_version VARCHAR(100) DEFAULT 'gemini-2.5-flash',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.ai_feedback IS 'Lưu nhận xét AI, lời khen gợi mở và bằng chứng trích dẫn tương ứng trong văn bản học sinh';

-- -----------------------------------------------------------------------------
-- 13. BẢNG: teacher_feedback (Nhận xét và đánh giá chính thức của Giáo viên)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.teacher_feedback (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    attempt_id UUID NOT NULL REFERENCES public.student_writing_attempts(id) ON DELETE CASCADE,
    teacher_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    score NUMERIC(4,2) CHECK (score BETWEEN 0.00 AND 10.00), -- Điểm số thang 10
    overall_comment TEXT NOT NULL,      -- Lời nhận xét và động viên chính thức
    praise_points TEXT,                 -- Điểm đáng khen ngợi
    revision_requests TEXT,             -- Yêu cầu cần chỉnh sửa / hoàn thiện thêm
    rubric_evaluations JSONB NOT NULL DEFAULT '[]'::jsonb, -- Điểm chi tiết từng tiêu chí
    stickers JSONB DEFAULT '[]'::jsonb, -- Nhãn dán khích lệ (Bút chì vàng, Ngôi sao chăm chỉ...)
    status VARCHAR(20) NOT NULL DEFAULT 'published' CHECK (status IN ('draft', 'published', 'returned_for_edit')),
    published_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.teacher_feedback IS 'Nhận xét, chấm điểm và chỉ dẫn sửa bài chính thức từ giáo viên';

-- -----------------------------------------------------------------------------
-- CHỈ MỤC TỐI ƯU TRUY VẤN
-- -----------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_assignments_class ON public.writing_assignments(class_id);
CREATE INDEX IF NOT EXISTS idx_assignments_teacher ON public.writing_assignments(teacher_id);
CREATE INDEX IF NOT EXISTS idx_attempts_student ON public.student_writing_attempts(student_id);
CREATE INDEX IF NOT EXISTS idx_attempts_class ON public.student_writing_attempts(class_id);
CREATE INDEX IF NOT EXISTS idx_attempts_assignment ON public.student_writing_attempts(assignment_id);
CREATE INDEX IF NOT EXISTS idx_attempts_status ON public.student_writing_attempts(status);
CREATE INDEX IF NOT EXISTS idx_revisions_attempt ON public.writing_revisions(attempt_id, revision_number);
CREATE INDEX IF NOT EXISTS idx_ai_feedback_attempt ON public.ai_feedback(attempt_id);
CREATE INDEX IF NOT EXISTS idx_teacher_feedback_attempt ON public.teacher_feedback(attempt_id);

-- -----------------------------------------------------------------------------
-- TRIGGERS CẬP NHẬT UPDATED_AT
-- -----------------------------------------------------------------------------
DROP TRIGGER IF EXISTS trg_assignments_updated_at ON public.writing_assignments;
CREATE TRIGGER trg_assignments_updated_at
BEFORE UPDATE ON public.writing_assignments
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS trg_attempts_updated_at ON public.student_writing_attempts;
CREATE TRIGGER trg_attempts_updated_at
BEFORE UPDATE ON public.student_writing_attempts
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS trg_teacher_feedback_updated_at ON public.teacher_feedback;
CREATE TRIGGER trg_teacher_feedback_updated_at
BEFORE UPDATE ON public.teacher_feedback
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
