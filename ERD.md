# ERD - Aplikasi Administrasi RT Perumahan

```
┌──────────────────────────────┐
│           users              │
├──────────────────────────────┤
│ id           BIGINT (PK)     │
│ name         VARCHAR(255)    │
│ email        VARCHAR(255) UQ │
│ password     VARCHAR(255)    │
│ created_at   TIMESTAMP       │
│ updated_at   TIMESTAMP       │
└──────────────────────────────┘


┌──────────────────────────────┐         ┌──────────────────────────────┐
│         residents            │         │          houses              │
├──────────────────────────────┤         ├──────────────────────────────┤
│ id           BIGINT (PK)     │         │ id           BIGINT (PK)     │
│ full_name    VARCHAR(255)    │         │ house_number VARCHAR(10) UQ  │
│ ktp_photo    VARCHAR(255)    │         │ address      VARCHAR(255)    │
│ status       ENUM            │         │ occupancy_status ENUM        │
│              (tetap/kontrak) │         │              (dihuni/        │
│ phone_number VARCHAR(20)     │         │               tidak_dihuni)  │
│ is_married   BOOLEAN         │         │ created_at   TIMESTAMP       │
│ created_at   TIMESTAMP       │         │ updated_at   TIMESTAMP       │
│ updated_at   TIMESTAMP       │         └──────────┬───────────────────┘
└──────────┬───────────────────┘                    │
           │                                        │
           │            1                      1    │
           └──────────────┐    ┌────────────────────┘
                          │    │
                       N  ▼    ▼  N
              ┌──────────────────────────────┐
              │      house_residents          │
              ├──────────────────────────────┤
              │ id           BIGINT (PK)     │
              │ house_id     BIGINT (FK)  ───┼──> houses.id
              │ resident_id  BIGINT (FK)  ───┼──> residents.id
              │ start_date   DATE            │
              │ end_date     DATE (nullable) │
              │ is_active    BOOLEAN         │
              │ created_at   TIMESTAMP       │
              │ updated_at   TIMESTAMP       │
              └──────────┬───────────────────┘
                         │
                         │ 1
                         │
                         ▼ N
              ┌──────────────────────────────┐
              │         payments             │
              ├──────────────────────────────┤
              │ id               BIGINT (PK) │
              │ house_resident_id BIGINT (FK)┼──> house_residents.id
              │ payment_type     ENUM        │
              │                  (satpam/    │
              │                   kebersihan)│
              │ amount           INT         │
              │ month            TINYINT     │
              │ year             SMALLINT    │
              │ status           ENUM        │
              │                  (lunas/     │
              │                   belum_lunas│
              │ payment_date     DATE        │
              │ notes            TEXT        │
              │ created_at       TIMESTAMP   │
              │ updated_at       TIMESTAMP   │
              │                              │
              │ UNIQUE(house_resident_id,    │
              │        payment_type,         │
              │        month, year)          │
              └──────────────────────────────┘


┌──────────────────────────────┐
│         expenses             │
├──────────────────────────────┤
│ id           BIGINT (PK)     │
│ title        VARCHAR(255)    │
│ description  TEXT            │
│ amount       INT             │
│ month        TINYINT         │
│ year         SMALLINT        │
│ category     ENUM            │
│              (gaji_satpam/   │
│               listrik_pos/   │
│               perbaikan_jalan│
│               perbaikan_     │
│               selokan/       │
│               lainnya)       │
│ expense_date DATE            │
│ created_at   TIMESTAMP       │
│ updated_at   TIMESTAMP       │
└──────────────────────────────┘
```

## Relasi

| Relasi | Tipe | Keterangan |
|--------|------|------------|
| residents → house_residents | One to Many | Satu penghuni bisa punya riwayat di beberapa rumah |
| houses → house_residents | One to Many | Satu rumah bisa punya riwayat beberapa penghuni |
| house_residents → payments | One to Many | Satu record penghuni-rumah bisa punya banyak pembayaran |
| expenses | Standalone | Tidak berelasi, pengeluaran level RT |

## Catatan

- Tabel `house_residents` menyimpan histori siapa yang pernah tinggal di rumah mana. Kolom `is_active = true` menandakan penghuni saat ini. Kalau `end_date` masih null artinya masih tinggal.
- Tabel `payments` punya unique constraint supaya tidak ada pembayaran ganda untuk jenis + bulan + tahun yang sama per penghuni.
- Tabel `expenses` berdiri sendiri karena pengeluaran RT tidak terkait langsung ke penghuni tertentu.
