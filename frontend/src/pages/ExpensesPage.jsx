import { useState, useEffect } from 'react'
import { HiPlus, HiPencil, HiTrash } from 'react-icons/hi'
import toast from 'react-hot-toast'
import api from '../services/api'

const categories = { gaji_satpam: 'Gaji Satpam', listrik_pos: 'Listrik Pos', perbaikan_jalan: 'Perbaikan Jalan', perbaikan_selokan: 'Perbaikan Selokan', lainnya: 'Lainnya' }
const catColors = { gaji_satpam: 'purple', listrik_pos: 'yellow', perbaikan_jalan: 'blue', perbaikan_selokan: 'green', lainnya: 'gray' }
const monthNames = ['','Januari','Februari','Maret','April','Mei','Juni','Juli','Agustus','September','Oktober','November','Desember']
const fmt = (n) => 'Rp ' + (n || 0).toLocaleString('id-ID')

export default function ExpensesPage() {
  const [expenses, setExpenses] = useState([])
  const [showModal, setShowModal] = useState(false)
  const [editing, setEditing] = useState(null)
  const [month, setMonth] = useState('')
  const [year, setYear] = useState(new Date().getFullYear())
  const [form, setForm] = useState({ title: '', description: '', amount: '', month: new Date().getMonth() + 1, year: new Date().getFullYear(), category: 'lainnya', expense_date: new Date().toISOString().split('T')[0] })

  const load = () => {
    const p = { year }
    if (month) p.month = month
    api.get('/expenses', { params: p }).then(r => setExpenses(r.data))
  }

  useEffect(() => { load() }, [month, year])

  const openAdd = () => {
    setEditing(null)
    setForm({ title: '', description: '', amount: '', month: new Date().getMonth() + 1, year: new Date().getFullYear(), category: 'lainnya', expense_date: new Date().toISOString().split('T')[0] })
    setShowModal(true)
  }

  const openEdit = (e) => {
    setEditing(e)
    setForm({ title: e.title, description: e.description || '', amount: e.amount, month: e.month, year: e.year, category: e.category, expense_date: e.expense_date?.split('T')[0] })
    setShowModal(true)
  }

  const handleSubmit = async (ev) => {
    ev.preventDefault()
    try {
      if (editing) {
        await api.put(`/expenses/${editing.id}`, { ...form, amount: parseInt(form.amount) })
        toast.success('Pengeluaran diperbarui')
      } else {
        await api.post('/expenses', { ...form, amount: parseInt(form.amount) })
        toast.success('Pengeluaran ditambahkan')
      }
      setShowModal(false)
      load()
    } catch (err) {
      toast.error(err.response?.data?.message || 'Gagal')
    }
  }

  const handleDelete = async (id) => {
    if (!confirm('Hapus pengeluaran ini?')) return
    try {
      await api.delete(`/expenses/${id}`)
      toast.success('Dihapus')
      load()
    } catch {
      toast.error('Gagal')
    }
  }

  const total = expenses.reduce((s, e) => s + e.amount, 0)

  return (
    <div className="fade-in">
      <div className="page-header">
        <div>
          <h2>Pengeluaran</h2>
          <p>Kelola pengeluaran RT perumahan</p>
        </div>
        <button className="btn btn-primary" onClick={openAdd}><HiPlus /> Tambah</button>
      </div>

      <div className="filter-bar">
        <select className="form-select" value={month} onChange={e => setMonth(e.target.value)}>
          <option value="">Semua Bulan</option>
          {monthNames.slice(1).map((n, i) => <option key={i+1} value={i+1}>{n}</option>)}
        </select>
        <select className="form-select" value={year} onChange={e => setYear(e.target.value)}>
          {[2024,2025,2026].map(y => <option key={y} value={y}>{y}</option>)}
        </select>
        <div className="total-bar">Total: {fmt(total)}</div>
      </div>

      <div className="table-container">
        <table>
          <thead><tr><th>Tanggal</th><th>Judul</th><th>Kategori</th><th>Periode</th><th>Jumlah</th><th style={{ width: 100 }}>Aksi</th></tr></thead>
          <tbody>
            {expenses.map(e => (
              <tr key={e.id}>
                <td>{e.expense_date?.split('T')[0]}</td>
                <td>
                  <div style={{ fontWeight: 600, color: 'var(--text-100)' }}>{e.title}</div>
                  {e.description && <div style={{ fontSize: 12, color: 'var(--text-400)', marginTop: 3 }}>{e.description}</div>}
                </td>
                <td><span className={`badge ${catColors[e.category]}`}>{categories[e.category]}</span></td>
                <td>{monthNames[e.month]} {e.year}</td>
                <td style={{ fontWeight: 700, color: 'var(--danger)' }}>{fmt(e.amount)}</td>
                <td>
                  <div style={{ display: 'flex', gap: 4 }}>
                    <button className="btn btn-secondary btn-sm" onClick={() => openEdit(e)}><HiPencil /></button>
                    <button className="btn btn-danger btn-sm" onClick={() => handleDelete(e.id)}><HiTrash /></button>
                  </div>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        {expenses.length === 0 && <div className="empty-state"><p>Tidak ada pengeluaran</p></div>}
      </div>

      {showModal && (
        <div className="modal-overlay" onClick={() => setShowModal(false)}>
          <div className="modal" onClick={ev => ev.stopPropagation()}>
            <div className="modal-header">
              <h3>{editing ? 'Edit Pengeluaran' : 'Tambah Pengeluaran'}</h3>
              <button className="modal-close" onClick={() => setShowModal(false)}>✕</button>
            </div>
            <form onSubmit={handleSubmit}>
              <div className="modal-body">
                <div className="form-group">
                  <label className="form-label">Judul</label>
                  <input className="form-input" value={form.title} onChange={e => setForm({...form, title: e.target.value})} placeholder="contoh: Gaji Satpam" required />
                </div>
                <div className="form-group">
                  <label className="form-label">Deskripsi (opsional)</label>
                  <input className="form-input" value={form.description} onChange={e => setForm({...form, description: e.target.value})} placeholder="Keterangan tambahan" />
                </div>
                <div className="form-row">
                  <div className="form-group">
                    <label className="form-label">Jumlah (Rp)</label>
                    <input type="number" className="form-input" value={form.amount} onChange={e => setForm({...form, amount: e.target.value})} placeholder="0" required />
                  </div>
                  <div className="form-group">
                    <label className="form-label">Kategori</label>
                    <select className="form-select" value={form.category} onChange={e => setForm({...form, category: e.target.value})}>
                      {Object.entries(categories).map(([k,v]) => <option key={k} value={k}>{v}</option>)}
                    </select>
                  </div>
                </div>
                <div className="form-row">
                  <div className="form-group">
                    <label className="form-label">Bulan</label>
                    <select className="form-select" value={form.month} onChange={e => setForm({...form, month: parseInt(e.target.value)})}>
                      {monthNames.slice(1).map((n,i) => <option key={i+1} value={i+1}>{n}</option>)}
                    </select>
                  </div>
                  <div className="form-group">
                    <label className="form-label">Tanggal</label>
                    <input type="date" className="form-input" value={form.expense_date} onChange={e => setForm({...form, expense_date: e.target.value})} required />
                  </div>
                </div>
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
