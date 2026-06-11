import { useState, useEffect } from 'react'
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer, AreaChart, Area } from 'recharts'
import { HiHome, HiUsers, HiKey, HiCurrencyDollar, HiTrendingDown, HiExclamation, HiCash, HiChartBar } from 'react-icons/hi'
import api from '../services/api'

const monthNames = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des']
const fmt = (n) => 'Rp ' + (n || 0).toLocaleString('id-ID')

const CustomTooltip = ({ active, payload, label }) => {
  if (!active || !payload) return null
  return (
    <div style={{ background: '#1a1d28', border: '1px solid rgba(255,255,255,0.06)', borderRadius: 12, padding: '14px 18px', boxShadow: '0 8px 32px rgba(0,0,0,0.4)' }}>
      <p style={{ fontSize: 12, fontWeight: 700, marginBottom: 8, color: '#f0f2f5' }}>{label}</p>
      {payload.map((p, i) => (
        <p key={i} style={{ fontSize: 12, color: p.color, marginBottom: 2 }}>
          {p.name}: <strong>{fmt(p.value)}</strong>
        </p>
      ))}
    </div>
  )
}

export default function DashboardPage() {
  const [dashboard, setDashboard] = useState(null)
  const [chartData, setChartData] = useState([])
  const [year, setYear] = useState(new Date().getFullYear())

  useEffect(() => {
    api.get('/reports/dashboard').then(r => setDashboard(r.data))
    api.get('/reports/yearly', { params: { year } }).then(r => {
      setChartData(r.data.monthly_data.map(d => ({ ...d, name: monthNames[d.month - 1] })))
    })
  }, [year])

  if (!dashboard) return (
    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', height: '60vh', color: 'var(--text-400)' }}>
      <p>Memuat data...</p>
    </div>
  )

  return (
    <div className="fade-in">
      <div className="page-header">
        <div>
          <h2>Dashboard</h2>
          <p>Ringkasan administrasi perumahan bulan ini</p>
        </div>
        <select className="form-select" style={{ width: 'auto', minWidth: 100 }} value={year} onChange={e => setYear(e.target.value)}>
          {[2024, 2025, 2026].map(y => <option key={y} value={y}>{y}</option>)}
        </select>
      </div>

      <div className="stat-grid">
        <div className="stat-card blue">
          <div className="stat-icon"><HiHome /></div>
          <div className="stat-value">{dashboard.total_houses}</div>
          <div className="stat-label">Total Rumah</div>
        </div>
        <div className="stat-card green">
          <div className="stat-icon"><HiUsers /></div>
          <div className="stat-value">{dashboard.occupied_houses}</div>
          <div className="stat-label">Dihuni</div>
        </div>
        <div className="stat-card yellow">
          <div className="stat-icon"><HiKey /></div>
          <div className="stat-value">{dashboard.empty_houses}</div>
          <div className="stat-label">Kosong</div>
        </div>
        <div className="stat-card purple">
          <div className="stat-icon"><HiUsers /></div>
          <div className="stat-value">{dashboard.total_residents}</div>
          <div className="stat-label">Penghuni</div>
        </div>
      </div>

      <div className="stat-grid" style={{ gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))' }}>
        <div className="stat-card green">
          <div className="stat-icon"><HiCurrencyDollar /></div>
          <div className="stat-value" style={{ fontSize: 20 }}>{fmt(dashboard.monthly_income)}</div>
          <div className="stat-label">Pemasukan Bulan Ini</div>
        </div>
        <div className="stat-card red">
          <div className="stat-icon"><HiTrendingDown /></div>
          <div className="stat-value" style={{ fontSize: 20 }}>{fmt(dashboard.monthly_expense)}</div>
          <div className="stat-label">Pengeluaran Bulan Ini</div>
        </div>
        <div className="stat-card blue">
          <div className="stat-icon"><HiChartBar /></div>
          <div className="stat-value" style={{ fontSize: 20 }}>{fmt(dashboard.yearly_balance)}</div>
          <div className="stat-label">Saldo Tahun {year}</div>
        </div>
        <div className="stat-card yellow">
          <div className="stat-icon"><HiExclamation /></div>
          <div className="stat-value">{dashboard.unpaid_count}</div>
          <div className="stat-label">Belum Lunas</div>
        </div>
      </div>

      <div className="chart-card">
        <h3>Pemasukan & Pengeluaran — {year}</h3>
        <ResponsiveContainer width="100%" height={340}>
          <BarChart data={chartData} barGap={4}>
            <CartesianGrid strokeDasharray="3 3" stroke="rgba(255,255,255,0.04)" vertical={false} />
            <XAxis dataKey="name" stroke="#565d72" fontSize={12} tickLine={false} axisLine={false} />
            <YAxis stroke="#565d72" fontSize={11} tickLine={false} axisLine={false} tickFormatter={v => v >= 1e6 ? `${v/1e6}jt` : v >= 1e3 ? `${v/1e3}rb` : v} />
            <Tooltip content={<CustomTooltip />} />
            <Legend wrapperStyle={{ fontSize: 12, paddingTop: 12 }} />
            <Bar dataKey="income" name="Pemasukan" fill="#22c55e" radius={[6,6,0,0]} maxBarSize={36} />
            <Bar dataKey="expense" name="Pengeluaran" fill="#f43f5e" radius={[6,6,0,0]} maxBarSize={36} />
          </BarChart>
        </ResponsiveContainer>
      </div>

      <div className="chart-card">
        <h3>Trend Saldo — {year}</h3>
        <ResponsiveContainer width="100%" height={200}>
          <AreaChart data={chartData}>
            <defs>
              <linearGradient id="saldoGrad" x1="0" y1="0" x2="0" y2="1">
                <stop offset="5%" stopColor="#7c5cfc" stopOpacity={0.2} />
                <stop offset="95%" stopColor="#7c5cfc" stopOpacity={0} />
              </linearGradient>
            </defs>
            <CartesianGrid strokeDasharray="3 3" stroke="rgba(255,255,255,0.04)" vertical={false} />
            <XAxis dataKey="name" stroke="#565d72" fontSize={12} tickLine={false} axisLine={false} />
            <YAxis stroke="#565d72" fontSize={11} tickLine={false} axisLine={false} tickFormatter={v => v >= 1e6 ? `${v/1e6}jt` : v >= 1e3 ? `${v/1e3}rb` : v} />
            <Tooltip content={<CustomTooltip />} />
            <Area type="monotone" dataKey="balance" name="Saldo" stroke="#7c5cfc" fill="url(#saldoGrad)" strokeWidth={2.5} dot={{ fill: '#7c5cfc', r: 3, strokeWidth: 0 }} />
          </AreaChart>
        </ResponsiveContainer>
      </div>
    </div>
  )
}
