Attribute VB_Name = "Proctor"
Option Explicit


'Constants for this experiment
'=========================================================================================
'=========================================================================================

'Variables Common to Most Experiments
'=========================================================================================

Public sDir As String               'Application's Starting Directory
Public sSubName As String           'Subject's first name
Public subID As Integer             'The subjects id number.
Public sBlockType As String         'Block type name

Public sTraining As Integer
Public sOrder(1 To 22) As String
Public sOrdCondition  As Integer
Public sAssociation(1 To 4) As Integer

Public iCondition As Integer        'Which condition is being run
Public iTrialNum As Integer         'Current Trial Number
Public iBlockNum As Integer         'Current Block Number
Public iBlockSize As Integer        'Current Block Size

Public iFileNum As Integer          'Used when opeing/editing files
Public iLoop As Integer             'Global Loop variable
Public outPutFile_Training As String         'This is the R-<subId>.txt file.
Public outPutFile_Inference As String         'This is the R-<subId>.txt file.
Public outPutFile_Skill As String         'This is the R-<subId>.txt file.

'Variables used for Block statistics
Public RTs As Double
Public RT2 As Double
Public totalRT As Double

Public iCorrect As Integer
Public iWrong As Integer

Public DirectX As New DirectX7
Public DS As DirectSound

Public HighTone As DirectSoundBuffer
Public LowTone As DirectSoundBuffer

Public Const bDebug As Boolean = True 'Set debug on or off


    Public nTrainingBlocks As Integer
    Public nTrainingBlockTrials As Integer
    Public nInferenceBlocks As Integer
    Public nInferenceBlockTrials As Integer
    Public nSkillBlocks As Integer
    Public nSkillBlockTrials As Integer
    Public nSecsWait As Integer

