<?
/* File: sym2_s02.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Saves the data from the demographics form.  If the subject
 *     is from USA or Canada, we want to ask about their ethnicity next.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");

    // determine next page based on country
    if(    ($country == "USA")
    	|| ($country == "United States")
    	|| ($country == "Canada") )
    {
        // next stage: ethnicity
        $nextpage = $prefix . "_p03.php";
    }
    else
    {
        // next stage: email
        $nextpage = $prefix . "_p04.php";
    }

    $stage = "A02";

    if ($repSID)
    {
        // subject must have hit back and re-submitted this data...
        if ($repSID != $_SESSION['SID'])
        {
            // SID and repeat SID don't match!  error!
            print("<META HTTP-EQUIV='REFRESH' CONTENT='0; URL=error.php?error=SID3'>");
        }
        else
        {
            //update the record
            $query = "UPDATE $TABLES[subjects] SET
                             demCountry = '$country',
                             demGender = '$gender',
                             demAge = '$age',
                             demEducation = '$education',
                             demPsychExp = '$psychexp',
                             demEnvironment1 = '$environment'
                       WHERE SID = '".$_SESSION['SID']."';";
            $result = mysql_query($query, $dbh) or die($query . "<p>" . mysql_error());
        }
    }
    else
    {
        // new subject, insert necessary rows in tables.
        unset($MSC);
        $MSC = makeMSC();

        // create a row for the subject + data
        $query = "INSERT INTO $TABLES[subjects] SET
                              MSC = '$MSC',
                              trackStage = '$stage',
                              defemail = '".$_SESSION['defemail']."',
                              demCountry = '$country',
                              demGender = '$gender',
                              demAge = '$age',
                              demEducation = '$education',
                              demPsychExp = '$psychexp',
                              demEnvironment1 = '$environment',
                              demEnvironment2 = NULL,
                              subjectJSBrowser = '$browser',
                              subjectResolution = '$resolution',
                              subjectIP = '$IPaddress',
                              subjectHost = '$IPhost',
                              subjectBrowser = '$HTTP_USER_AGENT',
                              subjectBrowserTest = '$browsertest';";
        $result = mysql_query($query, $dbh) or die($query . "<p>" . mysql_error());

        //get actual ID and register it as session variable $_SESSION['SID']
        $subjectID = mysql_insert_id();
        $_SESSION['SID'] = $subjectID;

        if ($devmode > 0)
            db_do("UPDATE $TABLES[subjects] SET ignoreData='1' WHERE SID='".$_SESSION['SID']."';");

        $_SESSION['MSC'] =$MSC;

        // create a row for tracking the subject   
        $query = "INSERT INTO $TABLES[tracking] SET
                              SID = '".$_SESSION['SID']."',
                              stage = '$stage',
                              startDate = '$cur_date',
                              startTime = '$cur_time',
                              lastDate = '$cur_date',
                              lastTime = '$cur_time',
                              startTS = '$timestamp',
                              lastTS = '$timestamp',
                              p02TS = '$timestamp';";
        $result = mysql_query($query, $dbh) or die($query);

        // create a row for allowing subject to resume after delay
        $query = "INSERT INTO $TABLES[resume] SET
                              SID = '".$_SESSION['SID']."',
                              page = '$nextpage';";
        $result = mysql_query($query, $dbh) or die($query);
        
        db_do("INSERT INTO $TABLES[conditions] SET SID='".$_SESSION['SID']."';");

    }

    // move on to stage 3 or 4 based on selected country
    print("<META HTTP-EQUIV='REFRESH' CONTENT='0; URL=".$nextpage."'>");

?>
