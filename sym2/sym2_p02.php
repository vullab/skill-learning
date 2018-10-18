<?php
/* File: sym2_p02.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Shows a form to collect demographic information from
 *     the subject before beginning the survey.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");

    printHeader("Demographic Information", 0, $myemail);

    // next page: submit demographic information
    $nextpage = $prefix . "_s02.php";
?>
    <script language="JavaScript" type="text/javascript">
    <!--
		var PresStartTime = new Date();
		var PresEndTime = new Date();

		function go()
		{
		
			PresEndTime = new Date();
			document.form.responsetime.value = (PresEndTime.getTime() - PresStartTime.getTime());

			if( !(document.form.gender[0].checked ||
				document.form.gender[1].checked) ||
				!document.form.age.selectedIndex ||
				!document.form.education.selectedIndex ||
				!document.form.environment.selectedIndex ||
				!document.form.psychexp.selectedIndex)
			{
				if( !(confirm("We ask that you answer all of the " +
								"questions,\nif you prefer not to, simply " +
								"click 'Cancel' to go on to the next " +
								"page;\notherwise, click 'OK' to finish " +
								"filling out this page.")))
				{
				document.form.submit();
				}
			}
			else
			{
				document.form.submit();
			}
		}
    //-->
    </script>

    <form action="<?=$nextpage?>" method="POST" name="form">
      <input type="hidden" name="responsetime" value="X">
      <input type="hidden" name="browsertest" value="<?=$browsertest?>">
      <input type="hidden" name="browser" value="X">
      <input type="hidden" name="resolution" value="X">
<? if (isset($_SESSION['SID'])) { ?>
      <input type="hidden" name="repSID" value="<?=$_SESSION['SID']?>">
<? } ?>
      <table width="600" border="0" cellpadding="1" cellspacing="0">
        <tr>
          <td colspan="2" align="center">
            Thanks for participating.   First, a few very quick 
            demographic questions:
          </td>
        </tr>
        <tr>
          <td>
            What country do you live in?
          </td>
          <td>
            <SELECT NAME="country">
<?=$COMMON_LIST_countries?>
            </SELECT>
          </td>
        </tr>
        <tr>
          <td>
            What is your gender?
          </td>
          <td>
            <INPUT NAME="gender" TYPE="radio" VALUE="m"> Male 
            <INPUT NAME="gender" TYPE="radio" VALUE="f"> Female 
          </td>
        </tr>
        <tr>
          <td>
            What is your age?
          </td>
          <td>
            <SELECT NAME="age">
<?=$COMMON_LIST_ages?>
            </SELECT> 
          </td>
        </tr>
        <tr>
          <td>
            What is the highest level of education you have had?
          </td>
          <td>
            <SELECT NAME="education">
<?=$COMMON_LIST_education?>
            </SELECT>
          </td>
        </tr>
        <tr>
          <td valign=top align=left>
            Which best describes the environment you are currently in:
          </td>
          <td valign=top align=left>
            <SELECT NAME="environment">
<?=$COMMON_LIST_environments?>
            </SELECT>
          </td>
        </tr>
        <tr>
          <td valign="top">
            How much exposure have you had to psychology?
          </td>
          <td>
            <SELECT NAME="psychexp">
<?=$COMMON_LIST_psychexp?>
            </SELECT>
          </td>
        </tr>
        <tr>
          <td align=center colspan="2">
            <input type="button" value="Continue" name="Continue" onClick="go();">
          </td>
        </tr>
      </table>
    </form>

	<script language="JavaScript" type="text/javascript">
	<!--
		isNS4 = (document.layers) ? true : false;
		isIE4 = (document.all && !document.getElementById) ? true : false;
		isIE5 = (document.all && document.getElementById) ? true : false;
		isNS6 = (!document.all && document.getElementById) ? true : false;
		if(isNS4)  
			document.form.browser.value = "NS4";
		if(isIE4)  
			document.form.browser.value = "IE4";
		if(isIE5)  
			document.form.browser.value = "IE5";
		if(isNS6)  
			document.form.browser.value = "IE6";

		document.form.resolution.value = screen.width + "x" + screen.height;
    //-->
    </script>

<?
    showCounter("");
    
    printFooter('', $myemail);
?>