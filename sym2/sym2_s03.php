<?
/* File: sym2_s03.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Saves the data from the ethnicity form.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");
	
    if (testSID())
    {
        // next stage: email
        $stage = "A03";
        $curn = "p03";
        $nextpage = $prefix . "_p04.php";
        updateTracking($stage, $curn, $nextpage);

        // add the subject's ethnicity to the row
        db_do("UPDATE $TABLES[subjects] SET demEthnicity = '$ethnicity' WHERE SID = '".$_SESSION['SID']."';");
   
        // move on to stage 4
        print("<META HTTP-EQUIV='REFRESH' CONTENT='0; URL=".$nextpage."'>");
    }
?>
