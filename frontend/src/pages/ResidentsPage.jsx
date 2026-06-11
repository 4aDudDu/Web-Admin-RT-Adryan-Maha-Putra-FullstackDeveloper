import { useState, useEffect } from 'react'
import { HiPlus, HiPencil, HiPhone, HiSearch, HiTrash } from 'react-icons/hi'
import toast from 'react-hot-toast'
import api from '../services/api'

export default function ResidentsPage() {
  const [residents, setResidents] = useState([])
  const [showModal, setShowModal] = useState(false)
  const [editing, setEditing] = useState(null)
  const [search, setSearch] = useState('')
  const [form, setForm] = useState({ full_name: '', status: 'tetap', phone_number: '', is_married: false })
  const [ktpFile, setKtpFile] = useState(null)

  const load = () => api.get('/residents', { params: { search } }).then(r => setResidents(r.data))
  useEffect(() => { load() }, [search])

  const openAdd = () => {
    setEditing(null)
    setForm({ full_name: '', status: 'tetap', phone_number: '', is_married: false })
    setKtpFile(null)
    setShowModal(true)
  }

  const openEdit = (r) => {
    setEditing(r)
    setForm({ full_name: r.full_name, status: r.status, phone_number: r.phone_number, is_married: r.is_married })
    setKtpFile(null)
    setShowModal(true)
  }

  const handleSubmit = async (e) => {
    e.preventDefault()
    const fd = new FormData()
    fd.append('full_name', form.full_name)
    fd.append('status', form.status)
    fd.append('phone_number', form.phone_number)
    fd.append('is_married', form.is_married ? '1' : '0')
    if (ktpFile) fd.append('ktp_photo', ktpFile)
    try {
      if (editing) {
        await api.post(`/residents/${editing.id}`, fd, { headers: { 'Content-Type': 'multipart/form-data' } })
        toast.success('Data penghuni diperbarui')
      } else {
        await api.post('/residents', fd, { headers: { 'Content-Type': 'multipart/form-data' } })
        toast.success('Penghuni baru ditambahkan')
      }
      setShowModal(false)
      load()
    } catch (err) {
      toast.error(err.response?.data?.message || 'Gagal menyimpan data')
    }
  }

  const handleDeleteKtp = async (resident) => {
    if (!confirm(`Hapus foto KTP ${resident.full_name}?`)) return
    try {
      await api.delete(`/residents/${resident.id}/delete-ktp`)
      toast.success('Foto KTP dihapus')
      load()
    } catch {
      toast.error('Gagal menghapus foto')
    }
  }

  return (
    <div className="fade-in">
      <div className="page-header">
        <div>
          <h2>Data Penghuni</h2>
          <p>Kelola data penghuni perumahan — {residents.length} orang terdaftar</p>
        </div>
        <button className="btn btn-primary" onClick={openAdd}><HiPlus /> Tambah</button>
      </div>

      <div className="filter-bar">
        <div style={{ position: 'relative', flex: 1, maxWidth: 340 }}>
          <HiSearch style={{ position: 'absolute', left: 14, top: 13, color: 'var(--text-400)', fontSize: 16 }} />
          <input className="form-input" style={{ paddingLeft: 40 }} placeholder="Cari berdasarkan nama..." value={search} onChange={e => setSearch(e.target.value)} />
        </div>
      </div>

      <div className="table-container">
        <table>
          <thead>
            <tr>
              <th>Nama Lengkap</th>
              <th>Status</th>
              <th>No. Telepon</th>
              <th>Pernikahan</th>
              <th>KTP</th>
              <th style={{ width: 100 }}>Aksi</th>
            </tr>
          </thead>
          <tbody>
            {residents.map(r => (
              <tr key={r.id}>
                <td><span style={{ fontWeight: 600, color: 'var(--text-100)' }}>{r.full_name}</span></td>
                <td><span className={`badge ${r.status === 'tetap' ? 'green' : 'yellow'}`}>{r.status === 'tetap' ? 'Tetap' : 'Kontrak'}</span></td>
                <td style={{ fontSize: 13 }}><HiPhone style={{ marginRight: 6, verticalAlign: 'middle', opacity: 0.5 }} />{r.phone_number}</td>
                <td><span className={`badge ${r.is_married ? 'blue' : 'gray'}`}>{r.is_married ? 'Menikah' : 'Belum'}</span></td>
                <td>
                  {r.ktp_photo ? (
                    <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                      <img src={`/storage/${r.ktp_photo}`} alt="KTP" className="ktp-preview" />
                      <button className="btn btn-danger btn-sm" onClick={() => handleDeleteKtp(r)} title="Hapus foto KTP"><HiTrash /></button>
                    </div>
                  ) : (
                    <span className="badge gray">Belum upload</span>
                  )}
                </td>
                <td><button className="btn btn-secondary btn-sm" onClick={() => openEdit(r)}><HiPencil /> Edit</button></td>
              </tr>
            ))}
          </tbody>
        </table>
        {residents.length === 0 && (
          <div className="empty-state">
            <p>Belum ada data penghuni</p>
          </div>
        )}
      </div>

      {showModal && (
        <div className="modal-overlay" onClick={() => setShowModal(false)}>
          <div className="modal" onClick={e => e.stopPropagation()}>
            <div className="modal-header">
              <h3>{editing ? 'Edit Penghuni' : 'Tambah Penghuni Baru'}</h3>
              <button className="modal-close" onClick={() => setShowModal(false)}>✕</button>
            </div>
            <form onSubmit={handleSubmit}>
              <div className="modal-body">
                <div className="form-group">
                  <label className="form-label">Nama Lengkap</label>
                  <input className="form-input" value={form.full_name} onChange={e => setForm({...form, full_name: e.target.value})} placeholder="Masukkan nama lengkap" required />
                </div>
                <div className="form-row">
                  <div className="form-group">
                    <label className="form-label">Status Penghuni</label>
                    <select className="form-select" value={form.status} onChange={e => setForm({...form, status: e.target.value})}>
                      <option value="tetap">Tetap</option>
                      <option value="kontrak">Kontrak</option>
                    </select>
                  </div>
                  <div className="form-group">
                    <label className="form-label">No. Telepon</label>
                    <input className="form-input" value={form.phone_number} onChange={e => setForm({...form, phone_number: e.target.value})} placeholder="08xx" required />
                  </div>
                </div>
                <div className="form-group">
                  <label className="form-label">Status Pernikahan</label>
                  <div className="toggle-wrapper" onClick={() => setForm({...form, is_married: !form.is_married})}>
                    <div className={`toggle ${form.is_married ? 'active' : ''}`}></div>
                    <span style={{ fontSize: 13.5, color: 'var(--text-200)' }}>{form.is_married ? 'Sudah Menikah' : 'Belum Menikah'}</span>
                  </div>
                </div>
                <div className="form-group">
                  <label className="form-label">Foto KTP</label>
                  <div className="ktp-upload" onClick={() => document.getElementById('ktp-input').click()}>
                    <input id="ktp-input" type="file" accept="image/*" onChange={e => setKtpFile(e.target.files[0])} />
                    {ktpFile
                      ? <p style={{ color: 'var(--accent)', fontWeight: 600, fontSize: 13 }}>{ktpFile.name}</p>
                      : <p style={{ color: 'var(--text-400)', fontSize: 13 }}>Klik untuk upload foto KTP (JPG/PNG)</p>
                    }
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
