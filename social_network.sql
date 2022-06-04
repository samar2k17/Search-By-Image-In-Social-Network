-- phpMyAdmin SQL Dump
-- version 3.3.9
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 01, 2019 at 06:25 AM
-- Server version: 5.5.8
-- PHP Version: 5.3.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `social_network`
--

-- --------------------------------------------------------

--
-- Table structure for table `tblbanned`
--

CREATE TABLE IF NOT EXISTS `tblbanned` (
  `filename` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblbanned`
--

INSERT INTO `tblbanned` (`filename`) VALUES
('F1554099820693.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `tblfeedback`
--

CREATE TABLE IF NOT EXISTS `tblfeedback` (
  `fid` int(11) NOT NULL AUTO_INCREMENT,
  `feedback` varchar(200) NOT NULL,
  `userid` varchar(11) NOT NULL,
  `fuserid` varchar(11) NOT NULL,
  `rdate` date NOT NULL,
  PRIMARY KEY (`fid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `tblfeedback`
--

INSERT INTO `tblfeedback` (`fid`, `feedback`, `userid`, `fuserid`, `rdate`) VALUES
(1, 'he is a very good officer.                            ', '2', '11', '2016-12-14');

-- --------------------------------------------------------

--
-- Table structure for table `tblfiles`
--

CREATE TABLE IF NOT EXISTS `tblfiles` (
  `userid` int(11) NOT NULL,
  `filename` varchar(30) NOT NULL,
  `filepath` varchar(60) NOT NULL,
  `adding_date` date NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(20) DEFAULT NULL,
  `fuserid` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `tblfiles`
--

INSERT INTO `tblfiles` (`userid`, `filename`, `filepath`, `adding_date`, `id`, `status`, `fuserid`) VALUES
(2, 'my first file', 'F1481654865755.pdf', '2016-12-14', 1, 'Approve', '11'),
(2, 'hello niro', 'F1481684474902.docx', '2016-12-14', 2, 'Complete', '11'),
(2, 'ffggh', 'F1487228875192.jpg', '2017-02-16', 3, 'Pending', '11');

-- --------------------------------------------------------

--
-- Table structure for table `tblfriends`
--

CREATE TABLE IF NOT EXISTS `tblfriends` (
  `fid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(10) NOT NULL,
  `fuserid` varchar(10) NOT NULL,
  `status` varchar(20) NOT NULL,
  `rdate` date NOT NULL,
  PRIMARY KEY (`fid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `tblfriends`
--

INSERT INTO `tblfriends` (`fid`, `userid`, `fuserid`, `status`, `rdate`) VALUES
(4, '11', '2', 'Accepted', '2018-03-07');

-- --------------------------------------------------------

--
-- Table structure for table `tbllikes`
--

CREATE TABLE IF NOT EXISTS `tbllikes` (
  `lid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(10) NOT NULL,
  `likes` varchar(50) NOT NULL,
  `rdate` date NOT NULL,
  PRIMARY KEY (`lid`),
  UNIQUE KEY `userid` (`userid`,`likes`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `tbllikes`
--

INSERT INTO `tbllikes` (`lid`, `userid`, `likes`, `rdate`) VALUES
(4, '2', 'A', '2018-03-07'),
(7, '2', 'B', '2018-03-07'),
(8, '2', 'C', '2018-03-07'),
(9, '2', 'D', '2018-03-07'),
(10, '11', 'A', '2018-03-07'),
(11, '11', 'C', '2018-03-07'),
(12, '14', 'A', '2018-03-07'),
(13, '14', 'C', '2018-03-07'),
(14, '14', 'D', '2018-03-07');

-- --------------------------------------------------------

--
-- Table structure for table `tblmessages`
--

CREATE TABLE IF NOT EXISTS `tblmessages` (
  `messageid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(10) NOT NULL,
  `fuserid` varchar(10) NOT NULL,
  `text` varchar(100) NOT NULL,
  `rdate` datetime NOT NULL,
  `data_type` varchar(20) NOT NULL,
  PRIMARY KEY (`messageid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `tblmessages`
--

INSERT INTO `tblmessages` (`messageid`, `userid`, `fuserid`, `text`, `rdate`, `data_type`) VALUES
(2, '11', '2', 'haan bolo', '2016-12-14 10:24:58', 'text'),
(3, '11', '2', 'hkhhkhk', '2017-02-16 12:36:54', 'text'),
(4, '2', '11', 'check file', '2017-02-16 12:39:13', 'text'),
(5, '2', '11', 'F1487228953266.jpg', '2017-02-16 12:39:13', 'document'),
(6, '2', '11', 'hi niro', '2018-03-07 06:21:01', 'text'),
(7, '2', '11', 'hi niro how are you', '2018-03-07 06:21:14', 'text'),
(8, '2', '11', 'F1520427074467.pdf', '2018-03-07 06:21:14', 'document'),
(10, '2', '11', 'so how are you mr mohan', '2018-03-07 06:36:42', 'text');

-- --------------------------------------------------------

--
-- Table structure for table `tblstatus`
--

CREATE TABLE IF NOT EXISTS `tblstatus` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(180) NOT NULL,
  `filename` varchar(30) NOT NULL,
  `userid` varchar(10) NOT NULL,
  `rdate` datetime NOT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `tblstatus`
--

INSERT INTO `tblstatus` (`sid`, `status`, `filename`, `userid`, `rdate`) VALUES
(2, 'hi hello', 'F1520413564856.jpg', '2', '2018-03-07 00:00:00'),
(3, 'alafadasd', 'F1520413751407.png', '2', '2018-03-07 00:00:00'),
(4, 'asad', 'F1520413759171.jpg', '2', '2018-03-07 00:00:00'),
(6, 'asdasdasd', 'F1520413776424.jpg', '2', '2018-03-07 00:00:00'),
(7, 'hi hwllo now', 'F1520432783882.jpeg', '2', '2018-03-07 19:56:23');

-- --------------------------------------------------------

--
-- Table structure for table `tbluser`
--

CREATE TABLE IF NOT EXISTS `tbluser` (
  `fname` varchar(20) NOT NULL,
  `lname` varchar(20) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(20) NOT NULL,
  `emailid` varchar(30) NOT NULL,
  `mobile_no` varchar(10) NOT NULL,
  `address` varchar(100) NOT NULL,
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `rdate` date NOT NULL,
  `usertype` varchar(10) NOT NULL,
  `status` varchar(10) NOT NULL,
  `image` varchar(30) DEFAULT 'NA',
  PRIMARY KEY (`userid`),
  UNIQUE KEY `username` (`username`,`emailid`),
  UNIQUE KEY `mobile_no` (`mobile_no`),
  UNIQUE KEY `emailid` (`emailid`),
  UNIQUE KEY `emailid_2` (`emailid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `tbluser`
--

INSERT INTO `tbluser` (`fname`, `lname`, `username`, `password`, `emailid`, `mobile_no`, `address`, `userid`, `rdate`, `usertype`, `status`, `image`) VALUES
('Durgesh', 'Kumar', 'durgeshk', 'asdfgh', 'admin@gmail.com', '9898998999', 'London', 1, '2014-09-26', 'admin', 'True', NULL),
('User', 'dfsfa', 'user', 'asdfgh', 'user@gmail.com', '9999999999', 'New delhi', 2, '2014-09-28', 'user', 'True', 'F1520417071255.jpg'),
('Niro', 'Thakur', 'niro', 'asdfgh', 'niro@gmail.com', '9555542585', 'New delhi1', 11, '2016-12-13', 'user', 'True', 'NA'),
('Anushree', 'Kesarwani', 'anushree', '1006987', 'anushree.k1994@gmail.com', '8800580794', 'Delhi', 14, '2017-02-16', 'user', 'True', 'F1520413751407.png'),
('rakeshkr', 'singh', 'rakeshkr', '186502', 'samarrashid10@gmail.com', '9205502894', 'delhi', 15, '2019-04-01', 'user', 'True', 'NA');
