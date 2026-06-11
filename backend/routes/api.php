<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ResidentController;
use App\Http\Controllers\Api\HouseController;
use App\Http\Controllers\Api\PaymentController;
use App\Http\Controllers\Api\ExpenseController;
use App\Http\Controllers\Api\ReportController;
use Illuminate\Support\Facades\Route;

Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/me', [AuthController::class, 'me']);

    Route::get('/residents', [ResidentController::class, 'index']);
    Route::post('/residents', [ResidentController::class, 'store']);
    Route::get('/residents/{resident}', [ResidentController::class, 'show']);
    Route::post('/residents/{resident}', [ResidentController::class, 'update']);
    Route::post('/residents/{resident}/upload-ktp', [ResidentController::class, 'uploadKtp']);
    Route::delete('/residents/{resident}/delete-ktp', [ResidentController::class, 'deleteKtp']);

    Route::get('/houses', [HouseController::class, 'index']);
    Route::post('/houses', [HouseController::class, 'store']);
    Route::get('/houses/{house}', [HouseController::class, 'show']);
    Route::put('/houses/{house}', [HouseController::class, 'update']);
    Route::post('/houses/{house}/assign-resident', [HouseController::class, 'assignResident']);
    Route::post('/houses/{house}/remove-resident', [HouseController::class, 'removeResident']);
    Route::get('/houses/{house}/history', [HouseController::class, 'history']);
    Route::get('/houses/{house}/payments', [HouseController::class, 'payments']);

    Route::get('/payments', [PaymentController::class, 'index']);
    Route::post('/payments', [PaymentController::class, 'store']);
    Route::post('/payments/bulk', [PaymentController::class, 'bulkStore']);
    Route::get('/payments/summary', [PaymentController::class, 'summary']);

    Route::get('/expenses', [ExpenseController::class, 'index']);
    Route::post('/expenses', [ExpenseController::class, 'store']);
    Route::get('/expenses/{expense}', [ExpenseController::class, 'show']);
    Route::put('/expenses/{expense}', [ExpenseController::class, 'update']);
    Route::delete('/expenses/{expense}', [ExpenseController::class, 'destroy']);

    Route::get('/reports/dashboard', [ReportController::class, 'dashboard']);
    Route::get('/reports/yearly', [ReportController::class, 'yearly']);
    Route::get('/reports/monthly', [ReportController::class, 'monthly']);
});
