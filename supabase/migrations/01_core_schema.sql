-- =============================================================================
-- EDUNOVA Writing Coach - Supabase PostgreSQL Migration
-- File 01: Core Schema (Schools, Profiles, Classes, Class Members)
-- =============================================================================

-- Bật extension mở rộng mã hóa UUID và chuỗi
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Hàm tự động cập nhật trường updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- -----------------------------------------------------------------------------
-- 1. BẢNG: schools (Thông tin các trường học trong hệ thống)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.schools (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    code VARCHAR(50) NOT NULL UNIQUE,
    address TEXT,
    email VARCHAR(255),
    phone VARCHAR(50),
    hotline VARCHAR(50),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.schools IS 'Danh mục các trường tiểu học tham gia hệ thống EDUNOVA';

-- -----------------------------------------------------------------------------
-- 2. BẢNG: classes (Thông tin lớp học)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.classes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    school_id UUID NOT NULL REFERENCES public.schools(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL, -- Ví dụ: Lớp 4A8, Lớp 4A1
    grade INT NOT NULL CHECK (grade BETWEEN 1 AND 5),
    academic_year VARCHAR(20) DEFAULT '2024-2025',
    max_students INT NOT NULL DEFAULT 40 CHECK (max_students > 0),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_school_class_name UNIQUE (school_id, name, academic_year)
);

COMMENT ON TABLE public.classes IS 'Danh mục lớp học thuộc từng trường';

-- -----------------------------------------------------------------------------
-- 3. BẢNG: profiles (Hồ sơ người dùng: Học sinh, Giáo viên, Cán bộ trường, Quản trị)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    auth_user_id UUID UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
    role VARCHAR(20) NOT NULL CHECK (role IN ('student', 'teacher', 'school', 'admin')),
    username VARCHAR(100) UNIQUE,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    student_code VARCHAR(50), -- Mã học sinh ví dụ: HS4A8-01
    pin_hash VARCHAR(255),   -- Mã PIN đăng nhập cho học sinh tiểu học (mã hóa bcrypt/pgcrypto)
    school_id UUID REFERENCES public.schools(id) ON DELETE SET NULL,
    class_id UUID REFERENCES public.classes(id) ON DELETE SET NULL,
    class_name VARCHAR(100),  -- Tên lớp lưu cache hiển thị nhanh (Lớp 4A8)
    avatar VARCHAR(255) DEFAULT '👦',
    status VARCHAR(20) NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'locked', 'pending')),
    last_login_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_school_student_code UNIQUE (school_id, student_code)
);

COMMENT ON TABLE public.profiles IS 'Hồ sơ tài khoản tập trung cho học sinh, giáo viên, cán bộ trường và admin';

-- -----------------------------------------------------------------------------
-- 4. BẢNG: class_members (Thành viên lớp: phân công giáo viên chủ nhiệm & học sinh)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.class_members (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    class_id UUID NOT NULL REFERENCES public.classes(id) ON DELETE CASCADE,
    profile_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    role_in_class VARCHAR(30) NOT NULL CHECK (role_in_class IN ('student', 'primary_teacher', 'assistant_teacher')),
    status VARCHAR(20) NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'transferred', 'inactive')),
    joined_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_class_member UNIQUE (class_id, profile_id)
);

COMMENT ON TABLE public.class_members IS 'Bảng liên kết quản lý danh sách học sinh và giáo viên phụ trách từng lớp';

-- -----------------------------------------------------------------------------
-- CHỈ MỤC TỐI ƯU TRUY VẤN (INDEXES)
-- -----------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_classes_school_id ON public.classes(school_id);
CREATE INDEX IF NOT EXISTS idx_profiles_role ON public.profiles(role);
CREATE INDEX IF NOT EXISTS idx_profiles_class_id ON public.profiles(class_id);
CREATE INDEX IF NOT EXISTS idx_profiles_student_code ON public.profiles(student_code);
CREATE INDEX IF NOT EXISTS idx_class_members_class ON public.class_members(class_id);
CREATE INDEX IF NOT EXISTS idx_class_members_profile ON public.class_members(profile_id);

-- -----------------------------------------------------------------------------
-- TRIGGERS TỰ ĐỘNG CẬP NHẬT UPDATED_AT
-- -----------------------------------------------------------------------------
DROP TRIGGER IF EXISTS trg_schools_updated_at ON public.schools;
CREATE TRIGGER trg_schools_updated_at
BEFORE UPDATE ON public.schools
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS trg_classes_updated_at ON public.classes;
CREATE TRIGGER trg_classes_updated_at
BEFORE UPDATE ON public.classes
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS trg_profiles_updated_at ON public.profiles;
CREATE TRIGGER trg_profiles_updated_at
BEFORE UPDATE ON public.profiles
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
