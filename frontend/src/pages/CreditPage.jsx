import { HiCode, HiCheckCircle } from 'react-icons/hi'

export default function CreditPage() {
  return (
    <div className="fade-in">
      <div className="page-header">
        <div>
          <h2>Kredit & Pengembang</h2>
          <p>Informasi tentang pengembang aplikasi Sistem Administrasi RT</p>
        </div>
      </div>

      <div style={{ maxWidth: 600, margin: '0 auto', marginTop: 40 }}>
        <div className="chart-card" style={{ textAlign: 'center', padding: '40px 20px' }}>
          <div style={{ 
            width: 80, 
            height: 80, 
            background: 'var(--accent)', 
            borderRadius: '50%', 
            display: 'flex', 
            alignItems: 'center', 
            justifyContent: 'center', 
            margin: '0 auto 20px',
            fontSize: 32,
            color: 'white',
            boxShadow: '0 0 20px rgba(124, 92, 252, 0.4)'
          }}>
            <HiCode />
          </div>
          <h2 style={{ fontSize: 24, marginBottom: 8 }}>Adryan Maha Putra</h2>
          <p style={{ color: 'var(--accent)', fontWeight: 600, fontSize: 16, marginBottom: 20 }}>Fullstack Developer</p>
          
          <div style={{ background: 'rgba(255,255,255,0.03)', padding: 20, borderRadius: 12, textAlign: 'left', marginBottom: 24 }}>
            <h4 style={{ fontSize: 14, color: 'var(--text-400)', marginBottom: 12, textTransform: 'uppercase', letterSpacing: 1 }}>Tech Stack</h4>
            <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                <HiCheckCircle style={{ color: 'var(--green)', fontSize: 18 }} />
                <span><strong style={{ color: 'var(--text-100)' }}>Backend:</strong> Laravel 12, MySQL, Sanctum</span>
              </div>
              <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                <HiCheckCircle style={{ color: 'var(--green)', fontSize: 18 }} />
                <span><strong style={{ color: 'var(--text-100)' }}>Frontend:</strong> React 18, Vite, Recharts</span>
              </div>
              <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                <HiCheckCircle style={{ color: 'var(--green)', fontSize: 18 }} />
                <span><strong style={{ color: 'var(--text-100)' }}>Desain:</strong> Modern Dark UI, Glassmorphism</span>
              </div>
            </div>
          </div>

          <p style={{ color: 'var(--text-400)', fontSize: 14, lineHeight: 1.6 }}>
            Aplikasi ini dikembangkan untuk mempermudah dan mendigitalisasi pengelolaan administrasi RT, mencakup data warga, iuran, dan laporan kas secara efisien.
          </p>
        </div>
      </div>
    </div>
  )
}
