<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Expense extends Model
{
    protected $fillable = [
        'title',
        'description',
        'amount',
        'month',
        'year',
        'category',
        'expense_date',
    ];

    protected $casts = [
        'expense_date' => 'date',
        'amount' => 'integer',
    ];
}
