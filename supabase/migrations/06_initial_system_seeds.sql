-- =============================================================================
-- EDUNOVA Writing Coach - Supabase PostgreSQL Migration
-- File 06: Initial System Seed Data (Cấu hình hệ thống, KHÔNG tạo tài khoản hay bài viết giả)
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1. BẢNG DANH MỤC CẤU HÌNH HỆ THỐNG: system_configs (Tùy chọn)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.system_configs (
    key VARCHAR(100) PRIMARY KEY,
    category VARCHAR(50) NOT NULL,
    value JSONB NOT NULL,
    description TEXT,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.system_configs IS 'Lưu trữ các danh mục cấu hình chuẩn: vai trò, cấp độ viết, kỹ năng đánh giá';

-- -----------------------------------------------------------------------------
-- 2. KHỞI TẠO CÁC LOẠI VAI TRÒ (ROLES)
-- -----------------------------------------------------------------------------
INSERT INTO public.system_configs (key, category, value, description)
VALUES (
    'system_roles',
    'roles',
    '[
        {"code": "student", "name": "Học sinh", "description": "Luyện viết, nhận phản hồi AI và giáo viên, chơi mini games"},
        {"code": "teacher", "name": "Giáo viên", "description": "Quản lý lớp học, giao bài, chấm bài, phản hồi học sinh"},
        {"code": "school", "name": "Cán bộ trường", "description": "Quản lý tổng quan các lớp, giáo viên và học liệu trường"},
        {"code": "admin", "name": "Quản trị viên", "description": "Toàn quyền quản trị hệ thống, dữ liệu và kiểm toán"}
    ]'::jsonb,
    'Danh mục các vai trò người dùng trong hệ thống EDUNOVA'
)
ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value, updated_at = NOW();

-- -----------------------------------------------------------------------------
-- 3. KHỞI TẠO CÁC LOẠI CẤP ĐỘ VIẾT (WRITING LEVELS)
-- -----------------------------------------------------------------------------
INSERT INTO public.system_configs (key, category, value, description)
VALUES (
    'writing_levels',
    'curriculum',
    '[
        {"code": "sentence", "name": "Luyện câu", "target_words": "10-25 từ", "focus": "Đúng ngữ pháp, mở rộng trạng ngữ, dùng từ gợi tả"},
        {"code": "paragraph", "name": "Luyện đoạn văn", "target_words": "80-150 từ", "focus": "Đoạn văn 4-5 câu, có câu mở đoạn, thân đoạn, kết đoạn"},
        {"code": "essay", "name": "Luyện bài văn", "target_words": "180-350 từ", "focus": "Bài văn hoàn chỉnh gồm 3 phần: Mở bài, Thân bài, Kết bài"}
    ]'::jsonb,
    'Các cấp độ phát triển kỹ năng viết chuẩn từ câu, đoạn đến bài'
)
ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value, updated_at = NOW();

-- -----------------------------------------------------------------------------
-- 4. KHỞI TẠO CÁC LOẠI KỸ NĂNG NGÔN NGỮ (SKILL TYPES)
-- -----------------------------------------------------------------------------
INSERT INTO public.system_configs (key, category, value, description)
VALUES (
    'writing_skills',
    'pedagogy',
    '[
        {"code": "spelling", "name": "Chính tả & Dấu câu", "description": "Quy tắc chính tả phụ âm đầu, vần khó và dấu thanh"},
        {"code": "vocabulary", "name": "Vốn từ gợi tả & Biểu cảm", "description": "Từ láy, tính từ, từ gợi hình ảnh và âm thanh"},
        {"code": "sentence_structure", "name": "Cấu trúc & Liên kết câu", "description": "Câu đơn, câu ghép, phép thế và từ nối liên kết"},
        {"code": "rhetoric", "name": "Biện pháp tu từ", "description": "Kỹ thuật so sánh và nhân hóa theo chương trình lớp 4"},
        {"code": "outline_structure", "name": "Bố cục & Phát triển ý", "description": "Sắp xếp ý mạch lạc, đủ mở - thân - kết theo đúng trọng tâm đề"},
        {"code": "emotion_creativity", "name": "Cảm xúc & Sáng tạo", "description": "Bộc lộ suy nghĩ, tình cảm chân thật của học sinh"}
    ]'::jsonb,
    'Các kỹ năng cốt lõi được đo lường trong rubric và nhận xét AI'
)
ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value, updated_at = NOW();

-- -----------------------------------------------------------------------------
-- 5. KHỞI TẠO DANH SÁCH 4 TRÒ CHƠI HỌC TẬP CHUẨN (GAMES)
-- -----------------------------------------------------------------------------
INSERT INTO public.games (id, title, description, target_grade, category, difficulty_levels, rules_and_guide, icon, is_active)
VALUES
(
    'sentence-builder',
    'Vua Ghép Câu',
    'Thử thách sắp xếp các mảnh ghép từ ngữ thành câu văn hoàn chỉnh, đúng trật tự cú pháp và giàu nhạc điệu.',
    4,
    'sentence_craft',
    '["Cơ bản", "Trung bình", "Thử thách"]'::jsonb,
    'Kéo thả hoặc nhấn vào các thẻ từ ngữ để ghép thành câu có nghĩa. Chú ý vị trí trạng ngữ chỉ thời gian, nơi chốn và dấu chấm cuối câu.',
    '🧩',
    TRUE
),
(
    'spelling-detective',
    'Thám Tử Chính Tả',
    'Hóa thân thành thám tử nhí truy tìm các từ ngữ viết sai chính tả trong đoạn trích văn học và sửa lại cho đúng chuẩn.',
    4,
    'spelling',
    '["Cơ bản", "Trung bình", "Thử thách"]'::jsonb,
    'Đọc kỹ văn bản, bấm vào từ bị nghi ngờ sai chính tả (phân biệt l/n, s/x, tr/ch, dấu hỏi/ngã) và chọn đáp án chính xác nhất.',
    '🔍',
    TRUE
),
(
    'vivid-words',
    'Truy Tìm Từ Đắt',
    'Khám phá kho tàng từ láy, từ gợi tả âm thanh, màu sắc, dáng vẻ để làm câu văn bừng sáng vẻ đẹp nghệ thuật.',
    4,
    'vocabulary',
    '["Cơ bản", "Trung bình", "Thử thách"]'::jsonb,
    'Chọn từ ngữ có sắc thái gợi cảm và hình ảnh cao nhất để thay thế cho từ ngữ thông thường trong ngữ cảnh câu văn.',
    '💎',
    TRUE
),
(
    'sentence-smith',
    'Thợ Rèn Câu Văn',
    'Luyện kỹ năng nâng cấp câu văn đơn giản thành câu văn mở rộng nhiều thành phần, kết hợp biện pháp so sánh hoặc nhân hóa.',
    4,
    'rhetoric',
    '["Cơ bản", "Trung bình", "Thử thách"]'::jsonb,
    'Dựa vào câu gốc và câu hỏi gợi mở, viết lại câu bằng cách bổ sung thêm chi tiết cụ thể, từ ngữ gợi cảm hoặc hình ảnh so sánh sinh động.',
    '⚡',
    TRUE
)
ON CONFLICT (id) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    category = EXCLUDED.category,
    rules_and_guide = EXCLUDED.rules_and_guide,
    icon = EXCLUDED.icon,
    updated_at = NOW();
