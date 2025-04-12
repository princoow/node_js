-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : sam. 15 mars 2025 à 13:20
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `hopital`
--

-- --------------------------------------------------------

--
-- Structure de la table `appointments`
--

CREATE TABLE `appointments` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `prenom` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `specialty` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `appointments`
--

INSERT INTO `appointments` (`id`, `name`, `prenom`, `email`, `phone`, `date`, `specialty`, `created_at`) VALUES
(1, 'Traore', NULL, 'tresorlevi@icloud.com', '0777683059', '2025-09-08', 'Rhumatologue', '2025-03-15 05:11:30'),
(2, NULL, NULL, 'tresorlevi@icloud.com', '0777683059', '2025-09-08', 'Rhumatologue', '2025-03-15 05:12:46'),
(3, NULL, NULL, 'tresorlevi@icloud.com', '0777683059', '2025-09-08', 'Rhumatologue', '2025-03-15 05:13:16'),
(4, NULL, NULL, 'tresorlevi@icloud.com', '0777683059', '2025-01-09', 'Rhumatologue', '2025-03-15 05:31:55');

-- --------------------------------------------------------

--
-- Structure de la table `comptes`
--

CREATE TABLE `comptes` (
  `id` int(11) NOT NULL,
  `id_users` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `role` enum('patient','secretaire','admin') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `medecins`
--

CREATE TABLE `medecins` (
  `id` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `id_specialites` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `rdv`
--

CREATE TABLE `rdv` (
  `id_rdv` int(11) NOT NULL,
  `id_users` int(11) NOT NULL,
  `id_specialites` int(11) NOT NULL,
  `id_secretaire` int(11) DEFAULT NULL,
  `date_rdv` date NOT NULL,
  `status` enum('en attente','confirmé','annulé') DEFAULT 'en attente',
  `date_creation` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `specialites`
--

CREATE TABLE `specialites` (
  `id_specialites` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `specialites`
--

INSERT INTO `specialites` (`id_specialites`, `nom`) VALUES
(2, 'Cardiologue'),
(12, 'Chirurgien'),
(3, 'Dentiste'),
(4, 'Dermatologue'),
(7, 'Gastro-entérologue'),
(11, 'Gynécologue-obstétricien'),
(1, 'Médecin Généraliste'),
(8, 'Néphrologue'),
(6, 'Neurologue'),
(14, 'Oncologue'),
(10, 'Pédiatre'),
(5, 'Pneumologue'),
(13, 'Radiologue'),
(9, 'Rhumatologue');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id_users` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `adresse` varchar(255) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `statut` enum('patient','secretaire') NOT NULL,
  `date_inscription` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id_users`, `nom`, `prenom`, `adresse`, `telephone`, `email`, `mot_de_passe`, `statut`, `date_inscription`) VALUES
(4, 'Koffi', 'grace', 'Abidjan', '0777683059', 'gracekoffi033@gmail.com', '$2b$10$FT0Dn81XerrLJOrLSqJHO.KkW.G8Vg1oaRxfvfb5JhIi5q0LbGeYO', 'patient', '2025-03-15 12:02:18'),
(5, 'kouassi', 'Carelle', 'Abidjan', '0777683059', 'carellekouassi@gmail.com', '$2b$10$zrMUEFKWW4Rvrevo991BNeKGzBbyK.Mk/exdjlDVlvlv6ulP7ofrm', 'secretaire', '2025-03-15 12:02:51'),
(6, 'konan', 'christ', 'abidjan', '0998775434', 'konanchrist@gmail.com', '$2b$10$jtlYK8aqkNTvjy8k1IzRTeQfeS9EhFqz44cDdl0L9UJ8TPtKPOeZK', 'patient', '2025-03-15 12:09:07'),
(7, 'adou', 'ines', 'Abidjan', '0987654321', 'adouines@gmail.com', '$2b$10$2xFkJqxMiUJeSy2BfIux/.ugOjd8RpArUW.DpiPk6rKO15EzISHd2', 'secretaire', '2025-03-15 12:10:47');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `comptes`
--
ALTER TABLE `comptes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_users` (`id_users`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `medecins`
--
ALTER TABLE `medecins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_specialites` (`id_specialites`);

--
-- Index pour la table `rdv`
--
ALTER TABLE `rdv`
  ADD PRIMARY KEY (`id_rdv`),
  ADD KEY `id_users` (`id_users`),
  ADD KEY `id_specialites` (`id_specialites`);

--
-- Index pour la table `specialites`
--
ALTER TABLE `specialites`
  ADD PRIMARY KEY (`id_specialites`),
  ADD UNIQUE KEY `nom` (`nom`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_users`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `comptes`
--
ALTER TABLE `comptes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `medecins`
--
ALTER TABLE `medecins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `rdv`
--
ALTER TABLE `rdv`
  MODIFY `id_rdv` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `specialites`
--
ALTER TABLE `specialites`
  MODIFY `id_specialites` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id_users` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `comptes`
--
ALTER TABLE `comptes`
  ADD CONSTRAINT `comptes_ibfk_1` FOREIGN KEY (`id_users`) REFERENCES `users` (`id_users`);

--
-- Contraintes pour la table `medecins`
--
ALTER TABLE `medecins`
  ADD CONSTRAINT `medecins_ibfk_1` FOREIGN KEY (`id_specialites`) REFERENCES `specialites` (`id_specialites`);

--
-- Contraintes pour la table `rdv`
--
ALTER TABLE `rdv`
  ADD CONSTRAINT `rdv_ibfk_1` FOREIGN KEY (`id_users`) REFERENCES `users` (`id_users`),
  ADD CONSTRAINT `rdv_ibfk_2` FOREIGN KEY (`id_specialites`) REFERENCES `specialites` (`id_specialites`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
