Attribute VB_Name = "Procedures"
Option Explicit

'Declaration of APIs used in program
Public Declare Function QueryPerformanceCounter Lib "kernel32" (lpPerformanceCount As Currency) As Long
Public Declare Function QueryPerformanceFrequency Lib "kernel32" (lpFrequency As Currency) As Long
Public Declare Function SetCursorPos Lib "user32" (ByVal x As Long, ByVal y As Long) As Long
Public Declare Function PlaySound Lib "winmm.dll" (ByVal lpszname As String, ByVal hModule As Long, ByVal dwFlags As Long) As Long
'Public InstructionSet As Integer

'Used for timing
Public SecFreq(10) As Currency
Public start(10) As Currency
Public BlockType As String

'Starts the timer
Public Sub StartTimer(index As Integer)
    QueryPerformanceFrequency SecFreq(index)
    QueryPerformanceCounter start(index)
End Sub

'Reads the current time since the timer was started
Public Function ReadTimer(index As Integer)
Dim currentTime As Currency
    If SecFreq(index) = 0 Then Exit Function
    QueryPerformanceCounter currentTime
    ReadTimer = ((currentTime - start(index)) / SecFreq(index)) * 1000
End Function

'This is where the program begins!
Sub Main()

'Set the initial directory
If Right$(App.path, 1) <> "\" Then
    sDir = App.path & "\"
Else
    sDir = App.path
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
    nInferenceBlocks = 1
    nInferenceBlockTrials = 12
    nSkillBlocks = 4
    nSkillBlockTrials = 30
    nSecsWait = 360
End If


'Initialize Variables
iCondition = 1
iBlockNum = 0
iTrialNum = 0
iWrong = 0
iCorrect = 0

'Randomizes the random number generator
Randomize Timer

'Show the Greeting form
frmGreet.Show

End Sub

Public Sub EndProgram()

On Error Resume Next
Dim fForm As Form

If MsgBox("Do you really want to quit?", vbYesNo + vbQuestion) = vbYes Then
    'End the program!
    End
End If

End Sub


Public Function FindIDinCurrentSubjects(ID As String) As Boolean

On Error GoTo ErrorHandler

'Used to input a line from the file
Static sLine As String

'Get next free file
iFileNum = FreeFile

'Check if the currect subjects file exists
'If it does not exist then create it
If Dir(sDir & "CurrentSubjects.txt") = "" Then
    Open sDir & "CurrentSubjects.txt" For Output As iFileNum
    Close iFileNum
End If

'Open the file that contains all subject names/id's/initials
Open sDir & "CurrentSubjects.txt" For Input As iFileNum

'Keep looping through lines until we reach the end of the file
While Not (EOF(iFileNum))

    'Get next line from file and stick into 'sLine'
    Input #iFileNum, sLine
    
    'If IDs match then it already exists in the file
    If Val(Trim(sLine)) = Val(ID) Then
        FindIDinCurrentSubjects = True
        Close #iFileNum
        Exit Function
    End If

Wend

Close #iFileNum
'FindIDinCurrentSubjects = False
Exit Function

ErrorHandler:
If Err.Number = 53 Then
    FindIDinCurrentSubjects = True
ElseIf Err.Number <> 0 Then
    Err.Raise Err.Number
End If

End Function

'Basic Pause Procedure
'If FreezeEverything is passed in as true, then the program will
'freeze while the loop runs
Public Sub Pause(Secs As Single, Optional FreezeEverything = False)

StartTimer (8)
While ReadTimer(8) < Secs * 1000
If Not FreezeEverything Then DoEvents
Wend

End Sub
Public Sub PauseMil(Mil As Single, Optional FreezeEverything = False)

StartTimer (9)
While ReadTimer(9) < Mil
If Not FreezeEverything Then DoEvents
Wend

End Sub

'Print header file, and This can use for comments for the output text file
'The stream of characters which procedured by this procedure will be ignore
'when use ReadLine( ) routine
Public Sub PrintHeaders(file As String, ParamArray data() As Variant)
    Dim filenum As Integer, i
    filenum = OpenAppend(file)
    Print #filenum, "#";
    For Each i In data
        Print #filenum, i & Chr(9);
    Next i
    Print #filenum, NextLine;
    Close #filenum
End Sub

'Create an Director with the specified Path as String
Public Sub CreateDir(path As String)
    On Error GoTo label
    MkDir (path)
    Exit Sub
label:
    If Err.Number = 75 Then
        Exit Sub
    ElseIf Err.Number <> 0 Then
        Err.Raise Err.Number
    End If
End Sub
'Open a file for append.
'the new inputs will append to the end of the file
Public Function OpenAppend(filePath As String) As Integer
    Dim filenum As Integer
    filenum = FreeFile
    Open filePath For Append As filenum
    OpenAppend = filenum
    Exit Function
End Function

'Print the array of string to file will a tab character separator.
'This Tab key helps excel to distinguish line
Public Sub PrintToFile(filenum As Integer, ParamArray data() As Variant)
    Dim i As Variant, temp As String
    For Each i In data
        If i = NextLine Then
            Print #filenum, i;
            'myDebug.RichTextBox1.Text = myDebug.RichTextBox1.Text & i
        Else
            Print #filenum, i & Chr(9);
            'myDebug.RichTextBox1.Text = myDebug.RichTextBox1.Text & i & Chr(9)
        End If
    Next i
    'myDebug.OpenFile getfilename(filenum)
End Sub
'Create newLine for output file ( carried return + newline character )
Public Function NextLine()
    NextLine = Chr$(13) + Chr$(10)
End Function
'This is very important procedure in the experiment.
'Sometime we want to move the cursor to corner so it won't bother the subject
'one can call this procedure as many times as they deem necessary
Public Sub MoveMouseToCorner()
    SetCursorPos Screen.Width, Screen.Height
End Sub

Public Sub MoveMouseToCenter()
    SetCursorPos Screen.Width / 2 / 15, Screen.Height / 2 / 15
End Sub


Public Function ReadLines(file As Integer) As Variant
    Dim x As Integer, line As String, z As Integer, y As Integer
    Dim data() As Variant, ch As String
    Dim reply As Integer
    
' ==================added on 3/22/2005 by David words are speartted by tabs==================
    If EOF(file) Then
        Exit Function
    End If
    
    Line Input #file, line
    line = Trim(line)
    If Left(line, 1) = "#" Or line = " " Or line = "" Then
        ReadLines = ReadLines(file)
        Exit Function
    End If
    
    ReDim data(Len(line) + 1)
    z = 1
    y = 1
    x = 1
    
    'MsgBox (Mid(line, 1, 3))
    
    While x <= Len(line) + 1
        ch = Mid$(line, x, 1)
        If ch = "" Then 'Then end of the line
            data(y) = Trim(Mid(line, z, x - z))
        ElseIf ch = Chr(9) Then '9 is equal to the tab key
            data(y) = Trim(Mid(line, z, x - z)) 'Read whole word into array
            y = y + 1
            z = x + 1
        End If
        x = x + 1
    Wend
    
    ReadLines = data
End Function


