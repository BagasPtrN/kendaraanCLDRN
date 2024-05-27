-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 27 Bulan Mei 2024 pada 10.46
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `motomobi`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `mobil`
--

CREATE TABLE `mobil` (
  `id` char(10) NOT NULL,
  `merek_jenis` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `mobil`
--

INSERT INTO `mobil` (`id`, `merek_jenis`) VALUES
('0123456789', 'Toyota Innova'),
('0132456789', 'Toyota Camry'),
('0987654321', 'Honda Brio'),
('1123456789', 'Honda Jazz'),
('1132456789', 'Honda CR-V'),
('1234567890', 'Toyota Avanza'),
('2123456789', 'Suzuki Ignis'),
('2132456789', 'Suzuki SX4'),
('2345678901', 'Suzuki Ertiga'),
('3123456789', 'Mitsubishi Mirage'),
('3132456789', 'Mitsubishi Outlander'),
('3456789012', 'Mitsubishi Xpander'),
('4123456789', 'Daihatsu Sigra'),
('4132456789', 'Daihatsu Luxio'),
('4567890123', 'Daihatsu Terios'),
('5123456789', 'Toyota Yaris'),
('5132456789', 'Toyota Alphard'),
('5678901234', 'Toyota Fortuner'),
('6123456789', 'Honda Civic'),
('6132456789', 'Honda Accord'),
('6789012345', 'Honda HR-V'),
('7123456789', 'Suzuki Swift'),
('7132456789', 'Suzuki Jimny'),
('7890123456', 'Suzuki Baleno'),
('8123456789', 'Mitsubishi Lancer'),
('8132456789', 'Mitsubishi Triton'),
('8901234567', 'Mitsubishi Pajero Sport'),
('9012345678', 'Daihatsu Xenia'),
('9123456789', 'Daihatsu Ayla'),
('9132456789', 'Daihatsu Gran Max');

-- --------------------------------------------------------

--
-- Struktur dari tabel `motor`
--

CREATE TABLE `motor` (
  `id` char(8) NOT NULL,
  `merek_jenis` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `motor`
--

INSERT INTO `motor` (`id`, `merek_jenis`) VALUES
('01234567', 'Suzuki Address'),
('01324567', 'Yamaha Mio'),
('11234567', 'Kawasaki Versys'),
('11324567', 'Honda CRF150L'),
('12345678', 'Yamaha NMAX'),
('21234567', 'Yamaha MT-15'),
('21324567', 'Suzuki Smash'),
('23456789', 'Suzuki Satria'),
('31234567', 'Honda PCX'),
('31324567', 'Kawasaki Ninja 250'),
('34567890', 'Kawasaki Ninja'),
('41234567', 'Suzuki Nex II'),
('41324567', 'Yamaha Fazzio'),
('45678901', 'Yamaha R15'),
('51234567', 'Kawasaki W175'),
('51324567', 'Honda Revo'),
('56789012', 'Honda Vario'),
('61234567', 'Yamaha Aerox'),
('61324567', 'Suzuki Intruder'),
('67890123', 'Suzuki GSX-R150'),
('71234567', 'Honda Supra GTR150'),
('71324567', 'Kawasaki D-Tracker'),
('78901234', 'Kawasaki KLX'),
('81234567', 'Suzuki Burgman Street'),
('81324567', 'Yamaha Lexi'),
('87654321', 'Honda Beat'),
('89012345', 'Yamaha XMAX'),
('90123456', 'Honda CBR150R'),
('91234567', 'Kawasaki ZX-25R'),
('91324567', 'Honda ADV150');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `mobil`
--
ALTER TABLE `mobil`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `motor`
--
ALTER TABLE `motor`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
