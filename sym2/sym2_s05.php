<?
/* File: sym2_s05.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Prepares for Encoding Presentation.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");
	
    if (testSID())
    {
        // next stage: encoding presentation
   	    $stage = "A05";
       	$curn = "p05";
       	$nextpage = $prefix . "_p06.php";
       	updateTracking($stage, $curn, $nextpage);

		unset($_SESSION['order']);
		unset($_SESSION['count']);
    	unset($_SESSION['conditions']);

	    // start counter at 0 (prepare to step through all word-pairs)
    	$_SESSION['count'] = 0;
    
    	$_SESSION['order'] = db_rows("SELECT WID FROM $TABLES[stimuli] ORDER BY RAND();");
    	$conds = array("FTN","BTN","FSN","BSN","FBN","BBN","FTR","BTR","FSR","BSR","FBR","BBR");
		foreach ($_SESSION['order'] as $i => $wid)
		{
			$_SESSION['conditions'][$i] = $conds[$i%12];
			$tableconds[] = "W" . $wid . " = '" . $_SESSION['conditions'][$i] . "'";
		}
	    db_do("UPDATE $TABLES[conditions] SET\n" . implode(",\n", $tableconds) . "\nWHERE SID = '".$_SESSION['SID']."';");
    
    	shuffle($_SESSION['order']);
    
	    print("<META HTTP-EQUIV='REFRESH' CONTENT='0; URL=".$nextpage."'>");

	}
?>

