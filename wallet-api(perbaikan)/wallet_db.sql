-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 18, 2025 at 07:37 PM
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
-- Database: `wallet_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `transaction_id` varchar(36) NOT NULL,
  `user_id` longtext DEFAULT NULL,
  `type` longtext DEFAULT NULL,
  `amount` bigint(20) DEFAULT NULL,
  `balance_before` bigint(20) DEFAULT NULL,
  `balance_after` bigint(20) DEFAULT NULL,
  `remarks` longtext DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`transaction_id`, `user_id`, `type`, `amount`, `balance_before`, `balance_after`, `remarks`, `created_at`) VALUES
('01ebc072-03b4-42a9-8a6e-5fa902a0f8aa', 'c9e1c30e-5fa4-4b27-902a-9eafd8ea5971', 'CREDIT', 5000, 75000, 80000, 'Transfer ke teman', '2025-12-18 18:26:56.158'),
('02572c0d-4745-497f-8dc5-697a70d26f1e', 'c9e1c30e-5fa4-4b27-902a-9eafd8ea5971', 'CREDIT', 5000, 95000, 100000, 'Transfer ke teman', '2025-12-18 19:03:37.715'),
('0b812efe-b995-4645-88b1-bf86fb8c4e43', 'c44c4b47-cb79-4263-974f-14f9f31229e3', 'DEBIT', 50000, 200000, 150000, 'Bayar air', '2025-12-19 00:13:33.488'),
('19aa1d74-7a21-466d-84ee-2bcf4a64a88f', 'a3d55143-7a87-4e10-a126-befdbd171bfe', 'DEBIT', 50000, 100000, 50000, 'Kirim uang', '2025-12-18 23:41:15.690'),
('22eef9ec-49a5-4858-b8e4-0aeafafb8838', 'c9e1c30e-5fa4-4b27-902a-9eafd8ea5971', 'CREDIT', 5000, 65000, 70000, 'Transfer ke teman', '2025-12-18 18:26:46.100'),
('3499d6f3-596f-4540-9c59-bd74c00e4d59', '267d9b33-e36b-412d-b5e6-611d3aa93599', 'DEBIT', 5000, 35000, 30000, 'Transfer ke teman', '2025-12-18 18:26:36.043'),
('35083a5c-7f74-4590-b092-7cc48bb608ed', '267d9b33-e36b-412d-b5e6-611d3aa93599', 'DEBIT', 10000, 50000, 40000, 'Bayar paket data', '2025-12-18 18:24:52.504'),
('3a06a8c1-97d9-4391-aa2a-576a8c8ebed5', 'c44c4b47-cb79-4263-974f-14f9f31229e3', 'DEBIT', 30000, 120000, 90000, 'Transfer teman', '2025-12-19 00:15:51.861'),
('3ae9481f-e5eb-416c-b145-e486bfca5c4d', '267d9b33-e36b-412d-b5e6-611d3aa93599', 'CREDIT', 30000, 0, 30000, 'Transfer teman', '2025-12-19 00:15:51.862'),
('3f0649d0-eda1-402d-80e6-c02c626f4672', 'c9e1c30e-5fa4-4b27-902a-9eafd8ea5971', 'DEBIT', 10000, 20000, 10000, 'Bayar pulsa', '2025-12-18 17:56:30.725'),
('5083c36e-4059-4ba8-9891-bc41889ef598', '86021d3c-fb28-4814-bf4c-5852b8501c19', 'DEBIT', 25000, 50000, 25000, 'Belanja harian', '2025-12-19 01:27:02.201'),
('5234ece6-9fec-4db2-8e6e-036cbf4debd4', 'adbd145d-7be9-49f3-b9a8-5fd4c57d7b6c', 'CREDIT', 10000, 60000, 70000, 'Top Up', '2025-12-18 17:26:08.545'),
('580723b8-6464-4cc7-b846-d12d4f099442', 'c9e1c30e-5fa4-4b27-902a-9eafd8ea5971', 'CREDIT', 5000, 80000, 85000, 'Transfer ke teman', '2025-12-18 18:27:01.391'),
('5a3d8e24-964a-44d8-a851-b7341c75c70d', '267d9b33-e36b-412d-b5e6-611d3aa93599', 'DEBIT', 5000, 15000, 10000, 'Transfer ke teman', '2025-12-18 18:26:56.153'),
('5a6248fa-b068-47bd-aaaf-c377e513d816', 'a3d55143-7a87-4e10-a126-befdbd171bfe', 'DEBIT', 5000, 30000, 25000, 'Bayar pulsa lala', '2025-12-19 00:06:35.538'),
('661f870c-0600-4f5a-8ec5-6352d6d72214', 'c9e1c30e-5fa4-4b27-902a-9eafd8ea5971', 'CREDIT', 5000, 100000, 105000, 'Transfer ke teman', '2025-12-18 19:03:42.742'),
('662f8587-5e86-4447-9d7f-626999a823b7', 'c9e1c30e-5fa4-4b27-902a-9eafd8ea5971', 'CREDIT', 5000, 50000, 55000, 'Transfer ke adik', '2025-12-18 18:08:24.078'),
('67b916ad-94ee-47bb-8ef3-845b8d1134d4', '267d9b33-e36b-412d-b5e6-611d3aa93599', 'DEBIT', 5000, 20000, 15000, 'Transfer ke teman', '2025-12-18 18:26:51.125'),
('6b9ce6d9-65da-480e-9dbf-de8c62e256bc', 'adbd145d-7be9-49f3-b9a8-5fd4c57d7b6c', 'CREDIT', 10000, 70000, 80000, 'Top Up', '2025-12-18 17:30:55.101'),
('716b593e-8b46-4d35-89a9-acaebe02597c', '267d9b33-e36b-412d-b5e6-611d3aa93599', 'DEBIT', 5000, 10000, 5000, 'Transfer ke teman', '2025-12-18 18:27:01.386'),
('7329794e-744e-4f9c-86ea-8d5aa14b9008', 'c9e1c30e-5fa4-4b27-902a-9eafd8ea5971', 'CREDIT', 5000, 90000, 95000, 'Transfer ke teman', '2025-12-18 19:03:32.689'),
('76831451-b8d3-424b-adcc-496dc356b0e8', 'c9e1c30e-5fa4-4b27-902a-9eafd8ea5971', 'CREDIT', 5000, 105000, 110000, 'Transfer ke teman', '2025-12-18 19:03:47.773'),
('7d8318a6-aa90-4607-89cc-15cb9136dd65', 'ce41c7b9-42a0-4102-aac9-85f0ec669caa', 'CREDIT', 50000, 0, 50000, 'transfer ibu', '2025-12-19 01:25:49.810'),
('80da347d-76a8-4c8f-8605-756a83cfb768', 'c9e1c30e-5fa4-4b27-902a-9eafd8ea5971', 'CREDIT', 5000, 50000, 55000, 'Top Up', '2025-12-18 18:07:26.143'),
('8f6338d5-3126-4c5d-ad3f-f536889f3fb7', 'c9e1c30e-5fa4-4b27-902a-9eafd8ea5971', 'CREDIT', 5000, 70000, 75000, 'Transfer ke teman', '2025-12-18 18:26:51.135'),
('91130922-d322-4630-b943-1ef4ba19c390', '267d9b33-e36b-412d-b5e6-611d3aa93599', 'DEBIT', 5000, 25000, 20000, 'Transfer ke teman', '2025-12-18 18:26:46.094'),
('94bd21d7-6133-4cf1-a0ca-e2fa7212b1a0', '267d9b33-e36b-412d-b5e6-611d3aa93599', 'DEBIT', 5000, 30000, 25000, 'Transfer ke teman', '2025-12-18 18:26:41.068'),
('98a469ed-a875-407f-966d-79ab40ff94a6', '669bd3e9-dabb-4347-9312-c0e71d3f25c5', 'CREDIT', 60000, 50000, 110000, 'Top Up', '2025-12-18 17:22:40.625'),
('9abbd34f-ec36-43f3-857a-e78747025598', 'c9e1c30e-5fa4-4b27-902a-9eafd8ea5971', 'CREDIT', 5000, 110000, 115000, 'Transfer ke teman', '2025-12-19 00:04:21.523'),
('9bf47c76-ceaa-455d-b056-f960176ec490', '86021d3c-fb28-4814-bf4c-5852b8501c19', 'DEBIT', 50000, 100000, 50000, 'transfer ibu', '2025-12-19 01:25:49.805'),
('9e38703a-632a-43cb-b3c7-6fc8ecb815a7', '86021d3c-fb28-4814-bf4c-5852b8501c19', 'CREDIT', 50000, 100000, 150000, 'Top Up', '2025-12-19 01:25:10.355'),
('9f2c0095-d532-4d37-9848-e17cd08c2cdc', 'c9e1c30e-5fa4-4b27-902a-9eafd8ea5971', 'CREDIT', 5000, 60000, 65000, 'Transfer ke teman', '2025-12-18 18:26:41.073'),
('bcb9544d-e554-4ed7-8bff-e77641d8bf09', 'c9e1c30e-5fa4-4b27-902a-9eafd8ea5971', 'CREDIT', 5000, 55000, 60000, 'Transfer ke teman', '2025-12-18 18:26:36.046'),
('bced1bf0-933b-4f3a-81c5-f49a731f8e15', 'c9e1c30e-5fa4-4b27-902a-9eafd8ea5971', 'DEBIT', 5000, 50000, 45000, 'Transfer ke adik', '2025-12-18 18:08:24.074'),
('c4e4957b-ec1e-4324-b455-1afeba6af9fb', 'a3d55143-7a87-4e10-a126-befdbd171bfe', 'CREDIT', 50000, 0, 50000, 'Top Up', '2025-12-19 00:03:45.969'),
('cd52d9ef-5380-4056-9350-520f45d8e05f', 'c2f97c18-8cd3-4053-8bd8-e97046b5cc6d', 'CREDIT', 50000, 0, 50000, 'Kirim uang', '2025-12-18 23:41:15.693'),
('d0ee193d-e226-41b8-b76f-291a07dae8a3', '86021d3c-fb28-4814-bf4c-5852b8501c19', 'CREDIT', 100000, 0, 100000, 'Top Up', '2025-12-19 01:23:42.713'),
('d5d8f284-50d0-40dd-977a-472ec15e4555', '267d9b33-e36b-412d-b5e6-611d3aa93599', 'DEBIT', 5000, 20000, 15000, 'Transfer ke teman', '2025-12-18 19:03:32.686'),
('dc04fbc1-e6a6-4776-b120-c3b89692ff1a', 'a3d55143-7a87-4e10-a126-befdbd171bfe', 'CREDIT', 50000, 100000, 150000, 'Top Up', '2025-12-18 23:40:44.238'),
('de940e5f-8203-4d72-a4c6-0eb41e1c79b3', '267d9b33-e36b-412d-b5e6-611d3aa93599', 'DEBIT', 5000, 10000, 5000, 'Transfer ke teman', '2025-12-18 19:03:42.738'),
('e1b6607f-a1fd-4626-a819-d5aa9f6972ea', 'c9e1c30e-5fa4-4b27-902a-9eafd8ea5971', 'CREDIT', 5000, 85000, 90000, 'Transfer ke teman', '2025-12-18 18:27:06.425'),
('e2c105f0-21fd-479e-bf59-19c9d914120c', 'd578c999-7955-43b2-bdd7-755d08a18e1e', 'DEBIT', 10000, 50000, 40000, 'Bayar pulsa', '2025-12-18 19:02:40.110'),
('e7386054-bd3d-4b4f-9366-41f33f1b4c7f', 'a3d55143-7a87-4e10-a126-befdbd171bfe', 'DEBIT', 5000, 45000, 40000, 'Transfer ke teman', '2025-12-19 00:04:21.519'),
('e7e732af-7c17-4d98-a434-befcd05f88ee', '267d9b33-e36b-412d-b5e6-611d3aa93599', 'DEBIT', 5000, 5000, 0, 'Transfer ke teman', '2025-12-18 19:03:47.769'),
('ef6acff4-c9af-4555-a356-00c31e169f36', 'adbd145d-7be9-49f3-b9a8-5fd4c57d7b6c', 'DEBIT', 10000, 80000, 70000, 'Bayar pulsa', '2025-12-18 17:31:23.584'),
('f685fc38-ff1e-4fd1-891b-f83de56b8710', '267d9b33-e36b-412d-b5e6-611d3aa93599', 'DEBIT', 5000, 15000, 10000, 'Transfer ke teman', '2025-12-18 19:03:37.708'),
('f7c5d228-7608-444d-b27b-18a37dbac647', 'a3d55143-7a87-4e10-a126-befdbd171bfe', 'CREDIT', 100000, 0, 100000, 'Top Up', '2025-12-18 23:39:18.280');

-- --------------------------------------------------------

--
-- Table structure for table `transfer_queues`
--

CREATE TABLE `transfer_queues` (
  `transfer_queue_id` varchar(36) NOT NULL,
  `from_user_id` varchar(36) DEFAULT NULL,
  `to_user_id` varchar(36) DEFAULT NULL,
  `amount` bigint(20) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `processed_at` datetime(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transfer_queues`
