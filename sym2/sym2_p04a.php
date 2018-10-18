<?
/* File: sym2_p04a.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Verify the email address the subject gave.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");

    if (testSID())
    {

	    // validate the email address with regular expression matching:
    	if (!validateEmail($email))
    	{
        	//invalid or null email address was provided... try again?
        	$nextpage = $prefix . "_invalidemail.php";
        	print("<META HTTP-EQUIV='REFRESH' CONTENT='0; URL=".$nextpage."'>");
    	}
    	else
    	{
	        db_do("UPDATE $TABLES[tracking] SET p04TS = '$timestamp' WHERE SID = '".$_SESSION['SID']."';");

    	    if (($devmode > 0) and ($overwrite == 1)) {
        	    // remove old email addresses of the same (in dev mode) to allow it again
            	$newemail = "DEV" . rand(1,999) . "_" . $email;
            	db_do("UPDATE $TABLES[subjects] SET subjectEmail = '$newemail' WHERE subjectEmail = '$email';");
        	}

        	printHeader("Confirm Email Address", 0, $myemail);

	        $nextpage = $prefix . "_s04.php";
?>

    <script language="JavaScript" type="text/javascript">
    <!--
        function ago()
        {
            if(!document.form2.email)
            {
                alert("You must answer all of the questions to continue.");
            }
            else
            {
                document.form2.submit();
            }
        }
        
        function go()
        {
            document.form.submit();
        }
    //-->
    </script>

    <table width=600 border=0 cellpadding=1 cellspacing=0>
      <tr>
        <td colspan="2">
          This is the email you entered:
          <br><b><?=$email?></b>
        </td>
      </tr>
      <tr>
        <td>
          <form action="<?=$nextpage?>" method="POST" name="form">
            If this is correct, click "Continue" on the right.
        </td>
        <td>
          <input type="hidden" name="email" value="<?=$email?>">
          <input type="button" name="Continue" value="Continue" onClick="go();">
          </form>
        </td>
      </tr>
      <tr>
        <td colspan=2>&nbsp;
        </td>
      </tr>
      <tr>
        <td>
          <form name="form2" action="<?=$prefix?>_p04a.php" method="POST">
            If this is incorrect, please enter your actual email in the 
            box to your right and click "Change".
        </td>
        <td>
          <input type="text" name="email">
        </td>
      </tr>
      <tr>
        <td align=center colspan="2">
          <input type="button" value="Change" name="Change" onClick="ago();">
          </form>
        </td>
      </tr>
    </table>

<?
	        printFooter('', $myemail);
    	}
    }
?>
