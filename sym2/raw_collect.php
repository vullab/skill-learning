<?
include_once("_session.php");


$REFILL = true;


/*** BEGIN ANALYSIS ***/

$totrows = 0;

if ($REFILL)
{
    $query = "TRUNCATE TABLE $TABLES[data];";
    $result = mysql_query($query, $dbh) or die(mysql_error() . "<p>Could not do query: " . $query);
    if($result)
    {
        echo "<p>Table was cleared - refilling now...<br>";
    }
}

$query = "SELECT SID, subjectEmail, demCountry, demGender, demAge,
                 demEducation, demPsychExp, demEthnicity, 
                 subjectJSBrowser, subjectResolution,
                 subjectIP, subjectHost, subjectBrowser, subjectBrowserTest
          FROM $TABLES[subjects]
          WHERE trackStage = 'B17';";
$subjectsresult = mysql_query($query, $dbh) or die("Could not do query: " . $query);
while($subjectdata = mysql_fetch_array($subjectsresult))
{

    /*** DEMOGRAPHICS ***/
    // get SID, email, country, gender, age, edu., psych experience, ethnicity,
    // environments, browsers etc. directly from 'sym2_subjects'
    
    list($SID, $subjectEmail, $demCountry, $demGender, $demAge,
         $demEducation, $demPsychExp, $demEthnicity, 
         $subjectJSBrowser, $subjectResolution, $subjectIP,
         $subjectHost, $subjectBrowser, $subjectBrowserTest) = $subjectdata;


    /*** CHECK FOR DUPLICATE IN RAW TABLE ***/
    // do the next while() iteration if we already did this SID
    if (! $REFILL)
    {
        $query = "SELECT * FROM $TABLES[data] WHERE SID='$SID';";
        $result = mysql_query($query, $dbh) or die("Could not do query: " . $query);
        if (mysql_num_rows($result) > 0)
            continue;
    }


    /*** CLEAR VARS ***/
    $FB = $FS = $FT = $BB = $BS = $BT = "NULL";
    $FBRT = $FSRT = $FTRT = $BBRT = $BSRT = $BTRT = 0;
    
    $timeToCompleteSession1 = $timeToCompleteSession2 = $timeToSession2 = "NULL";


	/*** SET CONDITIONS ***/
	$WIDs = db_rows("SELECT WID FROM $TABLES[finalTest] WHERE SID='$SID';");
	foreach ($WIDs as $WID)
	{
		$cond = db_get("SELECT W$WID FROM $TABLES[conditions] WHERE SID='$SID';");
		$correct = db_get("SELECT (response=responseExpected) FROM $TABLES[finalTest] WHERE SID='$SID' AND WID='$WID';");
		//db_do("UPDATE $TABLES[finalTest] SET condition='$cond', exactCorrect='$correct' WHERE SID='$SID' AND WID='$WID';");
		db_do("UPDATE $TABLES[finalTest] SET exactCorrect='$correct' WHERE SID='$SID' AND WID='$WID';");
	}

    /*** TOTAL UP CORRECT RESPONSES ***/

	$FB = db_get("SELECT AVG(exactCorrect) FROM $TABLES[finalTest] WHERE SID='$SID' AND condition='FB';");
	$FS = db_get("SELECT AVG(exactCorrect) FROM $TABLES[finalTest] WHERE SID='$SID' AND condition='FS';");
	$FT = db_get("SELECT AVG(exactCorrect) FROM $TABLES[finalTest] WHERE SID='$SID' AND condition='FT';");
	$BB = db_get("SELECT AVG(exactCorrect) FROM $TABLES[finalTest] WHERE SID='$SID' AND condition='BB';");
	$BS = db_get("SELECT AVG(exactCorrect) FROM $TABLES[finalTest] WHERE SID='$SID' AND condition='BS';");
	$BT = db_get("SELECT AVG(exactCorrect) FROM $TABLES[finalTest] WHERE SID='$SID' AND condition='BT';");
	$FBRT = db_get("SELECT AVG(responseTime) FROM $TABLES[finalTest] WHERE SID='$SID' AND condition='FB' AND exactCorrect='1';");
	$FSRT = db_get("SELECT AVG(responseTime) FROM $TABLES[finalTest] WHERE SID='$SID' AND condition='FS' AND exactCorrect='1';");
	$FTRT = db_get("SELECT AVG(responseTime) FROM $TABLES[finalTest] WHERE SID='$SID' AND condition='FT' AND exactCorrect='1';");
	$BBRT = db_get("SELECT AVG(responseTime) FROM $TABLES[finalTest] WHERE SID='$SID' AND condition='BB' AND exactCorrect='1';");
	$BSRT = db_get("SELECT AVG(responseTime) FROM $TABLES[finalTest] WHERE SID='$SID' AND condition='BS' AND exactCorrect='1';");
	$BTRT = db_get("SELECT AVG(responseTime) FROM $TABLES[finalTest] WHERE SID='$SID' AND condition='BT' AND exactCorrect='1';");


    /*** SESSION DELAYS ***/

    // get timestamps from tracking to determine time between p02TS and p13TS
    $query = "SELECT p13TS - p02TS FROM $TABLES[tracking] WHERE SID = '$SID';";
    $result = mysql_query($query, $dbh) or die("Could not do query: " . $query);
    if($row = mysql_fetch_row($result))
        $timeToCompleteSession1 = $row[0];

    // get timestamps from tracking to determine time between p13TS and p14TS
    $query = "SELECT p14TS - p13TS FROM $TABLES[tracking] WHERE SID = '$SID';";
    $result = mysql_query($query, $dbh) or die("Could not do query: " . $query);
    if($row = mysql_fetch_row($result))
        $timeToSession2 = $row[0];


    // get timestamps from tracking to determine time between p14TS and p16TS
    $query = "SELECT p16TS - p14TS FROM $TABLES[tracking] WHERE SID = '$SID';";
    $result = mysql_query($query, $dbh) or die("Could not do query: " . $query);
    if($row = mysql_fetch_row($result))
        $timeToCompleteSession2 = $row[0];

    /*** GET FIELD NAMES ***/  
    unset($queryline);
    $query = "SHOW COLUMNS FROM $TABLES[data];";
    $result = mysql_query($query, $dbh) or die("Could not do query: " . $query);
    while($row = mysql_fetch_object($result))
    {
        $thevar = $row->Field;
        if($$thevar != "NULL")
            $$thevar = "'" . $$thevar . "'";
        $queryline[] = "$thevar = " . $$thevar;
    }  

  
    /*** SAVE DATA IN RAW TABLE ***/
    $query = "INSERT INTO $TABLES[data] SET\n";
    $query .= implode(",\n", $queryline) . ";";
    $result = mysql_query($query, $dbh) or die(mysql_error() . "<p>Could not do query: " . $query);
    $totrows++;
}

echo "All done!  Added $totrows row(s) of raw data.";
?>

<p>

<FORM>
<INPUT type="button" value="Back" onClick="history.back()">
</FORM>