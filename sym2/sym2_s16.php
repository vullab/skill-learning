<?
/* File: sym2_s16.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Handle Final Test Trial data.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");
	
    if (testSID())
    {
    	list($wordCue, $wordTarget) = db_get("SELECT wordA, wordB FROM $TABLES[stimuli] WHERE WID = '".$_SESSION['order'][$_SESSION['count']]."';");
    	$wc = db_get("SELECT W".$_SESSION['order'][$_SESSION['count']]." FROM $TABLES[conditions] WHERE SID='".$_SESSION['SID']."';");

    	if ($wc{2} == "R")
    	{
    		$wordA = $wordTarget;
    		$wordB = $wordCue;
    	}
    	else
    	{
    		$wordA = $wordCue;
    		$wordB = $wordTarget;
    	}

		$responseExpected = ($wc{0} == "F") ? $wordB : $wordA;
		$score = getScore($response, $responseExpected);
		//$correct = ($score <= 0.2) ? "1" : "0";
		$correct = ($score <= 0.0001) ? "1" : "0";

	   	// make a record of the last word-pair presentation and time at which it was completed
    	$query = "INSERT INTO $TABLES[finalTest] SET
						SID = '".$_SESSION['SID']."',
						trial = '".$_SESSION['count']."',
						WID = '".$_SESSION['order'][$_SESSION['count']]."',
						trialTS = '$timestamp',
						responseTime = '$responsetime',
						blurcount = '$blurcount',
						condition = '$wc',
						direction = '$wd',
						response = '$response',
						responseExpected = '$responseExpected',
						score = '$score',
						correct = '$correct';";
		db_do($query);

	    // move on to the next word-pair
    	$_SESSION['count']++;

    	// are we done with all the word-pairs?
    	if($_SESSION['count'] >= count($_SESSION['order']))
    	{
        	// next stage: 17 - done with session 2
        	$stage = "A16";
	       	$curn = "p16";
        	$nextpage = $prefix . "_p17.php";
        	$_SESSION['count'] = 99;
	    }
    	else
    	{
        	// next stage: 16 - final test the next word-pair
        	$stage = "A15";
	       	$curn = "p16";
        	$nextpage = $prefix . "_p16.php";
	    }
       	updateTracking($stage, $curn, $nextpage);

    	// move on to the next stage or step
    	print("<META HTTP-EQUIV='REFRESH' CONTENT='0; URL=".$nextpage."'>");

	}

function getScore($test, $against)
{
    $exceptions = array(); //"print", "storage", "road", "planet", "bench");

    $trimmed1 = strtolower(trim($test)) . " ";
    $trimmed2 = strtolower(trim($against)) . " ";

    if ($trimmed1 == $trimmed2)
        return 0;

    if (strlen($test) <= 1)
        return 99;
        
    foreach ($exceptions as $nono)
        if (strtolower($test) == strtolower($nono))
            return 99;

    $trimmed11 = preg_replace("/s\s/", "", $trimmed1);
    $trimmed12 = preg_replace("/\s/", "", $trimmed11);
    
    $trimmed21 = preg_replace("/s\s/", '', $trimmed2);
    $trimmed22 = preg_replace("/\s/", '', $trimmed21);
        
    $mp1 = metaphone($trimmed12);
    $mp2 = metaphone($trimmed22);
    $sx1 = soundex($trimmed12);
    $sx2 = soundex($trimmed22);
    
    $lsraw = levenshtein($trimmed12, $trimmed22);
    $lsmraw = levenshtein($mp1, $mp2);
    $lssraw = levenshtein($sx1, $sx2);
    $lsrawpc = $lsraw/strlen($trimmed12) * (2 * ($lsmraw/strlen($mp1))+.01) * (($lssraw/strlen($sx1))+1);
    $lsrawpc = $lsrawpc * .8;

    $score = $lsrawpc;

    //$score = array($lsraw/strlen($trimmed12), 2*($lsmraw/strlen($mp1)+.01), ($lssraw/strlen($sx1)+1));
    
//    if($lsrawpc < .201)
//        $lsrawc = 0;
//    else
//        $lsrawc = 1;
    
//    $lsmp = levenshtein($mp1, $mp2);
//    $lssx = levenshtein($sx1, $sx2);
//    $lsbt = $lsmp * $lssx * $lsrawc;
//    
//    $score = 10 - $lsraw - (2*$lsmp) - (2*$lssx);
    
    //if($lsbt == 0)
        return $score;
    //else
        //return 0;
}

?>

