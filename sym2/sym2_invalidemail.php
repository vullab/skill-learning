<?
/* File: sym2_invalidemail.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Deal with invalid email addresses - may just have been a typo.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");

    if (testSID())
    {

        printHeader("Email Address", 0, $myemail);

		// Next page: submit email
		$nextpage = $prefix . "_p04a.php";
?>

    <script language="JavaScript" type="text/javascript">
    <!--
        // Continue was pressed:
        function go() 
        {
            if(!document.form.email.value)
            {
                alert("You must enter a valid email address.");
            }
            else
            {
                var str = document.form.email.value;
                var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                if (filter.test(str))
                {
                    document.form.submit();
                }
                else
                {
                    alert("You must enter a valid email address.");
                }
            }
        }
    //-->
    </script>

    <form action="<?=$nextpage?>" method="POST" name="form">
      <table width=600 border=0 cellpadding=1 cellspacing=0>
        <tr>
          <td colspan="2">
            <b>The email address you entered is not valid.  Please try again:</b>
            <br><br>
            We need to get your email so we can contact you tomorrow after 
            completing the first session today.  This email will be kept on 
            the server and will only be seen by the computer.  It will be 
            used for only one purpose: to contact you the next day with the 
            link to resume the experiment in sessions 2.  We will not give 
            the email address to anyone or use it ourselves to contact you 
            except for the final phase of this experiment.  When you are 
            done your email will be deleted from the database.
            <br>
          </td>
        </tr>
        <tr>
          <td>
            Please enter your email:
          </td>
          <td>
            <input type="text" name="email">
          </td>
        </tr>
        <tr>
          <td align=center colspan="2">
            <input type="button" value="continue" name="Continue" onClick="go();">
          </td>
        </tr>
      </table>
    </form>

<?
	    printFooter('', $myemail);
	}
?>