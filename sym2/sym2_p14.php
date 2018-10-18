<?
/* File: sym2_p14.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Log into session 2
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");

	session_destroy();

    $_SESSION['SID'] = $_REQUEST['SID'];
    $_SESSION['MSC'] = $_REQUEST['MSC'];
	$query = "SELECT SID, MSC FROM $TABLES[subjects] WHERE SID = '".$_SESSION['SID']."';";
	$result = mysql_query($query, $dbh) or die($query);
	$rows = mysql_num_rows($result);

	if($rows < 1)
    	printPage("That subject ID does not exist");
	elseif($rows > 1)
    	printPage("ERROR! There are multiple subjects with that ID, please notify us of this problem by emailing ".$myemail);
	else
	{
    	$subject = mysql_fetch_array($result);
    	if($subject[1] != $_SESSION['MSC'])
        	printPage("That entry code does not match the one recorded for subject ".$_SESSION['SID'].".  Please note that it is case sensitive.");
    	else
    	{
        	$query = "SELECT SID FROM $TABLES[tracking] WHERE ((p14TS > 0) && (SID='".$_SESSION['SID']."'));";
        	$result = mysql_query($query, $dbh) or die($query);
        	$rows = mysql_num_rows($result);
        	if($rows > 0)
            	printPage("Subject number ".$_SESSION['SID']." has already started session 2.  <br>If you started session 2 and were unable to finish, please click <a href='".$prefix."_resume.php?SID=".$SID."&MSC=".$MSC."'>here to resume where you left off.</a>.");
        	else
        	{
            	$subjectID = $SID;
            	$MASt = $MSC;
            	testSID();
            	session_start();
            	$_SESSION['SID'] = $subjectID;
            	$_SESSION['MSC'] = $MASt;
            	$stage = "B14";
            	$curn = "p14";
            	$nextpage = $prefix . "_p15.php";
		        updateTracking($stage, $curn, $nextpage);
            
            	print("<META HTTP-EQUIV='REFRESH' CONTENT='0; URL=".$nextpage."'>");
        	}
    	}
	}
        
function printPage($note)
{
    global $prefix, $myemail;
    printHeader("Begin Session Two", 0, $myemail);
?>
    <script language="JavaScript" type="text/javascript">
    <!--
        function go() {
            document.form.submit();
        }
    //-->
    </script>

    <table width=600 border=0 cellpadding=1 cellspacing=0>
      <tr>
        <td colspan="2">
    <?=$note?>
    <br><br>
    Please enter your subject ID and entry code (both found in the invitation email 
    we sent you) below.<br><br>
    <form name="form" action="<?=$prefix?>_p14.php" method="POST">
      Subject ID: <input type="text" name="SID">
      <br><br>
      Entry Code: <input type="text" name="MSC"><br><br>
      <input type="button" name="Continue" value="Continue" onClick="go();">
    </form>
        </td>
      </tr>
    </table>

<?
    printFooter('', $myemail);
}    
?>

