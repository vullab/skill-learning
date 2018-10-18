Option Strict Off
Option Explicit On
Imports VB = Microsoft.VisualBasic
Friend Class frmGreet
	Inherits System.Windows.Forms.Form
	
	Private Sub cmdStart_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdStart.Click
		
		'Check to see if the subject already exists in the CurrectSubjects file
		If txtSubID.Text <> "999" Then
			If FindIDinCurrentSubjects((txtSubID.Text)) Then
				MsgBox("Subject ID " & txtSubID.Text & " already exists!" & vbCrLf & "Please enter new ID")
				txtSubID.Focus()
				Exit Sub
			End If
		End If
		
		'Information is all ok, so let's begin!
		iFileNum = FreeFile
		
		If txtSubID.Text <> "999" Then
			'Add this user to CurrentSubjects.txt
			FileOpen(iFileNum, sDir & "CurrentSubjects.txt", OpenMode.Append)
			PrintLine(iFileNum, txtSubID.Text, txtSubIn.Text, iCondition, NextLine)
			FileClose(iFileNum)
		End If
		
		
		'Create the directory if it doesn't already exist
		CreateDir((sDir & "Res_Data"))
		
		Dim temp As Short
		temp = Int(Rnd() * 2) + 1
		If (temp = 1) Then
			sTraining = -600
		ElseIf (temp = 2) Then 
			sTraining = 600
		End If
		
		sOrdCondition = 1
		If (sOrdCondition = 1) Then
			For iLoop = 1 To nTrainingBlocks
				sOrder(iLoop) = "T"
			Next iLoop
			For iLoop = nTrainingBlocks + 1 To nTrainingBlocks + nSkillBlocks
				sOrder(iLoop) = "S"
			Next iLoop
			sOrder(nTrainingBlocks + nSkillBlocks + 1) = "E"
		ElseIf (sOrdCondition = 2) Then 
			For iLoop = 1 To nTrainingBlocks
				sOrder(iLoop) = "T"
			Next iLoop
			For iLoop = nTrainingBlocks + 1 To nTrainingBlocks + nSkillBlocks
				sOrder(iLoop) = "S"
			Next iLoop
			For iLoop = nTrainingBlocks + nSkillBlocks + 1 To nTrainingBlocks + nInferenceBlocks + nSkillBlocks
				sOrder(iLoop) = "I"
			Next iLoop
			sOrder(nTrainingBlocks + nInferenceBlocks + nSkillBlocks + 1) = "E"
		ElseIf (sOrdCondition = 3) Then 
			For iLoop = 1 To nTrainingBlocks
				sOrder(iLoop) = "T"
			Next iLoop
			sOrder(nTrainingBlocks + 1) = "P"
			For iLoop = nTrainingBlocks + 2 To nTrainingBlocks + nInferenceBlocks + 1
				sOrder(iLoop) = "I"
			Next iLoop
			For iLoop = nTrainingBlocks + nInferenceBlocks + 2 To nTrainingBlocks + nInferenceBlocks + nSkillBlocks + 1
				sOrder(iLoop) = "S"
			Next iLoop
			sOrder(nTrainingBlocks + nInferenceBlocks + nSkillBlocks + 2) = "E"
		End If
		
		RandomPermutation((4))
		
		'Create the RFile and begin experiment!
		SetupRFile() 'Create RawData Files
        MsgBox("We got here!")
		'Move on to the Instructions
		frmInstructions.Visible = True
		
		MoveMouseToCorner()
		Me.Close()
	End Sub
	
	Private Sub frmGreet_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles MyBase.KeyPress
		Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
		
		'Quit if user presses the Escape button
		If KeyAscii = System.Windows.Forms.Keys.Escape Then EndProgram()
		
		eventArgs.KeyChar = Chr(KeyAscii)
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
	End Sub
	
	'UPGRADE_WARNING: Event frmGreet.Resize may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub frmGreet_Resize(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Resize
		
		'Center the picturebox that contains all controls
		picBack.Left = VB6.TwipsToPixelsX((VB6.PixelsToTwipsX(Me.Width) - VB6.PixelsToTwipsX(picBack.Width)) / 2)
		picBack.Top = VB6.TwipsToPixelsY((VB6.PixelsToTwipsY(Me.Height) - VB6.PixelsToTwipsY(picBack.Height)) / 2)
		
	End Sub
	
	
	'UPGRADE_WARNING: Event optOC.CheckedChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub optOC_CheckedChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles optOC.CheckedChanged
		If eventSender.Checked Then
			Dim index As Short = optOC.GetIndex(eventSender)
			iCondition = index
		End If
	End Sub
	
	
	'UPGRADE_WARNING: Event txtSubID.TextChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub txtSubID_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtSubID.TextChanged
		
		'Make Start enabled if all info is entered
		cmdStart.Enabled = txtSubID.Text <> "" And txtSubIn.Text <> ""
		
		'Keep track of ID
		subID = Val(txtSubID.Text)
		
		'Autotab
		If Len(txtSubID.Text) = 3 Then System.Windows.Forms.SendKeys.Send("{TAB}")
		
		'Used for TESTING purposes only
		If txtSubID.Text = "999" Then
			txtSubIn.Text = "ABC"
			cmdStart.Focus()
		End If
		
	End Sub
	
	Private Sub txtSubID_Validating(ByVal eventSender As System.Object, ByVal eventArgs As System.ComponentModel.CancelEventArgs) Handles txtSubID.Validating
		Dim Cancel As Boolean = eventArgs.Cancel
		
		If txtSubID.Text <> "999" Then
			If FindIDinCurrentSubjects((txtSubID.Text)) Then
				txtSubID.Text = CStr(putInNextID)
			End If
		End If
		
		eventArgs.Cancel = Cancel
	End Sub
	
	
	Private Sub txtSubID_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtSubID.KeyPress
		Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
		
		If KeyAscii = System.Windows.Forms.Keys.Back Then GoTo EventExitSub
		
		If KeyAscii = 13 Then System.Windows.Forms.SendKeys.Send("{tab}") : GoTo EventExitSub
		
		'Only allow numbers to be entered
		If KeyAscii < System.Windows.Forms.Keys.D0 Or KeyAscii > System.Windows.Forms.Keys.D9 Then
			KeyAscii = 0
			lblNumbersOnly.Visible = True
		Else
			lblNumbersOnly.Visible = False
		End If
		
		
