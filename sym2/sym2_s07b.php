<?
/* File: sym2_s07b.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Prepares for Test/Study Phase.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");
	
    if (testSID())
    {
        // next stage: encoding presentation
   	    $stage = "A07";
       	$curn = "p07b";
       	$nextpage = $prefix . "_p08.php";
       	updateTracking($stage, $curn, $nextpage);

	    // clear the previous order to make a new random order
    	unset($_SESSION['order']);
    	$_SESSION['order'] = array();
    	$_SESSION['count'] = 0;
    
       	$tmporder = db_rows("SELECT WID FROM $TABLES[stimuli] ORDER BY RAND();");
       	foreach ($tmporder as $wid)
       	{
       		if (db_get("SELECT SUBSTRING(W".$wid.", 2, 1) FROM $TABLES[conditions] WHERE SID='".$_SESSION['SID']."';") != "B")
       			$_SESSION['order'][] = $wid;
       	}
    
	    // move on to next page
    	print("<META HTTP-EQUIV='REFRESH' CONTENT='0; URL=".$nextpage."'>");

	}
?>

