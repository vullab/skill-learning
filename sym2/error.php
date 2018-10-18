<?
/* File: error.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Handles error notices
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");

    if($submitted == "resume")
    {
        $result = errorResume($myemail);
        printError($result, $myemail);
    }
    elseif($submitted == "report")
    {
        $result = errorReport($myemail);
        printError($result, $myemail);
    }
    else
    {
        printError($COMMON_ERR[$error], $myemail);
    }

?>