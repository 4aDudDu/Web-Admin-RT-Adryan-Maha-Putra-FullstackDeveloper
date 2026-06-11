<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\House;
use App\Models\HouseResident;
use Illuminate\Http\Request;

class HouseController extends Controller
{
    public function index()
    {
        $houses = House::with('currentResident.resident')->orderBy('house_number')->get();
        return response()->json($houses);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'house_number' => 'required|string|max:10|unique:houses',
            'address' => 'nullable|string|max:255',
        ]);

        $validated['occupancy_status'] = 'tidak_dihuni';
        $house = House::create($validated);

        return response()->json($house, 201);
    }

    public function show(House $house)
    {
        $house->load(['currentResident.resident', 'residentHistory']);
        return response()->json($house);
    }

    public function update(Request $request, House $house)
    {
        $validated = $request->validate([
            'house_number' => 'sometimes|required|string|max:10|unique:houses,house_number,' . $house->id,
            'address' => 'nullable|string|max:255',
        ]);

        $house->update($validated);
        return response()->json($house);
    }

    public function assignResident(Request $request, House $house)
    {
        $validated = $request->validate([
            'resident_id' => 'required|exists:residents,id',
            'start_date' => 'required|date',
        ]);

        // Deactivate current resident if any
        $currentResident = $house->houseResidents()->where('is_active', true)->first();
        if ($currentResident) {
            $currentResident->update([
                'is_active' => false,
                'end_date' => now()->toDateString(),
            ]);
        }

        // Deactivate this resident from any other house
        HouseResident::where('resident_id', $validated['resident_id'])
            ->where('is_active', true)
            ->update([
                'is_active' => false,
                'end_date' => now()->toDateString(),
            ]);

        // Create new assignment
        $houseResident = HouseResident::create([
            'house_id' => $house->id,
            'resident_id' => $validated['resident_id'],
            'start_date' => $validated['start_date'],
            'is_active' => true,
        ]);

        // Update house status
        $house->update(['occupancy_status' => 'dihuni']);

        $houseResident->load('resident');
        return response()->json($houseResident, 201);
    }

    public function removeResident(House $house)
    {
        $currentResident = $house->houseResidents()->where('is_active', true)->first();
        if ($currentResident) {
            $currentResident->update([
                'is_active' => false,
                'end_date' => now()->toDateString(),
            ]);
        }

        $house->update(['occupancy_status' => 'tidak_dihuni']);

        return response()->json(['message' => 'Penghuni berhasil dikeluarkan']);
    }

    public function history(House $house)
    {
        $history = $house->houseResidents()
            ->with('resident')
            ->orderBy('start_date', 'desc')
            ->get();

        return response()->json($history);
    }

    public function payments(House $house, Request $request)
    {
        $query = $house->houseResidents()->with(['resident', 'payments']);

        if ($request->has('year')) {
            $year = $request->year;
            $query->whereHas('payments', function ($q) use ($year) {
                $q->where('year', $year);
            });
        }

        $houseResidents = $query->get();

        $payments = [];
        foreach ($houseResidents as $hr) {
            foreach ($hr->payments as $payment) {
                $payments[] = [
                    'id' => $payment->id,
                    'resident_name' => $hr->resident->full_name,
                    'resident_id' => $hr->resident->id,
                    'house_resident_id' => $hr->id,
                    'payment_type' => $payment->payment_type,
                    'amount' => $payment->amount,
                    'month' => $payment->month,
                    'year' => $payment->year,
                    'status' => $payment->status,
                    'payment_date' => $payment->payment_date,
                    'notes' => $payment->notes,
                ];
            }
        }

        // Sort by year desc, month desc
        usort($payments, function ($a, $b) {
            if ($a['year'] !== $b['year']) return $b['year'] - $a['year'];
            return $b['month'] - $a['month'];
        });

        return response()->json($payments);
    }
}
