-- =============================================================================
-- EDUNOVA Writing Coach - Supabase PostgreSQL Migration
-- File 02: Curriculum & Learning Resources
-- Tables: curriculum_lessons, lesson_stages, lesson_rubrics, learning_resources
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 5. BẢNG: curriculum_lessons (Danh mục bài học phân phối chương trình SGK Tiếng Việt 4)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.curriculum_lessons (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code VARCHAR(50) UNIQUE, -- Mã định danh bài học: VD KNTT-B01, TV4-T1-B01
    semester VARCHAR(50) NOT NULL CHECK (semester IN ('Học kì I', 'Học kì II')),
    book_volume VARCHAR(50) NOT NULL CHECK (book_volume IN ('Tập một', 'Tập hai')),
    week INT NOT NULL CHECK (week BETWEEN 1 AND 35),
    lesson_number INT NOT NULL CHECK (lesson_number > 0),
    lesson_title VARCHAR(255) NOT NULL, -- Tên bài Viết theo SGK
    page INT CHECK (page > 0),           -- Trang SGK
    theme VARCHAR(255) NOT NULL,        -- Chủ điểm: Mỗi người một vẻ, Trải nghiệm và khám phá...
    reading_lesson VARCHAR(255),        -- Bài đọc tương ứng trong tuần
    genre VARCHAR(100) NOT NULL,        -- Kiểu bài: Đoạn văn nêu ý kiến, Kể chuyện, Miêu tả...
    writing_level VARCHAR(50) NOT NULL DEFAULT 'paragraph' CHECK (writing_level IN ('sentence', 'paragraph', 'essay')),
    writing_prompt TEXT NOT NULL,       -- Yêu cầu viết / Đề bài
    learning_objective TEXT,            -- Nhiệm vụ và mục tiêu học tập
    practice_steps JSONB DEFAULT '{}'::jsonb,  -- Cấu trúc các bước luyện viết
    resources JSONB DEFAULT '{}'::jsonb,       -- Tài nguyên bài học (ngữ liệu, ghi nhớ...)
    verification_status VARCHAR(50) NOT NULL DEFAULT 'verified' CHECK (verification_status IN ('verified', 'needs_verification', 'draft')),
    verification_notes TEXT,            -- Ghi chú đối chiếu SGK với chuẩn kiến thức
    source_label VARCHAR(150) DEFAULT 'SGK Tiếng Việt 4 - Kết nối tri thức với cuộc sống',
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.curriculum_lessons IS 'Kho chương trình bài học phân phối theo SGK Tiếng Việt 4 chuẩn Bộ Giáo dục & Đào tạo';

-- -----------------------------------------------------------------------------
-- 6. BẢNG: lesson_stages (Các chặng luyện viết theo quy trình 6 bước chuẩn EDUNOVA)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.lesson_stages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lesson_id UUID NOT NULL REFERENCES public.curriculum_lessons(id) ON DELETE CASCADE,
    stage_order INT NOT NULL CHECK (stage_order BETWEEN 1 AND 6),
    stage_code VARCHAR(50) NOT NULL CHECK (stage_code IN (
        'find_ideas',       -- Bước 1: Tìm ý
        'outline',          -- Bước 2: Lập dàn ý
        'drafting',         -- Bước 3: Tự viết
        'ai_suggestions',   -- Bước 4: Nhận gợi ý
        'self_revision',    -- Bước 5: Tự sửa
        'finalization'      -- Bước 6: Hoàn thiện
    )),
    stage_name VARCHAR(100) NOT NULL,
    instructions TEXT NOT NULL,         -- Hướng dẫn chi tiết cho từng chặng
    prompts_or_questions JSONB DEFAULT '[]'::jsonb, -- Câu hỏi gợi ý tư duy / khung hướng dẫn
    checklist JSONB DEFAULT '[]'::jsonb,            -- Danh mục tiêu chí tự kiểm tra
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_lesson_stage UNIQUE (lesson_id, stage_order)
);

COMMENT ON TABLE public.lesson_stages IS 'Quy trình 6 bước luyện viết: 1. Tìm ý, 2. Lập dàn ý, 3. Tự viết, 4. Nhận gợi ý, 5. Tự sửa, 6. Hoàn thiện';

