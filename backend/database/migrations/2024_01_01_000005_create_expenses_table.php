<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('expenses', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->text('description')->nullable();
            $table->integer('amount');
            $table->tinyInteger('month');
            $table->smallInteger('year');
            $table->enum('category', [
                'gaji_satpam',
                'listrik_pos',
                'perbaikan_jalan',
                'perbaikan_selokan',
                'lainnya'
            ])->default('lainnya');
            $table->date('expense_date');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('expenses');
    }
};
