
CREATE TABLE `sym2_conditions` (
  `SID` smallint(5) default NULL,
  `W101` char(3) default NULL,
  `W102` char(3) default NULL,
  `W103` char(3) default NULL,
  `W104` char(3) default NULL,
  `W105` char(3) default NULL,
  `W106` char(3) default NULL,
  `W107` char(3) default NULL,
  `W108` char(3) default NULL,
  `W109` char(3) default NULL,
  `W110` char(3) default NULL,
  `W111` char(3) default NULL,
  `W112` char(3) default NULL,
  `W113` char(3) default NULL,
  `W114` char(3) default NULL,
  `W115` char(3) default NULL,
  `W116` char(3) default NULL,
  `W117` char(3) default NULL,
  `W118` char(3) default NULL,
  `W119` char(3) default NULL,
  `W120` char(3) default NULL,
  `W121` char(3) default NULL,
  `W122` char(3) default NULL,
  `W123` char(3) default NULL,
  `W124` char(3) default NULL,
  `W125` char(3) default NULL,
  `W126` char(3) default NULL,
  `W127` char(3) default NULL,
  `W128` char(3) default NULL,
  `W129` char(3) default NULL,
  `W130` char(3) default NULL,
  `W131` char(3) default NULL,
  `W132` char(3) default NULL,
  `W133` char(3) default NULL,
  `W134` char(3) default NULL,
  `W135` char(3) default NULL,
  `W136` char(3) default NULL,
  `W137` char(3) default NULL,
  `W138` char(3) default NULL,
  `W139` char(3) default NULL,
  `W140` char(3) default NULL,
  `W141` char(3) default NULL,
  `W142` char(3) default NULL,
  `W143` char(3) default NULL,
  `W144` char(3) default NULL,
  `W145` char(3) default NULL,
  `W146` char(3) default NULL,
  `W147` char(3) default NULL,
  `W148` char(3) default NULL,
  `W149` char(3) default NULL,
  `W150` char(3) default NULL,
  `W151` char(3) default NULL,
  `W152` char(3) default NULL,
  `W153` char(3) default NULL,
  `W154` char(3) default NULL,
  `W155` char(3) default NULL,
  `W156` char(3) default NULL,
  `W157` char(3) default NULL,
  `W158` char(3) default NULL,
  `W159` char(3) default NULL,
  `W160` char(3) default NULL
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `sym2_data`
-- 

CREATE TABLE `sym2_data` (
  `SID` smallint(5) unsigned NOT NULL auto_increment,
  `subjectEmail` varchar(127) default NULL,
  `demCountry` varchar(63) default NULL,
  `demGender` char(1) default NULL,
  `demAge` char(3) default NULL,
  `demEducation` varchar(20) default NULL,
  `demPsychExp` varchar(20) default NULL,
  `demEthnicity` varchar(20) default NULL,
  `subjectJSBrowser` char(3) default NULL,
  `subjectResolution` varchar(15) default NULL,
  `subjectIP` varchar(20) default NULL,
  `subjectHost` varchar(50) default NULL,
  `subjectBrowser` varchar(127) default NULL,
  `subjectBrowserTest` char(1) default NULL,
  `timeToCompleteSession1` int(12) default NULL,
  `timeToSession2` int(12) default NULL,
  `timeToCompleteSession2` int(12) default NULL,
  `FB` float default NULL,
  `FS` float default NULL,
  `FT` float default NULL,
  `BB` float default NULL,
  `BS` float default NULL,
  `BT` float default NULL,
  `FBRT` int(7) default NULL,
  `FSRT` int(7) default NULL,
  `FTRT` int(7) default NULL,
  `BBRT` int(7) default NULL,
  `BSRT` int(7) default NULL,
  `BTRT` int(7) default NULL,
  PRIMARY KEY  (`SID`)
) TYPE=MyISAM AUTO_INCREMENT=246 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `sym2_finalTest`
-- 

CREATE TABLE `sym2_finalTest` (
  `SID` smallint(5) default NULL,
  `trial` char(3) default NULL,
  `WID` char(3) default NULL,
  `condition` char(2) default NULL,
  `direction` char(3) default NULL,
  `response` varchar(30) default NULL,
  `responseTime` int(12) default NULL,
  `responseExpected` varchar(15) default NULL,
  `score` float default NULL,
  `exactCorrect` char(1) default NULL,
  `correct` char(1) default NULL,
  `trialTs` int(12) default NULL,
  `blurcount` int(5) default NULL
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `sym2_learn1`
-- 

CREATE TABLE `sym2_learn1` (
  `SID` smallint(5) default NULL,
  `trial` char(3) default NULL,
  `WID` char(3) default NULL,
  `responseTime` int(12) default NULL,
  `trialTS` int(12) default NULL,
  `blurcount` int(5) default NULL
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `sym2_learn2`
-- 

CREATE TABLE `sym2_learn2` (
  `SID` smallint(5) default NULL,
  `trial` char(3) default NULL,
  `WID` char(3) default NULL,
  `responseTime` int(12) default NULL,
  `trialTS` int(12) default NULL,
  `blurcount` int(5) default NULL
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `sym2_learn3`
-- 

CREATE TABLE `sym2_learn3` (
  `SID` smallint(5) default NULL,
  `trial` char(3) default NULL,
  `WID` char(3) default NULL,
  `responseTime` int(12) default NULL,
  `trialTS` int(12) default NULL,
  `blurcount` int(5) default NULL
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `sym2_presentation`
-- 

CREATE TABLE `sym2_presentation` (
  `SID` smallint(5) default NULL,
  `trial` char(3) default NULL,
  `WID` char(3) default NULL,
  `trialTS` int(12) default NULL,
  `responseTime` int(12) default NULL,
  `blurcount` int(5) default NULL
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `sym2_resume`
-- 

CREATE TABLE `sym2_resume` (
  `SID` smallint(5) unsigned NOT NULL default '0',
  `page` varchar(155) default NULL,
  `session` text,
  PRIMARY KEY  (`SID`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `sym2_subjects`
-- 

CREATE TABLE `sym2_subjects` (
  `SID` smallint(5) unsigned NOT NULL auto_increment,
  `MSC` varchar(4) default NULL,
  `defemail` varchar(127) default NULL,
  `subjectEmail` varchar(127) default NULL,
  `trackStage` char(3) default NULL,
  `demCountry` varchar(63) default NULL,
  `demGender` char(1) default NULL,
  `demAge` char(3) default NULL,
  `demEducation` varchar(20) default NULL,
  `demPsychExp` varchar(20) default NULL,
  `demEthnicity` varchar(20) default NULL,
  `demEnvironment1` varchar(20) default NULL,
  `demEnvironment2` varchar(20) default NULL,
  `subjectJSBrowser` char(3) default NULL,
  `subjectResolution` varchar(15) default NULL,
  `subjectIP` varchar(20) default NULL,
  `subjectHost` varchar(50) default NULL,
  `subjectBrowser` varchar(127) default NULL,
  `subjectBrowserTest` char(1) default NULL,
  `emailprize` varchar(127) default NULL,
  `subscribe` char(1) default NULL,
  `ignoreData` char(1) NOT NULL default '0',
  PRIMARY KEY  (`SID`)
) TYPE=MyISAM AUTO_INCREMENT=254 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `sym2_tracking`
-- 

CREATE TABLE `sym2_tracking` (
  `SID` smallint(5) unsigned default NULL,
  `stage` char(3) default NULL,
  `startDate` date default NULL,
  `startTime` time default NULL,
  `lastDate` date default NULL,
  `lastTime` time default NULL,
  `endDate` date default NULL,
  `endTime` time default NULL,
  `startTS` int(12) default NULL,
  `lastTS` int(12) default NULL,
  `endTS` int(12) default NULL,
  `p02TS` int(12) default NULL,
  `p02RT` int(7) default NULL,
  `p03TS` int(12) default NULL,
  `p03RT` int(7) default NULL,
  `p04TS` int(12) default NULL,
  `p04RT` int(7) default NULL,
  `p04aTS` int(12) default NULL,
  `p04aRT` int(7) default NULL,
  `p05TS` int(12) default NULL,
  `p05RT` int(7) default NULL,
  `p06TS` int(12) default NULL,
  `p06RT` int(7) default NULL,
  `p07TS` int(12) default NULL,
  `p07RT` int(7) default NULL,
  `p07bTS` int(12) default NULL,
  `p07bRT` int(7) default NULL,
  `p08TS` int(12) default NULL,
  `p08RT` int(7) default NULL,
  `p09TS` int(12) default NULL,
  `p09RT` int(7) default NULL,
  `p09bTS` int(12) default NULL,
  `p09bRT` int(7) default NULL,
  `p10TS` int(12) default NULL,
  `p10RT` int(7) default NULL,
  `p11TS` int(12) default NULL,
  `p11RT` int(7) default NULL,
  `p11bTS` int(12) default NULL,
  `p11bRT` int(7) default NULL,
  `p12TS` int(12) default NULL,
  `p12RT` int(7) default NULL,
  `p14TS` int(12) default NULL,
  `p14RT` int(7) default NULL,
  `p15TS` int(12) default NULL,
  `p15RT` int(7) default NULL,
  `p16TS` int(12) default NULL,
  `p16RT` int(7) default NULL,
  `p17TS` int(12) default NULL,
  `p17RT` int(7) default NULL,
  `p18TS` int(12) default NULL,
  `p18RT` int(7) default NULL,
  `p13TS` int(12) default NULL,
  `p13RT` int(7) default NULL,
  `e01TS` int(12) default NULL,
  `e02TS` int(12) default NULL
) TYPE=MyISAM;
