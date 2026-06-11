<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class House extends Model
{
    protected $fillable = [
        'house_number',
        'address',
        'occupancy_status',
    ];

    public function houseResidents(): HasMany
    {
        return $this->hasMany(HouseResident::class);
    }

    public function currentResident()
    {
        return $this->hasOne(HouseResident::class)->where('is_active', true)->with('resident');
    }

    public function residentHistory(): HasMany
    {
        return $this->hasMany(HouseResident::class)->with('resident')->orderBy('start_date', 'desc');
    }
}
