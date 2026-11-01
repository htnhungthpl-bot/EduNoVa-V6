import { createClient, SupabaseClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.SUPABASE_URL || process.env.VITE_SUPABASE_URL || '';
const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY || '';
const anonKey = process.env.SUPABASE_ANON_KEY || process.env.VITE_SUPABASE_ANON_KEY || '';

export function isSupabaseBackendConfigured(): boolean {
  return Boolean(supabaseUrl && (serviceRoleKey || anonKey));
}

let adminClient: SupabaseClient | null = null;

export function getSupabaseAdmin(): SupabaseClient | null {
  if (!isSupabaseBackendConfigured()) return null;
  if (!adminClient) {
    adminClient = createClient(supabaseUrl, serviceRoleKey || anonKey, {
      auth: {
        autoRefreshToken: false,
        persistSession: false,
      },
    });
  }
  return adminClient;
}

export function getMaskedBackendUrl(): string {
  if (!supabaseUrl) return 'Chưa cấu hình (Thiếu SUPABASE_URL)';
  try {
    const url = new URL(supabaseUrl);
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
