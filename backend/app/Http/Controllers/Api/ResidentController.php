<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Resident;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class ResidentController extends Controller
{
    public function index(Request $request)
    {
        $query = Resident::query();

        if ($request->has('search')) {
            $query->where('full_name', 'like', '%' . $request->search . '%');
        }

        if ($request->has('status')) {
            $query->where('status', $request->status);
        }

        $residents = $query->orderBy('full_name')->get();

        return response()->json($residents);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'full_name' => 'required|string|max:255',
            'status' => 'required|in:tetap,kontrak',
            'phone_number' => 'required|string|max:20',
            'is_married' => 'required|boolean',
            'ktp_photo' => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
        ]);

        if ($request->hasFile('ktp_photo')) {
            $validated['ktp_photo'] = $request->file('ktp_photo')->store('ktp', 'public');
        }

        $resident = Resident::create($validated);

        return response()->json($resident, 201);
    }

    public function show(Resident $resident)
    {
        $resident->load(['houseResidents.house', 'houseResidents.payments']);
        return response()->json($resident);
    }

    public function update(Request $request, Resident $resident)
    {
        $validated = $request->validate([
            'full_name' => 'sometimes|required|string|max:255',
            'status' => 'sometimes|required|in:tetap,kontrak',
            'phone_number' => 'sometimes|required|string|max:20',
            'is_married' => 'sometimes|required|boolean',
            'ktp_photo' => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
        ]);

        if ($request->hasFile('ktp_photo')) {
            if ($resident->ktp_photo) {
                Storage::disk('public')->delete($resident->ktp_photo);
            }
            $validated['ktp_photo'] = $request->file('ktp_photo')->store('ktp', 'public');
        }

        $resident->update($validated);

        return response()->json($resident);
    }

    public function uploadKtp(Request $request, Resident $resident)
    {
        $request->validate([
            'ktp_photo' => 'required|image|mimes:jpg,jpeg,png|max:2048',
        ]);

        if ($resident->ktp_photo) {
            Storage::disk('public')->delete($resident->ktp_photo);
        }

        $path = $request->file('ktp_photo')->store('ktp', 'public');
        $resident->update(['ktp_photo' => $path]);

        return response()->json($resident);
    }

    public function deleteKtp(Resident $resident)
    {
        if ($resident->ktp_photo) {
            Storage::disk('public')->delete($resident->ktp_photo);
            $resident->update(['ktp_photo' => null]);
        }

        return response()->json($resident);
    }
}
