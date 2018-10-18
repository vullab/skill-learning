<?
/* File: sym2_s17.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Saves email for drawing, subscribes if requested.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");

    if (testSID())
    {

        session_destroy();
    
		$nextpage = $prefix . "_p18.php";
    	$stage = "B17";
    	$curn = "p17";
    
        if ($subscribe == 'Y')
            db_do("INSERT INTO mailing_list SET email_address='$emailprize';");
        else
            $subscribe = 'N';
            
        db_do("UPDATE $TABLES[subjects] SET trackStage='$stage', emailprize='$emailprize', subscribe='$subscribe' WHERE SID = '".$_SESSION['SID']."';");
   
        db_do("UPDATE $TABLES[tracking] SET
                        stage = '$stage',
                        lastDate = '$cur_date',
                        lastTime = '$cur_time',
                        lastTS = '$timestamp',
                        endDate = '$cur_date',
                        endTime = '$cur_time',
                        endTS = '$timestamp'
                  WHERE SID = '".$_SESSION['SID']."';");

        db_do("UPDATE $TABLES[resume] SET page='$nextpage', session='done' WHERE SID = '".$_SESSION['SID']."';");

        print("<META HTTP-EQUIV='REFRESH' CONTENT='0; URL=".$nextpage."'>");

	}
?>

