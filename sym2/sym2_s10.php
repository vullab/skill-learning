<?
/* File: sym2_s10.php
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
    	$query = "INSERT INTO $TABLES[test2] SET
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
        	// next stage: 11 - done with learning test 2
        	$stage = "A10";
	       	$curn = "p10";
        	$nextpage = $prefix . "_p11.php";
        	$_SESSION['count'] = 99;
	    }
    	else
    	{
        	// next stage: 10 - test/study the next word-pair
        	$stage = "A09";
	       	$curn = "p10";
        	$nextpage = $prefix . "_p10.php";
	    }
       	updateTracking($stage, $curn, $nextpage);

    	// move on to the next stage or step
    	print("<META HTTP-EQUIV='REFRESH' CONTENT='0; URL=".$nextpage."'>");

	}
?>