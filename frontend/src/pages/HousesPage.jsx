import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { HiPlus, HiArrowRight } from 'react-icons/hi'
import toast from 'react-hot-toast'
import api from '../services/api'

export default function HousesPage() {
  const [houses, setHouses] = useState([])
  const [showModal, setShowModal] = useState(false)
  const [form, setForm] = useState({ house_number: '', address: '' })
  const navigate = useNavigate()

  const load = () => api.get('/houses').then(r => setHouses(r.data))
  useEffect(() => { load() }, [])

  const occupied = houses.filter(h => h.occupancy_status === 'dihuni').length

  const handleSubmit = async (e) => {
    e.preventDefault()
    try {
      await api.post('/houses', form)
      toast.success('Rumah baru ditambahkan')
      setShowModal(false)
      setForm({ house_number: '', address: '' })
      load()
    } catch (err) {
      toast.error(err.response?.data?.message || 'Gagal menyimpan')
    }
  }

  return (
    <div className="fade-in">
      <div className="page-header">
        <div>
          <h2>Data Rumah</h2>
          <p>{houses.length} rumah — {occupied} dihuni, {houses.length - occupied} kosong</p>
        </div>
        <button className="btn btn-primary" onClick={() => setShowModal(true)}><HiPlus /> Tambah</button>
      </div>

      <div className="house-grid">
        {houses.map(h => (
          <div key={h.id} className="house-card" onClick={() => navigate(`/houses/${h.id}`)}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: 4 }}>
              <div className="house-number">{h.house_number}</div>
              <span className={`badge ${h.occupancy_status === 'dihuni' ? 'green' : 'gray'}`}>
                {h.occupancy_status === 'dihuni' ? 'Dihuni' : 'Kosong'}
              </span>
            </div>
            <div className="house-address">{h.address || '—'}</div>
            {h.current_resident?.resident ? (
              <div className="resident-info">
                <span style={{ color: 'var(--text-400)' }}>Penghuni: </span>
                <span style={{ fontWeight: 600, color: 'var(--accent)' }}>{h.current_resident.resident.full_name}</span>
              </div>
            ) : (
              <div className="resident-info" style={{ background: 'rgba(86,93,114,0.08)' }}>
                <span style={{ color: 'var(--text-400)' }}>Belum ada penghuni</span>
              </div>
            )}
            <div style={{ marginTop: 14, display: 'flex', justifyContent: 'flex-end' }}>
              <span style={{ fontSize: 12, color: 'var(--text-400)', display: 'flex', alignItems: 'center', gap: 4 }}>
                Lihat Detail <HiArrowRight />
              </span>
            </div>
          </div>
        ))}
      </div>

      {showModal && (
        <div className="modal-overlay" onClick={() => setShowModal(false)}>
          <div className="modal" onClick={e => e.stopPropagation()}>
            <div className="modal-header">
              <h3>Tambah Rumah Baru</h3>
              <button className="modal-close" onClick={() => setShowModal(false)}>✕</button>
            </div>
            <form onSubmit={handleSubmit}>
              <div className="modal-body">
                <div className="form-group">
                  <label className="form-label">Nomor Rumah</label>
                  <input className="form-input" value={form.house_number} onChange={e => setForm({...form, house_number: e.target.value})} placeholder="contoh: A-21" required />
                </div>
                <div className="form-group">
                  <label className="form-label">Alamat</label>
                  <input className="form-input" value={form.address} onChange={e => setForm({...form, address: e.target.value})} placeholder="Jl. Perumahan Elite..." />
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
