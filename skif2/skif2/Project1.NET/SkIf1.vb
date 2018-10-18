Option Strict Off
Option Explicit On
Module SkIf1
	
	
	'Constants for this experiment
	'=========================================================================================
	'=========================================================================================
	
	'Variables Common to Most Experiments
	'=========================================================================================
	
	Public sDir As String 'Application's Starting Directory
	Public sSubName As String 'Subject's first name
	Public subID As Short 'The subjects id number.
	Public sBlockType As String 'Block type name
	
	Public sTraining As Short
	'UPGRADE_WARNING: Lower bound of array sOrder was changed from 1 to 0. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="0F1C9BE1-AF9D-476E-83B1-17D43BECFF20"'
	Public sOrder(22) As String
	Public sOrdCondition As Short
	'UPGRADE_WARNING: Lower bound of array sAssociation was changed from 1 to 0. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="0F1C9BE1-AF9D-476E-83B1-17D43BECFF20"'
	Public sAssociation(4) As Short
	
	Public iCondition As Short 'Which condition is being run
	Public iTrialNum As Short 'Current Trial Number
	Public iBlockNum As Short 'Current Block Number
	Public iBlockSize As Short 'Current Block Size
	
	Public iFileNum As Short 'Used when opeing/editing files
	Public iLoop As Short 'Global Loop variable
	Public outPutFile_Training As String 'This is the R-<subId>.txt file.
	Public outPutFile_Inference As String 'This is the R-<subId>.txt file.
	Public outPutFile_Skill As String 'This is the R-<subId>.txt file.
	
	'Variables used for Block statistics
	Public RTs As Double
	Public RT2 As Double
	Public totalRT As Double
	
	Public iCorrect As Short
	Public iWrong As Short
	
	Public DirectX As New DxVBLib.DirectX7
	Public DS As DxVBLib.DirectSound
	
	Public HighTone As DxVBLib.DirectSoundBuffer
	Public LowTone As DxVBLib.DirectSoundBuffer
	
	Public Const bDebug As Boolean = False 'Set debug on or off
	
	
	Public nTrainingBlocks As Short
	Public nTrainingBlockTrials As Short
	Public nInferenceBlocks As Short
	Public nInferenceBlockTrials As Short
	Public nSkillBlocks As Short
	Public nSkillBlockTrials As Short
	Public nSecsWait As Short
End Module