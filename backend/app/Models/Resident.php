<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasManyThrough;

class Resident extends Model
{
    protected $fillable = [
        'full_name',
        'ktp_photo',
        'status',
        'phone_number',
        'is_married',
    ];

    protected $casts = [
        'is_married' => 'boolean',
    ];

    public function houseResidents(): HasMany
    {
        return $this->hasMany(HouseResident::class);
    }

    public function activeHouseResident()
    {
        return $this->houseResidents()->where('is_active', true)->first();
    }

    public function houses(): HasManyThrough
    {
        return $this->hasManyThrough(House::class, HouseResident::class, 'resident_id', 'id', 'id', 'house_id');
    }
}
