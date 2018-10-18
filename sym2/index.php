<?
/* File: index.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 * 
 * Description: This is the first page a subject sees when entering the
 *     study.  If the study is closed, a notice is posted as such.  If not,
 *     the consent form is shown and the subject is given a button to
 *     continue on with the study.
 */
 
 	// Include the necessary session data and libraries
	include_once("_session.php");

	// Clear the session data
	session_destroy();

	// was there an email in the query string?  pass it along for later...
	$defemail = $_SERVER["QUERY_STRING"];
	if (!(validateEmail($defemail)))
		$defemail="";
        
	if ($SURVEYINFO->isClosed == '1')
	{
		// if the survey is closed, make the announcement
		$nextpage = "http://surveys.dualtask.org/";
		$content = $COMMON_closed;
		printHeader("Study not Available", 0, $myemail);
	}
	else
	{
		// if the survey is still open, show the consent form
        
		// next page: participation requirements
		$nextpage = $prefix."_p01.php";
		$content = $COMMON_consent;
		printHeader("Consent", 0, $myemail);
	}
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

    <form action="<?=$nextpage?>" method="POST" name="form">
      <input type="hidden" name="defemail" value="<?=$defemail?>">
      <input type="hidden" name="responsetime" value="X">
      <table width="600" border="0" cellpadding="1" cellspacing="0">
        <tr>
          <td align="left">
            <?=$content?> 
          </td>
        </tr>
        <tr>
          <td align="center">
            <br><br>
            <input type="button" value="Continue" name="Continue" onclick="go();">
          </td>
        </tr>
      </table>
    </form>

<?
    // do a hidden count on this page - how many people get this far then quit?
    showCounter("");
    printFooter('', $myemail);
?>