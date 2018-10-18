<?
/* File: sym2_p17.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: All done with the survey!
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");

    if (testSID())
    {
   
        printHeader("Survey complete!", 1, $myemail);
        
        $nextpage = $prefix . "_s17.php";
?>
    <script language="JavaScript" type="text/javascript">
    <!--
      function go()
      {
        document.form.submit();
      }
    //-->
    </script>

    <form action="<?=$nextpage?>" method="POST" name="form">
      <table width=600 border=0 cellpadding=1 cellspacing=0>
        <tr>
          <td colspan="2">
            Thank you for completing our survey.
            <br><br>
            To enter into the drawing, simply enter your email address below.
            <br><br>
            <center>
            <input type="text" name="emailprize">
            &nbsp;&nbsp;&nbsp;
            <input type="submit">
            <br>
            <input type="checkbox" name="subscribe" value="Y"> I would like to be
            notified of future DualTask.org studies.
            </center>
          </td>
        </tr>
      </table>
    </form>
<?
        printFooter('', $myemail);
    }
?>