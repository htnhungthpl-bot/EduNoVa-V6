import { supabase, isSupabaseConfigured } from '../lib/supabase';
import { UserProfile, UserRole } from '../types';
import { api } from '../utils/api';

export interface DbProfileRow {
  id: string;
  auth_user_id?: string;
  role: UserRole;
  username?: string;
  full_name: string;
  email?: string;
  student_code?: string;
  school_id?: string;
  class_id?: string;
  class_name?: string;
  avatar?: string;
  status: 'active' | 'locked' | 'pending';
  last_login_at?: string;
  created_at: string;
  updated_at: string;
}

export const profileService = {
  /**
   * Get profile by ID
   */
  async getProfileById(id: string): Promise<UserProfile | null> {
    if (!isSupabaseConfigured()) {
      const users = await api.getUsers();
      return users.find((u: any) => u.id === id) || null;
    }

    const { data, error } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', id)
      .single();

    if (error || !data) return null;

    return {
      id: data.id,
      name: data.full_name,
      username: data.username,
      role: data.role as UserRole,
      school: '',
      schoolId: data.school_id,
      className: data.class_name || '',
      classId: data.class_id,
      avatar: data.avatar || '👦',
      email: data.email,
      studentCode: data.student_code,
      status: data.status === 'locked' ? 'locked' : 'active',
    };
  },

  /**
   * Get list of profiles by role
   */
  async getProfilesByRole(role?: UserRole): Promise<UserProfile[]> {
    if (!isSupabaseConfigured()) {
      const users = await api.getUsers();
      if (!role) return users;
      return users.filter((u: any) => u.role === role);
    }

    let query = supabase.from('profiles').select('*').order('created_at', { ascending: false });
    if (role) {
      query = query.eq('role', role);
    }

    const { data, error } = await query;
    if (error || !data) return [];

    return data.map((d: DbProfileRow): UserProfile => ({
      id: d.id,
      name: d.full_name,
      username: d.username,
      role: d.role,
      school: '',
      schoolId: d.school_id,
      className: d.class_name || '',
      classId: d.class_id,
      avatar: d.avatar || '👦',
      email: d.email,
      studentCode: d.student_code,
      status: d.status === 'locked' ? 'locked' : 'active',
    }));
  },

  /**
   * Get students belonging to a class
   */
  async getStudentsByClass(classIdOrName: string): Promise<UserProfile[]> {
    if (!isSupabaseConfigured()) {
      const users = await api.getUsers();
      const filter = classIdOrName.trim().toLowerCase();
      return users.filter(
        (u: any) =>
          u.role === 'student' &&
          (u.classId?.toLowerCase() === filter ||
            u.className?.toLowerCase() === filter ||
            u.className?.toLowerCase().includes(filter) ||
            !filter)
      );
    }

    const { data, error } = await supabase
      .from('profiles')
      .select('*')
      .eq('role', 'student')
      .or(`class_id.eq.${classIdOrName},class_name.ilike.%${classIdOrName}%`)
      .order('student_code', { ascending: true });

    if (error || !data) return [];

    return data.map((d: DbProfileRow): UserProfile => ({
      id: d.id,
      name: d.full_name,
      username: d.username,
      role: d.role,
      school: '',
      schoolId: d.school_id,
      className: d.class_name || '',
      classId: d.class_id,
      avatar: d.avatar || '👦',
      studentCode: d.student_code,
      status: d.status === 'locked' ? 'locked' : 'active',
    }));
  },

  /**
   * Update profile (safe attributes only; role changes prevented by RLS trigger)
   */
  async updateProfile(id: string, updates: Partial<{
    fullName: string;
    avatar: string;
    className: string;
    status: 'active' | 'locked';
  }>): Promise<boolean> {
    if (!isSupabaseConfigured()) {
      await api.updateUser(id, updates);
      return true;
    }

    const dbPayload: any = {};
    if (updates.fullName) dbPayload.full_name = updates.fullName;
    if (updates.avatar) dbPayload.avatar = updates.avatar;
    if (updates.className) dbPayload.class_name = updates.className;
    if (updates.status) dbPayload.status = updates.status;

    const { error } = await supabase
      .from('profiles')
      .update(dbPayload)
      .eq('id', id);

    return !error;
  },
};
