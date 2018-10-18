<?
/* File: sym2_p11.php
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

		// Next page: Test phase
		$nextpage = $prefix . "_s11.php";
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
Now we are going to present the same word pairs again, one last time. 
For some of the word pairs, you will see both the words again (for 
example, <b>dog: cat</b>) for 6 seconds. Again, we would like you to try and associate 
them together in order to remember them.
<br><br>
For other word pairs, you will see only the first word (for example, <b>dog: ____</b>) 
for 4 seconds, and we would like you to try and remember the second word 
(which is <b>cat</b>, in this example). After the first word is 
presented alone for 4 seconds, the second word will be presented for an 
additional 2 seconds, so you can see whether or not you remembered it.  
Please do your best to remember the words.
<br><br>
During this phase of the experiment, again try to learn both the forward direction 
(Dog -&gt; Cat) and the backward direction (Cat &lt;- Dog) between the two words. 
On a later test you might be given the word Dog, and asked to recall Cat; or, you 
might be given the word Cat, and asked to recall Dog.
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
