<?
/* File: _session.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 * 
 * Description: Manages all session data including procedures for
 *     keeping a user logged in after session times-out.  Also
 *     contains project and database variables, as well as library
 *     includes (for headers, error handling, etc.).
 */

 // Library files
	include_once("../_lib/db.php");
	include_once("../_lib/logs.php");
	include_once("../_lib/counter.php");
	include_once("../_lib/header.php");
	include_once("../_lib/email.php");
	include_once("../_lib/common.php");
	include_once("../_lib/error.php");

	include_once("_tracking.php");

// Database settings & connection
	$dbh = db_connect();
	$TABLES = null;
    $TABLES[subjects] = 'sym2_subjects';			// subject data
    $TABLES[conditions] = 'sym2_conditions';		// conditions for each word pair, per subject
    $TABLES[stimuli] = 'sym1_words';				// table of stimuli
	$TABLES[tracking] = 'sym2_tracking';			// session tracking
    $TABLES[resume] = 'sym2_resume';				// where subject would resume if necessary
    $TABLES[presentation] = 'sym2_presentation';	// stimuli presentation data
    $TABLES[test1] = 'sym2_learn1';					// test/study data
    $TABLES[test2] = 'sym2_learn2';					// test/study data
    $TABLES[test3] = 'sym2_learn3';					// test/study data
    $TABLES[finalTest] = 'sym2_finalTest';			// final cued-recall test data
    $TABLES[data] = 'sym2_data';

// Internal project settings
    // ID in the AllSurveys database:
    $SURVEYID = 31;
	// path to this survey:
    $cur_path = "http://surveys.dualtask.org/sym2/";
    // same as above:
    $path = $cur_path;

// External project settings
    $query = "SELECT * FROM AllSurveys WHERE ID = '".$SURVEYID."';";
    $result = mysql_query($query, $dbh) or die($query);
    // All external survey settings:
    $SURVEYINFO = mysql_fetch_object($result);
    // Project title:
    $expTitle = $SURVEYINFO->title;
    // Project prefix:
    $prefix = $SURVEYINFO->prefix;
    // Project devmode status: (0=production, 1=simple dev, 2=full dev)
    $devmode = $SURVEYINFO->devmode;
    // number of questions in the stimuli table:
    $MAXWORDS = db_get("SELECT COUNT(*) FROM $TABLES[stimuli];");

// Email settings
    $myname = "Symmetry Test at Dualtask.org";          // Name that will appear in From field on emails sent.
    $myemail = "symtest@dualtask.org";// Email that will appear in From field, as well as the email displayed on all of the pages.
    $traceemail = "traces@dualtask.org";        // All emails sent send a BCC to this address... for troubleshooting.
    $bounceemail = "bounces@dualtask.org";       // Bounced emails go here (in theory, if we can get a host that doesnt reset the Return-path.

// Get data from forms
	foreach($_REQUEST as $key => $val)
    	$$key = $val;	// some servers don't do this automatically

// Session info
    session_start();
    $subjectID = $_SESSION['SID'];
        
// Useful client-side information
    $IPaddress = $_SERVER['REMOTE_ADDR'];
    $IPhost = gethostbyaddr($IPaddress);
    $HTTP_USER_AGENT = $_SERVER['HTTP_USER_AGENT'];
    $timestamp = time();
    $cur_date = date('Y-m-d', $timestamp);
    $cur_time = date('H:i:s', $timestamp);

// Create Master Secret Code
	function makeMSC($length = 4)
	{
		for($i = 0; $i<$length; $i++)
			$MSC .= chr(rand(65,90));

		return $MSC;
	}

// Test that SID is valid, registered and matches MSC
	function testSID()
	{
		global $TABLES, $dbh;

		if (!$_SESSION['SID'])
		{
			print("<META HTTP-EQUIV='REFRESH' CONTENT='0; URL=error.php?error=SID1'>");
			return FALSE;
		}
		else
		{
			$query = "SELECT SID, MSC FROM $TABLES[subjects] WHERE (SID = '".$_SESSION['SID']."');";
			$result = mysql_query($query, $dbh) or die ("FAILURE here. 3" . $query);
			$rows = mysql_num_rows($result);
			$MSCr = mysql_fetch_array($result);
			if($rows < 1)
			{
				print("<META HTTP-EQUIV='REFRESH' CONTENT='0; URL=error.php?error=SID2&SID=".$_SESSION['SID']."'>");
				return FALSE;
			}
			elseif($_SESSION['MSC'] != $MSCr[1])
			{
				print("<META HTTP-EQUIV='REFRESH' CONTENT='0; URL=error.php?error=MSC1'>");
				return FALSE;
			}
			else
			{
				return TRUE;
			}
		}
	}
?>