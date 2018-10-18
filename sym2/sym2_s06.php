<?
/* File: sym2_s06.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Handle Presentation Trial data.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");
	
    if (testSID())
    {

	   	// make a record of the last word-pair presentation and time at which it was completed
    	$query = "INSERT INTO $TABLES[presentation] SET
						SID = '".$_SESSION['SID']."',
						trial = '".$_SESSION['count']."',
						WID = '".$_SESSION['order'][$_SESSION['count']]."',
						trialTS = '$timestamp',
						responseTime = '$responsetime',
						blurcount = '$blurcount';";
		db_do($query);

	    // move on to the next word-pair
    	$_SESSION['count']++;
    
    	// are we done with all the word-pairs?
    	if($_SESSION['count'] >= count($_SESSION['order']))
    	{
        	// next stage: 7 - Test Intro
        	$stage = "A06";
	       	$curn = "p06";
        	$nextpage = $prefix . "_p07.php";
        	$_SESSION['count'] = 0;
	    }
    	else
    	{
        	// next stage: 6 - present the next word-pair
        	$stage = "A05";
	       	$curn = "p06";
        	$nextpage = $prefix . "_p06.php";
	    }
       	updateTracking($stage, $curn, $nextpage);

    	// move on to the next stage or step
    	print("<META HTTP-EQUIV='REFRESH' CONTENT='0; URL=".$nextpage."'>");

	}
?>

