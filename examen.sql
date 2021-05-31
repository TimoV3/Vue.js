-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Gegenereerd op: 31 mei 2021 om 13:57
-- Serverversie: 10.4.17-MariaDB
-- PHP-versie: 7.4.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `examen`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `bestellingen`
--

CREATE TABLE `bestellingen` (
  `ID` int(11) NOT NULL,
  `Reserveringen_ID` int(11) NOT NULL,
  `Menuitem_ID` int(11) NOT NULL,
  `Aantal` int(11) NOT NULL,
  `Gereserveerd` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `gerechtencategorien`
--

CREATE TABLE `gerechtencategorien` (
  `ID` int(11) NOT NULL,
  `Code` varchar(3) NOT NULL,
  `Naam` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `gerechtsoorten`
--

CREATE TABLE `gerechtsoorten` (
  `ID` int(11) NOT NULL,
  `Code` varchar(3) NOT NULL,
  `Naam` varchar(20) NOT NULL,
  `Gerechtencategorie_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `klanten`
--

CREATE TABLE `klanten` (
  `ID` int(11) NOT NULL,
  `Naam` varchar(20) NOT NULL,
  `Telefoon` varchar(11) DEFAULT NULL,
  `Email` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `menuitems`
--

CREATE TABLE `menuitems` (
  `ID` int(11) NOT NULL,
  `Code` varchar(4) NOT NULL,
  `Naam` varchar(30) DEFAULT NULL,
  `Gerechtsoort_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `reserveringen`
--

CREATE TABLE `reserveringen` (
  `ID` int(11) NOT NULL,
  `Tafel` int(11) NOT NULL,
  `Datum` date DEFAULT NULL,
  `Tijd` time DEFAULT NULL,
  `Klant_ID` int(11) NOT NULL,
  `Aantal` int(11) NOT NULL,
  `Status` tinyint(4) NOT NULL,
  `Datum_toegevoegd` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Aantal_k` int(11) NOT NULL,
  `Allergieen` text DEFAULT NULL,
  `Opmerkingen` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `bestellingen`
--
ALTER TABLE `bestellingen`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Reserveringen_ID` (`Reserveringen_ID`),
  ADD KEY `Menuitem_ID` (`Menuitem_ID`);

--
-- Indexen voor tabel `gerechtencategorien`
--
ALTER TABLE `gerechtencategorien`
  ADD PRIMARY KEY (`ID`);

--
-- Indexen voor tabel `gerechtsoorten`
--
ALTER TABLE `gerechtsoorten`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Gerechtencategorie_ID` (`Gerechtencategorie_ID`);

--
-- Indexen voor tabel `klanten`
--
ALTER TABLE `klanten`
  ADD PRIMARY KEY (`ID`);

--
-- Indexen voor tabel `menuitems`
--
ALTER TABLE `menuitems`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Gerechtsoort_ID` (`Gerechtsoort_ID`);

--
-- Indexen voor tabel `reserveringen`
--
ALTER TABLE `reserveringen`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `bestellingen`
--
ALTER TABLE `bestellingen`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `reserveringen`
--
ALTER TABLE `reserveringen`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `bestellingen`
--
ALTER TABLE `bestellingen`
  ADD CONSTRAINT `bestellingen_ibfk_1` FOREIGN KEY (`Reserveringen_ID`) REFERENCES `reserveringen` (`ID`),
  ADD CONSTRAINT `bestellingen_ibfk_2` FOREIGN KEY (`Menuitem_ID`) REFERENCES `menuitems` (`ID`);

--
-- Beperkingen voor tabel `gerechtsoorten`
--
ALTER TABLE `gerechtsoorten`
  ADD CONSTRAINT `gerechtsoorten_ibfk_1` FOREIGN KEY (`Gerechtencategorie_ID`) REFERENCES `gerechtencategorien` (`ID`);

--
-- Beperkingen voor tabel `menuitems`
--
ALTER TABLE `menuitems`
  ADD CONSTRAINT `menuitems_ibfk_1` FOREIGN KEY (`Gerechtsoort_ID`) REFERENCES `gerechtsoorten` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
