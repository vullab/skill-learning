Option Strict Off
Option Explicit On
Imports VB = Microsoft.VisualBasic
Module Procedures
	
	'Declaration of APIs used in program
	Public Declare Function QueryPerformanceCounter Lib "kernel32" (ByRef lpPerformanceCount As Decimal) As Integer
	Public Declare Function QueryPerformanceFrequency Lib "kernel32" (ByRef lpFrequency As Decimal) As Integer
	Public Declare Function SetCursorPos Lib "user32" (ByVal x As Integer, ByVal y As Integer) As Integer
	Public Declare Function PlaySound Lib "winmm.dll" (ByVal lpszname As String, ByVal hModule As Integer, ByVal dwFlags As Integer) As Integer
	'Public InstructionSet As Integer
	
	'Used for timing
	Public SecFreq(10) As Decimal
	Public start(10) As Decimal
	Public BlockType As String
	
	'Starts the timer
	Public Sub StartTimer(ByRef index As Short)
		QueryPerformanceFrequency(SecFreq(index))
		QueryPerformanceCounter(start(index))
	End Sub
	
	'Reads the current time since the timer was started
	Public Function ReadTimer(ByRef index As Short) As Object
		Dim currentTime As Decimal
		If SecFreq(index) = 0 Then Exit Function
		QueryPerformanceCounter(currentTime)
		'UPGRADE_WARNING: Couldn't resolve default property of object ReadTimer. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		ReadTimer = ((currentTime - start(index)) / SecFreq(index)) * 1000
	End Function
	
	'This is where the program begins!
	'UPGRADE_WARNING: Application will terminate when Sub Main() finishes. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="E08DDC71-66BA-424F-A612-80AF11498FF8"'
	Public Sub Main()
		
		'Set the initial directory
		If Right(My.Application.Info.DirectoryPath, 1) <> "\" Then
			sDir = My.Application.Info.DirectoryPath & "\"
		Else
			sDir = My.Application.Info.DirectoryPath
		End If
		
		If bDebug = True Then
			nTrainingBlocks = 2
			nTrainingBlockTrials = 10
			nInferenceBlocks = 1
			nInferenceBlockTrials = 12
			nSkillBlocks = 2
			nSkillBlockTrials = 10
			nSecsWait = 30
		Else
			nTrainingBlocks = 16
			nTrainingBlockTrials = 20
			nInferenceBlocks = 0
			nInferenceBlockTrials = 12
            nSkillBlocks = 5
            nSkillBlockTrials = 20
			nSecsWait = 360
		End If
		
		
		'Initialize Variables
		iCondition = 1
		iBlockNum = 0
		iTrialNum = 0
		iWrong = 0
		iCorrect = 0
		
		'Randomizes the random number generator
		Randomize(VB.Timer())
		
		'Show the Greeting form
		frmGreet.Show()
		
	End Sub
	
	Public Sub EndProgram()
		
		On Error Resume Next
		Dim fForm As System.Windows.Forms.Form
		
		If MsgBox("Do you really want to quit?", MsgBoxStyle.YesNo + MsgBoxStyle.Question) = MsgBoxResult.Yes Then
			'End the program!
			End
		End If
		
	End Sub
	
	
	Public Function FindIDinCurrentSubjects(ByRef ID As String) As Boolean
		
		On Error GoTo ErrorHandler
		
		'Used to input a line from the file
		Static sLine As String
		
		'Get next free file
		iFileNum = FreeFile
		
		'Check if the currect subjects file exists
		'If it does not exist then create it
		'UPGRADE_WARNING: Dir has a new behavior. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="9B7D5ADD-D8FE-4819-A36C-6DEDAF088CC7"'
		If Dir(sDir & "CurrentSubjects.txt") = "" Then
			FileOpen(iFileNum, sDir & "CurrentSubjects.txt", OpenMode.Output)
			FileClose(iFileNum)
		End If
		
		'Open the file that contains all subject names/id's/initials
		FileOpen(iFileNum, sDir & "CurrentSubjects.txt", OpenMode.Input)
		
		'Keep looping through lines until we reach the end of the file
		While Not (EOF(iFileNum))
			
			'Get next line from file and stick into 'sLine'
			Input(iFileNum, sLine)
			
			'If IDs match then it already exists in the file
			If Val(Trim(sLine)) = Val(ID) Then
				FindIDinCurrentSubjects = True
				FileClose(iFileNum)
				Exit Function
			End If
			
		End While
		
		FileClose(iFileNum)
		'FindIDinCurrentSubjects = False
		Exit Function
		
