# Sistem Informasi Manajemen RT Perumahan

Aplikasi ini saya buat sebagai pemenuhan tugas Skill Fit Test - Full Stack Programmer. Sistem ini bertujuan untuk membantu pengurus RT di perumahan elite dalam mendigitalisasi pengelolaan administrasi warga, rumah, dan keuangan secara terpusat.

Aplikasi dikembangkan menggunakan arsitektur frontend dan backend yang terpisah (decoupled).

## Fitur Aplikasi

Sesuai dengan requirement dari study case, aplikasi ini mencakup:
- **Pengelolaan Warga & Rumah**: Sistem dapat mencatat rumah mana saja yang dihuni atau kosong, serta riwayat kepemilikan penghuninya. Pendataan warga juga mencakup kelengkapan data diri dan lampiran foto KTP.
- **Pencatatan Iuran**: Admin dapat mencatat iuran wajib warga (Satpam 100rb & Kebersihan 15rb). Tersedia juga fitur pembayaran multi-bulan untuk warga yang membayar satu tahun sekaligus.
- **Pencatatan Pengeluaran**: Pengeluaran operasional perumahan bisa dicatat berdasarkan kategori (gaji, listrik, perbaikan jalan, dll).
- **Laporan & Dashboard**: Terdapat halaman khusus untuk melihat riwayat arus kas masuk dan keluar beserta sisa saldo per bulan, lengkap dengan grafik.

## Tech Stack
- **Backend:** Laravel 12 (PHP), MySQL, Laravel Sanctum (API Auth)
- **Frontend:** React 18, Vite, Axios, Recharts (untuk grafik)

## Cara Menjalankan Aplikasi

Aplikasi ini dapat dijalankan langsung di environment lokal (tanpa Docker). Pastikan PHP (min v8.2), Node.js (min v18), Composer, dan MySQL sudah terinstall.

### 1. Konfigurasi Database & Backend
1. Buat database baru di MySQL dengan nama `rt_perumahan`.
2. Buka terminal, masuk ke folder `backend/`.
3. Install dependency backend:
   ```bash
   composer install
   ```
4. Copy file `.env.example` dan ubah namanya menjadi `.env`. Pastikan pengaturan databasenya seperti ini:
   ```env
   DB_CONNECTION=mysql
   DB_DATABASE=rt_perumahan
   DB_USERNAME=root
   DB_PASSWORD=
   ```
   *(Sesuaikan DB_PASSWORD jika MySQL Anda menggunakan password)*
5. Generate key dan jalankan migrasi beserta seedernya:
   ```bash
   php artisan key:generate
   php artisan migrate:fresh --seed
   ```
   *(Seeder ini otomatis akan membuatkan akun admin, 20 data rumah, 18 warga, dan riwayat keuangan untuk keperluan testing)*
6. Buat link storage untuk akses file KTP:
   ```bash
   php artisan storage:link
   ```
7. Nyalakan server backend:
   ```bash
   php artisan serve --port=8000
   ```

### 2. Konfigurasi Frontend
1. Buka terminal baru (biarkan terminal backend tetap menyala) dan masuk ke folder `frontend/`.
2. Install package node:
   ```bash
   npm install
   ```
3. Nyalakan server frontend:
   ```bash
   npm run dev
   ```

### 3. Akses Login
Silakan buka browser dan akses `http://localhost:5173`. 
Gunakan akun berikut untuk mencoba aplikasinya:
- **Email**: `admin@rt.com`
- **Password**: `password`

## Dokumentasi Database
Struktur tabel beserta relasinya sudah saya sediakan dalam file terpisah bernama `ERD.md` di dalam repository ini.

---
Dikembangkan oleh **Adryan Maha Putra**
