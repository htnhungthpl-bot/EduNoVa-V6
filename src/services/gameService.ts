import { supabase, isSupabaseConfigured } from '../lib/supabase';
import { GameId } from '../types/challenges';

export interface DbGame {
  id: string;
  title: string;
  description: string;
  target_grade: number;
  category: string;
  difficulty_levels: string[];
  rules_and_guide: string;
  icon: string;
  is_active: boolean;
}

export interface GameAttemptPayload {
  studentId: string;
  gameId: GameId;
  score: number;
  maxScore?: number;
  stars: number;
  durationSeconds?: number;
  completedLevel?: string;
  badgesEarned?: string[];
  metadata?: Record<string, any>;
}

export const gameService = {
  /**
   * Get all active games from Supabase
   */
  async getGames(): Promise<DbGame[]> {
    if (!isSupabaseConfigured()) {
      return [
        {
          id: 'sentence-builder',
          title: 'Vua Ghép Câu',
          description: 'Thử thách sắp xếp các mảnh ghép từ ngữ thành câu văn hoàn chỉnh, đúng trật tự cú pháp và giàu nhạc điệu.',
          target_grade: 4,
          category: 'sentence_craft',
          difficulty_levels: ['Cơ bản', 'Trung bình', 'Thử thách'],
          rules_and_guide: 'Kéo thả hoặc nhấn vào các thẻ từ ngữ để ghép thành câu có nghĩa.',
          icon: '🧩',
          is_active: true,
        },
        {
          id: 'spelling-detective',
          title: 'Thám Tử Chính Tả',
          description: 'Hóa thân thành thám tử nhí truy tìm các từ ngữ viết sai chính tả trong đoạn trích văn học và sửa lại cho đúng.',
          target_grade: 4,
          category: 'spelling',
          difficulty_levels: ['Cơ bản', 'Trung bình', 'Thử thách'],
          rules_and_guide: 'Đọc kỹ văn bản và chọn từ đúng quy tắc chính tả.',
          icon: '🔍',
          is_active: true,
        },
        {
          id: 'vivid-words',
          title: 'Truy Tìm Từ Đắt',
          description: 'Khám phá kho tàng từ láy, từ gợi tả âm thanh, màu sắc, dáng vẻ để làm câu văn bừng sáng.',
          target_grade: 4,
          category: 'vocabulary',
          difficulty_levels: ['Cơ bản', 'Trung bình', 'Thử thách'],
          rules_and_guide: 'Chọn từ ngữ có sức biểu đạt mạnh mẽ nhất trong ngữ cảnh.',
          icon: '💎',
          is_active: true,
        },
        {
          id: 'sentence-smith',
          title: 'Thợ Rèn Câu Văn',
          description: 'Luyện kỹ năng nâng cấp câu văn đơn giản thành câu văn mở rộng, kết hợp biện pháp so sánh hoặc nhân hóa.',
          target_grade: 4,
          category: 'rhetoric',
          difficulty_levels: ['Cơ bản', 'Trung bình', 'Thử thách'],
          rules_and_guide: 'Bổ sung trạng ngữ, hình ảnh so sánh hoặc từ ngữ gợi tả vào câu gốc.',
          icon: '⚡',
          is_active: true,
        },
      ];
    }

    const { data, error } = await supabase
      .from('games')
      .select('*')
      .eq('is_active', true)
      .order('id', { ascending: true });

    if (error || !data) return [];
    return data;
  },

  /**
   * Record a student game attempt
   */
  async recordGameAttempt(payload: GameAttemptPayload): Promise<any> {
    if (!isSupabaseConfigured()) {
      return { success: true };
    }

    const { data, error } = await supabase
      .from('game_attempts')
      .insert({
        student_id: payload.studentId,
        game_id: payload.gameId,
        score: payload.score,
        max_score: payload.maxScore || 100,
        stars: payload.stars,
        duration_seconds: payload.durationSeconds || 0,
        completed_level: payload.completedLevel || 'Cơ bản',
        badges_earned: payload.badgesEarned || [],
        metadata: payload.metadata || {},
      })
      .select()
      .single();

    if (error) throw new Error(error.message);
    return data;
  },

  /**
   * Get student's previous game attempts
   */
  async getStudentGameAttempts(studentId: string, gameId?: string): Promise<any[]> {
    if (!isSupabaseConfigured()) return [];

    let query = supabase
      .from('game_attempts')
      .select('*')
      .eq('student_id', studentId)
      .order('created_at', { ascending: false });

    if (gameId) {
      query = query.eq('game_id', gameId);
    }

    const { data, error } = await query;
    if (error || !data) return [];
    return data;
  },
};
