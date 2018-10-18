<?
/* File: sym2_s09.php
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
   	    $stage = "A09";
       	$curn = "p09";
       	$nextpage = $prefix . "_p09b.php";
       	updateTracking($stage, $curn, $nextpage);

	    // move on to next page
    	print("<META HTTP-EQUIV='REFRESH' CONTENT='0; URL=".$nextpage."'>");

	}
?>

