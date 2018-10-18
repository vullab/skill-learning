<?
/* File: sym2_p01.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 * 
 * Description: This page lists the participation requirements, giving
 *     the subject an idea of what they are getting themselves into
 *     before actually starting.
 */

	// Include the necessary session data and libraries
	include_once("_session.php");

    printHeader("Participation Requirements", 0, $myemail);

    // store this in session data to test the browser
    $_SESSION['testvariable'] = 99;

	if (!$browsertest)
		$browsertest = "X";

    // store the default email in the session, if there was one
    if ($defemail)
        $_SESSION['defemail'] = $defemail;

    // next page: demographics form
    $nextpage = $prefix . "_p02.php";
?>
    <script language="JavaScript" type="text/javascript">
    <!--
		var PresStartTime = new Date();
		var PresEndTime = new Date();

		function go()
		{
			PresEndTime = new Date();
			document.form.responsetime.value = (PresEndTime.getTime() - PresStartTime.getTime());
			document.form.submit();
		}
    //-->
    </script>
    
    <form name="form" action="<?=$nextpage?>" method="POST">
      <input type="hidden" name="responsetime" value="X">
      <input type="hidden" name="browsertest" value="<?=$browsertest?>">
      <table width="600" border="0" cellpadding="1" cellspacing="0">
        <tr>
          <td align="left">
Here are the requirements for participating in this study:
<br><br>
Once you start the session, <b>you must continue without closing your 
browser</b>. You must not leave the study until the end. You cannot pick 
it back up in the middle.  If you are away from the computer for too 
long, the session will timeout and you will be unable to complete 
the survey and ineligible to enter the drawing.
<br><br>
You must have javascript and cookies enabled on your browser. To 
find out if you do, click <a href="browser_test.php">here</a>.
<br><br>
To complete the study, we will require your email address, since we 
have to send you notification of how to complete each part. We will 
not disclose this information to anyone. We will only use your email 
address to send you the notification of future sessions or that you 
have won a prize. We will not save your email address after the 
study is completed.
<br><br>
<b>To complete the entire study and be eligible for the drawing, you 
must complete both sessions. You will be notified how to do so in 
an email we send you at that time.</b>
<br><br>
The drawing for a prize (US$100) is based solely on completing both 
sessions.  Higher performance will not improve your chances.  
Completing the study more than once will make you ineligible to 
win a prize.
<br><br>
If you are unable to meet these requirements, we thank you for your 
time, but unfortunately you cannot participate.
<br><br>
If these requirements do not pose a problem for you, click continue.
<br>
          </td>
        </tr>
        <tr>
          <td align="center">
            <input type=button name="Continue" value="Continue" caption="Continue" onClick="go();">
          </td>
        </tr>
      </table>
    </form>

<?
    // do a hidden count on this page - how many people get this far then quit?
    showCounter("");

    printFooter('', $myemail);
?>
