<?
/* File: sym2_s12.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Handle Test/Study Trial data.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");
	
    if (testSID())
    {

	   	// make a record of the last word-pair presentation and time at which it was completed
    	$query = "INSERT INTO $TABLES[test3] SET
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
        	// next stage: 13 - done with session 1
        	$stage = "A12";
	       	$curn = "p12";
        	$nextpage = $prefix . "_p13.php";
        	$_SESSION['count'] = 99;
	    }
    	else
    	{
        	// next stage: 12 - test/study the next word-pair
        	$stage = "A11";
	       	$curn = "p12";
        	$nextpage = $prefix . "_p12.php";
	    }
       	updateTracking($stage, $curn, $nextpage);

    	// move on to the next stage or step
    	print("<META HTTP-EQUIV='REFRESH' CONTENT='0; URL=".$nextpage."'>");

	}
?>