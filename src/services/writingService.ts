import { supabase, isSupabaseConfigured } from '../lib/supabase';
import { api } from '../utils/api';

export interface WritingAttemptPayload {
  studentId: string;
  classId: string;
  assignmentId?: string;
  lessonId?: string;
  promptTitle: string;
  writingLevel: 'sentence' | 'paragraph' | 'essay';
  originalContent: string;
  currentContent: string;
  currentStep?: number;
  wordCount?: number;
  status?: 'draft' | 'submitted' | 'reviewing' | 'completed' | 'needs_revision';
  rubricResults?: any[];
  stepData?: Record<string, any>;
}

export interface WritingRevisionPayload {
  attemptId: string;
  revisionNumber: number;
  stepNumber: number;
  stepName: string;
  content: string;
  wordCount?: number;
  changesSummary?: string;
  authorId?: string;
}

export interface AIFeedbackPayload {
  attemptId: string;
  revisionId?: string;
  stepNumber?: number;
  feedbackType: 'overall_review' | 'spelling_grammar' | 'vocab_enhancement' | 'outline_review' | 'rhetoric_review';
  overallFeedback: string;
  strengths: string[];
  suggestions: string[];
  evidenceSnippets: {
    snippet: string;
    type: 'praise' | 'suggestion' | 'grammar';
    explanation: string;
  }[];
  rubricScores?: any[];
  detectedTechniques?: string[];
  starsAwarded?: number;
}

export interface TeacherFeedbackPayload {
  attemptId: string;
  teacherId: string;
  score?: number;
  overallComment: string;
  praisePoints?: string;
  revisionRequests?: string;
  rubricEvaluations?: any[];
  stickers?: string[];
  status?: 'draft' | 'published' | 'returned_for_edit';
}

