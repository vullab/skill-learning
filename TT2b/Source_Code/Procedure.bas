Attribute VB_Name = "Procedure"
Option Explicit

'Declaration of APIs used in program
Public Declare Function QueryPerformanceCounter Lib "kernel32" (lpPerformanceCount As Currency) As Long
Public Declare Function QueryPerformanceFrequency Lib "kernel32" (lpFrequency As Currency) As Long
Public Declare Function SetCursorPos Lib "user32" (ByVal x As Long, ByVal Y As Long) As Long
Public Declare Function PlaySound Lib "winmm.dll" (ByVal lpszname As String, ByVal hModule As Long, ByVal dwFlags As Long) As Long
'Public InstructionSet As Integer

'Used for timing
Public SecFreq(10) As Currency
Public start(10) As Currency
Public BlockType As String

'Starts the timer
Public Sub StartTimer(Index As Integer)
    QueryPerformanceFrequency SecFreq(Index)
    QueryPerformanceCounter start(Index)
End Sub

'Reads the current time since the timer was started
Public Function ReadTimer(Index As Integer)
Dim currentTime As Currency
    If SecFreq(Index) = 0 Then Exit Function
    QueryPerformanceCounter currentTime
    ReadTimer = ((currentTime - start(Index)) / SecFreq(Index)) * 1000
End Function

'This is where the program begins!
Sub Main()

'Set the initial directory
If Right$(App.path, 1) <> "\" Then
    sDir = App.path & "\"
Else
    sDir = App.path
End If

'Initialize Variables
iCondition = 1
iTrialNum = 0
BLOCK_SIZE = 1
iBlockNum = 0

'Randomizes the random number generator
Randomize Timer

''Load up the colors that will be used
ReDim lColors(1 To 6)

For iLoop = 1 To UBound(lColors)
    lColors(iLoop) = RGB((30 + 10 * iLoop), (30 + 10 * iLoop), (30 + 10 * iLoop))
Next iLoop

'Load up response keys maps
ReDim sResponse(1 To 6)
sResponse(1) = "Z"
sResponse(2) = "X"
sResponse(3) = "C"
sResponse(4) = ","
sResponse(5) = "."
sResponse(6) = "/"

'Load up response keys maps
ReDim sColors(1 To 6)
sColors(1) = "40, 40, 40"
sColors(2) = "50, 50, 50"
sColors(3) = "60, 60, 60"
sColors(4) = "70, 70, 70"
sColors(5) = "80, 80, 80"
sColors(6) = "90, 90, 90"

'Load up color series for condtion 3
ReDim iCondition3(1 To 16)

Dim iTemp As Integer

For iLoop = 1 To 16
    iCondition3(iLoop) = 0
Next iLoop

'First 6 blocks
For iLoop = 1 To 6
    Do
        iTemp = Int(Rnd * 6) + 1
    Loop While iCondition3(iTemp) <> 0
    iCondition3(iTemp) = iLoop
Next iLoop

'Second set of 6 blocks
For iLoop = 1 To 6
    Do
        iTemp = Int(Rnd * 6) + 7
    Loop While iCondition3(iTemp) <> 0
    iCondition3(iTemp) = iLoop
Next iLoop

'Last 4 blocks
For iLoop = 13 To 16
    Do
        iTemp = Int(Rnd * 6) + 1
    Loop While iCondition3(13) = iTemp Or iCondition3(14) = iTemp _
        Or iCondition3(15) = iTemp Or iCondition3(16) = iTemp
    iCondition3(iLoop) = iTemp
Next iLoop

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

StartTimer (8)
While ReadTimer(8) < Mil
If Not FreezeEverything Then DoEvents
Wend

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

'Overloaded version of the same function as above
Public Sub SaveToFile(file As String, ParamArray data() As Variant)
    Dim i As Variant, temp As String
    Dim filenum As Integer
    filenum = OpenAppend(file)
    
    For Each i In data
        If i = NextLine Then
            Print #filenum, i;
        Else
            Print #filenum, i & Chr(9);
        End If
    Next i
    Close #filenum
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

'Create newLine for output file ( carried return + newline character ) (ie vbCrLf)
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

'Read a line from a file and return an array contains words separated by tabs
Public Function ReadLine(file As Integer) As Variant
Dim data() As String
Dim line As String
    
If EOF(file) Then
    Exit Function
End If

Line Input #file, line
line = Trim(line)

If Left(line, 1) = "#" Or line = " " Or line = "" Then
    ReadLine = ReadLine(file)
    Exit Function
End If

data = Split(line, Chr(9))
ReadLine = data
End Function
