import { useState, useEffect } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { HiArrowLeft, HiUserAdd, HiUserRemove } from 'react-icons/hi'
import toast from 'react-hot-toast'
import api from '../services/api'

const fmt = (n) => 'Rp ' + (n || 0).toLocaleString('id-ID')
const monthNames = ['','Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des']

export default function HouseDetailPage() {
  const { id } = useParams()
  const navigate = useNavigate()
  const [house, setHouse] = useState(null)
  const [history, setHistory] = useState([])
  const [payments, setPayments] = useState([])
  const [residents, setResidents] = useState([])
  const [showAssign, setShowAssign] = useState(false)
  const [assignForm, setAssignForm] = useState({ resident_id: '', start_date: new Date().toISOString().split('T')[0] })
  const [payYear, setPayYear] = useState(new Date().getFullYear())

  const load = () => {
    api.get(`/houses/${id}`).then(r => setHouse(r.data))
    api.get(`/houses/${id}/history`).then(r => setHistory(r.data))
    api.get(`/houses/${id}/payments`, { params: { year: payYear } }).then(r => setPayments(r.data))
  }

  useEffect(() => { load(); api.get('/residents').then(r => setResidents(r.data)) }, [id])
  useEffect(() => { api.get(`/houses/${id}/payments`, { params: { year: payYear } }).then(r => setPayments(r.data)) }, [payYear])

  const handleAssign = async (e) => {
    e.preventDefault()
    try {
      await api.post(`/houses/${id}/assign-resident`, assignForm)
      toast.success('Penghuni berhasil ditambahkan')
      setShowAssign(false)
      load()
    } catch (err) {
      toast.error(err.response?.data?.message || 'Gagal')
    }
  }

  const handleRemove = async () => {
    if (!confirm('Yakin ingin mengeluarkan penghuni dari rumah ini?')) return
    try {
      await api.post(`/houses/${id}/remove-resident`)
      toast.success('Penghuni berhasil dikeluarkan')
      load()
    } catch {
      toast.error('Gagal')
    }
  }

  if (!house) return <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', height: '60vh', color: 'var(--text-400)' }}>Memuat...</div>

  return (
    <div className="fade-in">
      <div className="page-header">
        <div className="detail-header">
          <button className="back-btn" onClick={() => navigate('/houses')}><HiArrowLeft /></button>
          <div>
            <h2>Rumah {house.house_number}</h2>
            <p>{house.address}</p>
          </div>
        </div>
        <div style={{ display: 'flex', gap: 8 }}>
          <button className="btn btn-primary" onClick={() => setShowAssign(true)}><HiUserAdd /> Assign</button>
          {house.occupancy_status === 'dihuni' && (
            <button className="btn btn-danger" onClick={handleRemove}><HiUserRemove /> Keluarkan</button>
          )}
        </div>
      </div>

      <div className="stat-grid" style={{ gridTemplateColumns: '1fr 1fr' }}>
        <div className={`stat-card ${house.occupancy_status === 'dihuni' ? 'green' : 'yellow'}`}>
          <div className="stat-value" style={{ fontSize: 18 }}>{house.occupancy_status === 'dihuni' ? 'Dihuni' : 'Kosong'}</div>
          <div className="stat-label">Status Rumah</div>
        </div>
        <div className="stat-card purple">
          <div className="stat-value" style={{ fontSize: 18 }}>{house.current_resident?.resident?.full_name || '—'}</div>
          <div className="stat-label">Penghuni Saat Ini</div>
        </div>
      </div>

      <div className="table-container" style={{ marginBottom: 24 }}>
        <div className="table-header"><h3>Riwayat Penghuni</h3></div>
        <table>
          <thead><tr><th>Nama</th><th>Status</th><th>Masuk</th><th>Keluar</th><th>Aktif</th></tr></thead>
          <tbody>
            {history.map(h => (
              <tr key={h.id}>
                <td style={{ fontWeight: 600, color: 'var(--text-100)' }}>{h.resident?.full_name}</td>
                <td><span className={`badge ${h.resident?.status === 'tetap' ? 'green' : 'yellow'}`}>{h.resident?.status}</span></td>
                <td>{h.start_date?.split('T')[0]}</td>
                <td>{h.end_date?.split('T')[0] || '—'}</td>
                <td><span className={`badge ${h.is_active ? 'green' : 'gray'}`}>{h.is_active ? 'Aktif' : 'Tidak'}</span></td>
              </tr>
            ))}
          </tbody>
        </table>
        {history.length === 0 && <div className="empty-state"><p>Belum ada riwayat</p></div>}
      </div>

      <div className="table-container">
        <div className="table-header">
          <h3>Riwayat Pembayaran</h3>
          <select className="form-select" style={{ width: 'auto' }} value={payYear} onChange={e => setPayYear(e.target.value)}>
            {[2024,2025,2026].map(y => <option key={y} value={y}>{y}</option>)}
          </select>
        </div>
        <table>
          <thead><tr><th>Penghuni</th><th>Jenis</th><th>Bulan</th><th>Jumlah</th><th>Status</th><th>Tgl Bayar</th></tr></thead>
          <tbody>
            {payments.map(p => (
              <tr key={p.id}>
                <td>{p.resident_name}</td>
                <td><span className={`badge ${p.payment_type === 'satpam' ? 'purple' : 'blue'}`}>{p.payment_type === 'satpam' ? 'Satpam' : 'Kebersihan'}</span></td>
                <td>{monthNames[p.month]} {p.year}</td>
                <td style={{ fontWeight: 600 }}>{fmt(p.amount)}</td>
                <td><span className={`badge ${p.status === 'lunas' ? 'green' : 'red'}`}>{p.status === 'lunas' ? 'Lunas' : 'Belum'}</span></td>
                <td>{p.payment_date?.split('T')[0] || '—'}</td>
              </tr>
            ))}
          </tbody>
        </table>
        {payments.length === 0 && <div className="empty-state"><p>Belum ada pembayaran</p></div>}
      </div>

      {showAssign && (
        <div className="modal-overlay" onClick={() => setShowAssign(false)}>
          <div className="modal" onClick={e => e.stopPropagation()}>
            <div className="modal-header">
              <h3>Assign Penghuni ke {house.house_number}</h3>
              <button className="modal-close" onClick={() => setShowAssign(false)}>✕</button>
            </div>
            <form onSubmit={handleAssign}>
              <div className="modal-body">
                <div className="form-group">
                  <label className="form-label">Pilih Penghuni</label>
                  <select className="form-select" value={assignForm.resident_id} onChange={e => setAssignForm({...assignForm, resident_id: e.target.value})} required>
                    <option value="">— Pilih penghuni —</option>
                    {residents.map(r => <option key={r.id} value={r.id}>{r.full_name} ({r.status})</option>)}
                  </select>
                </div>
                <div className="form-group">
                  <label className="form-label">Tanggal Mulai</label>
                  <input type="date" className="form-input" value={assignForm.start_date} onChange={e => setAssignForm({...assignForm, start_date: e.target.value})} required />
                </div>
              </div>
              <div className="modal-footer">
                <button type="button" className="btn btn-secondary" onClick={() => setShowAssign(false)}>Batal</button>
                <button type="submit" className="btn btn-primary">Simpan</button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  )
}
