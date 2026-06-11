import { useState, useEffect } from 'react'
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer, AreaChart, Area } from 'recharts'
import api from '../services/api'

const monthNames = ['','Januari','Februari','Maret','April','Mei','Juni','Juli','Agustus','September','Oktober','November','Desember']
const shortMonths = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des']
const fmt = (n) => 'Rp ' + (n || 0).toLocaleString('id-ID')

const CustomTooltip = ({ active, payload, label }) => {
  if (!active || !payload) return null
  return (
    <div style={{ background: '#1a1d28', border: '1px solid rgba(255,255,255,0.06)', borderRadius: 12, padding: '14px 18px', boxShadow: '0 8px 32px rgba(0,0,0,0.4)' }}>
      <p style={{ fontSize: 12, fontWeight: 700, marginBottom: 8, color: '#f0f2f5' }}>{label}</p>
      {payload.map((p, i) => (
        <p key={i} style={{ fontSize: 12, color: p.color, marginBottom: 2 }}>{p.name}: <strong>{fmt(p.value)}</strong></p>
      ))}
    </div>
  )
}

export default function ReportsPage() {
  const [year, setYear] = useState(new Date().getFullYear())
  const [yearlyData, setYearlyData] = useState(null)
  const [monthDetail, setMonthDetail] = useState(null)
  const [selectedMonth, setSelectedMonth] = useState(new Date().getMonth() + 1)

  useEffect(() => { api.get('/reports/yearly', { params: { year } }).then(r => setYearlyData(r.data)) }, [year])
  useEffect(() => { api.get('/reports/monthly', { params: { month: selectedMonth, year } }).then(r => setMonthDetail(r.data)) }, [selectedMonth, year])

  const chartData = yearlyData?.monthly_data?.map(d => ({ ...d, name: shortMonths[d.month - 1] })) || []

  return (
    <div className="fade-in">
      <div className="page-header">
        <div>
          <h2>Laporan Keuangan</h2>
          <p>Ringkasan pemasukan & pengeluaran tahunan</p>
        </div>
        <select className="form-select" style={{ width: 'auto' }} value={year} onChange={e => setYear(parseInt(e.target.value))}>
          {[2024,2025,2026].map(y => <option key={y} value={y}>{y}</option>)}
        </select>
      </div>

      {yearlyData && (
        <div className="stat-grid" style={{ gridTemplateColumns: 'repeat(3, 1fr)' }}>
          <div className="stat-card green">
            <div className="stat-icon">💰</div>
            <div className="stat-value" style={{ fontSize: 22 }}>{fmt(yearlyData.total_income)}</div>
            <div className="stat-label">Total Pemasukan {year}</div>
          </div>
          <div className="stat-card red">
            <div className="stat-icon">💸</div>
            <div className="stat-value" style={{ fontSize: 22 }}>{fmt(yearlyData.total_expense)}</div>
            <div className="stat-label">Total Pengeluaran {year}</div>
          </div>
          <div className="stat-card purple">
            <div className="stat-icon">💎</div>
            <div className="stat-value" style={{ fontSize: 22 }}>{fmt(yearlyData.total_balance)}</div>
            <div className="stat-label">Saldo Akhir {year}</div>
          </div>
        </div>
      )}

      <div className="chart-card">
        <h3>Pemasukan vs Pengeluaran — {year}</h3>
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
        <ResponsiveContainer width="100%" height={220}>
          <AreaChart data={chartData}>
            <defs>
              <linearGradient id="saldoGrad2" x1="0" y1="0" x2="0" y2="1">
                <stop offset="5%" stopColor="#7c5cfc" stopOpacity={0.2} />
                <stop offset="95%" stopColor="#7c5cfc" stopOpacity={0} />
              </linearGradient>
            </defs>
            <CartesianGrid strokeDasharray="3 3" stroke="rgba(255,255,255,0.04)" vertical={false} />
            <XAxis dataKey="name" stroke="#565d72" fontSize={12} tickLine={false} axisLine={false} />
            <YAxis stroke="#565d72" fontSize={11} tickLine={false} axisLine={false} tickFormatter={v => v >= 1e6 ? `${v/1e6}jt` : v >= 1e3 ? `${v/1e3}rb` : v} />
            <Tooltip content={<CustomTooltip />} />
            <Area type="monotone" dataKey="balance" name="Saldo" stroke="#7c5cfc" fill="url(#saldoGrad2)" strokeWidth={2.5} dot={{ fill: '#7c5cfc', r: 3, strokeWidth: 0 }} />
          </AreaChart>
        </ResponsiveContainer>
      </div>

      {/* Monthly Detail Selector */}
      <div style={{ marginBottom: 12 }}>
        <h3 style={{ fontSize: 15, fontWeight: 700, marginBottom: 14, letterSpacing: '-0.2px' }}>Detail Bulanan</h3>
      </div>
      <div className="month-pills">
        {monthNames.slice(1).map((n, i) => (
          <button key={i+1} className={`btn btn-sm ${selectedMonth === i+1 ? 'btn-primary' : 'btn-secondary'}`} onClick={() => setSelectedMonth(i+1)}>
            {n.slice(0,3)}
          </button>
        ))}
      </div>

      {monthDetail && (
        <>
          <div className="stat-grid" style={{ gridTemplateColumns: 'repeat(3, 1fr)', marginBottom: 20 }}>
            <div className="stat-card green">
              <div className="stat-value" style={{ fontSize: 18 }}>{fmt(monthDetail.total_income)}</div>
              <div className="stat-label">Pemasukan {monthDetail.month_name}</div>
            </div>
            <div className="stat-card red">
              <div className="stat-value" style={{ fontSize: 18 }}>{fmt(monthDetail.total_expense)}</div>
              <div className="stat-label">Pengeluaran {monthDetail.month_name}</div>
            </div>
            <div className="stat-card purple">
              <div className="stat-value" style={{ fontSize: 18 }}>{fmt(monthDetail.balance)}</div>
              <div className="stat-label">Saldo {monthDetail.month_name}</div>
            </div>
          </div>

          <div className="two-col">
            <div className="table-container">
              <div className="table-header"><h3>Pemasukan — {monthDetail.month_name}</h3></div>
              <table>
                <thead><tr><th>Rumah</th><th>Penghuni</th><th>Jenis</th><th>Jumlah</th><th>Status</th></tr></thead>
                <tbody>
                  {monthDetail.payments?.map(p => (
                    <tr key={p.id}>
                      <td style={{ fontWeight: 600, color: 'var(--text-100)' }}>{p.house_number}</td>
                      <td>{p.resident_name}</td>
                      <td><span className={`badge ${p.payment_type === 'satpam' ? 'purple' : 'blue'}`}>{p.payment_type}</span></td>
                      <td>{fmt(p.amount)}</td>
                      <td><span className={`badge ${p.status === 'lunas' ? 'green' : 'red'}`}>{p.status}</span></td>
                    </tr>
                  ))}
                </tbody>
              </table>
              {(!monthDetail.payments || monthDetail.payments.length === 0) && <div className="empty-state"><p>Tidak ada data</p></div>}
            </div>

            <div className="table-container">
              <div className="table-header"><h3>Pengeluaran — {monthDetail.month_name}</h3></div>
              <table>
                <thead><tr><th>Judul</th><th>Kategori</th><th>Jumlah</th></tr></thead>
                <tbody>
                  {monthDetail.expenses?.map(e => (
                    <tr key={e.id}>
                      <td style={{ fontWeight: 600, color: 'var(--text-100)' }}>{e.title}</td>
                      <td><span className="badge purple">{e.category}</span></td>
                      <td style={{ fontWeight: 600, color: 'var(--danger)' }}>{fmt(e.amount)}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
              {(!monthDetail.expenses || monthDetail.expenses.length === 0) && <div className="empty-state"><p>Tidak ada data</p></div>}
            </div>
          </div>
        </>
      )}
    </div>
  )
}
