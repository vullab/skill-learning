<?php
/* File: _tracking.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 * 
 * Description: Provides simple tracking and resume functions to follow a
 *     subject's path through the experiment and allow them to continue
 *     where they left off in the case of an error.
 */
 
// Update the tracking and resume tables
	function updateTracking($stage, $curn, $nextpage) {

		global $timestamp, $cur_date, $cur_time, $responsetime;
		global $dbh, $TABLES;

		//update subject table
		$query = "UPDATE $TABLES[subjects] SET
						trackStage = '$stage'
						WHERE SID = '".$_SESSION['SID']."';";
		$result = mysql_query($query, $dbh) or die($query);
    
		// check if columns exist in tracking table
		$query = "SHOW COLUMNS FROM $TABLES[tracking] LIKE '".$curn."TS';";
		$result = mysql_query($query, $dbh) or die(mysql_error() . "Could not get survey list with query: " . $query);
		if (mysql_num_rows($result) == 0) {    
			// Field does not exists, add it now
			$query = "ALTER TABLE $TABLES[tracking] ADD ".$curn."TS int(12) default NULL;";
			mysql_query($query, $dbh) or die($query);
		}
		$query = "SHOW COLUMNS FROM $TABLES[tracking] LIKE '".$curn."RT';";
		$result = mysql_query($query, $dbh) or die(mysql_error() . "Could not get survey list with query: " . $query);
		if (mysql_num_rows($result) == 0) {    
			// Field does not exists, add it now
			$query = "ALTER TABLE $TABLES[tracking] ADD ".$curn."RT int(7) default NULL;";
			mysql_query($query, $dbh) or die($query);
		}

		//update tracking table
		$query = "UPDATE $TABLES[tracking] SET
						stage = '$stage',
						lastDate = '$cur_date',
						lastTime = '$cur_time',
						lastTS = '$timestamp',
						".$curn."TS = '$timestamp',
						".$curn."RT = '$responsetime'
						WHERE SID = '".$_SESSION['SID']."';";
		$result = mysql_query($query, $dbh) or die($query);
 
		//update resume table
		$query = "UPDATE $TABLES[resume] SET 
						page = '$nextpage',
						session = '".addslashes(session_encode())."'
						WHERE SID = '".$_SESSION['SID']."';";
		$result = mysql_query($query, $dbh) or die($query);
	}
?>
