<?
/* File: sym2_p09b.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Display brief survey reminder instructions.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");

    if (testSID())
    {

        printHeader("Instructions", 0, $myemail);

		// Next page: Test phase
		$nextpage = $prefix . "_s09b.php";
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
Remember, on the following screens you are only trying to study the 
pair of words or think of the missing word - <b>do not type anything</b>.  
<br><br>
When you're ready to begin, click 'Continue'.
          </td>
        </tr>
        <tr>
          <td align=center colspan="2">
            <input type="button" value="Continue" name="Continue" onClick="go();">
          </td>
        </tr>
      </table>
    </form>

<?
    	printFooter('', $myemail);
	}
?>
