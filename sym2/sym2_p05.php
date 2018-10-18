<?
/* File: sym2_p05.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Display survey instructions.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");

    if (testSID())
    {

        printHeader("Instructions", 0, $myemail);

		// Next page: submit email
		$nextpage = $prefix . "_s05.php";
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
In this experiment we are going to try and teach you pairs of words.  
You will learn several word pairs, which will be presented side-by-side 
as in the example below:
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
      <table width="120" border="1" bordercolor="#333399" cellspacing="0" cellpadding="6">
        <tr>
          <td valign="middle" align="center">
            <b><big>Dog</big></b>
          </td>
        </tr>
      </table>
    </td>
    <td valign=top align=center></td>
    <td valign=top align=center>
      <table width="120" border="1" bordercolor="#333399" cellspacing="0" cellpadding="6">
        <tr>
          <td valign="middle" align="center">
            <b><big>Cat</big></b>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<br><br>
The word pairs will be presented one at a time, for 6 seconds each. When you see 
each word pair, try to associate them together in order to remember them. 
Try to learn both the forward direction (Dog -&gt; Cat) and the backward direction 
(Cat &lt;- Dog) between the two words, because later you will be tested over both 
directions. For example, you might be given the word Dog, and asked to recall the 
word Cat; or, you might be given the word Cat and asked to recall the word Dog.
<br><br>
When you're ready to begin, click 'Continue'.
          </td>
        </tr>
        <tr>
          <td align=center colspan="2">
            <input type="button" value="Continue" name="Continue" onClick="go();">
            <br><br>
          </td>
        </tr>
      </table>
    </form>

<?
    printFooter('', $myemail);
}
?>
