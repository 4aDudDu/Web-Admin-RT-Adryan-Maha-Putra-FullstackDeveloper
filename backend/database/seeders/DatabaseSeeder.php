<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Resident;
use App\Models\House;
use App\Models\HouseResident;
use App\Models\Payment;
use App\Models\Expense;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // Create admin user
        User::create([
            'name' => 'Pak RT',
            'email' => 'admin@rt.com',
            'password' => Hash::make('password'),
        ]);

        // Create 20 houses
        for ($i = 1; $i <= 20; $i++) {
            House::create([
                'house_number' => 'A-' . str_pad($i, 2, '0', STR_PAD_LEFT),
                'address' => 'Jl. Perumahan Elite Blok A No. ' . $i,
                'occupancy_status' => 'tidak_dihuni',
            ]);
        }

        // Create 18 residents (15 tetap + 3 kontrak)
        $residents = [
            ['full_name' => 'Ahmad Fauzi', 'status' => 'tetap', 'phone_number' => '081234567001', 'is_married' => true],
            ['full_name' => 'Budi Santoso', 'status' => 'tetap', 'phone_number' => '081234567002', 'is_married' => true],
            ['full_name' => 'Cahya Dewi', 'status' => 'tetap', 'phone_number' => '081234567003', 'is_married' => true],
            ['full_name' => 'Dedi Kurniawan', 'status' => 'tetap', 'phone_number' => '081234567004', 'is_married' => true],
            ['full_name' => 'Eka Pratama', 'status' => 'tetap', 'phone_number' => '081234567005', 'is_married' => false],
            ['full_name' => 'Fitri Handayani', 'status' => 'tetap', 'phone_number' => '081234567006', 'is_married' => true],
            ['full_name' => 'Gilang Ramadhan', 'status' => 'tetap', 'phone_number' => '081234567007', 'is_married' => true],
            ['full_name' => 'Hendra Wijaya', 'status' => 'tetap', 'phone_number' => '081234567008', 'is_married' => true],
            ['full_name' => 'Irfan Hakim', 'status' => 'tetap', 'phone_number' => '081234567009', 'is_married' => false],
            ['full_name' => 'Joko Widodo', 'status' => 'tetap', 'phone_number' => '081234567010', 'is_married' => true],
            ['full_name' => 'Kartini Sari', 'status' => 'tetap', 'phone_number' => '081234567011', 'is_married' => true],
            ['full_name' => 'Lukman Hakim', 'status' => 'tetap', 'phone_number' => '081234567012', 'is_married' => true],
            ['full_name' => 'Maya Angelina', 'status' => 'tetap', 'phone_number' => '081234567013', 'is_married' => false],
            ['full_name' => 'Nugroho Adi', 'status' => 'tetap', 'phone_number' => '081234567014', 'is_married' => true],
            ['full_name' => 'Oscar Pratama', 'status' => 'tetap', 'phone_number' => '081234567015', 'is_married' => true],
            // Kontrak residents
            ['full_name' => 'Putri Maharani', 'status' => 'kontrak', 'phone_number' => '081234567016', 'is_married' => false],
            ['full_name' => 'Rizky Aditya', 'status' => 'kontrak', 'phone_number' => '081234567017', 'is_married' => true],
            ['full_name' => 'Sinta Permata', 'status' => 'kontrak', 'phone_number' => '081234567018', 'is_married' => false],
        ];

        foreach ($residents as $r) {
            Resident::create($r);
        }

        // Assign 15 tetap residents to houses A-01 to A-15
        for ($i = 1; $i <= 15; $i++) {
            $house = House::find($i);
            $resident = Resident::find($i);

            HouseResident::create([
                'house_id' => $house->id,
                'resident_id' => $resident->id,
                'start_date' => '2024-01-01',
                'is_active' => true,
            ]);

            $house->update(['occupancy_status' => 'dihuni']);
        }

        // Assign 2 kontrak residents to houses A-16 and A-17
        HouseResident::create([
            'house_id' => 16,
            'resident_id' => 16,
            'start_date' => '2025-06-01',
            'is_active' => true,
        ]);
        House::find(16)->update(['occupancy_status' => 'dihuni']);

        HouseResident::create([
            'house_id' => 17,
            'resident_id' => 17,
            'start_date' => '2025-09-01',
            'is_active' => true,
        ]);
        House::find(17)->update(['occupancy_status' => 'dihuni']);

        // Add a historical resident (moved out) for house A-16
        HouseResident::create([
            'house_id' => 16,
            'resident_id' => 18, // Sinta was previous tenant
            'start_date' => '2024-06-01',
            'end_date' => '2025-05-31',
            'is_active' => false,
        ]);

        // Generate payments for 2026 (Jan-May)
        $houseResidents = HouseResident::where('is_active', true)->get();
        $currentYear = 2026;

        foreach ($houseResidents as $hr) {
            for ($m = 1; $m <= 5; $m++) {
                // Satpam - all paid
                Payment::create([
                    'house_resident_id' => $hr->id,
                    'payment_type' => 'satpam',
                    'amount' => 100000,
                    'month' => $m,
                    'year' => $currentYear,
                    'status' => 'lunas',
                    'payment_date' => sprintf('%d-%02d-05', $currentYear, $m),
                ]);

                // Kebersihan - most paid, some unpaid
                $isPaid = rand(1, 10) > 2; // 80% chance paid
                Payment::create([
                    'house_resident_id' => $hr->id,
                    'payment_type' => 'kebersihan',
                    'amount' => 15000,
                    'month' => $m,
                    'year' => $currentYear,
                    'status' => $isPaid ? 'lunas' : 'belum_lunas',
                    'payment_date' => $isPaid ? sprintf('%d-%02d-05', $currentYear, $m) : null,
                ]);
            }

            // June - some have paid, some haven't
            $juneRandom = rand(1, 3);
            if ($juneRandom <= 2) {
                Payment::create([
                    'house_resident_id' => $hr->id,
                    'payment_type' => 'satpam',
                    'amount' => 100000,
                    'month' => 6,
                    'year' => $currentYear,
                    'status' => 'lunas',
                    'payment_date' => '2026-06-03',
                ]);
            }
        }

        // One resident paid kebersihan for full year
        $yearlyPayer = HouseResident::where('house_id', 1)->where('is_active', true)->first();
        for ($m = 6; $m <= 12; $m++) {
            Payment::create([
                'house_resident_id' => $yearlyPayer->id,
                'payment_type' => 'kebersihan',
                'amount' => 15000,
                'month' => $m,
                'year' => $currentYear,
                'status' => 'lunas',
                'payment_date' => '2026-01-10',
                'notes' => 'Bayar 1 tahun penuh',
            ]);
        }

        // Generate expenses
        $expenseTemplates = [
            ['title' => 'Gaji Satpam', 'category' => 'gaji_satpam', 'amount' => 2500000],
            ['title' => 'Token Listrik Pos Satpam', 'category' => 'listrik_pos', 'amount' => 200000],
        ];

        for ($m = 1; $m <= 6; $m++) {
            foreach ($expenseTemplates as $et) {
                Expense::create([
                    'title' => $et['title'],
                    'description' => $et['title'] . ' bulan ' . $m,
                    'amount' => $et['amount'],
                    'month' => $m,
                    'year' => $currentYear,
                    'category' => $et['category'],
                    'expense_date' => sprintf('%d-%02d-28', $currentYear, $m),
                ]);
            }
        }

        // Some irregular expenses
        Expense::create([
            'title' => 'Perbaikan Jalan Blok A',
            'description' => 'Perbaikan jalan berlubang di depan rumah A-05 sampai A-08',
            'amount' => 5000000,
            'month' => 3,
            'year' => $currentYear,
            'category' => 'perbaikan_jalan',
            'expense_date' => '2026-03-15',
        ]);

        Expense::create([
            'title' => 'Perbaikan Selokan',
            'description' => 'Pembersihan dan perbaikan selokan tersumbat area A-10',
            'amount' => 1500000,
            'month' => 2,
            'year' => $currentYear,
            'category' => 'perbaikan_selokan',
            'expense_date' => '2026-02-20',
        ]);

        Expense::create([
            'title' => 'Cat Pos Satpam',
            'description' => 'Pengecatan ulang pos satpam',
            'amount' => 800000,
            'month' => 4,
            'year' => $currentYear,
            'category' => 'lainnya',
            'expense_date' => '2026-04-10',
        ]);
    }
}
