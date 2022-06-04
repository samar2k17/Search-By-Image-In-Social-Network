-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 09, 2018 at 01:13 PM
-- Server version: 5.7.21-0ubuntu0.16.04.1
-- PHP Version: 7.0.25-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `social_network`
--
CREATE DATABASE IF NOT EXISTS `social_network` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `social_network`;

-- --------------------------------------------------------

--
-- Table structure for table `tblfeedback`
--

CREATE TABLE `tblfeedback` (
  `fid` int(11) NOT NULL,
  `feedback` varchar(200) NOT NULL,
  `userid` varchar(11) NOT NULL,
  `fuserid` varchar(11) NOT NULL,
  `rdate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblfeedback`
--

INSERT INTO `tblfeedback` (`fid`, `feedback`, `userid`, `fuserid`, `rdate`) VALUES
(1, 'he is a very good officer.                            ', '2', '11', '2016-12-14');

-- --------------------------------------------------------

--
-- Table structure for table `tblfiles`
--

CREATE TABLE `tblfiles` (
  `userid` int(11) NOT NULL,
  `filename` varchar(30) NOT NULL,
  `filepath` varchar(60) NOT NULL,
  `adding_date` date NOT NULL,
  `id` int(11) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `fuserid` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

CREATE TABLE `tblfriends` (
  `fid` int(11) NOT NULL,
  `userid` varchar(10) NOT NULL,
  `fuserid` varchar(10) NOT NULL,
  `status` varchar(20) NOT NULL,
  `rdate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblfriends`
--

INSERT INTO `tblfriends` (`fid`, `userid`, `fuserid`, `status`, `rdate`) VALUES
(4, '11', '2', 'Accepted', '2018-03-07');

-- --------------------------------------------------------

--
-- Table structure for table `tbllikes`
--

CREATE TABLE `tbllikes` (
  `lid` int(11) NOT NULL,
  `userid` varchar(10) NOT NULL,
  `likes` varchar(50) NOT NULL,
  `rdate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

CREATE TABLE `tblmessages` (
  `messageid` int(11) NOT NULL,
  `userid` varchar(10) NOT NULL,
  `fuserid` varchar(10) NOT NULL,
  `text` varchar(100) NOT NULL,
  `rdate` datetime NOT NULL,
  `data_type` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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

CREATE TABLE `tblstatus` (
  `sid` int(11) NOT NULL,
  `status` varchar(180) NOT NULL,
  `filename` varchar(30) NOT NULL,
  `userid` varchar(10) NOT NULL,
  `rdate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

CREATE TABLE `tbluser` (
  `fname` varchar(20) NOT NULL,
  `lname` varchar(20) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(20) NOT NULL,
  `emailid` varchar(30) NOT NULL,
  `mobile_no` varchar(10) NOT NULL,
  `address` varchar(100) NOT NULL,
  `userid` int(11) NOT NULL,
  `rdate` date NOT NULL,
  `usertype` varchar(10) NOT NULL,
  `status` varchar(10) NOT NULL,
  `image` varchar(30) DEFAULT 'NA'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbluser`
--

INSERT INTO `tbluser` (`fname`, `lname`, `username`, `password`, `emailid`, `mobile_no`, `address`, `userid`, `rdate`, `usertype`, `status`, `image`) VALUES
('Durgesh', 'Kumar', 'durgeshk', 'asdfgh', 'admin@gmail.com', '9898998999', 'London', 1, '2014-09-26', 'admin', 'True', NULL),
('User', 'dfsfa', 'user', 'asdfgh', 'user@gmail.com', '9999999999', 'New delhi', 2, '2014-09-28', 'user', 'True', 'F1520417071255.jpg'),
('Niro', 'Thakur', 'niro', 'asdfgh', 'niro@gmail.com', '9555542585', 'New delhi1', 11, '2016-12-13', 'user', 'True', 'NA'),
('Anushree', 'Kesarwani', 'anushree', '1006987', 'anushree.k1994@gmail.com', '8800580794', 'Delhi', 14, '2017-02-16', 'user', 'True', 'F1520413751407.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tblfeedback`
--
ALTER TABLE `tblfeedback`
  ADD PRIMARY KEY (`fid`);

--
-- Indexes for table `tblfiles`
--
ALTER TABLE `tblfiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`userid`);

--
-- Indexes for table `tblfriends`
--
ALTER TABLE `tblfriends`
  ADD PRIMARY KEY (`fid`);

--
-- Indexes for table `tbllikes`
--
ALTER TABLE `tbllikes`
  ADD PRIMARY KEY (`lid`),
  ADD UNIQUE KEY `userid` (`userid`,`likes`);

--
-- Indexes for table `tblmessages`
--
ALTER TABLE `tblmessages`
  ADD PRIMARY KEY (`messageid`);

--
-- Indexes for table `tblstatus`
--
ALTER TABLE `tblstatus`
  ADD PRIMARY KEY (`sid`);

--
-- Indexes for table `tbluser`
--
ALTER TABLE `tbluser`
  ADD PRIMARY KEY (`userid`),
  ADD UNIQUE KEY `username` (`username`,`emailid`),
  ADD UNIQUE KEY `mobile_no` (`mobile_no`),
  ADD UNIQUE KEY `emailid` (`emailid`),
  ADD UNIQUE KEY `emailid_2` (`emailid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tblfeedback`
--
ALTER TABLE `tblfeedback`
  MODIFY `fid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `tblfiles`
--
ALTER TABLE `tblfiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `tblfriends`
--
ALTER TABLE `tblfriends`
  MODIFY `fid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `tbllikes`
--
ALTER TABLE `tbllikes`
  MODIFY `lid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `tblmessages`
--
ALTER TABLE `tblmessages`
  MODIFY `messageid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `tblstatus`
--
ALTER TABLE `tblstatus`
  MODIFY `sid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `tbluser`
--
ALTER TABLE `tbluser`
  MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
