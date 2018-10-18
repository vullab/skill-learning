<?
/* File: sym2_s15.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Prepare final test trials.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");
	
    if (testSID())
    {
		// next stage: final test
	    $stage = "B15";
	    $curn = "p15";
	    $nextpage = $prefix . "_p16.php";
       	updateTracking($stage, $curn, $nextpage);
    
	    unset($_SESSION['order']); 
    	$_SESSION['count'] = 0;
       	$_SESSION['order'] = db_rows("SELECT WID FROM $TABLES[stimuli] ORDER BY RAND();");
       
	    print("<META HTTP-EQUIV='REFRESH' CONTENT='0; URL=".$nextpage."'>");
	}
?>

