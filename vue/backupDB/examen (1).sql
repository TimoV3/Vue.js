-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Gegenereerd op: 01 jun 2021 om 07:57
-- Serverversie: 10.4.8-MariaDB
-- PHP-versie: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
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
  `Reservering_ID` int(11) NOT NULL,
  `Menuitem_ID` int(11) NOT NULL,
  `Aantal` int(11) DEFAULT NULL,
  `Geserveerd` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `gerechtencategorien`
--

CREATE TABLE `gerechtencategorien` (
  `ID` int(11) NOT NULL,
  `Code` varchar(3) NOT NULL,
  `Naam` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Gegevens worden geëxporteerd voor tabel `gerechtencategorien`
--

INSERT INTO `gerechtencategorien` (`ID`, `Code`, `Naam`) VALUES
(1, 'drk', 'Dranken'),
(2, 'hap', 'Hapjes'),
(3, 'hog', 'Hoofdgerechten'),
(4, 'nag', 'Nagerechten'),
(5, 'vog', 'Voorgerechten');

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

--
-- Gegevens worden geëxporteerd voor tabel `gerechtsoorten`
--

INSERT INTO `gerechtsoorten` (`ID`, `Code`, `Naam`, `Gerechtencategorie_ID`) VALUES
(1, 'bik', 'Bieren', 1),
(2, 'fik', 'Frisdranken', 1),
(3, 'ijn', 'Ijs', 4),
(4, 'koh', 'Koude voorgerechten', 2),
(5, 'mov', 'mousse', 4),
(6, 'veh', 'Vegatarische gerecht', 3),
(7, 'kov', 'Koude voorgerechten', 5);

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

--
-- Gegevens worden geëxporteerd voor tabel `klanten`
--

INSERT INTO `klanten` (`ID`, `Naam`, `Telefoon`, `Email`) VALUES
(1, 'Hans janssen', '0648587140', 'hansjanssen@gmail.com'),
(2, 'Erik seldenthuis', '0674133912', 'erik@zeldenthuis.nl'),
(3, 'Jan meeuwissen', '0637326423', 'janiseen@meeuwsen.nl');

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

--
-- Gegevens worden geëxporteerd voor tabel `menuitems`
--

INSERT INTO `menuitems` (`ID`, `Code`, `Naam`, `Gerechtsoort_ID`) VALUES
(1, 'hrtg', 'hertog jan', 1),
(2, 'fant', 'Fanta', 2),
(3, 'viss', 'Vissen schaal', 4),
(4, 'vsch', 'vega schintzel', 6),
(5, 'peps', 'pepsi', 2);

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
  `Datum_toegevoegd` timestamp NOT NULL DEFAULT current_timestamp(),
  `Aantal_k` int(11) NOT NULL,
  `Allergieen` text DEFAULT NULL,
  `Opmerkingen` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Gegevens worden geëxporteerd voor tabel `reserveringen`
--

INSERT INTO `reserveringen` (`ID`, `Tafel`, `Datum`, `Tijd`, `Klant_ID`, `Aantal`, `Status`, `Datum_toegevoegd`, `Aantal_k`, `Allergieen`, `Opmerkingen`) VALUES
(3, 3, '2021-03-12', '16:00:00', 2, 0, 1, '2021-05-31 20:21:19', 5, 'raar', 'help'),
(6, 2, '2021-03-31', '18:00:00', 2, 0, 1, '2021-12-21 23:00:00', 3, '', ''),
(7, 12, '2021-05-26', '22:00:00', 1, 0, 1, '2021-05-31 20:32:00', 1, 'raaar', 'toch'),
(8, 3, '2021-05-31', '14:33:00', 1, 3, 1, '2021-05-31 20:33:00', 4, 'geen', 'geen'),
(10, 33, '2021-06-17', '00:17:00', 2, 0, 1, '2021-07-02 22:12:00', 3, 'geen', '1');

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `bestellingen`
--
ALTER TABLE `bestellingen`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Reservering_ID` (`Reservering_ID`),
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
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Klant_ID` (`Klant_ID`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `bestellingen`
--
ALTER TABLE `bestellingen`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `menuitems`
--
ALTER TABLE `menuitems`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT voor een tabel `reserveringen`
--
ALTER TABLE `reserveringen`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `bestellingen`
--
ALTER TABLE `bestellingen`
  ADD CONSTRAINT `bestellingen_ibfk_1` FOREIGN KEY (`Reservering_ID`) REFERENCES `reserveringen` (`ID`),
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

--
-- Beperkingen voor tabel `reserveringen`
--
ALTER TABLE `reserveringen`
  ADD CONSTRAINT `reserveringen_ibfk_1` FOREIGN KEY (`Klant_ID`) REFERENCES `klanten` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
