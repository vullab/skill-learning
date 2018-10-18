<?
/* File: sym2_p08.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Presentation Phase.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");

    if (testSID())
    {

        printHeader("Test and Study", 0, $myemail);

		// Next page: submit email
		$nextpage = $prefix . "_s08.php";

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
        <td align=left>
          <br>
          <div name="bothforms" id="bothforms" style="visibility:visible; text-align: center; width: 100%; text-align:left; position:relative; font-size: 20px;">
          <br><br>
          <div name="wordspan" id="wordspan" style="visibility:hidden; text-align: center; width: 100%; text-align:left; position:absolute; font-size: 20px;">
            <table align="center" border="0" cellspacing="0" cellpadding="1">
              <tr>
                <td valign=top align=center>
                  <table width="120" border="1" bordercolor="#333399" cellspacing="0" cellpadding="6">
                    <tr>
                      <td valign="middle" align="center">
                        <b><big><?=$wordA?></big></b>
                      </td>
                    </tr>
                  </table>
                </td>
                <td valign=top align=center></td>
                <td valign=top align=center>
                  <table width="120" border="1" bordercolor="#333399" cellspacing="0" cellpadding="6">
                    <tr>
                      <td valign="middle" align="center">
                        <b><big><div name="targetspan" id="targetspan" style="visibility:hidden; position:relative;"><?=$wordB?></div></big></b>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
            </div>
            <div name="continuespan" id="continuespan" style="visibility:hidden; text-align: center; width: 100%; text-align:left; position:absolute; font-size: 20px;">
              <table border=0 align=center>
                <tr>
                  <td>
                    <form name="thetest" onSubmit="return go();">
                    <nobr><input type="button" name="OK" value="Continue" onClick="go();"></nobr>
                    </form>
                  </td>
                </tr>
              </table>
            </div>
          </div>
          <br><br>
          <br><br>
          <br><br>

<? if ($devmode > 0) { ?>
          <table width=600 align=center border=0 bgcolor="#C0C0FF">
            <tr>
              <td>
                DEV. MODE: pair <?=($_SESSION['count']+1)?> of <?=(count($_SESSION['order']))?>... <?=$wordCue?>: <?=$wordTarget?> (condition: <?=$wc?>, <?=$wordcond?>) <input type="button" value="next&gt;" name="Continue" onClick="go();">
              </td>
            </tr>
          </table>
<? } ?>

        </td>
      </tr>
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
        
        isNS4 = (document.layers) ? true : false;
        isIE4 = (document.all && !document.getElementById) ? true : false;
        isIE5 = (document.all && document.getElementById) ? true : false;
        isNS6 = (!document.all && document.getElementById) ? true : false;
        if (isNS4){
           feedback = document.layers["wordspan"];
           targetword = document.layers["targetspan"];
           contform = document.layers["continuespan"];
        }
        else if (isIE4) {
            feedback = document.all["wordspan"];
            targetword = document.all["targetspan"];
            contform = document.all["continuespan"];
        }
        else if (isIE5 || isNS6) {
            feedback = document.getElementById("wordspan");
            targetword = document.getElementById("targetspan");
            contform = document.getElementById("continuespan");
        }
    
    function go() {
        if(guessed == 0)
        {
            guessed = 1;

            // calculate response time:
            endTime = new Date();
            document.form.responsetime.value = (endTime.getTime() - startTime.getTime());
			document.form.blurcount.value = blurcount;
            document.form.submit();
        }
        return false;
    }
        
    function doStudy(){
        showTarget();
        showCue();
        //delay 6 seconds then show "continue" button and hide the rest
        var timerStudy = setTimeout("hideCue();hideTarget();showContinue();", 6000);
    }

    function doTest(){
        showCue();
        //delay 4 seconds then show the target word
        var timerTest = setTimeout("showTarget();", 4000);
        //delay 2 seconds then show "continue" button and hide the rest
        var timerStudy = setTimeout("hideCue();hideTarget();showContinue();", 6000);
    }

    function showCue(){
        if(isNS4)
            feedback.visibility = "visible";
        else
            feedback.style.visibility = "visible";
    }

    function hideCue(){
        if(isNS4)
            feedback.visibility = "hidden";
        else
            feedback.style.visibility = "hidden";
    }

    function showTarget(){
        if(isNS4)
            targetword.visibility = "visible";
        else
            targetword.style.visibility = "visible";
    }

    function hideTarget(){
        if(isNS4)
            targetword.visibility = "hidden";
        else
            targetword.style.visibility = "hidden";
    }

    function showContinue(){
        if(isNS4)
            contform.visibility = "visible";
        else
            contform.style.visibility = "visible";
    }

    function hideContinue(){
        if(isNS4)
            contform.visibility = "hidden";
        else
            contform.style.visibility = "hidden";
    }

<?
    // determine start-up action based on the condition (study or test):
    if ($wc{1} == "S")
    {
        // Study condition: show the pair for 6 seconds
        echo "\tdoStudy();\n";
    }
    else
    {
        // Test condition: show the cue for 4 seconds, then both for 2 seconds
        echo "\tdoTest();\n";
    }
    
    if ($devmode > 1)
    {
        echo "\thideTarget();\n";
        echo "\thideCue();\n";
        echo "\tshowContinue();\n";
    }
?>

	//-->
	</script>

    <script language="JavaScript" type="text/javascript" src="../_lib/leaveme.js"></script>

<?
	    printFooter('', $myemail);
	}
?>
