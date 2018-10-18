Attribute VB_Name = "Experiment"
Option Explicit

'==================================================================================
'Variables Common to Most Experiments
'==================================================================================

Public sDir As String               'Application's Starting Directory
Public subID As Integer             'The subjects id number.
Public sBlockType As String         'Block type name ("Var" or "Fixed")
Public iCondition As Integer        'Which condition is being run
Public iTrialNum As Integer         'Current Trial Number
Public iBlockNum As Integer         'Current Block Number
Public iSize As Integer             'Display Size

Public iFileNum As Integer          'Used when opeing/editing files
Public iLoop As Integer             'Global Loop variable
Public outPutFile As String         'This is the R-<subId>.txt file.
Public ExcelFile As String          'This is the Excel files name

Public iWrong As Integer            'Number of wrong in block
Public iCorrect As Integer          'Number of correct in block
Public dTotalRTs As Double          'Total RT time in block

Public iAvgRTs(1 To 32) As Integer  'Keep track of average rts for each block
Public iWrongCount(1 To 32) As Integer  'Keep track of wrongs for each block

Public lColors() As Long            'Color to display
Public sResponse() As String       'Possible response keys
Public sColors() As String          'The RGB String for each color
Public iCondition3() As Integer     'Color series for condition 3

'Variables used for Block statistics
Public RTs As Double

Public BLOCK_SIZE As Integer        'Number of trials for current block

'Constants for this experiment
'=================================================================================
'Turn Debugger on/off
Public Const bDebug As Boolean = False

'Name of experiment
Public Const sExpName As String = "TrainType2B"