-- -----------------------------------------------------------------------------
-- 7. BẢNG: lesson_rubrics (Rubric đánh giá chi tiết theo từng bài học hoặc thể loại)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.lesson_rubrics (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lesson_id UUID REFERENCES public.curriculum_lessons(id) ON DELETE CASCADE,
    genre VARCHAR(100),                 -- Áp dụng cho thể loại chung nếu lesson_id là NULL
    criterion_code VARCHAR(50) NOT NULL,
    criterion_name VARCHAR(255) NOT NULL, -- Tên tiêu chí: Bố cục, Dùng từ, Diễn đạt, Cảm xúc...
    weight NUMERIC(3,2) NOT NULL DEFAULT 1.00 CHECK (weight > 0),
    max_score NUMERIC(4,2) NOT NULL DEFAULT 10.00 CHECK (max_score > 0),
    level_descriptors JSONB NOT NULL DEFAULT '{
        "support_needed": "Cần hỗ trợ nhiều",
        "developing": "Đang hoàn thiện",
        "proficient": "Đạt yêu cầu",
        "advanced": "Vượt mức mong đợi"
    }'::jsonb,
    sort_order INT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.lesson_rubrics IS 'Tiêu chí rubric đánh giá bài viết theo 4 mức độ: Cần hỗ trợ, Đang phát triển, Thành thạo, Xuất sắc';

-- -----------------------------------------------------------------------------
-- 8. BẢNG: learning_resources (Kho học liệu, ngữ liệu mẫu, bài đọc SGK đã kiểm duyệt)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.learning_resources (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    source_name VARCHAR(255) NOT NULL,  -- Tên nguồn xuất bản (VD: NXB Giáo dục Việt Nam)
    book_name VARCHAR(255) NOT NULL,    -- Bộ sách (Kết nối tri thức, Chân trời sáng tạo, Cánh diều)
    volume VARCHAR(50) NOT NULL,        -- Tập 1 / Tập 2
    lesson_id UUID REFERENCES public.curriculum_lessons(id) ON DELETE SET NULL,
    page INT CHECK (page > 0),           -- Trang đã xác minh trong sách giáo khoa
    resource_type VARCHAR(50) NOT NULL CHECK (resource_type IN (
        'sample_essay',     -- Đoạn/Bài văn mẫu chuẩn
        'reading_excerpt',  -- Trích đoạn ngữ liệu đọc
        'grammar_rule',     -- Ghi nhớ ngữ pháp / từ ngữ
        'vocab_list',       -- Bộ từ vựng gợi ý theo chủ điểm
        'outline_template', -- Sơ đồ dàn ý mẫu
        'multimedia'        -- Tranh ảnh minh họa ngữ liệu
    )),
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    metadata JSONB DEFAULT '{}'::jsonb, -- Thông tin tác giả, giải nghĩa từ khó...
    verification_status VARCHAR(50) NOT NULL DEFAULT 'verified' CHECK (verification_status IN ('verified', 'pending', 'draft')),
    verified_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    verified_at TIMESTAMPTZ,
    verification_notes TEXT,            -- Ghi chú đối chiếu bản in
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.learning_resources IS 'Kho học liệu ngữ văn SGK đã xác minh bản in và trang sách cụ thể';

-- -----------------------------------------------------------------------------
-- CHỈ MỤC TỐI ƯU TRUY VẤN
-- -----------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_curriculum_week_volume ON public.curriculum_lessons(book_volume, week);
CREATE INDEX IF NOT EXISTS idx_curriculum_genre ON public.curriculum_lessons(genre);
CREATE INDEX IF NOT EXISTS idx_lesson_stages_lesson ON public.lesson_stages(lesson_id, stage_order);
CREATE INDEX IF NOT EXISTS idx_lesson_rubrics_lesson ON public.lesson_rubrics(lesson_id);
CREATE INDEX IF NOT EXISTS idx_learning_resources_book ON public.learning_resources(book_name, volume, page);
CREATE INDEX IF NOT EXISTS idx_learning_resources_lesson ON public.learning_resources(lesson_id);

-- -----------------------------------------------------------------------------
-- TRIGGERS CẬP NHẬT UPDATED_AT
-- -----------------------------------------------------------------------------
DROP TRIGGER IF EXISTS trg_curriculum_lessons_updated_at ON public.curriculum_lessons;
CREATE TRIGGER trg_curriculum_lessons_updated_at
BEFORE UPDATE ON public.curriculum_lessons
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS trg_lesson_stages_updated_at ON public.lesson_stages;
CREATE TRIGGER trg_lesson_stages_updated_at
BEFORE UPDATE ON public.lesson_stages
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS trg_lesson_rubrics_updated_at ON public.lesson_rubrics;
CREATE TRIGGER trg_lesson_rubrics_updated_at
BEFORE UPDATE ON public.lesson_rubrics
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS trg_learning_resources_updated_at ON public.learning_resources;
CREATE TRIGGER trg_learning_resources_updated_at
BEFORE UPDATE ON public.learning_resources
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
