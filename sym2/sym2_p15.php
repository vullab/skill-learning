<?
/* File: sym2_p15.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Session 2 Instructions
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");

    if (testSID())
    {
        $nextpage = $prefix . "_s15.php";

	    printHeader("Session Two: Instructions", 1, $myemail);

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
<b>Cued-Recall of Target</b>
<br><br>
Now we are going to quiz you over what you learned yesterday. For all of the 
word pairs, you will be shown either the first word or the second word, and we would 
like you to type in the correct word that was paired with it.
<br><br>
You might see an example like the one below.  In this case,  
you would type in the correct second word, which is <b>Cat</b>.
<br><br>

<table align="center" border="0" cellspacing="0" cellpadding="1">
<!--
  <tr>
    <td valign=bottom align=center>Cue:</td>
    <td valign=bottom align=center><img src="images/spacer.gif" width="30" height="1"></td>
    <td valign=bottom align=center>Target:</td>
  </tr>
  <tr>
    <td colspan="3"><img src="images/spacer.gif" width="1" height="10"></td>
  </tr>
-->
  <tr>
    <td valign=top align=center>
      <table width="120" height="45" border="1" bordercolor="#333399" cellspacing="0" cellpadding="6">
        <tr>
          <td valign="middle" align="center">
            <b><big>Dog</big></b>
          </td>
        </tr>
      </table>
    </td>
    <td valign=top align=center></td>
    <td valign=top align=center>
      <table width="120" height="45" border="1" bordercolor="#333399" cellspacing="0" cellpadding="6">
        <tr>
          <td valign="middle" align="center">
            <b><big><input type=text size=6 style="border: 0px solid #FFFFFF; text-align: center; font-family:Times New Roman; font-size:14pt; font-weight:bold"></big></b>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<br><br>
Or, you might see an example like the one below. In this case, you  
would type in the correct first word, which is <b>Dog</b>.

<br><br>

<table align="center" border="0" cellspacing="0" cellpadding="1">
<!--
  <tr>
    <td valign=bottom align=center>Cue:</td>
    <td valign=bottom align=center><img src="images/spacer.gif" width="30" height="1"></td>
    <td valign=bottom align=center>Target:</td>
  </tr>
  <tr>
    <td colspan="3"><img src="images/spacer.gif" width="1" height="10"></td>
  </tr>
-->
  <tr>
    <td valign=top align=center>
      <table width="120" height="45" border="1" bordercolor="#333399" cellspacing="0" cellpadding="6">
        <tr>
          <td valign="middle" align="center">
            <b><big><input type=text size=6 style="border: 0px solid #FFFFFF; text-align: center; font-family:Times New Roman; font-size:14pt; font-weight:bold"></big></b>
          </td>
        </tr>
      </table>
    </td>
    <td valign=top align=center></td>
    <td valign=top align=center>
      <table width="120" height="45" border="1" bordercolor="#333399" cellspacing="0" cellpadding="6">
        <tr>
          <td valign="middle" align="center">
            <b><big>Cat</big></b>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>

Take as much time as you need to enter a response.  Although some of them might be 
difficult to remember, please try your best and enter a response even if you are uncertain.
<br><br>
When you're ready to begin, please answer the question below and click 'Continue'.
          </td>
        </tr>
        <tr>
          <td valign=top align=left>
Which best describes the environment you are currently in:
          </td>
          <td valign=top align=left>
<select name="environment">
        <option value=""> PULL DOWN FOR OPTIONS
		<option value="1"> At home in a room by myself 
		<option value="2"> At home with others in the room
		<option value="3"> In an office alone
		<option value="4"> In an office with others in the room
		<option value="5"> In an internet cafe
		<option value="6"> In a library
		<option value="7"> In a computer room at school
		<option value="8"> Other - alone
		<option value="9"> Other - with people around
</select>
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
