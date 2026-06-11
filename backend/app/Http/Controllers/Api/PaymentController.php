<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Payment;
use App\Models\HouseResident;
use Illuminate\Http\Request;

class PaymentController extends Controller
{
    public function index(Request $request)
    {
        $query = Payment::with(['houseResident.resident', 'houseResident.house']);

        if ($request->has('month')) {
            $query->where('month', $request->month);
        }
        if ($request->has('year')) {
            $query->where('year', $request->year);
        }
        if ($request->has('payment_type')) {
            $query->where('payment_type', $request->payment_type);
        }
        if ($request->has('status')) {
            $query->where('status', $request->status);
        }

        $payments = $query->orderBy('year', 'desc')->orderBy('month', 'desc')->get();

        return response()->json($payments);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'house_resident_id' => 'required|exists:house_residents,id',
            'payment_type' => 'required|in:satpam,kebersihan',
            'month' => 'required|integer|min:1|max:12',
            'year' => 'required|integer|min:2020|max:2030',
            'status' => 'required|in:lunas,belum_lunas',
            'payment_date' => 'nullable|date',
            'notes' => 'nullable|string',
        ]);

        $validated['amount'] = $validated['payment_type'] === 'satpam' ? 100000 : 15000;

        if ($validated['status'] === 'lunas' && !$validated['payment_date']) {
            $validated['payment_date'] = now()->toDateString();
        }

        // Check for duplicates
        $exists = Payment::where('house_resident_id', $validated['house_resident_id'])
            ->where('payment_type', $validated['payment_type'])
            ->where('month', $validated['month'])
            ->where('year', $validated['year'])
            ->first();

        if ($exists) {
            $exists->update($validated);
            return response()->json($exists);
        }

        $payment = Payment::create($validated);
        $payment->load(['houseResident.resident', 'houseResident.house']);

        return response()->json($payment, 201);
    }

    public function bulkStore(Request $request)
    {
        $validated = $request->validate([
            'house_resident_id' => 'required|exists:house_residents,id',
            'payment_type' => 'required|in:satpam,kebersihan',
            'year' => 'required|integer|min:2020|max:2030',
            'months' => 'required|array|min:1',
            'months.*' => 'integer|min:1|max:12',
            'status' => 'required|in:lunas,belum_lunas',
            'payment_date' => 'nullable|date',
        ]);

        $amount = $validated['payment_type'] === 'satpam' ? 100000 : 15000;
        $paymentDate = $validated['status'] === 'lunas'
            ? ($validated['payment_date'] ?? now()->toDateString())
            : null;

        $payments = [];
        foreach ($validated['months'] as $month) {
            $payment = Payment::updateOrCreate(
                [
                    'house_resident_id' => $validated['house_resident_id'],
                    'payment_type' => $validated['payment_type'],
                    'month' => $month,
                    'year' => $validated['year'],
                ],
                [
                    'amount' => $amount,
                    'status' => $validated['status'],
                    'payment_date' => $paymentDate,
                ]
            );
            $payments[] = $payment;
        }

        return response()->json($payments, 201);
    }

    public function summary(Request $request)
    {
        $year = $request->get('year', date('Y'));

        $monthlySummary = [];
        for ($m = 1; $m <= 12; $m++) {
            $income = Payment::where('year', $year)
                ->where('month', $m)
                ->where('status', 'lunas')
                ->sum('amount');

            $monthlySummary[] = [
                'month' => $m,
                'income' => (int)$income,
            ];
        }

        return response()->json($monthlySummary);
    }
}
