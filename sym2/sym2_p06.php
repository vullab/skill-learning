<?
/* File: sym2_p06.php
 * Created on: Jun 23, 2006
 * Edited by: mbielich
 *
 * Description: Presentation Phase.
 */
 
	// Include the necessary session data and libraries
	include_once("_session.php");

    if (testSID())
    {

        printHeader("Learning Presentation", 0, $myemail);

		// Next page: submit email
		$nextpage = $prefix . "_s06.php";

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
            <div name="fact" id="fact" style="font-size:20px; visibility = visible; position:relative;">
              <center>
                <br><br><br>
                
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
                            <b><big><?=$wordB?></big></b>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>

              </center>
            </div>
            <div name="contbutton" id="contbutton" style="font-size:16px; visibility:hidden; position:relative;">
              <table border=0 align=center>
                <tr>
                  <td align="center">
                    <form name="form" action="<?=$nextpage?>" method="POST">
                      <input type="hidden" name="responsetime" value="x">
                      <input type="hidden" name="blurcount" value="0">
                      <input type="button" value="Continue" name="Continue" onClick="go();">
                    </form>
                  </td>
                </tr>
              </table>
            </div>
            <br><br>
            <br><br>
          </div>
          
<? if ($devmode > 0) { ?>
            <table width=600 align=center border=0 bgcolor="#C0C0FF">
              <tr>
                <td>
                  DEV. MODE: pair <?=($_SESSION['count']+1)?> of <?=(count($_SESSION['order']))?>... <?=$wordCue?>: <?=$wordTarget?> (condition: <?=$wc?>, <?=$wordcond?>) 
                  <input type="button" value="next&gt;" name="Continue" onClick="timeout();go();">
                </td>
              </tr>
            </table>
<? } ?>

          </td>
        </tr>
      </table>

    <script language="JavaScript" type="text/javascript">
    <!--
        var startTime = new Date();
        var endTime = new Date();
        var unclicked = true;
        var timedout = false;
    
        isNS4 = (document.layers) ? true : false;
        isIE4 = (document.all && !document.getElementById) ? true : false;
        isIE5 = (document.all && document.getElementById) ? true : false;
        isNS6 = (!document.all && document.getElementById) ? true : false;
        if (isNS4){
            factdisp = document.layers["fact"];
            contbut = document.layers["contbutton"];
        }
        else if (isIE4)
        {
            factdisp = document.all["fact"].style;
            contbut = document.all["contbutton"].style;
        }
        else if (isIE5 || isNS6)
        {
            factdisp = document.getElementById("fact").style;
            contbut = document.getElementById("contbutton").style;
        }
    
        function timeout()
        {
            factdisp.visibility = 'hidden';
            contbut.visibility = 'visible';
            timedout = true;
        }
    
        function go() 
        {
            if(timedout)
            {
                endTime = new Date();
                document.form.responsetime.value = (endTime.getTime() - startTime.getTime());
				document.form.blurcount.value = blurcount;
                document.form.submit();
            }
            else
                return false;
        }

        function startPage()
        {
            startTime = new Date();
<? if ($devmode > 1) { ?>
            var timercfb = setTimeout('timeout();',500);
<? } else { ?>
            var timercfb = setTimeout('timeout();',6000);
<? } ?>
        }
    
        startPage();
    //-->
    </script>

    <script language="JavaScript" type="text/javascript" src="../_lib/leaveme.js"></script>

<?
    	printFooter('', $myemail);
	}
?>