export const writingService = {
  /**
   * Create or start a new student writing attempt
   * Automatically initializes original_content and current_content
   */
  async createAttempt(payload: WritingAttemptPayload): Promise<any> {
    if (!isSupabaseConfigured()) {
      return api.submitEssay({
        assignmentId: payload.assignmentId,
        lessonId: payload.lessonId || 'custom',
        lessonTitle: payload.promptTitle,
        content: payload.currentContent,
        wordCount: payload.wordCount || 0,
      });
    }

    const { data, error } = await supabase
      .from('student_writing_attempts')
      .insert({
        student_id: payload.studentId,
        class_id: payload.classId,
        assignment_id: payload.assignmentId || null,
        lesson_id: payload.lessonId || null,
        prompt_title: payload.promptTitle,
        writing_level: payload.writingLevel,
        original_content: payload.originalContent, // Preserved permanently
        current_content: payload.currentContent,
        current_step: payload.currentStep || 1,
        word_count: payload.wordCount || 0,
        status: payload.status || 'draft',
        rubric_results: payload.rubricResults || [],
        step_data: payload.stepData || {},
      })
      .select()
      .single();

    if (error) throw new Error(error.message);

    // Automatically record revision 1 for the original draft
    await this.createRevision({
      attemptId: data.id,
      revisionNumber: 1,
      stepNumber: payload.currentStep || 1,
      stepName: 'Bản thảo ban đầu',
      content: payload.originalContent,
      wordCount: payload.wordCount || 0,
      authorId: payload.studentId,
    }).catch(err => console.warn('Could not record initial revision:', err));

    return data;
  },

  /**
   * Update current content without overwriting original content
   */
  async updateCurrentContent(attemptId: string, currentContent: string, currentStep?: number): Promise<any> {
    if (!isSupabaseConfigured()) {
      return { success: true };
    }

    const wordCount = currentContent.trim().split(/\s+/).filter(Boolean).length;
    const { data, error } = await supabase
      .from('student_writing_attempts')
      .update({
        current_content: currentContent,
        current_step: currentStep,
        word_count: wordCount,
        updated_at: new Date().toISOString(),
      })
      .eq('id', attemptId)
      .select()
      .single();

    if (error) throw new Error(error.message);
    return data;
  },

  /**
   * Record a new revision (strict preservation of version history)
   */
  async createRevision(payload: WritingRevisionPayload): Promise<any> {
    if (!isSupabaseConfigured()) {
      return { success: true };
    }

    const wordCount = payload.wordCount || payload.content.trim().split(/\s+/).filter(Boolean).length;

    const { data, error } = await supabase
      .from('writing_revisions')
      .insert({
        attempt_id: payload.attemptId,
        revision_number: payload.revisionNumber,
        step_number: payload.stepNumber,
        step_name: payload.stepName,
        content: payload.content, // Separate version copy
        word_count: wordCount,
        changes_summary: payload.changesSummary,
        created_by: payload.authorId,
      })
      .select()
      .single();

    if (error) throw new Error(error.message);
    return data;
  },

  /**
   * Get all revisions for a specific writing attempt
   */
  async getRevisions(attemptId: string): Promise<any[]> {
    if (!isSupabaseConfigured()) return [];

    const { data, error } = await supabase
      .from('writing_revisions')
      .select('*')
      .eq('attempt_id', attemptId)
      .order('revision_number', { ascending: true });

    if (error || !data) return [];
    return data;
  },

  /**
   * Save AI Feedback with specific textual evidence snippets
   */
  async saveAiFeedback(payload: AIFeedbackPayload): Promise<any> {
    if (!isSupabaseConfigured()) {
      return { success: true };
    }

    const { data, error } = await supabase
      .from('ai_feedback')
      .insert({
        attempt_id: payload.attemptId,
        revision_id: payload.revisionId || null,
        step_number: payload.stepNumber || 4,
        feedback_type: payload.feedbackType,
        overall_feedback: payload.overallFeedback,
        strengths: payload.strengths || [],
        suggestions: payload.suggestions || [],
        evidence_snippets: payload.evidenceSnippets || [], // Stored evidence
        rubric_scores: payload.rubricScores || [],
        detected_techniques: payload.detectedTechniques || [],
        stars_awarded: payload.starsAwarded,
      })
      .select()
      .single();

    if (error) throw new Error(error.message);
    return data;
  },

  /**
   * Save Teacher Feedback and grading
   */
  async saveTeacherFeedback(payload: TeacherFeedbackPayload): Promise<any> {
    if (!isSupabaseConfigured()) {
      return api.reviewSubmission(payload.attemptId, {
        score: payload.score,
        teacherComment: payload.overallComment,
        rubricScores: payload.rubricEvaluations,
        isPublished: payload.status === 'published',
        stickersEarned: payload.stickers,
      });
    }

    const { data, error } = await supabase
      .from('teacher_feedback')
      .insert({
        attempt_id: payload.attemptId,
        teacher_id: payload.teacherId,
        score: payload.score,
        overall_comment: payload.overallComment,
        praise_points: payload.praisePoints,
        revision_requests: payload.revisionRequests,
        rubric_evaluations: payload.rubricEvaluations || [],
        stickers: payload.stickers || [],
        status: payload.status || 'published',
        published_at: payload.status === 'published' ? new Date().toISOString() : null,
      })
      .select()
      .single();

    if (error) throw new Error(error.message);

    // Update status of attempt
    await supabase
      .from('student_writing_attempts')
      .update({
        status: payload.status === 'returned_for_edit' ? 'needs_revision' : 'completed',
      })
      .eq('id', payload.attemptId);

    return data;
  },

  /**
   * Get student writing submissions by class or student
   */
  async getStudentAttempts(filter?: { classId?: string; studentId?: string; status?: string }): Promise<any[]> {
    if (!isSupabaseConfigured()) {
      const posts = await api.customGet<any[]>('/api/submissions').catch(() => []);
      return posts;
    }

    let query = supabase
      .from('student_writing_attempts')
      .select('*, profiles!student_id(full_name, student_code, avatar, class_name), classes!class_id(name)')
      .order('created_at', { ascending: false });

    if (filter?.classId) query = query.eq('class_id', filter.classId);
    if (filter?.studentId) query = query.eq('student_id', filter.studentId);
    if (filter?.status && filter.status !== 'all') query = query.eq('status', filter.status);

    const { data, error } = await query;
    if (error || !data) return [];
    return data;
  },
};