ErrorHandler: 
		If Err.Number = 53 Then
			FindIDinCurrentSubjects = True
		ElseIf Err.Number <> 0 Then 
			Err.Raise(Err.Number)
		End If
		
	End Function
	
	'Basic Pause Procedure
	'If FreezeEverything is passed in as true, then the program will
	'freeze while the loop runs
	Public Sub Pause(ByRef Secs As Single, Optional ByRef FreezeEverything As Object = False)
		
		StartTimer((8))
		'UPGRADE_WARNING: Couldn't resolve default property of object ReadTimer(8). Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		While ReadTimer(8) < Secs * 1000
			If Not FreezeEverything Then System.Windows.Forms.Application.DoEvents()
		End While
		
	End Sub
	Public Sub PauseMil(ByRef Mil As Single, Optional ByRef FreezeEverything As Object = False)
		
		StartTimer((9))
		'UPGRADE_WARNING: Couldn't resolve default property of object ReadTimer(9). Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		While ReadTimer(9) < Mil
			If Not FreezeEverything Then System.Windows.Forms.Application.DoEvents()
		End While
		
	End Sub
	
	'Print header file, and This can use for comments for the output text file
	'The stream of characters which procedured by this procedure will be ignore
	'when use ReadLine( ) routine
	'UPGRADE_WARNING: ParamArray data was changed from ByRef to ByVal. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="93C6A0DC-8C99-429A-8696-35FC4DCEFCCC"'
	Public Sub PrintHeaders(ByRef file As String, ParamArray ByVal data() As Object)
		Dim filenum As Short
		Dim i As Object
		filenum = OpenAppend(file)
		Print(filenum, "#")
		For	Each i In data
			'UPGRADE_WARNING: Couldn't resolve default property of object i. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			Print(filenum, i & Chr(9))
		Next i
		Print(filenum, NextLine)
		FileClose(filenum)
	End Sub
	
	'Create an Director with the specified Path as String
	Public Sub CreateDir(ByRef path As String)
		On Error GoTo label
		MkDir((path))
		Exit Sub
label: 
		If Err.Number = 75 Then
			Exit Sub
		ElseIf Err.Number <> 0 Then 
			Err.Raise(Err.Number)
		End If
	End Sub
	'Open a file for append.
	'the new inputs will append to the end of the file
	Public Function OpenAppend(ByRef filePath As String) As Short
		Dim filenum As Short
		filenum = FreeFile
		FileOpen(filenum, filePath, OpenMode.Append)
		OpenAppend = filenum
		Exit Function
	End Function
	
	'Print the array of string to file will a tab character separator.
	'This Tab key helps excel to distinguish line
	'UPGRADE_WARNING: ParamArray data was changed from ByRef to ByVal. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="93C6A0DC-8C99-429A-8696-35FC4DCEFCCC"'
	Public Sub PrintToFile(ByRef filenum As Short, ParamArray ByVal data() As Object)
		Dim i As Object
        'Dim temp As String
		For	Each i In data
			'UPGRADE_WARNING: Couldn't resolve default property of object NextLine. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			'UPGRADE_WARNING: Couldn't resolve default property of object i. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			If i = NextLine Then
				Print(filenum, i)
				'myDebug.RichTextBox1.Text = myDebug.RichTextBox1.Text & i
			Else
				'UPGRADE_WARNING: Couldn't resolve default property of object i. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
				Print(filenum, i & Chr(9))
				'myDebug.RichTextBox1.Text = myDebug.RichTextBox1.Text & i & Chr(9)
			End If
		Next i
		'myDebug.OpenFile getfilename(filenum)
	End Sub
	'Create newLine for output file ( carried return + newline character )
	Public Function NextLine() As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object NextLine. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		NextLine = Chr(13) & Chr(10)
	End Function
	'This is very important procedure in the experiment.
	'Sometime we want to move the cursor to corner so it won't bother the subject
	'one can call this procedure as many times as they deem necessary
	Public Sub MoveMouseToCorner()
		SetCursorPos(VB6.PixelsToTwipsX(System.Windows.Forms.Screen.PrimaryScreen.Bounds.Width), VB6.PixelsToTwipsY(System.Windows.Forms.Screen.PrimaryScreen.Bounds.Height))
	End Sub
	
	Public Sub MoveMouseToCenter()
		SetCursorPos(VB6.PixelsToTwipsX(System.Windows.Forms.Screen.PrimaryScreen.Bounds.Width) / 2 / 15, VB6.PixelsToTwipsY(System.Windows.Forms.Screen.PrimaryScreen.Bounds.Height) / 2 / 15)
	End Sub
	
	
	Public Function ReadLines(ByRef file As Short) As Object
		Dim z, x, y As Short
		Dim line As String
		Dim data() As Object
		Dim ch As String
        'Dim reply As Short
		
		' ==================added on 3/22/2005 by David words are speartted by tabs==================
		If EOF(file) Then
			Exit Function
		End If
		
		line = LineInput(file)
		line = Trim(line)
		If Left(line, 1) = "#" Or line = " " Or line = "" Then
			'UPGRADE_WARNING: Couldn't resolve default property of object ReadLines(). Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			ReadLines = ReadLines(file)
			Exit Function
		End If
		
		ReDim data(Len(line) + 1)
		z = 1
		y = 1
		x = 1
		
		'MsgBox (Mid(line, 1, 3))
		
		While x <= Len(line) + 1
			ch = Mid(line, x, 1)
			If ch = "" Then 'Then end of the line
				'UPGRADE_WARNING: Couldn't resolve default property of object data(y). Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
				data(y) = Trim(Mid(line, z, x - z))
			ElseIf ch = Chr(9) Then  '9 is equal to the tab key
				'UPGRADE_WARNING: Couldn't resolve default property of object data(y). Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
				data(y) = Trim(Mid(line, z, x - z)) 'Read whole word into array
				y = y + 1
				z = x + 1
			End If
			x = x + 1
		End While
		
		'UPGRADE_WARNING: Couldn't resolve default property of object ReadLines. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		ReadLines = VB6.CopyArray(data)
	End Function
End Module