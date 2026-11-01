import { supabase, isSupabaseConfigured } from '../lib/supabase';
import { DbClass, DbSchool } from '../types';
import { api } from '../utils/api';

export const classService = {
  /**
   * Get all schools
   */
  async getSchools(): Promise<DbSchool[]> {
    if (!isSupabaseConfigured()) {
      return api.getSchools();
    }

    const { data, error } = await supabase
      .from('schools')
      .select('*')
      .order('name', { ascending: true });

    if (error || !data) return api.getSchools();

    return data.map((s: any) => ({
      id: s.id,
      name: s.name,
      code: s.code,
      address: s.address || '',
      email: s.email,
      phone: s.phone,
      hotline: s.hotline,
      createdAt: s.created_at,
    }));
  },

  /**
   * Get all classes with optional school filter
   */
  async getClasses(schoolId?: string): Promise<DbClass[]> {
    if (!isSupabaseConfigured()) {
      return api.getClasses();
    }

    let query = supabase.from('classes').select('*, schools(name)').order('name', { ascending: true });
    if (schoolId) {
      query = query.eq('school_id', schoolId);
    }

    const { data, error } = await query;
    if (error || !data) return api.getClasses();

    return data.map((c: any) => ({
      id: c.id,
      name: c.name,
      grade: c.grade,
      schoolId: c.school_id,
      schoolName: c.schools?.name || '',
      teacherIds: [],
      teacherNames: [],
      createdAt: c.created_at,
    }));
  },

  /**
   * Create a new school
   */
  async createSchool(schoolData: {
    name: string;
    code: string;
    address?: string;
    email?: string;
    phone?: string;
  }): Promise<any> {
    if (!isSupabaseConfigured()) {
      return api.createSchool(schoolData);
    }

    const { data, error } = await supabase
      .from('schools')
      .insert({
        name: schoolData.name,
        code: schoolData.code,
        address: schoolData.address,
        email: schoolData.email,
        phone: schoolData.phone,
      })
      .select()
      .single();

    if (error) throw new Error(error.message);
    return data;
  },

  /**
   * Create a new class
   */
  async createClass(classData: {
    name: string;
    grade: number;
    schoolId: string;
  }): Promise<any> {
    if (!isSupabaseConfigured()) {
      return api.createClass(classData);
    }

    const { data, error } = await supabase
      .from('classes')
      .insert({
        name: classData.name,
        grade: classData.grade,
        school_id: classData.schoolId,
      })
      .select()
      .single();

    if (error) throw new Error(error.message);
    return data;
  },
};