--

INSERT INTO `transfer_queues` (`transfer_queue_id`, `from_user_id`, `to_user_id`, `amount`, `remarks`, `status`, `created_at`, `processed_at`) VALUES
('4d43df59-bf04-4479-9908-ff194481629b', 'a3d55143-7a87-4e10-a126-befdbd171bfe', 'c9e1c30e-5fa4-4b27-902a-9eafd8ea5971', 50000, 'Transfer ke teman', 'FAILED', '2025-12-19 00:03:05.604', '2025-12-19 00:03:06.472'),
('8f07c78b-62b6-4876-a483-fc2a99cd9f1c', 'a3d55143-7a87-4e10-a126-befdbd171bfe', 'c9e1c30e-5fa4-4b27-902a-9eafd8ea5971', 50000, 'Transfer ke teman', 'FAILED', '2025-12-19 00:01:11.690', '2025-12-19 00:01:16.432'),
('bbf8bff7-829e-4a79-937d-3f0d84043920', '86021d3c-fb28-4814-bf4c-5852b8501c19', 'ce41c7b9-42a0-4102-aac9-85f0ec669caa', 50000, 'transfer ibu', 'COMPLETED', '2025-12-19 01:25:45.770', '2025-12-19 01:25:49.801'),
('d64b68a2-5292-4c66-857b-13157d1c3945', 'a3d55143-7a87-4e10-a126-befdbd171bfe', 'c9e1c30e-5fa4-4b27-902a-9eafd8ea5971', 5000, 'Transfer ke teman', 'COMPLETED', '2025-12-19 00:04:19.472', '2025-12-19 00:04:21.514'),
('f28826c3-87e0-4bf0-96be-026b74a52ed5', 'c44c4b47-cb79-4263-974f-14f9f31229e3', '267d9b33-e36b-412d-b5e6-611d3aa93599', 30000, 'Transfer teman', 'COMPLETED', '2025-12-19 00:15:50.270', '2025-12-19 00:15:51.858');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` varchar(36) NOT NULL,
  `first_name` longtext DEFAULT NULL,
  `last_name` longtext DEFAULT NULL,
  `phone` varchar(191) DEFAULT NULL,
  `address` longtext DEFAULT NULL,
  `pin` longtext DEFAULT NULL,
  `balance` bigint(20) DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `phone`, `address`, `pin`, `balance`, `created_at`, `updated_at`) VALUES
('267d9b33-e36b-412d-b5e6-611d3aa93599', 'nanda', 'wira', '08123456789', 'Jl. Baru No.99', '1234', 30000, '2025-12-18 18:21:37.212', '2025-12-19 01:34:44.074'),
('86021d3c-fb28-4814-bf4c-5852b8501c19', 'Budi', 'Santoso', '082345678910', 'Jl. Contoh No.1', '1234', 25000, '2025-12-19 01:22:05.214', '2025-12-19 01:27:02.195'),
('c44c4b47-cb79-4263-974f-14f9f31229e3', 'Najwa', 'Kafka', '082345678901', 'Palembang', '654321', 90000, '2025-12-19 00:10:41.400', '2025-12-19 00:19:36.248'),
('ce41c7b9-42a0-4102-aac9-85f0ec669caa', 'AYU', 'HANDAYANI', '082345678905', 'Palembang', '123456', 50000, '2025-12-19 01:18:24.812', '2025-12-19 01:25:49.798');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transaction_id`);

--
-- Indexes for table `transfer_queues`
--
ALTER TABLE `transfer_queues`
  ADD PRIMARY KEY (`transfer_queue_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `uni_users_phone` (`phone`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
