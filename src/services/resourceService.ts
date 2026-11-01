import { supabase, isSupabaseConfigured } from '../lib/supabase';
import { Grade4LessonItem } from '../types';
import { getInitialCurriculumData } from '../data/grade4CurriculumData';

export interface DbLearningResource {
  id: string;
  source_name: string;
  book_name: string;
  volume: string;
  lesson_id?: string;
  page?: number;
  resource_type: 'sample_essay' | 'reading_excerpt' | 'grammar_rule' | 'vocab_list' | 'outline_template' | 'multimedia';
  title: string;
  content: string;
  metadata?: Record<string, any>;
  verification_status: 'verified' | 'pending' | 'draft';
  verification_notes?: string;
}

export const resourceService = {
  /**
   * Get curriculum lessons from Supabase with fallback to local grade4CurriculumData
   */
  async getCurriculumLessons(): Promise<Grade4LessonItem[]> {
    if (!isSupabaseConfigured()) {
      return getInitialCurriculumData();
    }

    const { data, error } = await supabase
      .from('curriculum_lessons')
      .select('*')
      .order('week', { ascending: true })
      .order('lesson_number', { ascending: true });

    if (error || !data || data.length === 0) {
      return getInitialCurriculumData();
    }

    return data.map((d: any) => ({
      id: d.id,
      semester: d.semester,
      bookVolume: d.book_volume,
      week: d.week,
      lessonNumber: d.lesson_number,
      lessonTitle: d.lesson_title,
      page: d.page || 0,
      theme: d.theme,
      readingLesson: d.reading_lesson || '',
      genre: d.genre,
      stage: 'Luyện viết',
      writingPrompt: d.writing_prompt,
      learningObjective: d.learning_objective || '',
      practiceSteps: d.practice_steps || {},
      evaluationRubric: [],
      resources: d.resources || {},
      verificationStatus: d.verification_status,
      verificationNotes: d.verification_notes,
      sourceLabel: d.source_label,
      isSampleData: false,
    }));
  },

  /**
   * Get 6-step stages for a specific lesson
   */
  async getLessonStages(lessonId: string): Promise<any[]> {
    if (!isSupabaseConfigured()) return [];

    const { data, error } = await supabase
      .from('lesson_stages')
      .select('*')
      .eq('lesson_id', lessonId)
      .order('stage_order', { ascending: true });

    if (error || !data) return [];
    return data;
  },

  /**
   * Get rubrics for a lesson or genre
   */
  async getLessonRubrics(lessonId?: string, genre?: string): Promise<any[]> {
    if (!isSupabaseConfigured()) return [];

    let query = supabase.from('lesson_rubrics').select('*').order('sort_order', { ascending: true });
    if (lessonId) {
      query = query.eq('lesson_id', lessonId);
    } else if (genre) {
      query = query.eq('genre', genre);
    }

    const { data, error } = await query;
    if (error || !data) return [];
    return data;
  },

  /**
   * Get verified learning resources (textbook excerpts, sample essays)
   */
  async getLearningResources(filter?: {
    bookName?: string;
    volume?: string;
    lessonId?: string;
    resourceType?: string;
  }): Promise<DbLearningResource[]> {
    if (!isSupabaseConfigured()) return [];

    let query = supabase
      .from('learning_resources')
      .select('*')
      .eq('verification_status', 'verified')
      .order('page', { ascending: true });

    if (filter?.bookName) query = query.eq('book_name', filter.bookName);
    if (filter?.volume) query = query.eq('volume', filter.volume);
    if (filter?.lessonId) query = query.eq('lesson_id', filter.lessonId);
    if (filter?.resourceType) query = query.eq('resource_type', filter.resourceType);

    const { data, error } = await query;
    if (error || !data) return [];
    return data;
  },
};
