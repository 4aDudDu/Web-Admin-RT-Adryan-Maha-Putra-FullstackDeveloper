<div align="center">
  <h1>Sistem Informasi Manajemen RT Perumahan</h1>
  <p>Aplikasi web modern untuk mengelola administrasi Rukun Tetangga (RT), mulai dari pendataan warga, manajemen rumah, hingga rekapitulasi iuran dan pengeluaran kas dengan visualisasi data interaktif.</p>

  [![Laravel](https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white)](https://laravel.com)
  [![React](https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB)](https://reactjs.org/)
  [![Vite](https://img.shields.io/badge/Vite-B73BFE?style=for-the-badge&logo=vite&logoColor=FFD62E)](https://vitejs.dev/)
  [![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
</div>

---

## Fitur Utama

Aplikasi ini dirancang untuk menyelesaikan masalah pencatatan manual di lingkungan perumahan elit dengan fitur-fitur berikut:

### Manajemen Warga & Rumah
* **Pendataan Rumah**: Melacak status rumah (Dihuni / Kosong) beserta alamat detail.
* **Pendataan Penghuni**: Mengelola data warga tetap maupun kontrak, lengkap dengan status pernikahan dan nomor telepon.
* **Riwayat Kepemilikan**: Mencatat histori penghuni dari waktu ke waktu pada setiap rumah (Assign & Remove).
* **Arsip Dokumen KTP**: Fitur upload, preview, dan hapus foto KTP penghuni secara aman.

### Keuangan (Iuran & Pengeluaran)
* **Pencatatan Iuran Bulanan**: Mendukung pencatatan iuran Satpam (Rp 100.000) dan Kebersihan (Rp 15.000).
* **Pembayaran Multi-Bulan (Bulk Payment)**: Fitur khusus untuk warga yang membayar iuran langsung untuk 1 tahun penuh (bulk 12 bulan) dalam satu kali klik.
* **Manajemen Kas Keluar (Expenses)**: Mencatat pengeluaran RT berdasarkan kategori (Gaji Satpam, Listrik Pos, Perbaikan, dll).

### Laporan & Dashboard Analitik
* **Dashboard Eksekutif**: Menampilkan statistik ringkasan total rumah, warga, pemasukan, dan saldo secara *real-time*.
* **Visualisasi Grafik (Charts)**: Dilengkapi grafik batang dan area (menggunakan Recharts) untuk tren saldo dan perbandingan pemasukan vs pengeluaran tahunan.
* **Filter Dinamis**: Laporan bisa difilter berdasarkan bulan dan tahun untuk memudahkan audit keuangan RT.

### Modern UI/UX
* **Premium Dark Mode**: Desain antarmuka eksklusif menggunakan skema warna *Electric Indigo* dipadukan dengan *Glassmorphism*.
* **Smooth Animations**: Transisi elemen yang mulus (fade-in, modal pop-up, hover effects).
* **Responsive Layout**: Tampilan yang optimal di berbagai ukuran layar.

---

## Tech Stack & Arsitektur

Proyek ini dipisahkan menjadi dua bagian utama (Decoupled Architecture):

### Backend (API Server)
* **Framework**: Laravel 12
* **Database**: MySQL (Eloquent ORM)
* **Authentication**: Laravel Sanctum (Token-based API Auth)
* **Fitur Tambahan**: Database Seeder untuk dummy data, Artisan Storage untuk manajemen file upload KTP.

### Frontend (Client-Side)
* **Framework**: React 18
* **Build Tool**: Vite 
* **Routing**: React Router DOM 
* **HTTP Client**: Axios 
* **Visualisasi Data**: Recharts
* **Iconografi**: React Icons 
* **Notifikasi**: React Hot Toast

---

## Struktur Proyek

```text
webloker/
├── backend/                  # Direktori Backend Laravel
│   ├── app/Models/           # Definisi skema database
│   ├── app/Http/Controllers/ # Logika bisnis (API Endpoint)
│   ├── database/seeders/     # Data dummy awal
│   └── routes/api.php        # Daftar rute API
│
├── frontend/                 # Direktori Frontend React
│   ├── src/pages/            # Halaman UI (Dashboard, Residents, dll)
│   ├── src/services/         # Konfigurasi Axios
│   ├── src/index.css         # Custom Design System (CSS)
│   └── vite.config.js        # Konfigurasi Vite & Proxy
```

---

## Cara Instalasi & Menjalankan Aplikasi

Pastikan komputer atau laptop kamu sudah terinstal perangkat lunak berikut:
* **PHP** (Minimal versi 8.2)
* **Composer**
* **Node.js** (Minimal versi 18)
* **MySQL** (Bisa menggunakan Laragon, XAMPP, dsb.)

### 1. Persiapan Database
1. Buka aplikasi MySQL klien kamu (misal: phpMyAdmin, HeidiSQL, atau Terminal).
2. Buat database baru dengan mengeksekusi perintah SQL berikut:
   ```sql
   CREATE DATABASE rt_perumahan;
   ```

### 2. Setup Backend (Laravel API)
1. Buka terminal atau command prompt, lalu masuk ke direktori backend:
   ```bash
   cd backend
   ```
2. Instal semua dependensi PHP yang dibutuhkan:
   ```bash
   composer install
   ```
3. Salin file konfigurasi environment:
   ```bash
   cp .env.example .env
   ```
   *(Jika menggunakan Windows Command Prompt dan perintah `cp` tidak dikenali, kamu bisa menyalin file `.env.example` secara manual dan mengubah namanya menjadi `.env`)*
4. Buka file `.env` yang baru dibuat, dan pastikan konfigurasi database sudah benar:
   ```env
   DB_CONNECTION=mysql
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_DATABASE=rt_perumahan
   DB_USERNAME=root
   DB_PASSWORD=
   ```
   *(Isi `DB_PASSWORD` sesuai dengan kata sandi MySQL kamu, kosongkan jika tidak ada)*
5. Generate application key Laravel:
   ```bash
   php artisan key:generate
   ```
6. Jalankan migrasi tabel dan masukkan data awal (seeder) ke dalam database:
   ```bash
   php artisan migrate:fresh --seed
   ```
   *(Perintah ini akan membuat struktur tabel sekaligus mengisi 20 data rumah, 18 data penghuni, serta riwayat pembayaran dan pengeluaran dummy).*
7. Buat symbolic link agar foto KTP yang diunggah dapat diakses oleh publik:
   ```bash
   php artisan storage:link
   ```
8. Jalankan server lokal backend (biarkan terminal ini tetap terbuka):
   ```bash
   php artisan serve --port=8000
   ```

### 3. Setup Frontend (React Client)
1. Buka jendela terminal **baru** (tanpa menutup terminal backend), lalu masuk ke direktori frontend:
   ```bash
   cd frontend
   ```
2. Instal dependensi JavaScript (React & plugin terkait):
   ```bash
   npm install
   ```
3. Jalankan server lokal untuk frontend (Vite):
   ```bash
   npm run dev
   ```

### 4. Mengakses Aplikasi
Setelah kedua server (backend dan frontend) berhasil berjalan, kamu bisa mulai menggunakan aplikasi:
1. Buka web browser (Chrome, Firefox, Safari, dll).
2. Kunjungi alamat: **[http://localhost:5173](http://localhost:5173)**
3. Gunakan akun administrator bawaan untuk masuk:
   * **Email**: `admin@rt.com`
   * **Password**: `password`

---

## Pengembang

Dikembangkan dan dikelola oleh:
* **Adryan Maha Putra**
* Fullstack Developer
* S1 Teknik Informatika - Universitas Muhammadiyah Riau

