import { useState, useEffect, createContext, useContext } from 'react'
import { BrowserRouter, Routes, Route, Navigate, NavLink, useNavigate } from 'react-router-dom'
import { Toaster } from 'react-hot-toast'
import { HiHome, HiUserGroup, HiOfficeBuilding, HiCash, HiTrendingDown, HiChartBar, HiLogout } from 'react-icons/hi'
import api from './services/api'
import LoginPage from './pages/LoginPage'
import DashboardPage from './pages/DashboardPage'
import ResidentsPage from './pages/ResidentsPage'
import HousesPage from './pages/HousesPage'
import HouseDetailPage from './pages/HouseDetailPage'
import PaymentsPage from './pages/PaymentsPage'
import ExpensesPage from './pages/ExpensesPage'
import ReportsPage from './pages/ReportsPage'
import CreditPage from './pages/CreditPage'
import './index.css'

const AuthContext = createContext(null)
export const useAuth = () => useContext(AuthContext)

function AuthProvider({ children }) {
  const [user, setUser] = useState(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    const token = localStorage.getItem('token')
    const savedUser = localStorage.getItem('user')
    if (token && savedUser) setUser(JSON.parse(savedUser))
    setLoading(false)
  }, [])

  const login = (userData, token) => {
    localStorage.setItem('token', token)
    localStorage.setItem('user', JSON.stringify(userData))
    setUser(userData)
  }

  const logout = async () => {
    try { await api.post('/logout') } catch {}
    localStorage.removeItem('token')
    localStorage.removeItem('user')
    setUser(null)
  }

  if (loading) return null
  return <AuthContext.Provider value={{ user, login, logout }}>{children}</AuthContext.Provider>
}

function Sidebar() {
  const { user, logout } = useAuth()

  const navItems = [
    { to: '/', icon: <HiHome />, label: 'Dashboard' },
    { to: '/residents', icon: <HiUserGroup />, label: 'Penghuni' },
    { to: '/houses', icon: <HiOfficeBuilding />, label: 'Rumah' },
    { to: '/payments', icon: <HiCash />, label: 'Pembayaran' },
    { to: '/expenses', icon: <HiTrendingDown />, label: 'Pengeluaran' },
    { to: '/reports', icon: <HiChartBar />, label: 'Laporan' },
    { to: '/credit', icon: <HiUserGroup />, label: 'Kredit' },
  ]

  return (
    <aside className="sidebar">
      <div className="sidebar-logo">
        <div className="logo-icon">RT</div>
        <div>
          <h1>RT Admin</h1>
          <p>Perumahan Elite</p>
        </div>
      </div>
      <nav className="nav-menu">
        {navItems.map(item => (
          <NavLink
            key={item.to}
            to={item.to}
            end={item.to === '/'}
            className={({ isActive }) => `nav-item ${isActive ? 'active' : ''}`}
          >
            <span className="nav-icon">{item.icon}</span>
            {item.label}
          </NavLink>
        ))}
      </nav>
      <div style={{ borderTop: '1px solid var(--glass-border)', paddingTop: 20 }}>
        <div style={{ padding: '6px 16px 12px', fontSize: 12, color: 'var(--text-400)' }}>
          {user?.name}
        </div>
        <button className="nav-item" onClick={logout} style={{ color: 'var(--danger)' }}>
          <span className="nav-icon"><HiLogout /></span>
          Keluar
        </button>
      </div>
    </aside>
  )
}

function ProtectedRoute({ children }) {
  const { user } = useAuth()
  if (!user) return <Navigate to="/login" replace />
  return (
    <div className="app-layout">
      <Sidebar />
      <main className="main-content fade-in">{children}</main>
    </div>
  )
}

export default function App() {
  return (
    <BrowserRouter>
      <AuthProvider>
        <Toaster
          position="top-right"
          toastOptions={{
            style: {
              background: '#1a1d28',
              color: '#f0f2f5',
              border: '1px solid rgba(255,255,255,0.06)',
              borderRadius: 12,
              fontSize: 13,
              fontFamily: 'Plus Jakarta Sans, sans-serif',
              boxShadow: '0 8px 32px rgba(0,0,0,0.3)',
            },
          }}
        />
        <Routes>
          <Route path="/login" element={<LoginPage />} />
          <Route path="/" element={<ProtectedRoute><DashboardPage /></ProtectedRoute>} />
          <Route path="/residents" element={<ProtectedRoute><ResidentsPage /></ProtectedRoute>} />
          <Route path="/houses" element={<ProtectedRoute><HousesPage /></ProtectedRoute>} />
          <Route path="/houses/:id" element={<ProtectedRoute><HouseDetailPage /></ProtectedRoute>} />
          <Route path="/payments" element={<ProtectedRoute><PaymentsPage /></ProtectedRoute>} />
          <Route path="/expenses" element={<ProtectedRoute><ExpensesPage /></ProtectedRoute>} />
          <Route path="/reports" element={<ProtectedRoute><ReportsPage /></ProtectedRoute>} />
          <Route path="/credit" element={<ProtectedRoute><CreditPage /></ProtectedRoute>} />
        </Routes>
      </AuthProvider>
    </BrowserRouter>
  )
}
