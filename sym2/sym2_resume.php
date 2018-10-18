<?
/* File: sym2_resume.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Allows a subject to resume where they left off.
 */
 
    session_destroy();
    unset($_SESSION['SID']);
    
	// Include the necessary session data and libraries
	include_once("_session.php");

    $_SESSION['SID'] = $_REQUEST['SID'];
    $_SESSION['MSC'] = $_REQUEST['MSC'];
    $rows = db_get("SELECT COUNT(*) FROM $TABLES[subjects] WHERE SID = '".$_SESSION['SID']."';");

    if($rows < 1)
    {
        printPage("That subject ID does not exist");
    }
    elseif($rows > 1)
    {
        printPage("ERROR! There are multiple subjects with that ID, please notify us of this problem by emailing ".$myemail);
    }
    else
    {
        $testMSC = db_get("SELECT MSC FROM $TABLES[subjects] WHERE SID = '".$_SESSION['SID']."';");
        if($testMSC != $_SESSION['MSC'])
        {
            printPage("That entry code does not match the one recorded for subject ".$_SESSION['SID'].".  Please note that it is case sensitive.");
        }
        else
        {
            list($nextpage, $sesbuf) = db_get("SELECT page, session FROM $TABLES[resume] WHERE SID = '".$_SESSION['SID']."';");
            session_decode($sesbuf);

            print("<META HTTP-EQUIV='REFRESH' CONTENT='0; URL=".$nextpage."'>");
        }
    }
        
function printPage($note)
{
    global $prefix, $myemail;
    printHeader("Resume Survey", 0, $myemail);
    ?>
    <script language="JavaScript" type="text/javascript">
    <!--
      function go()
      {
        document.form.submit();
      }
    //-->
    </script>
    
    <form action="resume.php" method="POST" name="form">
      <table width=600 border=0 cellpadding=1 cellspacing=0>
        <tr>
          <td colspan="2">
            <?=$note?>
            <br><br>
            Please enter your subject ID and entry code (both found in the 
            invitation email we sent you) below.
            <br><br>
            Subject ID: <input type="text" name="SID">
            <br><br>
            Entry Code: <input type="text" name="MSC"><br><br>
            <input type="button" name="Continue" value="Continue" onClick="go();">
          </td>
        </tr>
      </table>
    </form>
    <?
    printFooter('', $myemail);
}    
?>
