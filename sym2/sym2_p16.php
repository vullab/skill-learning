<?
/* File: sym2_p16.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Final Test.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");
	
    if (testSID())
    {

        printHeader("Session Two: Test", 1, $myemail);

		// Next page: submit email
		$nextpage = $prefix . "_s16.php";

	    // get next word-pair and condition from the database
    	list($wordCue, $wordTarget) = db_get("SELECT wordA, wordB FROM $TABLES[stimuli] WHERE WID = '".$_SESSION['order'][$_SESSION['count']]."';");
    	$wc = db_get("SELECT W".$_SESSION['order'][$_SESSION['count']]." FROM $TABLES[conditions] WHERE SID='".$_SESSION['SID']."';");

		$wordcond = ($wc{2} == "R") ? "(Reversed)" : "(Normal)";
		if ($wc{1} == "S") {$wordcond = "Study ".$wordcond;} elseif ($wc{1} == "T") {$wordcond = "Test ".$wordcond;} else {$wordcond = "Baseline ".$wordcond;}
		$wordcond = ($wc{0} == "F") ? "Forward ".$wordcond : "Backward ".$wordcond;

    	if ($wc{2} == "R")
    	{
    		$wordA = $wordTarget;
    		$wordB = $wordCue;
    	}
    	else
    	{
    		$wordA = $wordCue;
    		$wordB = $wordTarget;
    	}
?>

    <table width=600 border=0 cellpadding=1 cellspacing=0>
      <tr>
        <td align=center>
          <br><br>
          <form name="thetest" onSubmit="return go();" autocomplete="off">
            <font size="4">
<?
if ($wc{0} == "F")
{
?>
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
            <b><big><?=$wordA?></big></b>
          </td>
        </tr>
      </table>
    </td>
    <td valign=top align=center></td>
    <td valign=top align=center>
      <table width="120" height="45" border="1" bordercolor="#333399" cellspacing="0" cellpadding="6">
        <tr>
          <td valign="middle" align="center">
            <b><big><input type=text name="theresponse" size="6" style="border: 0px solid #FFFFFF; font-family:Times New Roman; font-size:14pt; font-weight:bold; text-align: center;"></big></b>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td colspan=2></td>
    <td valign=middle align=center><br><input type="button" name="OK" value="OK" onClick="go();"></td>
  </tr>
</table>
<?
    $correct = $wordB;
}
elseif ($wc{0} == "B")
{
?>
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
            <b><big><input type=text name="theresponse" size="6" style="border: 0px solid #FFFFFF; font-family:Times New Roman; font-size:14pt; font-weight:bold; text-align: center;"></big></b>
          </td>
        </tr>
      </table>
    </td>
    <td valign=top align=center></td>
    <td valign=top align=center>
      <table width="120" height="45" border="1" bordercolor="#333399" cellspacing="0" cellpadding="6">
        <tr>
          <td valign="middle" align="center">
            <b><big><?=$wordB?></big></b>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td valign=middle align=center><br><input type="button" name="OK" value="OK" onClick="go();"></td>
    <td colspan=2></td>
  </tr>
</table>
<?
    $correct = $wordA;
}
?>
</font>
</form>
<br><br>

<? 
if ($devmode > 0) { ?>
<table width=600 align=center border=0 bgcolor="#C0C0FF"><tr><td>
DEV. MODE: pair <?=($_SESSION['count']+1)?> of <?=count($_SESSION['order'])?>... <?=$wordCue?>: <?=$wordTarget?> (cond.: <?=$wc?>, <?=$wordcond?>) simulate:<input type="button" value="correct" name="Continue" onClick="document.thetest.theresponse.value='<?=$correct?>';go();"><input type="button" value="incorrect" name="Continue" onClick="document.thetest.theresponse.value='XXX';go();">
</td></tr></table>
<? } ?>

</td></tr>
</table>

<form action="<?=$nextpage?>" method="POST" name="form">
<input type="hidden" name="response">
<input type="hidden" name="responsetime">
<input type="hidden" name="blurcount" value="0">
<input type="hidden" name="correct">
</form>

    <script language="JavaScript" type="text/javascript">
    <!--//
        var startTime = new Date();
        var endTime = new Date();
        var guessed = 0;
        correctThing = '<?=$correct?>';
        
        isNS4 = (document.layers) ? true : false;
        isIE4 = (document.all && !document.getElementById) ? true : false;
        isIE5 = (document.all && document.getElementById) ? true : false;
        isNS6 = (!document.all && document.getElementById) ? true : false;
        if (isNS4){
            correctfb = document.layers["correct"];
        }
        else if (isIE4) {
            correctfb = document.all["correct"];
        }
        else if (isIE5 || isNS6) {
            correctfb = document.getElementById("correct");
        }
    
    rnd.today=new Date();
    rnd.seed=rnd.today.getTime();

    function rnd() {
            rnd.seed = ((rnd.seed*9301+49297) % 233280);
            return (rnd.seed/(233280.0));
    }

    function rand(number) {
        return (Math.ceil(rnd()*number));
    }
    
    function go() {
        if(guessed == 0)
        {
            if(document.thetest.theresponse.value)
            {
                guessed = 1;

                endTime = new Date();
                document.form.responsetime.value = (endTime.getTime() - startTime.getTime());
				document.form.blurcount.value = blurcount;
                if(document.thetest.theresponse.value.toLowerCase() == correctThing.toLowerCase())
                    correctAns();
                else
                    incorrectAns();
            }
            else
            {
                alert("Please enter a guess, even if you do not know the answer.");
                document.thetest.theresponse.focus();
            }        
        }
        return false;
    }

    function correctAns()
    {
        document.form.response.value = document.thetest.theresponse.value.toLowerCase();
        document.form.correct.value = 1;
        document.form.submit();
    }

    function incorrectAns(){
        document.form.response.value = document.thetest.theresponse.value.toLowerCase();
        document.form.correct.value = 0;
        document.form.submit();
    }            

    document.thetest.theresponse.focus();
    //-->
    </script>

    <script language="JavaScript" type="text/javascript" src="../_lib/leaveme.js"></script>

<?
	    printFooter('', $myemail);
	}
?>
