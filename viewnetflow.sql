-- phpMyAdmin SQL Dump
-- version 2.11.0
-- http://www.phpmyadmin.net
--
-- 主機: 127.0.0.1:3306
-- 建立日期: Dec 20, 2013, 03:18 PM
-- 伺服器版本: 5.0.45
-- PHP 版本: 5.2.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- 資料庫: `flowtool`
--

-- --------------------------------------------------------

--
-- 資料表格式： `history_ip`
--

CREATE TABLE IF NOT EXISTS `history_ip` (
  `type` varchar(10) NOT NULL,
  `date` datetime NOT NULL,
  `flow_down` bigint(20) NOT NULL,
  `dpkts_down` bigint(20) NOT NULL,
  `doctets_down` bigint(120) NOT NULL,
  `flow_up` bigint(20) NOT NULL,
  `dpkts_up` bigint(20) NOT NULL,
  `doctets_up` bigint(120) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- 資料表格式： `history_today_ip`
--

CREATE TABLE IF NOT EXISTS `history_today_ip` (
  `date` date NOT NULL,
  `ip` varchar(15) NOT NULL default '',
  `flow_down` int(10) default NULL,
  `dpkts_down` int(10) default NULL,
  `doctets_down` int(20) default NULL,
  `flow_up` int(10) default NULL,
  `dpkts_up` int(10) default NULL,
  `doctets_up` int(20) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- 資料表格式： `month_ip`
--

CREATE TABLE IF NOT EXISTS `month_ip` (
  `ip` varchar(15) NOT NULL default '',
  `flow_down` bigint(10) default NULL,
  `dpkts_down` bigint(10) default NULL,
  `doctets_down` bigint(20) default NULL,
  `flow_up` bigint(10) default NULL,
  `dpkts_up` bigint(10) default NULL,
  `doctets_up` bigint(20) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Stand-in structure for view `todayip_view`
--
CREATE TABLE IF NOT EXISTS `todayip_view` (
`ip` varchar(15)
,`doctets_down` int(20)
,`dpkts_down` int(10)
,`flow_down` int(10)
,`bpf_down` bigint(13)
,`ppf_down` bigint(13)
,`bpp_down` bigint(13)
,`doctets_up` int(20)
,`dpkts_up` int(10)
,`flow_up` int(10)
,`bpf_up` bigint(13)
,`ppf_up` bigint(13)
,`bpp_up` bigint(13)
);
-- --------------------------------------------------------

--
-- 資料表格式： `today_ip`
--

CREATE TABLE IF NOT EXISTS `today_ip` (
  `ip` varchar(15) NOT NULL default '',
  `flow_down` int(10) default NULL,
  `dpkts_down` int(10) default NULL,
  `doctets_down` int(20) default NULL,
  `flow_up` int(10) default NULL,
  `dpkts_up` int(10) default NULL,
  `doctets_up` int(20) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- 資料表格式： `today_ipdown`
--

CREATE TABLE IF NOT EXISTS `today_ipdown` (
  `ip` varchar(15) NOT NULL,
  `flow_down` int(10) NOT NULL,
  `dpkts_down` int(10) NOT NULL,
  `doctets_down` int(20) NOT NULL,
  `flow_up` int(10) NOT NULL,
  `dpkts_up` int(10) NOT NULL,
  `doctets_up` int(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- 資料表格式： `today_ipup`
--

CREATE TABLE IF NOT EXISTS `today_ipup` (
  `ip` varchar(15) NOT NULL,
  `flow_down` int(10) NOT NULL,
  `dpkts_down` int(10) NOT NULL,
  `doctets_down` int(20) NOT NULL,
  `flow_up` int(10) NOT NULL,
  `dpkts_up` int(10) NOT NULL,
  `doctets_up` int(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Stand-in structure for view `today_view`
--
CREATE TABLE IF NOT EXISTS `today_view` (
`ip` varchar(15)
,`flow_down` int(10)
,`dpkts_down` int(10)
,`doctets_down` int(20)
,`ppf_down` bigint(13)
,`bpf_down` bigint(13)
,`flow_up` int(10)
,`dpkts_up` int(10)
,`doctets_up` int(20)
,`ppf_up` bigint(13)
,`bpf_up` bigint(13)
);
-- --------------------------------------------------------

--
-- 資料表格式： `toplist`
--

CREATE TABLE IF NOT EXISTS `toplist` (
  `ip` varchar(15) NOT NULL default '',
  `value` bigint(12) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- 資料表格式： `week_ip`
--

CREATE TABLE IF NOT EXISTS `week_ip` (
  `ip` varchar(15) NOT NULL default '',
  `flow_down` bigint(10) default NULL,
  `dpkts_down` bigint(10) default NULL,
  `doctets_down` bigint(20) default NULL,
  `flow_up` bigint(10) default NULL,
  `dpkts_up` bigint(10) default NULL,
  `doctets_up` bigint(20) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure for view `todayip_view`
--
DROP TABLE IF EXISTS `todayip_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `flowtool`.`todayip_view` AS select `flowtool`.`today_ip`.`ip` AS `ip`,`flowtool`.`today_ip`.`doctets_down` AS `doctets_down`,`flowtool`.`today_ip`.`dpkts_down` AS `dpkts_down`,`flowtool`.`today_ip`.`flow_down` AS `flow_down`,ceiling((`flowtool`.`today_ip`.`doctets_down` / `flowtool`.`today_ip`.`flow_down`)) AS `bpf_down`,ceiling((`flowtool`.`today_ip`.`dpkts_down` / `flowtool`.`today_ip`.`flow_down`)) AS `ppf_down`,ceiling((`flowtool`.`today_ip`.`doctets_down` / `flowtool`.`today_ip`.`dpkts_down`)) AS `bpp_down`,`flowtool`.`today_ip`.`doctets_up` AS `doctets_up`,`flowtool`.`today_ip`.`dpkts_up` AS `dpkts_up`,`flowtool`.`today_ip`.`flow_up` AS `flow_up`,ceiling((`flowtool`.`today_ip`.`doctets_up` / `flowtool`.`today_ip`.`flow_up`)) AS `bpf_up`,ceiling((`flowtool`.`today_ip`.`dpkts_up` / `flowtool`.`today_ip`.`flow_up`)) AS `ppf_up`,ceiling((`flowtool`.`today_ip`.`doctets_up` / `flowtool`.`today_ip`.`dpkts_up`)) AS `bpp_up` from `flowtool`.`today_ip`;

-- --------------------------------------------------------

--
-- Structure for view `today_view`
--
DROP TABLE IF EXISTS `today_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `flowtool`.`today_view` AS select `flowtool`.`today_ip`.`ip` AS `ip`,`flowtool`.`today_ip`.`flow_down` AS `flow_down`,`flowtool`.`today_ip`.`dpkts_down` AS `dpkts_down`,`flowtool`.`today_ip`.`doctets_down` AS `doctets_down`,ceiling((`flowtool`.`today_ip`.`dpkts_down` / `flowtool`.`today_ip`.`flow_down`)) AS `ppf_down`,ceiling((`flowtool`.`today_ip`.`doctets_down` / `flowtool`.`today_ip`.`flow_down`)) AS `bpf_down`,`flowtool`.`today_ip`.`flow_up` AS `flow_up`,`flowtool`.`today_ip`.`dpkts_up` AS `dpkts_up`,`flowtool`.`today_ip`.`doctets_up` AS `doctets_up`,ceiling((`flowtool`.`today_ip`.`dpkts_up` / `flowtool`.`today_ip`.`flow_up`)) AS `ppf_up`,ceiling((`flowtool`.`today_ip`.`doctets_up` / `flowtool`.`today_ip`.`flow_up`)) AS `bpf_up` from `flowtool`.`today_ip`;

