<?
/* File: browser_test.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 * 
 * Description: This page tests the client's browser, checking for the
 *     availability of javascript and cookies.
 */

	// Include the necessary session data and libraries
	include_once("_session.php");

    // last page: participation requirements
    $lastpage = $prefix . "_p01.php";
	
	printHeader('Browser Test', 0, $myemail);
?>
	<script language="javascript" type="text/javascript">
	<!--//
		function go()
		{
			if((document.form.jstest.value == "OK") &&
				(document.form.cookietest.value == "OK"))
			{
				document.form.submit();
			}
			else
			{
				alert("Either Cookies or JavaScript\nare not enabled on  your computer\n" +
						"you cannot continue with the survey.");
			}
		}

		function JStest()
		{
			var timera = setTimeout("document.form.jstest.value = 'OK';",1000);
		}

		JStest();
	//-->
	</script>
	
<form name="form" action="<?=$lastpage?>" method="POST">
<input type="hidden" name="browsertest" value="1">
<table width=600 border=0>
<tr><td colspan="2" align=center>
<b>Check the text boxes below to see if your cookies and javascript are enabled</b>
<br>&nbsp;
</td></tr>
<tr><td align=left>
<b>Javascript</b> (if the text box does not change to say "OK" that means that JavaScript 
is not working properly.) 
</td><td align=left>
<input type="text" name="jstest" value="Testing...">
</td></tr>
<tr><td align="left">
<b>Cookies</b> (this should say either "OK" or "Disabled", if it says "Disabled" 
please read the instructions below on how you can fix the problem.)
</td><td align="left">
<input type="text" name="cookietest" value="<?
if($_SESSION['testvariable'] == 99){echo "OK";}
else{echo "Disabled";}
?>">
</td></tr>
<tr><td align=left colspan=2>
<br><br>
If your browser failed any one of our tests you can try to fix it.
<br>
<br>
If it failed the JavaScript test, we highly recommend that you download one of the newer browsers, since an outdated browser is the most likely cause of the problem.
<br>
If you do have the latest browser and your JavaScript test still fails, please email us with the problem so that we can fix it.
<br>
<br>
If your browser failed the Cookie test, you can easily fix this.<br>
<b>To enable cookies in Netscape:</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;1. In the Edit menu, select Preferences.<br>
&nbsp;&nbsp;&nbsp;&nbsp;2. Select Cookies in the Privacy and Security category<br>
&nbsp;&nbsp;&nbsp;&nbsp;3. Select "Enable cookies based on privacy settings"<br>
&nbsp;&nbsp;&nbsp;&nbsp;4. Click "View" next to that option, and select "Medium".<br>
<b>To enable cookies in Internet Explorer:</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;1. In the Tools menu, select Internet Options.<br>
&nbsp;&nbsp;&nbsp;&nbsp;2. Click on the Privacy tab.<BR>
&nbsp;&nbsp;&nbsp;&nbsp;3. Move the sliding scale to "Medium".<br><br>
If this did not address  your problem or you have any questions, comments or concerns about our survey, please email us at
<a href="mailto: <?=$myemail?>"><?=$myemail?></a>.
</td>
</tr>
<tr><td align=center colspan=2>
<input type="button" name=continue value="Continue" onClick="go();">
</td></tr>
</table>
</form>
<?
printFooter("",$myemail);
?>
