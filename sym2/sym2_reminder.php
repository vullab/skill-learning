<?
/* File: sym2_reminder.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Send out email reminders.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");
	include_once("_email.php");

/*** First session 2 email (6 hours before a full day) ***/
$query = "SELECT
            SID,
            MSC,
            subjectEmail, 
            trackStage
          FROM $TABLES[subjects]
          WHERE trackStage = 'A13';";
$result = mysql_query($query, $dbh) or die("Could not get subjects for Ab. Query: " . $query);
while($subjectm = mysql_fetch_object($result))
{
    
    $trackingquery = "SELECT p13TS FROM $TABLES[tracking] WHERE SID = '".$subjectm->SID."';";
    $trackingresult = mysql_query($trackingquery, $dbh) or erroremail("Could not get tracking information for subject " . $subjectm->SID . " query: " . $trackingquery);
    $subtrack = mysql_fetch_array($trackingresult);
    
    if(($timestamp - $subtrack[0]) > (18*3600))
    {
        sendEmail(makeEmail($E01, $subjectm->SID, $subjectm->MSC),
                  "You may now begin the second session of our study",
                  $subjectm->subjectEmail);
    
        $queryl = "UPDATE $TABLES[subjects] SET trackStage = 'E01' WHERE SID='".$subjectm->SID."';";
        $resultl = mysql_query($queryl, $dbh) or die($queryl);
    
        $queryl = "UPDATE $TABLES[tracking] SET 
                    e01TS = '$timestamp',
                    stage = 'E01' WHERE SID='".$subjectm->SID."';";
        $resultl = mysql_query($queryl, $dbh) or die($queryl);
    }
}



/** second session 2 email (24 hours after completing session 1)***/
$query = "SELECT
            SID,
            MSC,
            subjectEmail,
            trackStage
          FROM $TABLES[subjects]
          WHERE trackStage = 'E01';";
$result = mysql_query($query, $dbh) or die("Could not get subjects for Ab. Query: " . $query);
while($subjectm = mysql_fetch_object($result))
{
    
    $trackingquery = "SELECT p13TS FROM $TABLES[tracking] WHERE SID = '" . $subjectm->SID . "';";
    $trackingresult = mysql_query($trackingquery, $dbh) or erroremail("Could not get tracking information for subject " . $subjectm->SID . " query: " . $trackingquery);
    $subtrack = mysql_fetch_array($trackingresult);
    
    if(($timestamp - $subtrack[0]) > (24*3600))
    {
        sendEmail(makeEmail($E02, $subjectm->SID, $subjectm->MSC),
                  "Please begin the second session of our study",
                  $subjectm->subjectEmail);
    
        $queryl = "UPDATE $TABLES[subjects] SET trackStage = 'E02' WHERE SID='".$subjectm->SID."';";
        $resultl = mysql_query($queryl, $dbh) or die($queryl);
    
        $queryl = "UPDATE $TABLES[tracking] SET e02TS = '$timestamp',
                                         stage = 'E02' WHERE SID='".$subjectm->SID."';";
        $resultl = mysql_query($queryl, $dbh) or die($queryl);
    }
}

?>