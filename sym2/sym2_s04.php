<?
/* File: sym2_s04.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Saves the data from the email form.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");
	
    if (testSID())
    {

	    // check if the email address has already been used (if it's located in the database already)
    	$query = "SELECT SID FROM $TABLES[subjects] WHERE subjectEmail = '$email';";
    	$result = mysql_query($query, $dbh) or die($query);
    	$rows = mysql_num_rows($result);
    	if($rows > 0)
    	{
        	//next stage: email already exists, thanks anyway
        	$nextpage = $prefix . "_email.php";
        	$stage = "A04";
    	}
    	else
    	{
	        // next stage: instructions for presentation
    	    $stage = "A04";
        	$curn = "p04";
        	$nextpage = $prefix . "_p05.php";
        	updateTracking($stage, $curn, $nextpage);
        
        	// add the subject's email to the row
        	db_do("UPDATE $TABLES[subjects] SET subjectEmail = '$email' WHERE SID = '".$_SESSION['SID']."';");
    	}
       
    	// move on to next stage
    	print("<META HTTP-EQUIV='REFRESH' CONTENT='0; URL=".$nextpage."'>");

	}
?>

