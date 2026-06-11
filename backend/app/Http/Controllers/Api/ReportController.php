<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Payment;
use App\Models\Expense;
use App\Models\House;
use App\Models\Resident;
use Illuminate\Http\Request;

class ReportController extends Controller
{
    public function yearly(Request $request)
    {
        $year = $request->get('year', date('Y'));

        $data = [];
        $totalIncome = 0;
        $totalExpense = 0;

        for ($m = 1; $m <= 12; $m++) {
            $income = Payment::where('year', $year)
                ->where('month', $m)
                ->where('status', 'lunas')
                ->sum('amount');

            $expense = Expense::where('year', $year)
                ->where('month', $m)
                ->sum('amount');

            $totalIncome += $income;
            $totalExpense += $expense;

            $data[] = [
                'month' => $m,
                'month_name' => $this->getMonthName($m),
                'income' => (int) $income,
                'expense' => (int) $expense,
                'balance' => (int) ($income - $expense),
            ];
        }

        return response()->json([
            'year' => (int) $year,
            'monthly_data' => $data,
            'total_income' => (int) $totalIncome,
            'total_expense' => (int) $totalExpense,
            'total_balance' => (int) ($totalIncome - $totalExpense),
        ]);
    }

    public function monthly(Request $request)
    {
        $month = $request->get('month', date('n'));
        $year = $request->get('year', date('Y'));

        // Income details
        $payments = Payment::with(['houseResident.resident', 'houseResident.house'])
            ->where('month', $month)
            ->where('year', $year)
            ->orderBy('payment_type')
            ->get()
            ->map(function ($payment) {
                return [
                    'id' => $payment->id,
                    'resident_name' => $payment->houseResident->resident->full_name ?? 'N/A',
                    'house_number' => $payment->houseResident->house->house_number ?? 'N/A',
                    'payment_type' => $payment->payment_type,
                    'amount' => $payment->amount,
                    'status' => $payment->status,
                    'payment_date' => $payment->payment_date,
                ];
            });

        // Expense details
        $expenses = Expense::where('month', $month)
            ->where('year', $year)
            ->orderBy('expense_date')
            ->get();

        $totalIncome = $payments->where('status', 'lunas')->sum('amount');
        $totalExpense = $expenses->sum('amount');

        return response()->json([
            'month' => (int) $month,
            'year' => (int) $year,
            'month_name' => $this->getMonthName($month),
            'payments' => $payments->values(),
            'expenses' => $expenses,
            'total_income' => (int) $totalIncome,
            'total_expense' => (int) $totalExpense,
            'balance' => (int) ($totalIncome - $totalExpense),
        ]);
    }

    public function dashboard()
    {
        $currentMonth = (int) date('n');
        $currentYear = (int) date('Y');

        $totalHouses = House::count();
        $occupiedHouses = House::where('occupancy_status', 'dihuni')->count();
        $totalResidents = Resident::count();

        $monthlyIncome = Payment::where('year', $currentYear)
            ->where('month', $currentMonth)
            ->where('status', 'lunas')
            ->sum('amount');

        $monthlyExpense = Expense::where('year', $currentYear)
            ->where('month', $currentMonth)
            ->sum('amount');

        // Yearly totals
        $yearlyIncome = Payment::where('year', $currentYear)
            ->where('status', 'lunas')
            ->sum('amount');

        $yearlyExpense = Expense::where('year', $currentYear)
            ->sum('amount');

        // Unpaid count this month
        $unpaidCount = Payment::where('year', $currentYear)
            ->where('month', $currentMonth)
            ->where('status', 'belum_lunas')
            ->count();

        return response()->json([
            'total_houses' => $totalHouses,
            'occupied_houses' => $occupiedHouses,
            'empty_houses' => $totalHouses - $occupiedHouses,
            'total_residents' => $totalResidents,
            'monthly_income' => (int) $monthlyIncome,
            'monthly_expense' => (int) $monthlyExpense,
            'monthly_balance' => (int) ($monthlyIncome - $monthlyExpense),
            'yearly_income' => (int) $yearlyIncome,
            'yearly_expense' => (int) $yearlyExpense,
            'yearly_balance' => (int) ($yearlyIncome - $yearlyExpense),
            'unpaid_count' => $unpaidCount,
            'current_month' => $currentMonth,
            'current_year' => $currentYear,
        ]);
    }

    private function getMonthName(int $month): string
    {
        $names = [
            1 => 'Januari', 2 => 'Februari', 3 => 'Maret',
            4 => 'April', 5 => 'Mei', 6 => 'Juni',
            7 => 'Juli', 8 => 'Agustus', 9 => 'September',
            10 => 'Oktober', 11 => 'November', 12 => 'Desember',
        ];
        return $names[$month] ?? '';
    }
}