EventExitSub: 
		eventArgs.KeyChar = Chr(KeyAscii)
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
	End Sub
	
	'UPGRADE_WARNING: Event txtSubIn.TextChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub txtSubIn_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles txtSubIn.TextChanged
		
		cmdStart.Enabled = txtSubID.Text <> "" And txtSubIn.Text <> ""
		
		'Autotab
		If Len(txtSubIn.Text) = 3 Then System.Windows.Forms.SendKeys.Send("{TAB}")
		
	End Sub
	
	Private Sub txtSubIn_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtSubIn.KeyPress
		Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
		
		If KeyAscii = System.Windows.Forms.Keys.Back Then GoTo EventExitSub
		
		If KeyAscii = 13 Then System.Windows.Forms.SendKeys.Send("{tab}") : GoTo EventExitSub
		
		'Only allow letters to be entered
		If Asc(UCase(Chr(KeyAscii))) < System.Windows.Forms.Keys.A Or Asc(UCase(Chr(KeyAscii))) > System.Windows.Forms.Keys.Z Then
			KeyAscii = 0
			lblLettersOnly.Visible = True
		Else
			'Make it an uppercase letter
			KeyAscii = Asc(UCase(Chr(KeyAscii)))
			lblLettersOnly.Visible = False
		End If
		
