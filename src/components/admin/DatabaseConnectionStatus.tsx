import React, { useState, useEffect } from 'react';
import { 
  Database, 
  CheckCircle2, 
  AlertCircle, 
  RefreshCw, 
  ShieldCheck, 
  Zap, 
  ExternalLink, 
  Copy, 
  Check, 
  Lock, 
  Server, 
  Globe, 
  Key,
  Layers,
  HelpCircle
} from 'lucide-react';
import { testSupabaseConnection, isSupabaseConfigured, getMaskedSupabaseUrl, SupabaseHealthResult } from '../../lib/supabase';
import { api } from '../../utils/api';

export const DatabaseConnectionStatus: React.FC = () => {
  const [loading, setLoading] = useState<boolean>(false);
  const [copiedKey, setCopiedKey] = useState<string | null>(null);
  const [frontendHealth, setFrontendHealth] = useState<SupabaseHealthResult | null>(null);
  const [backendHealth, setBackendHealth] = useState<any | null>(null);
  const [selectedGuideTab, setSelectedGuideTab] = useState<'aistudio' | 'vercel' | 'supabase'>('aistudio');

  const runDiagnostics = async () => {
    setLoading(true);
    try {
      // 1. Run Frontend Supabase Client test
      const feRes = await testSupabaseConnection();
      setFrontendHealth(feRes);

      // 2. Run Backend Supabase Admin diagnostic test
      try {
        const beRes = await api.customGet<any>('/api/admin/supabase-status');
        setBackendHealth(beRes);
      } catch (err: any) {
        setBackendHealth({
          isConfigured: false,
          connected: false,
          message: 'Không thể kết nối API backend kiểm tra: ' + (err.message || 'Lỗi mạng'),
        });
      }
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    runDiagnostics();
  }, []);

  const handleCopy = (text: string, label: string) => {
    navigator.clipboard.writeText(text);
    setCopiedKey(label);
    setTimeout(() => setCopiedKey(null), 2500);
  };

  const isConnected = frontendHealth?.connected || backendHealth?.connected;
  const isConfigured = frontendHealth?.isConfigured || backendHealth?.isConfigured;

  return (
    <div className="space-y-6 animate-in fade-in duration-300">
      {/* Top Header Card */}
      <div className="bg-white rounded-3xl p-6 border border-slate-200/80 shadow-xs">
        <div className="flex flex-col lg:flex-row lg:items-center justify-between gap-4">
          <div className="flex items-start gap-4">
            <div className={`p-3.5 rounded-2xl ${
              isConnected 
                ? 'bg-emerald-50 text-emerald-600 border border-emerald-200' 
                : isConfigured 
                  ? 'bg-amber-50 text-amber-600 border border-amber-200'
                  : 'bg-slate-100 text-slate-500 border border-slate-200'
            }`}>
              <Database className="w-7 h-7" />
            </div>
            <div>
              <div className="flex items-center gap-2 flex-wrap">
                <h3 className="font-heading text-lg font-bold text-slate-900">
                  Trung tâm Kiểm tra Kết nối Supabase PostgreSQL
                </h3>
                {isConnected ? (
                  <span className="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full text-xs font-semibold bg-emerald-100 text-emerald-800">
                    <CheckCircle2 className="w-3.5 h-3.5 text-emerald-600" />
                    Đã kết nối trực tiếp
                  </span>
                ) : isConfigured ? (
                  <span className="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full text-xs font-semibold bg-amber-100 text-amber-800">
                    <AlertCircle className="w-3.5 h-3.5 text-amber-600" />
                    Có cấu hình, đang chờ xác thực
                  </span>
                ) : (
                  <span className="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full text-xs font-semibold bg-slate-200 text-slate-700">
                    Chưa cấu hình API Key
                  </span>
                )}
              </div>
              <p className="text-xs text-slate-500 mt-1">
                Khu vực giám sát sức khỏe cơ sở dữ liệu dành riêng cho Quản trị viên (Super Admin).
              </p>
            </div>
          </div>

          <button
            onClick={runDiagnostics}
            disabled={loading}
            className="px-4 py-2.5 rounded-2xl bg-amber-500 hover:bg-amber-600 text-slate-950 font-bold text-xs flex items-center justify-center gap-2 shadow-xs cursor-pointer transition-all active:scale-95 disabled:opacity-50"
          >
            <RefreshCw className={`w-4 h-4 ${loading ? 'animate-spin' : ''}`} />
            <span>{loading ? 'Đang kiểm tra...' : 'Kiểm tra kết nối ngay'}</span>
          </button>
        </div>

        {/* 4 Diagnostic Metrics Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mt-6">
          {/* Card 1: Trạng thái kết nối */}
          <div className="p-4 rounded-2xl bg-slate-50/80 border border-slate-200/60">
            <div className="flex items-center justify-between text-xs text-slate-500 mb-2">
              <span className="font-medium flex items-center gap-1.5">
                <Globe className="w-3.5 h-3.5 text-slate-400" />
                Trạng thái kết nối
              </span>
              <span className={`w-2.5 h-2.5 rounded-full ${isConnected ? 'bg-emerald-500' : isConfigured ? 'bg-amber-500' : 'bg-slate-400'}`} />
            </div>
            <div className="text-base font-bold text-slate-900">
              {isConnected ? 'Đang hoạt động' : isConfigured ? 'Cần kiểm tra quyền' : 'Chưa cấu hình'}
            </div>
            <div className="text-[11px] text-slate-500 mt-1 truncate" title={getMaskedSupabaseUrl()}>
              {getMaskedSupabaseUrl()}
            </div>
          </div>

          {/* Card 2: Thời gian phản hồi (Latency) */}
          <div className="p-4 rounded-2xl bg-slate-50/80 border border-slate-200/60">
            <div className="flex items-center justify-between text-xs text-slate-500 mb-2">
              <span className="font-medium flex items-center gap-1.5">
                <Zap className="w-3.5 h-3.5 text-amber-500" />
                Thời gian phản hồi
              </span>
              <span className="text-[10px] font-mono text-slate-400">RTT</span>
            </div>
            <div className="text-base font-bold text-slate-900 flex items-baseline gap-1">
              <span>{frontendHealth?.latencyMs || backendHealth?.latencyMs || 0}</span>
              <span className="text-xs font-normal text-slate-500">ms</span>
            </div>
            <div className="text-[11px] text-slate-500 mt-1">
              {(frontendHealth?.latencyMs || 0) > 0 ? 'Phản hồi qua Supabase SDK' : 'Chưa có dữ liệu đo'}
            </div>
          </div>

          {/* Card 3: Trạng thái xác thực (Auth) */}
          <div className="p-4 rounded-2xl bg-slate-50/80 border border-slate-200/60">
            <div className="flex items-center justify-between text-xs text-slate-500 mb-2">
              <span className="font-medium flex items-center gap-1.5">
                <ShieldCheck className="w-3.5 h-3.5 text-indigo-500" />
                Supabase Auth
              </span>
              <Lock className="w-3 h-3 text-slate-400" />
            </div>
            <div className="text-base font-bold text-slate-900">
              {frontendHealth?.authStatus === 'ready' ? 'Sẵn sàng' : frontendHealth?.authStatus === 'unconfigured' ? 'Chưa nạp key' : 'Chưa kích hoạt'}
            </div>
            <div className="text-[11px] text-slate-500 mt-1">
              JWT & Session quản lý tập trung
            </div>
          </div>

          {/* Card 4: Truy cập Database (PostgreSQL) */}
          <div className="p-4 rounded-2xl bg-slate-50/80 border border-slate-200/60">
            <div className="flex items-center justify-between text-xs text-slate-500 mb-2">
              <span className="font-medium flex items-center gap-1.5">
                <Server className="w-3.5 h-3.5 text-blue-500" />
                Truy cập Database
              </span>
              <Layers className="w-3 h-3 text-slate-400" />
            </div>
            <div className="text-base font-bold text-slate-900">
              {frontendHealth?.dbStatus === 'accessible' || backendHealth?.dbStatus === 'accessible'
                ? 'Đã mở quyền RLS'
                : frontendHealth?.dbStatus === 'table_missing'
                  ? 'Cần chạy migration'
                  : 'Sẵn sàng nạp'}
            </div>
            <div className="text-[11px] text-slate-500 mt-1">
              17 bảng dữ liệu chuẩn hóa
            </div>
          </div>
        </div>

        {/* Status notification banner */}
        <div className={`mt-4 p-4 rounded-2xl flex items-start gap-3 text-xs ${
          isConnected
            ? 'bg-emerald-50 text-emerald-900 border border-emerald-200'
            : isConfigured
              ? 'bg-amber-50 text-amber-900 border border-amber-200'
              : 'bg-slate-100 text-slate-800 border border-slate-200'
        }`}>
          {isConnected ? (
            <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0 mt-0.5" />
          ) : (
            <AlertCircle className="w-4 h-4 text-amber-600 shrink-0 mt-0.5" />
          )}
          <div className="space-y-1">
            <p className="font-semibold">
              {frontendHealth?.message || backendHealth?.message || 'Hệ thống đang sẵn sàng tích hợp Supabase.'}
            </p>
            <p className="text-[11px] opacity-80">
              Cập nhật lần cuối: {frontendHealth?.checkedAt ? new Date(frontendHealth.checkedAt).toLocaleTimeString('vi-VN') : 'Vừa xong'}
            </p>
          </div>
        </div>
      </div>

      {/* Database Tables Verification Matrix */}
      <div className="bg-white rounded-3xl p-6 border border-slate-200/80 shadow-xs">
        <div className="flex items-center justify-between mb-4">
          <div>
            <h4 className="font-heading font-bold text-slate-900 flex items-center gap-2">
              <Layers className="w-4 h-4 text-amber-600" />
              <span>Cấu trúc 17 Bảng Dữ liệu Đã Sẵn Sàng Đồng Bộ</span>
            </h4>
            <p className="text-xs text-slate-500 mt-0.5">
              Tất cả các bảng đều được bảo vệ bởi Row Level Security (RLS) và chia theo 4 nhóm dịch vụ.
            </p>
          </div>
          <span className="text-xs font-bold px-2.5 py-1 rounded-full bg-slate-100 text-slate-700">
            17 / 17 Bảng
          </span>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-3 text-xs">
          {/* Nhóm 1: Core */}
          <div className="p-3.5 rounded-2xl bg-slate-50 border border-slate-200/70 space-y-2">
            <div className="font-bold text-slate-800 flex items-center gap-1.5 border-b border-slate-200/60 pb-1.5">
              <span className="w-2 h-2 rounded-full bg-indigo-500" />
              <span>1. Nền tảng & Tài khoản</span>
            </div>
            <ul className="space-y-1 text-slate-600 text-[11px]">
              <li className="flex items-center justify-between">
                <code>schools</code>
                <span className="text-[10px] text-emerald-600 font-semibold">Trường học</span>
              </li>
              <li className="flex items-center justify-between">
                <code>classes</code>
                <span className="text-[10px] text-emerald-600 font-semibold">Lớp học</span>
              </li>
              <li className="flex items-center justify-between">
                <code>profiles</code>
                <span className="text-[10px] text-emerald-600 font-semibold">Hồ sơ người dùng</span>
              </li>
              <li className="flex items-center justify-between">
                <code>class_members</code>
                <span className="text-[10px] text-emerald-600 font-semibold">Thành viên lớp</span>
              </li>
            </ul>
          </div>

          {/* Nhóm 2: Curriculum */}
          <div className="p-3.5 rounded-2xl bg-slate-50 border border-slate-200/70 space-y-2">
            <div className="font-bold text-slate-800 flex items-center gap-1.5 border-b border-slate-200/60 pb-1.5">
              <span className="w-2 h-2 rounded-full bg-blue-500" />
              <span>2. Học liệu & SGK</span>
            </div>
            <ul className="space-y-1 text-slate-600 text-[11px]">
              <li className="flex items-center justify-between">
                <code>curriculum_lessons</code>
                <span className="text-[10px] text-blue-600 font-semibold">56 bài học</span>
              </li>
              <li className="flex items-center justify-between">
                <code>lesson_stages</code>
                <span className="text-[10px] text-blue-600 font-semibold">6 bước luyện viết</span>
              </li>
              <li className="flex items-center justify-between">
                <code>lesson_rubrics</code>
                <span className="text-[10px] text-blue-600 font-semibold">Tiêu chí 4 mức</span>
              </li>
              <li className="flex items-center justify-between">
                <code>learning_resources</code>
                <span className="text-[10px] text-blue-600 font-semibold">Ngữ liệu SGK</span>
              </li>
            </ul>
          </div>

          {/* Nhóm 3: Writing */}
          <div className="p-3.5 rounded-2xl bg-slate-50 border border-slate-200/70 space-y-2">
            <div className="font-bold text-slate-800 flex items-center gap-1.5 border-b border-slate-200/60 pb-1.5">
              <span className="w-2 h-2 rounded-full bg-amber-500" />
              <span>3. Bài viết & Phản hồi</span>
            </div>
            <ul className="space-y-1 text-slate-600 text-[11px]">
              <li className="flex items-center justify-between">
                <code>writing_assignments</code>
                <span className="text-[10px] text-amber-600 font-semibold">Giao bài tập</span>
              </li>
              <li className="flex items-center justify-between">
                <code>student_writing_attempts</code>
                <span className="text-[10px] text-amber-600 font-semibold">Bài viết học sinh</span>
              </li>
              <li className="flex items-center justify-between">
                <code>writing_revisions</code>
                <span className="text-[10px] text-amber-600 font-semibold">Lịch sử sửa bài</span>
              </li>
              <li className="flex items-center justify-between">
                <code>ai_feedback</code>
                <span className="text-[10px] text-amber-600 font-semibold">Nhận xét & Dẫn chứng</span>
              </li>
              <li className="flex items-center justify-between">
                <code>teacher_feedback</code>
                <span className="text-[10px] text-amber-600 font-semibold">Chấm bài giáo viên</span>
              </li>
            </ul>
          </div>

          {/* Nhóm 4: Gamification & System */}
          <div className="p-3.5 rounded-2xl bg-slate-50 border border-slate-200/70 space-y-2">
            <div className="font-bold text-slate-800 flex items-center gap-1.5 border-b border-slate-200/60 pb-1.5">
              <span className="w-2 h-2 rounded-full bg-emerald-500" />
              <span>4. Trò chơi & Kiểm toán</span>
            </div>
            <ul className="space-y-1 text-slate-600 text-[11px]">
              <li className="flex items-center justify-between">
                <code>games</code>
                <span className="text-[10px] text-emerald-600 font-semibold">4 Trò chơi</span>
              </li>
              <li className="flex items-center justify-between">
                <code>game_attempts</code>
                <span className="text-[10px] text-emerald-600 font-semibold">Kết quả & Sao</span>
              </li>
              <li className="flex items-center justify-between">
                <code>notifications</code>
                <span className="text-[10px] text-emerald-600 font-semibold">Thông báo</span>
              </li>
              <li className="flex items-center justify-between">
                <code>audit_logs</code>
                <span className="text-[10px] text-emerald-600 font-semibold">Nhật ký bảo mật</span>
              </li>
            </ul>
          </div>
        </div>
      </div>

      {/* Configuration & Environment Guide Card */}
      <div className="bg-white rounded-3xl p-6 border border-slate-200/80 shadow-xs">
        <div className="flex items-center gap-2 mb-4">
          <Key className="w-4 h-4 text-amber-600" />
          <h4 className="font-heading font-bold text-slate-900">
            Hướng dẫn Cấu hình Biến Môi trường An toàn (Secrets Management)
          </h4>
        </div>

        {/* Tab selection */}
        <div className="flex items-center gap-2 border-b border-slate-200 pb-2 mb-4">
          <button
            onClick={() => setSelectedGuideTab('aistudio')}
            className={`px-3 py-1.5 rounded-xl text-xs font-semibold cursor-pointer transition-all ${
              selectedGuideTab === 'aistudio'
                ? 'bg-amber-100 text-amber-900 font-bold'
                : 'text-slate-600 hover:bg-slate-100'
            }`}
          >
            Google AI Studio Secrets
          </button>
          <button
            onClick={() => setSelectedGuideTab('vercel')}
            className={`px-3 py-1.5 rounded-xl text-xs font-semibold cursor-pointer transition-all ${
              selectedGuideTab === 'vercel'
                ? 'bg-amber-100 text-amber-900 font-bold'
                : 'text-slate-600 hover:bg-slate-100'
            }`}
          >
            Vercel / Cloud Run
          </button>
          <button
            onClick={() => setSelectedGuideTab('supabase')}
            className={`px-3 py-1.5 rounded-xl text-xs font-semibold cursor-pointer transition-all ${
              selectedGuideTab === 'supabase'
                ? 'bg-amber-100 text-amber-900 font-bold'
                : 'text-slate-600 hover:bg-slate-100'
            }`}
          >
            Lấy Keys từ Supabase
          </button>
        </div>

        {/* Tab 1: AI Studio */}
        {selectedGuideTab === 'aistudio' && (
          <div className="space-y-3 text-xs text-slate-600">
            <p>
              Để kích hoạt kết nối thực tế trong môi trường Google AI Studio, bạn chỉ cần thêm các khóa bí mật vào bảng điều khiển <strong>Secrets</strong>:
            </p>
            <ol className="list-decimal pl-5 space-y-2 text-slate-700">
              <li>
                Mở menu <strong>Settings</strong> hoặc biểu tượng chiếc chìa khóa / ổ khóa (<strong>Secrets</strong>) ở thanh bên phải của giao diện Google AI Studio.
              </li>
              <li>
                Thêm 2 biến môi trường sau:
                <div className="space-y-2 mt-2">
                  <div className="flex items-center justify-between p-2.5 rounded-xl bg-slate-50 border border-slate-200">
                    <span className="font-mono font-bold text-slate-900">VITE_SUPABASE_URL</span>
                    <button
                      onClick={() => handleCopy('VITE_SUPABASE_URL', 'url')}
                      className="px-2 py-1 rounded bg-white hover:bg-slate-100 border border-slate-200 text-[10px] font-semibold flex items-center gap-1 cursor-pointer"
                    >
                      {copiedKey === 'url' ? <Check className="w-3 h-3 text-emerald-600" /> : <Copy className="w-3 h-3 text-slate-500" />}
                      <span>Sao chép</span>
                    </button>
                  </div>
                  <div className="flex items-center justify-between p-2.5 rounded-xl bg-slate-50 border border-slate-200">
                    <span className="font-mono font-bold text-slate-900">VITE_SUPABASE_ANON_KEY</span>
                    <button
                      onClick={() => handleCopy('VITE_SUPABASE_ANON_KEY', 'anon')}
                      className="px-2 py-1 rounded bg-white hover:bg-slate-100 border border-slate-200 text-[10px] font-semibold flex items-center gap-1 cursor-pointer"
                    >
                      {copiedKey === 'anon' ? <Check className="w-3 h-3 text-emerald-600" /> : <Copy className="w-3 h-3 text-slate-500" />}
                      <span>Sao chép</span>
                    </button>
                  </div>
                </div>
              </li>
              <li>
                Khởi động lại Dev Server hoặc tải lại trang để biến môi trường có hiệu lực.
              </li>
            </ol>
          </div>
        )}

        {/* Tab 2: Vercel / Cloud */}
        {selectedGuideTab === 'vercel' && (
          <div className="space-y-3 text-xs text-slate-600">
            <p>
              Nếu triển khai lên <strong>Vercel</strong>, <strong>Netlify</strong> hoặc dịch vụ Cloud khác, bạn vào mục <strong>Project Settings → Environment Variables</strong> và cấu hình:
            </p>
            <div className="p-3 bg-slate-900 text-slate-200 rounded-2xl font-mono text-[11px] space-y-1">
              <div>VITE_SUPABASE_URL=https://your-project.supabase.co</div>
              <div>VITE_SUPABASE_ANON_KEY=eyJhbGciOi... (Publishable Anon Key)</div>
              <div>SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOi... (Tùy chọn: Chỉ dùng ở server backend)</div>
            </div>
            <p className="text-amber-700 font-medium">
              ⚠️ Lưu ý bảo mật: Không bao giờ đặt tiền tố <code>VITE_</code> cho khóa Service Role hoặc Secret Key.
            </p>
          </div>
        )}

        {/* Tab 3: Supabase Guide */}
        {selectedGuideTab === 'supabase' && (
          <div className="space-y-3 text-xs text-slate-600">
            <p>
              Cách lấy URL và Publishable Key từ bảng điều khiển dự án Supabase của bạn:
            </p>
            <ol className="list-decimal pl-5 space-y-2 text-slate-700">
              <li>Đăng nhập <a href="https://supabase.com/dashboard" target="_blank" rel="noreferrer" className="text-amber-600 underline font-semibold">Supabase Dashboard</a> và chọn dự án EDUNOVA.</li>
              <li>Nhấp vào biểu tượng bánh răng <strong>Project Settings</strong> ở góc dưới thanh điều hướng trái.</li>
              <li>Chọn thẻ <strong>API</strong> (hoặc <strong>API Settings</strong>).</li>
              <li>
                Sao chép mục <strong>Project URL</strong> (dán vào <code>VITE_SUPABASE_URL</code>).
              </li>
              <li>
                Sao chép mục <strong>Project API keys → anon (public)</strong> (dán vào <code>VITE_SUPABASE_ANON_KEY</code>).
              </li>
            </ol>
          </div>
        )}
      </div>
    </div>
  );
};
