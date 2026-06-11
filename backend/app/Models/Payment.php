<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Payment extends Model
{
    protected $fillable = [
        'house_resident_id',
        'payment_type',
        'amount',
        'month',
        'year',
        'status',
        'payment_date',
        'notes',
    ];

    protected $casts = [
        'payment_date' => 'date',
        'amount' => 'integer',
    ];

    public function houseResident(): BelongsTo
    {
        return $this->belongsTo(HouseResident::class);
    }
}
