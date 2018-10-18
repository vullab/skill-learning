<?
/* File: sym2_p13.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: All done with session 1!
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");
	include_once("_email.php");

    if (testSID())
    {
	    $email = db_get("SELECT subjectEmail FROM $TABLES[subjects] WHERE SID = '".$_SESSION['SID']."';");

	    session_destroy();
   
	    $stage = "A13";
	    $curn = "p13";
        $nextpage = $prefix . "_p13.php";
        updateTracking($stage, $curn, $nextpage);

        printHeader("Session One Complete!", 1, $myemail);

?>
    <script language="JavaScript" type="text/javascript">
    <!--
        function go()
        {
            if(!1)
            {
                alert("You must answer all of the questions to continue.");
            }
            else
            {
                document.form.submit();
            }
        }
    //-->
    </script>

    <form action="<?=$nextpage?>" method="POST" name="form">
      <table width=600 border=0 cellpadding=1 cellspacing=0>
        <tr>
          <td colspan="2">
You have now completed Session One.
<br><br>
You will receive an email at the email address you specified (<?=$email?>) in
1 day with instructions on how to begin Session Two and enter the drawing.<br>
If there is a problem with the email address printed above, please let us know by emailing us at
<a href="mailto:<?=$myemail?>"><?=$myemail?></a>.  Be sure to tell us what the 
incorrect email address written above is, what the email address should be, and your 
subject ID (<?=$_SESSION['SID']?>).
<BR><BR>
Thank you very much for your interest and participation in our study.<br>
A complete list of our currently running studies is available at <a href="http://surveys.dualtask.org/index.php">http://surveys.dualtask.org/index.php</a>.
<br>
Your session has now ended, so you may not hit "back" on your browser to go back.<br>
<? if ($devmode > 0) { ?>
<p>
<table border=0 bgcolor="#C0C0FF">
  <tr>
    <td>
DEV. MODE: For testing purposes... the following email would be sent to the subject
18 hours from seeing this page:
<br>
<table border=1>
  <tr>
    <td>
<pre><?=prevEmail($E01, $_SESSION['SID'], $_SESSION['MSC'])?></pre>
    </td>
  </tr>
</table>
<p>
DEV. MODE: For testing purposes... the following email would be sent to the subject
24 hours from seeing this page if they did not already begin session 2:
<br>
<table border=1>
  <tr>
    <td>
<pre><?=prevEmail($E02, $_SESSION['SID'], $_SESSION['MSC'])?></pre>
    </td>
  </tr>
</table>
    </td>
  </tr>
</table>
<br>
<? } ?>
          </td>
        </tr>
      </table>
    </form>

<?
	    printFooter('', $myemail);
	}
?>
