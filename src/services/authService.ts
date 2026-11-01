import { supabase, isSupabaseConfigured } from '../lib/supabase';
import { UserProfile, UserRole } from '../types';
import { api, setStoredToken, setStoredUser } from '../utils/api';

export interface SupabaseAuthResult {
  success: boolean;
  user?: UserProfile;
  error?: string;
  isSupabaseAuth: boolean;
}

export const authService = {
  /**
   * Get the current authenticated user profile
   */
  async getCurrentUser(): Promise<UserProfile | null> {
    if (!isSupabaseConfigured()) {
      return api.getMe();
    }

    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) {
        return api.getMe();
      }

      // Query profile matching auth_user_id
      const { data: profile, error } = await supabase
        .from('profiles')
        .select('*')
        .eq('auth_user_id', user.id)
        .single();

      if (error || !profile) {
        return api.getMe();
      }

      return {
        id: profile.id,
        name: profile.full_name,
        username: profile.username || undefined,
        role: profile.role as UserRole,
        school: '',
        schoolId: profile.school_id || undefined,
        className: profile.class_name || '',
        classId: profile.class_id || undefined,
        avatar: profile.avatar || '👦',
        email: profile.email || undefined,
        studentCode: profile.student_code || undefined,
        status: (profile.status === 'locked' ? 'locked' : 'active'),
      };
    } catch (err) {
      console.warn('Fallback to local session:', err);
      return api.getMe();
    }
  },

  /**
   * Sign in with Email and Password
   */
  async signInWithEmail(email: string, password: string): Promise<SupabaseAuthResult> {
    if (!isSupabaseConfigured()) {
      // Use internal authentication proxy
      try {
        const response = await api.customPost<any>('/api/auth/login', {
          role: 'teacher',
          email,
          password,
        });
        return {
          success: true,
          user: response.user,
          isSupabaseAuth: false,
        };
      } catch (err: any) {
        return {
          success: false,
          error: err.message || 'Đăng nhập không thành công',
          isSupabaseAuth: false,
        };
      }
    }

    try {
      const { data, error } = await supabase.auth.signInWithPassword({
        email: email.trim(),
        password,
      });

      if (error) {
        return {
          success: false,
          error: error.message,
          isSupabaseAuth: true,
        };
      }

      if (!data.user) {
        return {
          success: false,
          error: 'Không tìm thấy thông tin tài khoản người dùng',
          isSupabaseAuth: true,
        };
      }

      // Fetch user profile from public.profiles
      const { data: profile } = await supabase
        .from('profiles')
        .select('*')
        .eq('auth_user_id', data.user.id)
        .single();

      const mappedUser: UserProfile = {
        id: profile?.id || data.user.id,
        name: profile?.full_name || data.user.email?.split('@')[0] || 'Giáo viên',
        username: profile?.username,
        role: (profile?.role as UserRole) || 'teacher',
        school: '',
        schoolId: profile?.school_id,
        className: profile?.class_name || '',
        classId: profile?.class_id,
        avatar: profile?.avatar || '👩‍🏫',
        email: data.user.email,
        status: (profile?.status === 'locked' ? 'locked' : 'active'),
      };

      setStoredUser(mappedUser);
      if (data.session?.access_token) {
        setStoredToken(data.session.access_token);
      }

      return {
        success: true,
        user: mappedUser,
        isSupabaseAuth: true,
      };
    } catch (err: any) {
      return {
        success: false,
        error: err.message || 'Lỗi mạng khi kết nối Supabase Auth',
        isSupabaseAuth: true,
      };
    }
  },

  /**
   * Student Login with Student Code & 4-digit PIN
   */
  async signInStudent(params: {
    fullName: string;
    studentCode?: string;
    pinCode: string;
    className: string;
  }): Promise<SupabaseAuthResult> {
    try {
      const response = await api.login({
        role: 'student',
        fullName: params.fullName,
        className: params.className,
        pinCode: params.pinCode,
      });

      return {
        success: true,
        user: response.user,
        isSupabaseAuth: false,
      };
    } catch (err: any) {
      return {
        success: false,
        error: err.message || 'Mã PIN hoặc thông tin học sinh không chính xác',
        isSupabaseAuth: false,
      };
    }
  },

  /**
   * Sign out current user
   */
  async signOut(): Promise<void> {
    api.logout();
    if (isSupabaseConfigured()) {
      try {
        await supabase.auth.signOut();
      } catch (err) {
        console.warn('Supabase signout warning:', err);
      }
    }
  },

  /**
   * Listen to auth state changes
   */
  onAuthStateChange(callback: (user: UserProfile | null) => void) {
    if (!isSupabaseConfigured()) {
      return { unsubscribe: () => {} };
    }

    const { data: { subscription } } = supabase.auth.onAuthStateChange(async (_event, session) => {
      if (session?.user) {
        const user = await authService.getCurrentUser();
        callback(user);
      } else {
        callback(null);
      }
    });

    return {
      unsubscribe: () => subscription.unsubscribe(),
    };
  },
};
