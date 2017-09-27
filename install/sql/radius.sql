-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Mer 27 Septembre 2017 à 23:55
-- Version du serveur: 5.5.38-0ubuntu0.14.04.1
-- Version de PHP: 5.5.9-1ubuntu4.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `radius`
--

-- --------------------------------------------------------

--
-- Structure de la table `nas`
--

CREATE TABLE IF NOT EXISTS `nas` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nasname` varchar(128) NOT NULL,
  `shortname` varchar(32) DEFAULT NULL,
  `type` varchar(30) DEFAULT 'other',
  `ports` int(5) DEFAULT NULL,
  `secret` varchar(60) NOT NULL DEFAULT 'secret',
  `server` varchar(64) DEFAULT NULL,
  `community` varchar(50) DEFAULT NULL,
  `description` varchar(200) DEFAULT 'RADIUS Client',
  PRIMARY KEY (`id`),
  KEY `nasname` (`nasname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `radacct`
--

CREATE TABLE IF NOT EXISTS `radacct` (
  `radacctid` bigint(21) NOT NULL AUTO_INCREMENT,
  `acctsessionid` varchar(64) NOT NULL DEFAULT '',
  `acctuniqueid` varchar(32) NOT NULL DEFAULT '',
  `username` varchar(64) NOT NULL DEFAULT '',
  `groupname` varchar(64) NOT NULL DEFAULT '',
  `realm` varchar(64) DEFAULT '',
  `nasipaddress` varchar(15) NOT NULL DEFAULT '',
  `nasportid` varchar(15) DEFAULT NULL,
  `nasporttype` varchar(32) DEFAULT NULL,
  `acctstarttime` datetime DEFAULT NULL,
  `acctstoptime` datetime DEFAULT NULL,
  `acctsessiontime` int(12) DEFAULT NULL,
  `acctauthentic` varchar(32) DEFAULT NULL,
  `connectinfo_start` varchar(50) DEFAULT NULL,
  `connectinfo_stop` varchar(50) DEFAULT NULL,
  `acctinputoctets` bigint(20) DEFAULT NULL,
  `acctoutputoctets` bigint(20) DEFAULT NULL,
  `calledstationid` varchar(50) NOT NULL DEFAULT '',
  `callingstationid` varchar(50) NOT NULL DEFAULT '',
  `acctterminatecause` varchar(32) NOT NULL DEFAULT '',
  `servicetype` varchar(32) DEFAULT NULL,
  `framedprotocol` varchar(32) DEFAULT NULL,
  `framedipaddress` varchar(15) NOT NULL DEFAULT '',
  `acctstartdelay` int(12) DEFAULT NULL,
  `acctstopdelay` int(12) DEFAULT NULL,
  `xascendsessionsvrkey` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`radacctid`),
  KEY `username` (`username`),
  KEY `framedipaddress` (`framedipaddress`),
  KEY `acctsessionid` (`acctsessionid`),
  KEY `acctsessiontime` (`acctsessiontime`),
  KEY `acctuniqueid` (`acctuniqueid`),
  KEY `acctstarttime` (`acctstarttime`),
  KEY `acctstoptime` (`acctstoptime`),
  KEY `nasipaddress` (`nasipaddress`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--

-- --------------------------------------------------------

--
-- Structure de la table `radcheck_old`
--

CREATE TABLE IF NOT EXISTS `radcheck_old` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL DEFAULT '',
  `attribute` varchar(64) NOT NULL DEFAULT '',
  `op` char(2) NOT NULL DEFAULT '==',
  `value` varchar(253) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `username` (`username`(32))
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;



-- --------------------------------------------------------

--
-- Structure de la table `radgroupcheck`
--

CREATE TABLE IF NOT EXISTS `radgroupcheck` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `groupname` varchar(64) NOT NULL DEFAULT '',
  `attribute` varchar(64) NOT NULL DEFAULT '',
  `op` char(2) NOT NULL DEFAULT '==',
  `value` varchar(253) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `groupname` (`groupname`(32))
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `radgroupreply`
--

CREATE TABLE IF NOT EXISTS `radgroupreply` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `groupname` varchar(64) NOT NULL DEFAULT '',
  `attribute` varchar(64) NOT NULL DEFAULT '',
  `op` char(2) NOT NULL DEFAULT '=',
  `value` varchar(253) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `groupname` (`groupname`(32))
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `radpostauth`
--

CREATE TABLE IF NOT EXISTS `radpostauth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL DEFAULT '',
  `pass` varchar(64) NOT NULL DEFAULT '',
  `reply` varchar(32) NOT NULL DEFAULT '',
  `authdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `radreply`
--

CREATE TABLE IF NOT EXISTS `radreply` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL DEFAULT '',
  `attribute` varchar(64) NOT NULL DEFAULT '',
  `op` char(2) NOT NULL DEFAULT '=',
  `value` varchar(253) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `username` (`username`(32))
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--

-- --------------------------------------------------------

--
-- Structure de la table `radusergroup_old`
--

CREATE TABLE IF NOT EXISTS `radusergroup_old` (
  `username` varchar(64) NOT NULL DEFAULT '',
  `groupname` varchar(64) NOT NULL DEFAULT '',
  `priority` int(11) NOT NULL DEFAULT '1',
  KEY `username` (`username`(32))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `radusergroup_old`


-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pseudo` text,
  `statut` text,
  `staff` int(11) DEFAULT NULL,
  `mac` text,
  `paiement` text,
  `etat` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  FULLTEXT KEY `pseudo` (`pseudo`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=56 ;

--
-- Contenu de la table `users`
--

INSERT INTO `users` (`id`, `pseudo`, `statut`, `staff`, `mac`, `paiement`, `etat`) VALUES
(1, 'Skyline', '', NULL, '', '', 0),
(2, '[TnT]GeTRoGuE', '', NULL, '', '', 0),
(3, '[Burnhead]Fanch', '', NULL, '', '', 0),
(4, '[Burnhead]Yianas', '', NULL, '', '', 0),
(5, '[Burnhead]Devilmaydante', '', NULL, '', '', 0),
(6, '[Burnhead]Paulolafoudre', '', NULL, '', '', 0),
(7, 'Pops', '', NULL, '', '', 0),
(8, '[Burnhead]Miniou', '', NULL, '', '', 0),
(9, '[Titeuf''Team]Guga Cola', '', NULL, '', '', 0),
(10, '[BHD]goose', '', NULL, '', '', 0),
(11, '[Tit''oeuf-team]Tostaky', '', NULL, '', '', 0),
(12, '[Tit''oeuf-team]grommur', '', NULL, '', '', 0),
(13, '[Burnhaed]ArKa', '', NULL, '', '', 0),
(14, 'Articondin', '', NULL, '', '', 0),
(15, 'Snyps95', '', NULL, '', '', 0),
(16, '[TnT]Tiama', '', NULL, '', '', 0),
(17, '[Titeuf''Team]goonia', '', NULL, '', '', 0),
(18, '[Oufs]Didjo', '', NULL, '', '', 0),
(19, '[Oufs]Koantenn', '', NULL, '', '', 0),
(20, '[burnhead]Gado', '', NULL, '', '', 0),
(21, '[Burnhead]Green', '', NULL, '', '', 0),
(22, '[GDTC]Venus Noire', '', NULL, '', '', 0),
(23, '[GDTC]Sepultura', '', NULL, '', '', 0),
(24, '[BHD]K', '', NULL, '', '', 0),
(25, '[Burnhead]Heo', '', NULL, '', '', 0),
(26, '[Titeuf Team]Sam Troulku', '', NULL, '', '', 0),
(27, '[tit''oeuf team]homer', '', NULL, '', '', 0),
(28, '[TnT]YumeTako', '', NULL, '', '', 0),
(29, '[Oufs]Angelfire', '', NULL, '', '', 0),
(30, '[Oufs]Didou', '', NULL, '', '', 0),
(31, '[Oufs]SinCaraa', '', NULL, '', '', 0),
(32, '[Tit''oeuf team]Ayesha', '', NULL, '', '', 0),
(33, 'D4rkw3st', '', NULL, '', '', 0),
(34, 'Antho', '', NULL, '', '', 0),
(35, '[TnT]Offman', '', NULL, '', '', 0),
(36, '[No Name]Nirotrix', '', NULL, '', '', 0),
(37, '[TnT]Xendeur', '', NULL, '', '', 0),
(38, '[Tit''oeuf Team]Kriscioss', '', NULL, '', '', 0),
(39, '[Oufs]Tevaurel', '', NULL, '', '', 0),
(40, '[TnT]Wartiouf', '', NULL, '', '', 0),
(41, '[No Name]Dweyna', '', NULL, '', '', 0),
(42, '[TnT]Thaeg', '', NULL, '', '', 0),
(43, '[Burnhead]Hunterblaze', '', NULL, '', '', 0),
(44, '[Burnhead]Herth', '', NULL, '', '', 0),
(45, '[TnT]Axmel', '', NULL, '', '', 0),
(46, '[TnT]Pignack', '', NULL, '', '', 0),
(47, 'micho', '', NULL, '', '', 0),
(48, '[Burnhead]KavÃ©', '', NULL, '', '', 0),
(49, 'Ju2256', 'staff', NULL, 'd4-3d-7e-4b-0a-ac', '', 1),
(50, 'Bogosse', 'staff', NULL, '', '', 0),
(51, 'Titeuf', 'staff', NULL, '', '', 0),
(52, 'Corel', 'staff', NULL, '', '', 0),
(53, 'Mr.Natas', 'staff', NULL, '', '', 0),
(54, 'Tiaurel', 'staff', NULL, '', '', 0),
(55, 'Kazer', 'staff', NULL, '', '', 0);

-- --------------------------------------------------------


-- --------------------------------------------------------

--
-- Structure de la vue `radcheck`
--
DROP TABLE IF EXISTS `radcheck`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `radcheck` AS select `users`.`id` AS `id`,`users`.`mac` AS `username`,'Password' AS `attribute`,'=' AS `op`,'oufslan' AS `value` from `users` where ((`users`.`etat` = 1) and (`users`.`mac` <> ''));

-- --------------------------------------------------------

--
-- Structure de la vue `radusergroup`
--
DROP TABLE IF EXISTS `radusergroup`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `radusergroup` AS select `users`.`id` AS `id`,`users`.`mac` AS `username`,'oufslan' AS `groupname`,1 AS `priority` from `users` where ((`users`.`etat` = 1) and (`users`.`mac` <> ''));

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
