-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 11, 2026 at 08:13 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rt_perumahan`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `amount` int(11) NOT NULL,
  `month` tinyint(4) NOT NULL,
  `year` smallint(6) NOT NULL,
  `category` enum('gaji_satpam','listrik_pos','perbaikan_jalan','perbaikan_selokan','lainnya') NOT NULL DEFAULT 'lainnya',
  `expense_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `title`, `description`, `amount`, `month`, `year`, `category`, `expense_date`, `created_at`, `updated_at`) VALUES
(1, 'Gaji Satpam', 'Gaji Satpam bulan 1', 2500000, 1, 2026, 'gaji_satpam', '2026-01-28', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(2, 'Token Listrik Pos Satpam', 'Token Listrik Pos Satpam bulan 1', 200000, 1, 2026, 'listrik_pos', '2026-01-28', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(3, 'Gaji Satpam', 'Gaji Satpam bulan 2', 2500000, 2, 2026, 'gaji_satpam', '2026-02-28', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(4, 'Token Listrik Pos Satpam', 'Token Listrik Pos Satpam bulan 2', 200000, 2, 2026, 'listrik_pos', '2026-02-28', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(5, 'Gaji Satpam', 'Gaji Satpam bulan 3', 2500000, 3, 2026, 'gaji_satpam', '2026-03-28', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(6, 'Token Listrik Pos Satpam', 'Token Listrik Pos Satpam bulan 3', 200000, 3, 2026, 'listrik_pos', '2026-03-28', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(7, 'Gaji Satpam', 'Gaji Satpam bulan 4', 2500000, 4, 2026, 'gaji_satpam', '2026-04-28', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(8, 'Token Listrik Pos Satpam', 'Token Listrik Pos Satpam bulan 4', 200000, 4, 2026, 'listrik_pos', '2026-04-28', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(9, 'Gaji Satpam', 'Gaji Satpam bulan 5', 2500000, 5, 2026, 'gaji_satpam', '2026-05-28', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(10, 'Token Listrik Pos Satpam', 'Token Listrik Pos Satpam bulan 5', 200000, 5, 2026, 'listrik_pos', '2026-05-28', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(11, 'Gaji Satpam', 'Gaji Satpam bulan 6', 2500000, 6, 2026, 'gaji_satpam', '2026-06-28', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(12, 'Token Listrik Pos Satpam', 'Token Listrik Pos Satpam bulan 6', 200000, 6, 2026, 'listrik_pos', '2026-06-28', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(13, 'Perbaikan Jalan Blok A', 'Perbaikan jalan berlubang di depan rumah A-05 sampai A-08', 5000000, 3, 2026, 'perbaikan_jalan', '2026-03-15', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(14, 'Perbaikan Selokan', 'Pembersihan dan perbaikan selokan tersumbat area A-10', 1500000, 2, 2026, 'perbaikan_selokan', '2026-02-20', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(15, 'Cat Pos Satpam', 'Pengecatan ulang pos satpam', 800000, 4, 2026, 'lainnya', '2026-04-10', '2026-06-10 18:58:04', '2026-06-10 18:58:04');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

CREATE TABLE `houses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `house_number` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `occupancy_status` enum('dihuni','tidak_dihuni') NOT NULL DEFAULT 'tidak_dihuni',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `houses`
--

INSERT INTO `houses` (`id`, `house_number`, `address`, `occupancy_status`, `created_at`, `updated_at`) VALUES
(1, 'A-01', 'Jl. Perumahan Elite Blok A No. 1', 'dihuni', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(2, 'A-02', 'Jl. Perumahan Elite Blok A No. 2', 'dihuni', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(3, 'A-03', 'Jl. Perumahan Elite Blok A No. 3', 'dihuni', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(4, 'A-04', 'Jl. Perumahan Elite Blok A No. 4', 'dihuni', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(5, 'A-05', 'Jl. Perumahan Elite Blok A No. 5', 'dihuni', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(6, 'A-06', 'Jl. Perumahan Elite Blok A No. 6', 'dihuni', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(7, 'A-07', 'Jl. Perumahan Elite Blok A No. 7', 'dihuni', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(8, 'A-08', 'Jl. Perumahan Elite Blok A No. 8', 'dihuni', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(9, 'A-09', 'Jl. Perumahan Elite Blok A No. 9', 'dihuni', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(10, 'A-10', 'Jl. Perumahan Elite Blok A No. 10', 'dihuni', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(11, 'A-11', 'Jl. Perumahan Elite Blok A No. 11', 'dihuni', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(12, 'A-12', 'Jl. Perumahan Elite Blok A No. 12', 'dihuni', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(13, 'A-13', 'Jl. Perumahan Elite Blok A No. 13', 'dihuni', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(14, 'A-14', 'Jl. Perumahan Elite Blok A No. 14', 'dihuni', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(15, 'A-15', 'Jl. Perumahan Elite Blok A No. 15', 'dihuni', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(16, 'A-16', 'Jl. Perumahan Elite Blok A No. 16', 'dihuni', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(17, 'A-17', 'Jl. Perumahan Elite Blok A No. 17', 'dihuni', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(18, 'A-18', 'Jl. Perumahan Elite Blok A No. 18', 'tidak_dihuni', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(19, 'A-19', 'Jl. Perumahan Elite Blok A No. 19', 'tidak_dihuni', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(20, 'A-20', 'Jl. Perumahan Elite Blok A No. 20', 'tidak_dihuni', '2026-06-10 18:58:04', '2026-06-10 18:58:04');

-- --------------------------------------------------------

--
-- Table structure for table `house_residents`
--

CREATE TABLE `house_residents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `house_id` bigint(20) UNSIGNED NOT NULL,
  `resident_id` bigint(20) UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `house_residents`
--

INSERT INTO `house_residents` (`id`, `house_id`, `resident_id`, `start_date`, `end_date`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2024-01-01', NULL, 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(2, 2, 2, '2024-01-01', NULL, 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(3, 3, 3, '2024-01-01', NULL, 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(4, 4, 4, '2024-01-01', NULL, 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(5, 5, 5, '2024-01-01', NULL, 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(6, 6, 6, '2024-01-01', NULL, 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(7, 7, 7, '2024-01-01', NULL, 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(8, 8, 8, '2024-01-01', NULL, 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(9, 9, 9, '2024-01-01', NULL, 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(10, 10, 10, '2024-01-01', NULL, 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(11, 11, 11, '2024-01-01', NULL, 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(12, 12, 12, '2024-01-01', NULL, 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(13, 13, 13, '2024-01-01', NULL, 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(14, 14, 14, '2024-01-01', NULL, 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(15, 15, 15, '2024-01-01', NULL, 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(16, 16, 16, '2025-06-01', NULL, 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(17, 17, 17, '2025-09-01', NULL, 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(18, 16, 18, '2024-06-01', '2025-05-31', 0, '2026-06-10 18:58:04', '2026-06-10 18:58:04');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2024_01_01_000001_create_residents_table', 1),
(5, '2024_01_01_000002_create_houses_table', 1),
(6, '2024_01_01_000003_create_house_residents_table', 1),
(7, '2024_01_01_000004_create_payments_table', 1),
(8, '2024_01_01_000005_create_expenses_table', 1),
(9, '2026_06_11_015613_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `house_resident_id` bigint(20) UNSIGNED NOT NULL,
  `payment_type` enum('satpam','kebersihan') NOT NULL,
  `amount` int(11) NOT NULL,
  `month` tinyint(4) NOT NULL,
  `year` smallint(6) NOT NULL,
  `status` enum('lunas','belum_lunas') NOT NULL DEFAULT 'belum_lunas',
  `payment_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `house_resident_id`, `payment_type`, `amount`, `month`, `year`, `status`, `payment_date`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 'satpam', 100000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(2, 1, 'kebersihan', 15000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(3, 1, 'satpam', 100000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(4, 1, 'kebersihan', 15000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(5, 1, 'satpam', 100000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(6, 1, 'kebersihan', 15000, 3, 2026, 'belum_lunas', NULL, NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(7, 1, 'satpam', 100000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(8, 1, 'kebersihan', 15000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(9, 1, 'satpam', 100000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(10, 1, 'kebersihan', 15000, 5, 2026, 'belum_lunas', NULL, NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(11, 1, 'satpam', 100000, 6, 2026, 'lunas', '2026-06-03', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(12, 2, 'satpam', 100000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(13, 2, 'kebersihan', 15000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(14, 2, 'satpam', 100000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(15, 2, 'kebersihan', 15000, 2, 2026, 'belum_lunas', NULL, NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(16, 2, 'satpam', 100000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(17, 2, 'kebersihan', 15000, 3, 2026, 'belum_lunas', NULL, NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(18, 2, 'satpam', 100000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(19, 2, 'kebersihan', 15000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(20, 2, 'satpam', 100000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(21, 2, 'kebersihan', 15000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(22, 2, 'satpam', 100000, 6, 2026, 'lunas', '2026-06-03', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(23, 3, 'satpam', 100000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(24, 3, 'kebersihan', 15000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(25, 3, 'satpam', 100000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(26, 3, 'kebersihan', 15000, 2, 2026, 'belum_lunas', NULL, NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(27, 3, 'satpam', 100000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(28, 3, 'kebersihan', 15000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(29, 3, 'satpam', 100000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(30, 3, 'kebersihan', 15000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(31, 3, 'satpam', 100000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(32, 3, 'kebersihan', 15000, 5, 2026, 'belum_lunas', NULL, NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(33, 3, 'satpam', 100000, 6, 2026, 'lunas', '2026-06-03', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(34, 4, 'satpam', 100000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(35, 4, 'kebersihan', 15000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(36, 4, 'satpam', 100000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(37, 4, 'kebersihan', 15000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(38, 4, 'satpam', 100000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(39, 4, 'kebersihan', 15000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(40, 4, 'satpam', 100000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(41, 4, 'kebersihan', 15000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(42, 4, 'satpam', 100000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(43, 4, 'kebersihan', 15000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(44, 4, 'satpam', 100000, 6, 2026, 'lunas', '2026-06-03', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(45, 5, 'satpam', 100000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(46, 5, 'kebersihan', 15000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(47, 5, 'satpam', 100000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(48, 5, 'kebersihan', 15000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(49, 5, 'satpam', 100000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(50, 5, 'kebersihan', 15000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(51, 5, 'satpam', 100000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(52, 5, 'kebersihan', 15000, 4, 2026, 'belum_lunas', NULL, NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(53, 5, 'satpam', 100000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(54, 5, 'kebersihan', 15000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(55, 5, 'satpam', 100000, 6, 2026, 'lunas', '2026-06-03', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(56, 6, 'satpam', 100000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(57, 6, 'kebersihan', 15000, 1, 2026, 'belum_lunas', NULL, NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(58, 6, 'satpam', 100000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(59, 6, 'kebersihan', 15000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(60, 6, 'satpam', 100000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(61, 6, 'kebersihan', 15000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(62, 6, 'satpam', 100000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(63, 6, 'kebersihan', 15000, 4, 2026, 'belum_lunas', NULL, NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(64, 6, 'satpam', 100000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(65, 6, 'kebersihan', 15000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(66, 6, 'satpam', 100000, 6, 2026, 'lunas', '2026-06-03', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(67, 7, 'satpam', 100000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(68, 7, 'kebersihan', 15000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(69, 7, 'satpam', 100000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(70, 7, 'kebersihan', 15000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(71, 7, 'satpam', 100000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(72, 7, 'kebersihan', 15000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(73, 7, 'satpam', 100000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(74, 7, 'kebersihan', 15000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(75, 7, 'satpam', 100000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(76, 7, 'kebersihan', 15000, 5, 2026, 'belum_lunas', NULL, NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(77, 7, 'satpam', 100000, 6, 2026, 'lunas', '2026-06-03', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(78, 8, 'satpam', 100000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(79, 8, 'kebersihan', 15000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(80, 8, 'satpam', 100000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(81, 8, 'kebersihan', 15000, 2, 2026, 'belum_lunas', NULL, NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(82, 8, 'satpam', 100000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(83, 8, 'kebersihan', 15000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(84, 8, 'satpam', 100000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(85, 8, 'kebersihan', 15000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(86, 8, 'satpam', 100000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(87, 8, 'kebersihan', 15000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(88, 9, 'satpam', 100000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(89, 9, 'kebersihan', 15000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(90, 9, 'satpam', 100000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(91, 9, 'kebersihan', 15000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(92, 9, 'satpam', 100000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(93, 9, 'kebersihan', 15000, 3, 2026, 'belum_lunas', NULL, NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(94, 9, 'satpam', 100000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(95, 9, 'kebersihan', 15000, 4, 2026, 'belum_lunas', NULL, NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(96, 9, 'satpam', 100000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(97, 9, 'kebersihan', 15000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(98, 10, 'satpam', 100000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(99, 10, 'kebersihan', 15000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(100, 10, 'satpam', 100000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(101, 10, 'kebersihan', 15000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(102, 10, 'satpam', 100000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(103, 10, 'kebersihan', 15000, 3, 2026, 'belum_lunas', NULL, NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(104, 10, 'satpam', 100000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(105, 10, 'kebersihan', 15000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(106, 10, 'satpam', 100000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(107, 10, 'kebersihan', 15000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(108, 10, 'satpam', 100000, 6, 2026, 'lunas', '2026-06-03', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(109, 11, 'satpam', 100000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(110, 11, 'kebersihan', 15000, 1, 2026, 'belum_lunas', NULL, NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(111, 11, 'satpam', 100000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(112, 11, 'kebersihan', 15000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(113, 11, 'satpam', 100000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(114, 11, 'kebersihan', 15000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(115, 11, 'satpam', 100000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(116, 11, 'kebersihan', 15000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(117, 11, 'satpam', 100000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(118, 11, 'kebersihan', 15000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(119, 12, 'satpam', 100000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(120, 12, 'kebersihan', 15000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(121, 12, 'satpam', 100000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(122, 12, 'kebersihan', 15000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(123, 12, 'satpam', 100000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(124, 12, 'kebersihan', 15000, 3, 2026, 'belum_lunas', NULL, NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(125, 12, 'satpam', 100000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(126, 12, 'kebersihan', 15000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(127, 12, 'satpam', 100000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(128, 12, 'kebersihan', 15000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(129, 12, 'satpam', 100000, 6, 2026, 'lunas', '2026-06-03', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(130, 13, 'satpam', 100000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(131, 13, 'kebersihan', 15000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(132, 13, 'satpam', 100000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(133, 13, 'kebersihan', 15000, 2, 2026, 'belum_lunas', NULL, NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(134, 13, 'satpam', 100000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(135, 13, 'kebersihan', 15000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(136, 13, 'satpam', 100000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(137, 13, 'kebersihan', 15000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(138, 13, 'satpam', 100000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(139, 13, 'kebersihan', 15000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(140, 13, 'satpam', 100000, 6, 2026, 'lunas', '2026-06-03', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(141, 14, 'satpam', 100000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(142, 14, 'kebersihan', 15000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(143, 14, 'satpam', 100000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(144, 14, 'kebersihan', 15000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(145, 14, 'satpam', 100000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(146, 14, 'kebersihan', 15000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(147, 14, 'satpam', 100000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(148, 14, 'kebersihan', 15000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(149, 14, 'satpam', 100000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(150, 14, 'kebersihan', 15000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(151, 15, 'satpam', 100000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(152, 15, 'kebersihan', 15000, 1, 2026, 'belum_lunas', NULL, NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(153, 15, 'satpam', 100000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(154, 15, 'kebersihan', 15000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(155, 15, 'satpam', 100000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(156, 15, 'kebersihan', 15000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(157, 15, 'satpam', 100000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(158, 15, 'kebersihan', 15000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(159, 15, 'satpam', 100000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(160, 15, 'kebersihan', 15000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(161, 15, 'satpam', 100000, 6, 2026, 'lunas', '2026-06-03', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(162, 16, 'satpam', 100000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(163, 16, 'kebersihan', 15000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(164, 16, 'satpam', 100000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(165, 16, 'kebersihan', 15000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(166, 16, 'satpam', 100000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(167, 16, 'kebersihan', 15000, 3, 2026, 'belum_lunas', NULL, NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(168, 16, 'satpam', 100000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(169, 16, 'kebersihan', 15000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(170, 16, 'satpam', 100000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(171, 16, 'kebersihan', 15000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(172, 16, 'satpam', 100000, 6, 2026, 'lunas', '2026-06-03', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(173, 17, 'satpam', 100000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(174, 17, 'kebersihan', 15000, 1, 2026, 'lunas', '2026-01-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(175, 17, 'satpam', 100000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(176, 17, 'kebersihan', 15000, 2, 2026, 'lunas', '2026-02-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(177, 17, 'satpam', 100000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(178, 17, 'kebersihan', 15000, 3, 2026, 'lunas', '2026-03-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(179, 17, 'satpam', 100000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(180, 17, 'kebersihan', 15000, 4, 2026, 'lunas', '2026-04-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(181, 17, 'satpam', 100000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(182, 17, 'kebersihan', 15000, 5, 2026, 'lunas', '2026-05-05', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(183, 1, 'kebersihan', 15000, 6, 2026, 'lunas', '2026-01-10', 'Bayar 1 tahun penuh', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(184, 1, 'kebersihan', 15000, 7, 2026, 'lunas', '2026-01-10', 'Bayar 1 tahun penuh', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(185, 1, 'kebersihan', 15000, 8, 2026, 'lunas', '2026-01-10', 'Bayar 1 tahun penuh', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(186, 1, 'kebersihan', 15000, 9, 2026, 'lunas', '2026-01-10', 'Bayar 1 tahun penuh', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(187, 1, 'kebersihan', 15000, 10, 2026, 'lunas', '2026-01-10', 'Bayar 1 tahun penuh', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(188, 1, 'kebersihan', 15000, 11, 2026, 'lunas', '2026-01-10', 'Bayar 1 tahun penuh', '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(189, 1, 'kebersihan', 15000, 12, 2026, 'lunas', '2026-01-10', 'Bayar 1 tahun penuh', '2026-06-10 18:58:04', '2026-06-10 18:58:04');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth-token', '8a9302921e05f9052b2afa16814f14c34a84821db04f7b5d383d69a0efc777c4', '[\"*\"]', '2026-06-10 19:07:02', NULL, '2026-06-10 19:06:53', '2026-06-10 19:07:02'),
(5, 'App\\Models\\User', 1, 'auth-token', '87c9142320c3e8bd752f567553d6b805aa35e50a3e787a7b0701634bfc65ccff', '[\"*\"]', '2026-06-11 11:12:50', NULL, '2026-06-11 11:09:40', '2026-06-11 11:12:50');

-- --------------------------------------------------------

--
-- Table structure for table `residents`
--

CREATE TABLE `residents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `ktp_photo` varchar(255) DEFAULT NULL,
  `status` enum('tetap','kontrak') NOT NULL DEFAULT 'tetap',
  `phone_number` varchar(255) NOT NULL,
  `is_married` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `residents`
--

INSERT INTO `residents` (`id`, `full_name`, `ktp_photo`, `status`, `phone_number`, `is_married`, `created_at`, `updated_at`) VALUES
(1, 'Ahmad Fauzi', NULL, 'tetap', '081234567001', 1, '2026-06-10 18:58:04', '2026-06-11 11:01:18'),
(2, 'Budi Santoso', NULL, 'tetap', '081234567002', 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(3, 'Cahya Dewi', NULL, 'tetap', '081234567003', 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(4, 'Dedi Kurniawan', NULL, 'tetap', '081234567004', 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(5, 'Eka Pratama', NULL, 'tetap', '081234567005', 0, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(6, 'Fitri Handayani', NULL, 'tetap', '081234567006', 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(7, 'Gilang Ramadhan', NULL, 'tetap', '081234567007', 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(8, 'Hendra Wijaya', NULL, 'tetap', '081234567008', 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(9, 'Irfan Hakim', NULL, 'tetap', '081234567009', 0, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(10, 'Joko Widodo', NULL, 'tetap', '081234567010', 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(11, 'Kartini Sari', NULL, 'tetap', '081234567011', 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(12, 'Lukman Hakim', NULL, 'tetap', '081234567012', 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(13, 'Maya Angelina', NULL, 'tetap', '081234567013', 0, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(14, 'Nugroho Adi', NULL, 'tetap', '081234567014', 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(15, 'Oscar Pratama', NULL, 'tetap', '081234567015', 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(16, 'Putri Maharani', NULL, 'kontrak', '081234567016', 0, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(17, 'Rizky Aditya', NULL, 'kontrak', '081234567017', 1, '2026-06-10 18:58:04', '2026-06-10 18:58:04'),
(18, 'Sinta Permata', NULL, 'kontrak', '081234567018', 0, '2026-06-10 18:58:04', '2026-06-10 18:58:04');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('9XjKXJdqtv4QM7lykmKRJRXpQb4xXaNYaq0kWV1k', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoidklHZzQ0bGlHVEpqYXlYQ3NwNHNEMkJMazNnQ0Q2dGd1aUFmVjlyQyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1781199562);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Pak RT', 'admin@rt.com', NULL, '$2y$12$0a6WLC9G5hwR/XzQB.lPvOIl8x/epmBHCl5845Zdtb6Mk4oLv0LFy', NULL, '2026-06-10 18:58:04', '2026-06-10 18:58:04');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `houses_house_number_unique` (`house_number`);

--
-- Indexes for table `house_residents`
--
ALTER TABLE `house_residents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `house_residents_house_id_foreign` (`house_id`),
  ADD KEY `house_residents_resident_id_foreign` (`resident_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `payment_unique` (`house_resident_id`,`payment_type`,`month`,`year`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `residents`
--
ALTER TABLE `residents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `house_residents`
--
ALTER TABLE `house_residents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=190;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `residents`
--
ALTER TABLE `residents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `house_residents`
--
ALTER TABLE `house_residents`
  ADD CONSTRAINT `house_residents_house_id_foreign` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `house_residents_resident_id_foreign` FOREIGN KEY (`resident_id`) REFERENCES `residents` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_house_resident_id_foreign` FOREIGN KEY (`house_resident_id`) REFERENCES `house_residents` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
