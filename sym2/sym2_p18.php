<?
/* File: sym2_p18.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: All done.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");

    printHeader("Survey complete!", 0, $myemail);

    $nextpage = $prefix . "_p18.php";
?>
    <form action="<?=$nextpage?>" method="POST" name="form">
      <table width=600 border=0 cellpadding=1 cellspacing=0>
        <tr>
          <td colspan="2">
            You have been entered into our drawing.<br><br>
            Thank you for your participation.
            To view all of our currently running surveys, please follow the link below:<br>
            <a href="http://surveys.dualtask.org/index.php">http://surveys.dualtask.org/index.php</a>
          </td>
        </tr>
      </table>
    </form>
<?
    printFooter('', $myemail);
?>
