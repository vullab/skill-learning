<?
include_once("_session.php");

/*** EMAIL BODIES ***/

$E01 = "
Thank you for completing the first session of our study
yesterday when you learned word pairs. You should return
to our study to proceed with session two to take the next
quiz and enter the drawing.

To complete session two and enter the drawing, please go to:
".$path.$prefix."_p14.php?SID=<*SID*>&MSC=<*MSC*>

Your subject ID is: <*SID*>
and your entry code is: <*MSC*>

If you have any questions, please email ".$myemail."

Thank you for your participation,
Dualtask.org";


$E02 = "
Yesterday you learned 60 word pairs, please return to our
study to begin session two and enter the drawing.

To complete session two, please go to:
".$path.$prefix."_p14.php?SID=<*SID*>&MSC=<*MSC*>

Your subject ID is: <*SID*>
and your entry code is: <*MSC*>

If you have any questions, please email ".$myemail."

Thank you for your participation,
Dualtask.org";

?>