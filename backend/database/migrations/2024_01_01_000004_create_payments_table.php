<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('payments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('house_resident_id')->constrained()->onDelete('cascade');
            $table->enum('payment_type', ['satpam', 'kebersihan']);
            $table->integer('amount');
            $table->tinyInteger('month');
            $table->smallInteger('year');
            $table->enum('status', ['lunas', 'belum_lunas'])->default('belum_lunas');
            $table->date('payment_date')->nullable();
            $table->text('notes')->nullable();
            $table->timestamps();

            $table->unique(['house_resident_id', 'payment_type', 'month', 'year'], 'payment_unique');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('payments');
    }
};
