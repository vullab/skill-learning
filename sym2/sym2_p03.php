<?
/* File: sym2_p03.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Shows the ethnicity form.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");

    if (testSID())
    {

        printHeader("Demographic Information 2", 0, $myemail);
    
        // next page: submit ethnicity
        $nextpage = $prefix . "_s03.php";

?>
	<script language="JavaScript" type="text/javascript">
	<!--
		var PresStartTime = new Date();
		var PresEndTime = new Date();

		function go()
		{
			if( !document.form.ethnicity.selectedIndex )
			{
				if(! confirm("We ask that you answer all of the questions,\n" +
								"if you prefer not to, simply click " +
								"'Cancel' to go on to the next page;\n" +
								"otherwise, click 'OK' to finish filling " +
								"out this page.") )
				{
					// user hit Cancel, allow them to submit incomplete
					PresEndTime = new Date();
					document.form.responsetime.value = (PresEndTime.getTime() - PresStartTime.getTime());
					document.form.submit();
				}
			}
			else
			{
				// all fields were entered, submit the form
				PresEndTime = new Date();
				document.form.responsetime.value = (PresEndTime.getTime() - PresStartTime.getTime());
				document.form.submit();
			}
		}
	//-->
	</script>

    <form action="<?=$nextpage?>" method="POST" name="form">
      <input type="hidden" name="responsetime" value="X">
      <table width="600" border="0" cellpadding="1" cellspacing="0">
        <tr>
          <td>
            What is your race or ethnicity?
          </td>
          <td>
            <SELECT NAME="ethnicity">
<?=$COMMON_LIST_ethnicities?>
            </SELECT>
          </td>
        </tr>
        <tr>
          <td align="center" colspan="2">
            <input type="button" value="Continue" name="Continue" onClick="go();">
          </td>
        </tr>
      </table>
    </form>

<?
        showCounter("");

        printFooter('', $myemail);
    }
?>
