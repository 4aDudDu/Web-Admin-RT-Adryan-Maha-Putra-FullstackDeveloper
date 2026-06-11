import { useState, useEffect } from 'react'
import { HiPlus } from 'react-icons/hi'
import toast from 'react-hot-toast'
import api from '../services/api'

const monthNames = ['','Januari','Februari','Maret','April','Mei','Juni','Juli','Agustus','September','Oktober','November','Desember']
const fmt = (n) => 'Rp ' + (n || 0).toLocaleString('id-ID')

export default function PaymentsPage() {
  const [payments, setPayments] = useState([])
  const [showModal, setShowModal] = useState(false)
  const [bulkMode, setBulkMode] = useState(false)
  const [houses, setHouses] = useState([])
  const [month, setMonth] = useState(new Date().getMonth() + 1)
  const [year, setYear] = useState(new Date().getFullYear())
  const [filterType, setFilterType] = useState('')
  const [form, setForm] = useState({ house_resident_id: '', payment_type: 'satpam', month: new Date().getMonth() + 1, year: new Date().getFullYear(), status: 'lunas' })
  const [bulkMonths, setBulkMonths] = useState([])

  const load = () => {
    const params = { year }
    if (month) params.month = month
    if (filterType) params.payment_type = filterType
    api.get('/payments', { params }).then(r => setPayments(r.data))
  }

  useEffect(() => { load() }, [month, year, filterType])
  useEffect(() => { api.get('/houses').then(r => setHouses(r.data)) }, [])

  const getActiveResidents = () => houses.filter(h => h.current_resident).map(h => ({ id: h.current_resident.id, label: `${h.house_number} — ${h.current_resident.resident.full_name}` }))

  const handleSubmit = async (e) => {
    e.preventDefault()
    try {
      if (bulkMode) {
        if (bulkMonths.length === 0) return toast.error('Pilih minimal 1 bulan')
        await api.post('/payments/bulk', { house_resident_id: form.house_resident_id, payment_type: form.payment_type, year: form.year, months: bulkMonths, status: form.status })
        toast.success(`${bulkMonths.length} bulan berhasil disimpan`)
      } else {
        await api.post('/payments', form)
        toast.success('Pembayaran berhasil disimpan')
      }
      setShowModal(false)
      load()
    } catch (err) {
      toast.error(err.response?.data?.message || 'Gagal menyimpan')
    }
  }

  const toggleMonth = (m) => setBulkMonths(prev => prev.includes(m) ? prev.filter(x => x !== m) : [...prev, m])

  return (
    <div className="fade-in">
      <div className="page-header">
        <div>
          <h2>Pembayaran Iuran</h2>
          <p>Kelola iuran Satpam (Rp 100.000) & Kebersihan (Rp 15.000)</p>
        </div>
        <button className="btn btn-primary" onClick={() => { setShowModal(true); setBulkMode(false); setBulkMonths([]) }}><HiPlus /> Tambah</button>
      </div>

      <div className="filter-bar">
        <select className="form-select" value={month} onChange={e => setMonth(e.target.value)}>
          <option value="">Semua Bulan</option>
          {monthNames.slice(1).map((n, i) => <option key={i+1} value={i+1}>{n}</option>)}
        </select>
        <select className="form-select" value={year} onChange={e => setYear(e.target.value)}>
          {[2024,2025,2026].map(y => <option key={y} value={y}>{y}</option>)}
        </select>
        <select className="form-select" value={filterType} onChange={e => setFilterType(e.target.value)}>
          <option value="">Semua Jenis</option>
          <option value="satpam">Satpam</option>
          <option value="kebersihan">Kebersihan</option>
        </select>
      </div>

      <div className="table-container">
        <table>
          <thead><tr><th>Rumah</th><th>Penghuni</th><th>Jenis</th><th>Periode</th><th>Jumlah</th><th>Status</th><th>Tgl Bayar</th></tr></thead>
          <tbody>
            {payments.map(p => (
              <tr key={p.id}>
                <td style={{ fontWeight: 600, color: 'var(--text-100)' }}>{p.house_resident?.house?.house_number}</td>
                <td>{p.house_resident?.resident?.full_name}</td>
                <td><span className={`badge ${p.payment_type === 'satpam' ? 'purple' : 'blue'}`}>{p.payment_type === 'satpam' ? 'Satpam' : 'Kebersihan'}</span></td>
                <td>{monthNames[p.month]} {p.year}</td>
                <td style={{ fontWeight: 600 }}>{fmt(p.amount)}</td>
                <td><span className={`badge ${p.status === 'lunas' ? 'green' : 'red'}`}>{p.status === 'lunas' ? 'Lunas' : 'Belum'}</span></td>
                <td>{p.payment_date?.split('T')[0] || '—'}</td>
              </tr>
            ))}
          </tbody>
        </table>
        {payments.length === 0 && <div className="empty-state"><p>Tidak ada data pembayaran</p></div>}
      </div>

      {showModal && (
        <div className="modal-overlay" onClick={() => setShowModal(false)}>
          <div className="modal" onClick={e => e.stopPropagation()}>
            <div className="modal-header">
              <h3>Tambah Pembayaran</h3>
              <button className="modal-close" onClick={() => setShowModal(false)}>✕</button>
            </div>
            <form onSubmit={handleSubmit}>
              <div className="modal-body">
                <div className="form-group">
                  <label className="form-label">Rumah / Penghuni</label>
                  <select className="form-select" value={form.house_resident_id} onChange={e => setForm({...form, house_resident_id: e.target.value})} required>
                    <option value="">— Pilih —</option>
                    {getActiveResidents().map(r => <option key={r.id} value={r.id}>{r.label}</option>)}
                  </select>
                </div>
                <div className="form-row">
                  <div className="form-group">
                    <label className="form-label">Jenis Iuran</label>
                    <select className="form-select" value={form.payment_type} onChange={e => setForm({...form, payment_type: e.target.value})}>
                      <option value="satpam">Satpam — Rp 100.000</option>
                      <option value="kebersihan">Kebersihan — Rp 15.000</option>
                    </select>
                  </div>
                  <div className="form-group">
                    <label className="form-label">Status</label>
                    <select className="form-select" value={form.status} onChange={e => setForm({...form, status: e.target.value})}>
                      <option value="lunas">Lunas</option>
                      <option value="belum_lunas">Belum Lunas</option>
                    </select>
                  </div>
                </div>

                <div className="form-group" style={{ display: 'flex', justifyContent: 'flex-end' }}>
                  <button type="button" className="btn btn-sm btn-secondary" onClick={() => { setBulkMode(!bulkMode); setBulkMonths([]) }}>
                    {bulkMode ? 'Per Bulan' : 'Bayar Multi-Bulan'}
                  </button>
                </div>

                {bulkMode ? (
                  <>
                    <div className="form-group">
                      <label className="form-label">Tahun</label>
                      <select className="form-select" value={form.year} onChange={e => setForm({...form, year: parseInt(e.target.value)})}>
                        {[2024,2025,2026].map(y => <option key={y} value={y}>{y}</option>)}
                      </select>
                    </div>
                    <div className="form-group">
                      <label className="form-label">Pilih Bulan <span style={{ color: 'var(--accent)' }}>({bulkMonths.length} dipilih)</span></label>
                      <div className="month-grid">
                        {monthNames.slice(1).map((n, i) => (
                          <button type="button" key={i+1} className={`btn btn-sm ${bulkMonths.includes(i+1) ? 'btn-primary' : 'btn-secondary'}`} onClick={() => toggleMonth(i+1)}>{n.slice(0,3)}</button>
                        ))}
                      </div>
                      <div style={{ marginTop: 10, display: 'flex', gap: 8 }}>
                        <button type="button" className="btn btn-secondary btn-sm" onClick={() => setBulkMonths([1,2,3,4,5,6,7,8,9,10,11,12])}>1 Tahun Penuh</button>
                        <button type="button" className="btn btn-secondary btn-sm" onClick={() => setBulkMonths([])}>Reset</button>
                      </div>
                    </div>
                  </>
                ) : (
                  <div className="form-row">
                    <div className="form-group">
                      <label className="form-label">Bulan</label>
                      <select className="form-select" value={form.month} onChange={e => setForm({...form, month: parseInt(e.target.value)})}>
                        {monthNames.slice(1).map((n, i) => <option key={i+1} value={i+1}>{n}</option>)}
                      </select>
                    </div>
                    <div className="form-group">
                      <label className="form-label">Tahun</label>
                      <select className="form-select" value={form.year} onChange={e => setForm({...form, year: parseInt(e.target.value)})}>
                        {[2024,2025,2026].map(y => <option key={y} value={y}>{y}</option>)}
                      </select>
                    </div>
                  </div>
                )}
              </div>
              <div className="modal-footer">
                <button type="button" className="btn btn-secondary" onClick={() => setShowModal(false)}>Batal</button>
                <button type="submit" className="btn btn-primary">Simpan</button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  )
}
