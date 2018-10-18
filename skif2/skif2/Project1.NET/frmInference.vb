Option Strict Off
Option Explicit On
Friend Class frmInference
	Inherits System.Windows.Forms.Form
	
	Dim picPath As String 'Path to Pictures
	'UPGRADE_WARNING: Lower bound of array sPreCuePic was changed from 1 to 0. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="0F1C9BE1-AF9D-476E-83B1-17D43BECFF20"'
	Dim sPreCuePic(4) As String 'The PreCue Pictures to display
	'UPGRADE_WARNING: Lower bound of array sStimPic was changed from 1 to 0. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="0F1C9BE1-AF9D-476E-83B1-17D43BECFF20"'
	Dim sStimPic(4) As String 'The Stim Pictures to display
	
	Dim iReliable As Short 'Reliable trial or not?
	Dim iPreCue As Short 'Which letter to show
	Dim iStim As Short 'Which tone to play
	
	Dim bDisplayed As Boolean 'If done showing tone
	Dim bDisplayDone As Boolean 'If done showing tone
	
	Dim iResponse As Short 'Response to letter task
	Dim bDataNotSaved As Boolean
	
	'UPGRADE_WARNING: Lower bound of array iStimOrd was changed from 1 to 0. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="0F1C9BE1-AF9D-476E-83B1-17D43BECFF20"'
	Dim iStimOrd(4) As Short
	Dim iSIdx As Short
	
	'UPGRADE_WARNING: Lower bound of array bKey was changed from 1 to 0. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="0F1C9BE1-AF9D-476E-83B1-17D43BECFF20"'
	Dim bKey(4) As Boolean 'Check if key is held down
	
	Private Sub startExperiment()
		expImage3.Visible = False
		iTrialNum = iTrialNum + 1
		bDisplayed = False
		bDisplayDone = True
		bDataNotSaved = True
		iResponse = 0
		RTs = 0
		RT2 = 0
		
		For iLoop = 1 To 4
			bKey(iLoop) = False
		Next iLoop
		
		
		If iTrialNum > nInferenceBlockTrials Then
			frmInstructions.Visible = True
			Me.Close()
			Exit Sub
		End If
		
		'Show Fixation Cross...
		fixImage.Visible = True
		Me.Refresh()
		PauseMil((500))
		fixImage.Visible = False
		Me.Refresh()
		PauseMil((500))
		
		'Pick a letter and tone
		Dim temporary As Short
		If (iSIdx = 0) Or (iSIdx = 4) Then
			
			
			For iLoop = 1 To 4
				iStimOrd(iLoop) = 0
			Next iLoop
			
			For iLoop = 1 To 4
				temporary = Int(Rnd() * 4) + 1
				While iStimOrd(temporary) > 0
					temporary = Int(Rnd() * 4) + 1
				End While
				iStimOrd(temporary) = iLoop
			Next iLoop
			
			iSIdx = 0
		End If
		
		iSIdx = iSIdx + 1
		
		iStim = iStimOrd(iSIdx)
		iReliable = 1
		
		iPreCue = sAssociation(iStim) 'If reliable go with association
		
		' Construct File Names
		Dim sPreCueFilename As String
		Dim sStimulusFilename As String
		Dim sStimCueFilename As String
		
		sPreCueFilename = sPreCuePic(iPreCue) & "_.bmp"
		sStimCueFilename = sPreCuePic(iPreCue) & sStimPic(iStim) & ".bmp"
		sStimulusFilename = "_" & sStimPic(iStim) & ".bmp"
		
		
		expImage1.Image = System.Drawing.Image.FromFile(My.Application.Info.DirectoryPath & picPath & "blank.bmp")
		expImage2.Image = System.Drawing.Image.FromFile(My.Application.Info.DirectoryPath & picPath & sPreCueFilename)
		expImage3.Image = System.Drawing.Image.FromFile(My.Application.Info.DirectoryPath & picPath & sPreCueFilename)
		
		'Do letter task
		StartTimer((1))
		bDisplayed = True
		expImage1.Visible = True
		Me.Refresh()
		
		PauseMil((400))
		
		expImage1.Visible = False
		StartTimer((2))
		expImage2.Visible = True
		Me.Refresh()
		
		PauseMil((400))
		
		expImage2.Visible = False
		StartTimer((3))
		expImage3.Visible = True
		bDisplayDone = True
		Me.Refresh()
		
		PauseMil((600))
		While bDataNotSaved = True
			PauseMil((100))
		End While
		ContinueOn()
		
	End Sub
	
	Private Sub writeData()
		Dim sAccuracy As String 'The accuracy of letter task
		
		'Check accuracy of letter
		If iResponse = iStim Then
			sAccuracy = "1"
			iCorrect = iCorrect + 1
		Else
			sAccuracy = "0"
			iWrong = iWrong + 1
		End If
		
		'Add up RT
		totalRT = totalRT + RTs
		
		'Open file and save data
		Dim filedata As Short
		filedata = OpenAppend(outPutFile_Inference)
		
		'"SubID", "Block", "Trial", "Letter", "Tone", _
		'"Letter Reponse", "Tone Response", "Letter Accuracy", "Tone Accuracy", _
		'"Letter RT", "Tone RT"
		
		PrintToFile(filedata, subID, iBlockNum, iTrialNum, sAssociation(1), sAssociation(2), sAssociation(3), sAssociation(4), sTraining, sOrdCondition, iStim, iPreCue, iReliable, iResponse, Int(RTs), sAccuracy, vbCrLf)
		
		FileClose(filedata)
		bDataNotSaved = False
		
	End Sub
	
	Private Sub ContinueOn()
		
		expImage3.Visible = False
		startExperiment()
		
	End Sub
	
	Private Sub frmInference_KeyDown(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
		Dim KeyCode As Short = eventArgs.KeyCode
		Dim Shift As Short = eventArgs.KeyData \ &H10000
		
		If bDisplayed And bDataNotSaved Then
			If KeyCode = System.Windows.Forms.Keys.Z Then
				bDisplayed = False
				'UPGRADE_WARNING: Couldn't resolve default property of object ReadTimer(). Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
				RTs = ReadTimer(1) - 400
				bKey(1) = True
			ElseIf KeyCode = System.Windows.Forms.Keys.X Then 
				bDisplayed = False
				'UPGRADE_WARNING: Couldn't resolve default property of object ReadTimer(). Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
				RTs = ReadTimer(1) - 400
				bKey(2) = True
			ElseIf KeyCode = System.Windows.Forms.Keys.N Then 
				bDisplayed = False
				'UPGRADE_WARNING: Couldn't resolve default property of object ReadTimer(). Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
				RTs = ReadTimer(1) - 400
				bKey(3) = True
			ElseIf KeyCode = System.Windows.Forms.Keys.M Then 
				bDisplayed = False
				'UPGRADE_WARNING: Couldn't resolve default property of object ReadTimer(). Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
				RTs = ReadTimer(1) - 400
				bKey(4) = True
			End If
		End If
		
	End Sub
	
	Private Sub frmInference_KeyUp(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyUp
		Dim KeyCode As Short = eventArgs.KeyCode
		Dim Shift As Short = eventArgs.KeyData \ &H10000
		If bDataNotSaved Then
			
			If KeyCode = System.Windows.Forms.Keys.Z And bKey(1) Then
				bKey(1) = False
				iResponse = 1
			ElseIf KeyCode = System.Windows.Forms.Keys.X And bKey(2) Then 
				bKey(2) = False
				iResponse = 2
			ElseIf KeyCode = System.Windows.Forms.Keys.N And bKey(3) Then 
				bKey(3) = False
				iResponse = 3
			ElseIf KeyCode = System.Windows.Forms.Keys.M And bKey(4) Then 
				bKey(4) = False
				iResponse = 4
			End If
			If iResponse <> 0 Then
				writeData()
			End If
		End If
		
	End Sub
	
	Private Sub frmInference_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles MyBase.KeyPress
		Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
		
		'Quit if user presses the Escape button
		If KeyAscii = System.Windows.Forms.Keys.Escape Then EndProgram()
		
		eventArgs.KeyChar = Chr(KeyAscii)
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
	End Sub
	
	Private Sub frmInference_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
		picPath = "\images\images\"
		
		sPreCuePic(1) = "A"
		sPreCuePic(2) = "B"
		sPreCuePic(3) = "C"
		sPreCuePic(4) = "D"
		
		sStimPic(1) = "1"
		sStimPic(2) = "2"
		sStimPic(3) = "3"
		sStimPic(4) = "4"
		
		bDisplayed = False
		iResponse = 0
		
		
		For iLoop = 1 To 4
			bKey(iLoop) = False
		Next iLoop
		
	End Sub
	
	'UPGRADE_WARNING: Form event frmInference.Activate has a new behavior. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6BA9B8D2-2A32-4B6E-8D36-44949974A5B4"'
	Private Sub frmInference_Activated(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Activated
		bDisplayed = False
		iResponse = 0
		
		'Display the Cross
		expImage1.Visible = False
		expImage2.Visible = False
		
		showResponse()
		iSIdx = 0
		startExperiment()
	End Sub
	
	'UPGRADE_WARNING: Event frmInference.Resize may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub frmInference_Resize(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Resize
		'Me.
		'txtDebug.Text = sDir
		'& "\images\images\Icon1.bmp"
		'cuePic1.Picture = sDir & "\images\images\Icon1.bmp"
		
		cuePic1.Height = VB6.TwipsToPixelsY(0.1 * VB6.PixelsToTwipsX(Me.Width))
		cuePic1.Width = VB6.TwipsToPixelsX(0.1 * VB6.PixelsToTwipsX(Me.Width))
		cuePic1.Left = VB6.TwipsToPixelsX(0 * (VB6.PixelsToTwipsX(Me.Width) / 4) + ((VB6.PixelsToTwipsX(Me.Width) / 4) - VB6.PixelsToTwipsX(cuePic1.Width)) / 2)
		cuePic1.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(Me.Height) - VB6.PixelsToTwipsY(cuePic1.Height) * 1.5)
		cuePic1.Image = System.Drawing.Image.FromFile(My.Application.Info.DirectoryPath & picPath & "Icon1.bmp")
		
		cuePic2.Height = VB6.TwipsToPixelsY(0.1 * VB6.PixelsToTwipsX(Me.Width))
		cuePic2.Width = VB6.TwipsToPixelsX(0.1 * VB6.PixelsToTwipsX(Me.Width))
		cuePic2.Left = VB6.TwipsToPixelsX(1 * (VB6.PixelsToTwipsX(Me.Width) / 4) + ((VB6.PixelsToTwipsX(Me.Width) / 4) - VB6.PixelsToTwipsX(cuePic2.Width)) / 2)
		cuePic2.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(Me.Height) - VB6.PixelsToTwipsY(cuePic2.Height) * 1.5)
		cuePic2.Image = System.Drawing.Image.FromFile(My.Application.Info.DirectoryPath & picPath & "Icon2.bmp")
		
		cuePic3.Height = VB6.TwipsToPixelsY(0.1 * VB6.PixelsToTwipsX(Me.Width))
		cuePic3.Width = VB6.TwipsToPixelsX(0.1 * VB6.PixelsToTwipsX(Me.Width))
		cuePic3.Left = VB6.TwipsToPixelsX(2 * (VB6.PixelsToTwipsX(Me.Width) / 4) + ((VB6.PixelsToTwipsX(Me.Width) / 4) - VB6.PixelsToTwipsX(cuePic3.Width)) / 2)
		cuePic3.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(Me.Height) - VB6.PixelsToTwipsY(cuePic3.Height) * 1.5)
		cuePic3.Image = System.Drawing.Image.FromFile(My.Application.Info.DirectoryPath & picPath & "Icon3.bmp")
		
		cuePic4.Height = VB6.TwipsToPixelsY(0.1 * VB6.PixelsToTwipsX(Me.Width))
		cuePic4.Width = VB6.TwipsToPixelsX(0.1 * VB6.PixelsToTwipsX(Me.Width))
		cuePic4.Left = VB6.TwipsToPixelsX(3 * (VB6.PixelsToTwipsX(Me.Width) / 4) + ((VB6.PixelsToTwipsX(Me.Width) / 4) - VB6.PixelsToTwipsX(cuePic4.Width)) / 2)
		cuePic4.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(Me.Height) - VB6.PixelsToTwipsY(cuePic4.Height) * 1.5)
		cuePic4.Image = System.Drawing.Image.FromFile(My.Application.Info.DirectoryPath & picPath & "Icon4.bmp")
		
		cueLabel1.Left = VB6.TwipsToPixelsX(0 * (VB6.PixelsToTwipsX(Me.Width) / 4) + ((VB6.PixelsToTwipsX(Me.Width) / 4) - VB6.PixelsToTwipsX(cueLabel1.Width)) / 2)
		cueLabel1.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(Me.Height) - VB6.PixelsToTwipsY(cuePic1.Height) * 0.5)
		
		cueLabel2.Left = VB6.TwipsToPixelsX(1 * (VB6.PixelsToTwipsX(Me.Width) / 4) + ((VB6.PixelsToTwipsX(Me.Width) / 4) - VB6.PixelsToTwipsX(cueLabel2.Width)) / 2)
		cueLabel2.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(Me.Height) - VB6.PixelsToTwipsY(cuePic2.Height) * 0.5)
		
		cueLabel3.Left = VB6.TwipsToPixelsX(2 * (VB6.PixelsToTwipsX(Me.Width) / 4) + ((VB6.PixelsToTwipsX(Me.Width) / 4) - VB6.PixelsToTwipsX(cueLabel3.Width)) / 2)
		cueLabel3.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(Me.Height) - VB6.PixelsToTwipsY(cuePic3.Height) * 0.5)
		
		cueLabel4.Left = VB6.TwipsToPixelsX(3 * (VB6.PixelsToTwipsX(Me.Width) / 4) + ((VB6.PixelsToTwipsX(Me.Width) / 4) - VB6.PixelsToTwipsX(cueLabel4.Width)) / 2)
		cueLabel4.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(Me.Height) - VB6.PixelsToTwipsY(cuePic4.Height) * 0.5)
		
		
		expImage1.Height = VB6.TwipsToPixelsY(0.25 * VB6.PixelsToTwipsX(Me.Width))
		expImage1.Width = VB6.TwipsToPixelsX(0.25 * VB6.PixelsToTwipsX(Me.Width))
		expImage1.Left = VB6.TwipsToPixelsX((VB6.PixelsToTwipsX(Me.Width) - VB6.PixelsToTwipsX(expImage1.Width)) / 2)
		expImage1.Top = VB6.TwipsToPixelsY((VB6.PixelsToTwipsY(Me.Height) - VB6.PixelsToTwipsY(expImage1.Height)) / 2)
		
		expImage2.Height = VB6.TwipsToPixelsY(0.25 * VB6.PixelsToTwipsX(Me.Width))
		expImage2.Width = VB6.TwipsToPixelsX(0.25 * VB6.PixelsToTwipsX(Me.Width))
		expImage2.Left = VB6.TwipsToPixelsX((VB6.PixelsToTwipsX(Me.Width) - VB6.PixelsToTwipsX(expImage2.Width)) / 2)
		expImage2.Top = VB6.TwipsToPixelsY((VB6.PixelsToTwipsY(Me.Height) - VB6.PixelsToTwipsY(expImage2.Height)) / 2)
		
		expImage3.Height = VB6.TwipsToPixelsY(0.25 * VB6.PixelsToTwipsX(Me.Width))
		expImage3.Width = VB6.TwipsToPixelsX(0.25 * VB6.PixelsToTwipsX(Me.Width))
		expImage3.Left = VB6.TwipsToPixelsX((VB6.PixelsToTwipsX(Me.Width) - VB6.PixelsToTwipsX(expImage3.Width)) / 2)
		expImage3.Top = VB6.TwipsToPixelsY((VB6.PixelsToTwipsY(Me.Height) - VB6.PixelsToTwipsY(expImage3.Height)) / 2)
		
		fixImage.Height = VB6.TwipsToPixelsY(0.25 * VB6.PixelsToTwipsX(Me.Width))
		fixImage.Width = VB6.TwipsToPixelsX(0.25 * VB6.PixelsToTwipsX(Me.Width))
		fixImage.Left = VB6.TwipsToPixelsX((VB6.PixelsToTwipsX(Me.Width) - VB6.PixelsToTwipsX(fixImage.Width)) / 2)
		fixImage.Top = VB6.TwipsToPixelsY((VB6.PixelsToTwipsY(Me.Height) - VB6.PixelsToTwipsY(fixImage.Height)) / 2)
		fixImage.Image = System.Drawing.Image.FromFile(My.Application.Info.DirectoryPath & picPath & "fixation.bmp")
		
	End Sub
	
	Public Sub showResponse()
		
		cuePic1.Visible = True
		cuePic2.Visible = True
		cuePic3.Visible = True
		cuePic4.Visible = True
		cueLabel1.Visible = True
		cueLabel2.Visible = True
		cueLabel3.Visible = True
		cueLabel4.Visible = True
		
	End Sub
End Class