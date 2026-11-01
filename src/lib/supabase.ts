import { createClient, SupabaseClient } from '@supabase/supabase-js';

// Retrieve public environment variables for frontend connection
// Note: Only publishable/anon key is used here. RLS must be enabled on all tables.
const rawUrl = (import.meta as any).env?.VITE_SUPABASE_URL || '';
const rawAnonKey = 
  (import.meta as any).env?.VITE_SUPABASE_ANON_KEY || 
  (import.meta as any).env?.VITE_SUPABASE_PUBLISHABLE_KEY || 
  '';

export const SUPABASE_URL = typeof rawUrl === 'string' ? rawUrl.trim() : '';
export const SUPABASE_ANON_KEY = typeof rawAnonKey === 'string' ? rawAnonKey.trim() : '';

/**
 * Checks if the Supabase frontend configuration is present
 */
export function isSupabaseConfigured(): boolean {
  return Boolean(
    SUPABASE_URL && 
    SUPABASE_ANON_KEY && 
    SUPABASE_URL.startsWith('https://') &&
    SUPABASE_URL.includes('.supabase.co') &&
    SUPABASE_ANON_KEY.length > 20
  );
}

/**
 * Get masked URL for safe UI display (e.g., https://abc****.supabase.co)
 */
export function getMaskedSupabaseUrl(): string {
  if (!SUPABASE_URL) return 'Chưa cấu hình (Thiếu VITE_SUPABASE_URL)';
  try {
    const url = new URL(SUPABASE_URL);
    const hostParts = url.hostname.split('.');
    if (hostParts.length >= 3) {
      const projectRef = hostParts[0];
      const maskedRef = projectRef.length > 6 
        ? `${projectRef.slice(0, 3)}••••${projectRef.slice(-3)}`
        : '••••••';
      return `https://${maskedRef}.${hostParts.slice(1).join('.')}`;
    }
    return 'https://••••••••.supabase.co';
  } catch {
    return 'URL không hợp lệ';
  }
}

// Fallback dummy client for build/runtime safety when env keys are not yet provided
const dummyClient = createClient(
  SUPABASE_URL || 'https://placeholder-project.supabase.co',
  SUPABASE_ANON_KEY || 'placeholder-anon-key-placeholder-anon-key-placeholder-anon-key',
  {
    auth: {
      persistSession: true,
      autoRefreshToken: true,
      detectSessionInUrl: true,
    },
  }
);

/**
 * Singleton Supabase Client instance for the entire application
 */
export const supabase: SupabaseClient = dummyClient;

export interface SupabaseHealthResult {
  isConfigured: boolean;
  connected: boolean;
  latencyMs: number;
  authStatus: 'ready' | 'unreachable' | 'unconfigured' | 'error';
  dbStatus: 'accessible' | 'permission_denied' | 'unreachable' | 'unconfigured' | 'table_missing';
  maskedUrl: string;
  message: string;
  details?: Record<string, any>;
  checkedAt: string;
}

/**
 * Perform a live diagnostic check of the Supabase connection
 */
export async function testSupabaseConnection(): Promise<SupabaseHealthResult> {
  const checkedAt = new Date().toISOString();
  const maskedUrl = getMaskedSupabaseUrl();

  if (!isSupabaseConfigured()) {
    return {
      isConfigured: false,
      connected: false,
      latencyMs: 0,
      authStatus: 'unconfigured',
      dbStatus: 'unconfigured',
      maskedUrl,
      message: 'Chưa tìm thấy biến môi trường VITE_SUPABASE_URL hoặc VITE_SUPABASE_ANON_KEY trong Google AI Studio Secrets / .env',
      checkedAt,
    };
  }

  const startTime = performance.now();

  try {
    // 1. Test Auth service ping
    let authStatus: SupabaseHealthResult['authStatus'] = 'ready';
    try {
      const { error: sessionError } = await supabase.auth.getSession();
      if (sessionError) {
        authStatus = 'error';
      }
    } catch {
      authStatus = 'unreachable';
    }

    // 2. Test Database query (read public system_configs or curriculum_lessons)
    let dbStatus: SupabaseHealthResult['dbStatus'] = 'accessible';
    let queryDetails: any = null;

    const { data, error, count } = await supabase
      .from('system_configs')
      .select('key, category', { count: 'exact' })
      .limit(5);

    if (error) {
      if (error.code === '42P01') {
        // Table does not exist yet -> Migration not run yet
        dbStatus = 'table_missing';
      } else if (error.code === '42501') {
        // RLS permission denied
        dbStatus = 'permission_denied';
      } else {
        // Fallback test on curriculum_lessons
        const { error: currError } = await supabase
          .from('curriculum_lessons')
          .select('id')
          .limit(1);

        if (currError) {
          dbStatus = 'unreachable';
          queryDetails = { code: error.code, message: error.message };
        } else {
          dbStatus = 'accessible';
        }
      }
    } else {
      queryDetails = { sampleCount: data?.length || 0, totalEstimated: count };
    }

    const latencyMs = Math.round(performance.now() - startTime);

    const isSuccess = authStatus === 'ready' && (dbStatus === 'accessible' || dbStatus === 'table_missing');

    return {
      isConfigured: true,
      connected: isSuccess,
      latencyMs,
      authStatus,
      dbStatus,
      maskedUrl,
      message: isSuccess
        ? `Kết nối Supabase thành công! Độ trễ phản hồi: ${latencyMs}ms.`
        : `Lỗi kết nối cơ sở dữ liệu: ${queryDetails?.message || 'Không thể truy vấn bảng dữ liệu'}`,
      details: queryDetails,
      checkedAt,
    };
  } catch (err: any) {
    const latencyMs = Math.round(performance.now() - startTime);
    return {
      isConfigured: true,
      connected: false,
      latencyMs,
      authStatus: 'unreachable',
      dbStatus: 'unreachable',
      maskedUrl,
      message: `Không thể kết nối đến máy chủ Supabase: ${err.message || 'Lỗi mạng'}`,
      details: { error: String(err) },
      checkedAt,
    };
  }
}
