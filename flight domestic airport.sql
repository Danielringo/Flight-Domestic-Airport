CREATE DATABASE origin_airport;

USE origin_airport;

SELECT * FROM sales_monthly_reporting;

CREATE TABLE `sales_monthly_reporting` (
  `Name of Passengers` text,
  `Transaction Time` text,
  `Flight Code` text,
  `Departure Time` text,
  `Type of Flight` text,
  `Origin Airport` text,
  `Destination Airport` text,
  `Airlines` text,
  `Airlines Code` text,
  `Kurs` text,
  `Price` int DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Total Payment` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT * FROM sales_monthly_reporting;




ALTER TABLE sales_monthly_reporting
RENAME COLUMN `Name of Passengers` TO name_passengers;

ALTER TABLE sales_monthly_reporting
RENAME COLUMN `Transaction Time` TO time_transactions;

ALTER TABLE sales_monthly_reporting
RENAME COLUMN `Flight Code` TO flight_code;

ALTER TABLE sales_monthly_reporting
RENAME COLUMN `Departure Time` TO departure_time;

ALTER TABLE sales_monthly_reporting
RENAME COLUMN `Type of Flight` TO type_flight;

ALTER TABLE sales_monthly_reporting
RENAME COLUMN `Origin Airport` TO origin_airport;

ALTER TABLE sales_monthly_reporting
RENAME COLUMN `Airlines Code` TO airlines_code;

ALTER TABLE sales_monthly_reporting
RENAME COLUMN `Total Payment` TO total_payment;

ALTER TABLE sales_monthly_reporting
RENAME COLUMN `Destination Airport` TO destination_airport;


SELECT
    CASE
        WHEN type_flight = 'Domestic' THEN 'Domestik'
        ELSE 'Internasional'
    END AS kategori_penerbangan,
    Airlines AS maskapai,
    airlines_code AS kode_maskapai,
    origin_airport AS bandara_asal,
    destination_airport AS bandara_tujuan,
    COUNT(*) AS jumlah_transaksi,
    SUM(Quantity) AS total_tiket_terjual,
    SUM(total_payment) AS total_pendapatan,
    ROUND(AVG(Price), 2) AS rata_rata_harga_tiket,
    MAX(Price) AS harga_tiket_tertinggi,
    COUNT(DISTINCT name_passengers) AS jumlah_penumpang_unik,
    SUM(CASE WHEN Quantity > 1 THEN 1 ELSE 0 END) AS pembelian_multi_tiket,
    ROUND(AVG(Kurs), 2) AS rata_rata_kurs,
    COUNT(DISTINCT flight_code) AS jumlah_penerbangan_unik,
    ROUND(SUM(total_payment) / SUM(Quantity), 2) AS pendapatan_per_tiket,
    CASE
        WHEN time_transactions LIKE '%am%' THEN 'Pagi'
        WHEN time_transactions LIKE '%pm%' AND SUBSTRING(time_transactions, 1, 2) < '05' THEN 'Siang'
        ELSE 'Malam'
    END AS periode_transaksi,
    CASE
        WHEN departure_time LIKE '%am%' THEN 'Pagi'
        WHEN departure_time LIKE '%pm%' AND SUBSTRING(departure_time, 1, 2) < '05' THEN 'Siang'
        ELSE 'Malam'
    END AS periode_keberangkatan
FROM
    sales_monthly_reporting
GROUP BY
    kategori_penerbangan,
    maskapai,
    kode_maskapai,
    bandara_asal,
    bandara_tujuan,
    periode_transaksi,
    periode_keberangkatan
ORDER BY
    total_pendapatan DESC,
    jumlah_transaksi DESC
LIMIT 1000;







