<?
/* File: sym2_email.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: They've already taken the survey - stop now.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");

    if (testSID())
    {

        printHeader("Email Address", 0, $myemail);

?>

    <table width=600 border=0 cellpadding=1 cellspacing=0>
      <tr>
        <td colspan="2">
          The email you entered is already registered in our database.  
          If you feel you recieved this message in error, please click 
          <a href="<?=$prefix?>_p04.php">here</a> and try entering the 
          email address again.
          <br><br>
          If you have already taken the survey, thank you for your 
          participation and enthusiasm, but unfortunately we can allow 
          only one subject per email address.
          <br><br>
          Thank you very much for your participation.
        </td>
      </tr>
    </table>

<?
    	printFooter('', $myemail);
	}
?>