EventExitSub: 
		eventArgs.KeyChar = Chr(KeyAscii)
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
	End Sub
	
	Private Sub SetupRFile()
		
		'Get names for output files
		outPutFile_Training = sDir & "Res_Data\" & subID & "_Training.xls"
		outPutFile_Inference = sDir & "Res_Data\" & subID & "_Inference.xls"
		outPutFile_Skill = sDir & "Res_Data\" & subID & "_Skill.xls"
		
		'Sets up the heading for the R-File
		PrintHeaders(outPutFile_Training, "SkIf 1  -  Started: " & Now)
		PrintHeaders(outPutFile_Training, "SubID", "Block", "Trial", "Association 1", "Association 2", "Association 3", "Association 4", "Training Condition", "Order Condition", "Symbol", "Pre Cue", "Reliability", "Response", "RT", "Accuracy")
		
		PrintHeaders(outPutFile_Inference, "SkIf 1  -  Started: " & Now)
		PrintHeaders(outPutFile_Inference, "SubID", "Block", "Trial", "Association 1", "Association 2", "Association 3", "Association 4", "Training Condition", "Order Condition", "Symbol", "Pre Cue", "Reliability", "Response", "RT", "Accuracy")
		
		PrintHeaders(outPutFile_Skill, "SkIf 1  -  Started: " & Now)
		PrintHeaders(outPutFile_Skill, "SubID", "Block", "Trial", "Association 1", "Association 2", "Association 3", "Association 4", "Training Condition", "Order Condition", "Symbol", "Pre Cue", "Reliability", "Response", "RT", "Accuracy")
		
	End Sub
	
	Private Function putInNextID() As Integer
		
		'This procedure finds the next available number if the
		'subject ID is already taken that was entered
		
		'UPGRADE_NOTE: str was upgraded to str_Renamed. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
		Dim str_Renamed() As Object
		Dim newID As Short
        'Dim currentID As Short
		newID = subID + 1
		Dim filenum As Short
		filenum = FreeFile
		FileOpen(filenum, sDir & "CurrentSubjects.txt", OpenMode.Input)
		While (Not EOF(filenum))
			'UPGRADE_WARNING: Couldn't resolve default property of object ReadLine(). Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			str_Renamed = ReadLine(filenum, 2)
			'UPGRADE_WARNING: Couldn't resolve default property of object str_Renamed(1). Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            If (str_Renamed(0) = newID) Then
                newID = newID + 1
            End If
		End While
		FileClose(filenum)
		subID = newID
		putInNextID = newID
	End Function
	
	Public Function ReadLine(ByRef file As Short, Optional ByRef lineLength As Short = 0) As Object
		Dim z, r, y As Short
		Dim line As String
		Dim data() As Object
		Dim ch As String
        'Dim reply As Short
		
		' =======================added on 8/24======================
		If EOF(file) Then
			Exit Function
		End If
		
		line = LineInput(file)
		line = Trim(line)
		If VB.Left(line, 1) = "#" Or line = " " Then
			'UPGRADE_WARNING: Couldn't resolve default property of object ReadLine(). Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			ReadLine = ReadLine(file, lineLength)
			Exit Function
		End If
		ReDim data(Len(line) + 1)
		z = 1
		y = 1
		r = 1
		While r <= Len(line) + 1
			ch = Mid(line, r, 1)
			If ch = "" Then 'Then end of the line
				'UPGRADE_WARNING: Couldn't resolve default property of object data(y). Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
				data(y) = Trim(Mid(line, z, r - z))
			ElseIf ch = " " Or ch = "   " Or ch = Chr(9) Then  '9 is equal to the tab key
				While ch = " " Or ch = "    " Or ch = Chr(9) 'Remove blanke spaces
					r = r + 1
					ch = Mid(line, r, 1)
				End While
				'UPGRADE_WARNING: Couldn't resolve default property of object data(y). Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
				data(y) = Trim(Mid(line, z, r - z)) 'Read whole word into array
				y = y + 1
				z = r
			End If
			r = r + 1
		End While
		lineLength = y
		'UPGRADE_WARNING: Couldn't resolve default property of object ReadLine. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		ReadLine = VB6.CopyArray(data)
	End Function
	
	Public Sub RandomPermutation(ByRef Number As Short)
		Dim temporary As Short
		
		For iLoop = 1 To Number
			sAssociation(iLoop) = 0
		Next iLoop
		
		For iLoop = 1 To Number
			temporary = Int(Rnd() * Number) + 1
			While sAssociation(temporary) > 0
				temporary = Int(Rnd() * Number) + 1
			End While
			sAssociation(temporary) = iLoop
		Next iLoop
	End Sub
End Class