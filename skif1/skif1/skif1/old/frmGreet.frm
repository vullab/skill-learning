VERSION 5.00
Begin VB.Form frmGreet 
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   8475
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   12060
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   ScaleHeight     =   8475
   ScaleWidth      =   12060
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.PictureBox picBack 
      BorderStyle     =   0  'None
      Height          =   6585
      Left            =   600
      ScaleHeight     =   6585
      ScaleWidth      =   9945
      TabIndex        =   0
      Top             =   720
      Width           =   9945
      Begin VB.TextBox txtSubID 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   5010
         MaxLength       =   3
         TabIndex        =   6
         Top             =   2040
         Width           =   1185
      End
      Begin VB.TextBox txtSubIn 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   5010
         MaxLength       =   3
         TabIndex        =   5
         Top             =   2820
         Width           =   1185
      End
      Begin VB.CommandButton cmdStart 
         Caption         =   "Start"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   4800
         TabIndex        =   4
         Top             =   4800
         Width           =   1215
      End
      Begin VB.Frame fmeCondition 
         Caption         =   "Condition"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1005
         Left            =   4440
         TabIndex        =   1
         Top             =   3480
         Visible         =   0   'False
         Width           =   2025
         Begin VB.OptionButton optOC 
            Caption         =   "1"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Index           =   1
            Left            =   360
            TabIndex        =   3
            Top             =   480
            Value           =   -1  'True
            Width           =   585
         End
         Begin VB.OptionButton optOC 
            Caption         =   "2"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Index           =   2
            Left            =   1005
            TabIndex        =   2
            Top             =   480
            Width           =   585
         End
      End
      Begin VB.Label lblSubID 
         Alignment       =   1  'Right Justify
         Caption         =   "Subject ID"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   2730
         TabIndex        =   11
         Top             =   2100
         Width           =   2055
      End
      Begin VB.Label lblSubInitials 
         Alignment       =   1  'Right Justify
         Caption         =   "Subject Initials"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   2010
         TabIndex        =   10
         Top             =   2880
         Width           =   2775
      End
      Begin VB.Label Label2 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         BackStyle       =   0  'Transparent
         Caption         =   "Welcome  please enter subject information:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   24
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   735
         Left            =   -90
         TabIndex        =   9
         Top             =   720
         Width           =   10215
      End
      Begin VB.Label lblNumbersOnly 
         AutoSize        =   -1  'True
         Caption         =   "(Numbers Only!)"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   6390
         TabIndex        =   8
         Top             =   2190
         Visible         =   0   'False
         Width           =   1365
      End
      Begin VB.Label lblLettersOnly 
         AutoSize        =   -1  'True
         Caption         =   "(Letters Only!)"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   6420
         TabIndex        =   7
         Top             =   2940
         Visible         =   0   'False
         Width           =   1215
      End
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Proctor 3"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   0
      TabIndex        =   12
      Top             =   0
      Width           =   1050
   End
End
Attribute VB_Name = "frmGreet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdStart_Click()

'Check to see if the subject already exists in the CurrectSubjects file
If txtSubID <> "999" Then
    If FindIDinCurrentSubjects(txtSubID.Text) Then
        MsgBox "Subject ID " & txtSubID.Text & " already exists!" & vbCrLf & "Please enter new ID"
        txtSubID.SetFocus
        Exit Sub
    End If
End If

'Information is all ok, so let's begin!
iFileNum = FreeFile

If txtSubID <> "999" Then
    'Add this user to CurrentSubjects.txt
    Open sDir & "CurrentSubjects.txt" For Append As iFileNum
    Print #iFileNum, txtSubID.Text, txtSubIn.Text, iCondition, NextLine
    Close #iFileNum
End If

'Create the directory if it doesn't already exist
CreateDir (sDir & "Res_Data")

'Create the RFile and begin experiment!
SetupRFile  'Create RawData Files

'Move on to the Instructions
frmInstructions.Visible = True

MoveMouseToCorner
Unload Me
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

'Quit if user presses the Escape button
If KeyAscii = vbKeyEscape Then EndProgram
    
End Sub

Private Sub Form_Resize()

'Center the picturebox that contains all controls
picBack.Left = (Me.Width - picBack.Width) / 2
picBack.Top = (Me.Height - picBack.Height) / 2

End Sub


Private Sub optOC_Click(index As Integer)
iCondition = index
End Sub


Private Sub txtSubID_Change()

'Make Start enabled if all info is entered
cmdStart.Enabled = txtSubID <> "" And txtSubIn <> ""

'Keep track of ID
subID = Val(txtSubID.Text)

'Autotab
If Len(txtSubID) = 3 Then SendKeys "{TAB}"

'Used for TESTING purposes only
If txtSubID = "999" Then
    txtSubIn = "ABC"
    cmdStart.SetFocus
End If

End Sub

Private Sub txtSubID_Validate(Cancel As Boolean)

If txtSubID <> "999" Then
    If FindIDinCurrentSubjects(txtSubID.Text) Then
        txtSubID = putInNextID
    End If
End If

End Sub


Private Sub txtSubID_KeyPress(KeyAscii As Integer)

If KeyAscii = vbKeyBack Then Exit Sub

If KeyAscii = 13 Then SendKeys "{tab}": Exit Sub

'Only allow numbers to be entered
If KeyAscii < vbKey0 Or KeyAscii > vbKey9 Then
    KeyAscii = 0
    lblNumbersOnly.Visible = True
Else
    lblNumbersOnly.Visible = False
End If
    

End Sub

Private Sub txtSubIn_Change()

cmdStart.Enabled = txtSubID <> "" And txtSubIn <> ""

'Autotab
If Len(txtSubIn) = 3 Then SendKeys "{TAB}"

End Sub

Private Sub txtSubIn_KeyPress(KeyAscii As Integer)

If KeyAscii = vbKeyBack Then Exit Sub

If KeyAscii = 13 Then SendKeys "{tab}": Exit Sub

'Only allow letters to be entered
If Asc(UCase(Chr(KeyAscii))) < vbKeyA Or Asc(UCase(Chr(KeyAscii))) > vbKeyZ Then
    KeyAscii = 0
    lblLettersOnly.Visible = True
Else
    'Make it an uppercase letter
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
    lblLettersOnly.Visible = False
End If

End Sub

Private Sub SetupRFile()

'Get names for output files
outPutFile = sDir & "Res_Data\" & subID & ".txt"
ExcelFile = sDir & "Res_Data\" & subID & ".xls"

'Sets up the heading for the R-File
PrintHeaders outPutFile, "Proctor 3  -  Started: " & Now
PrintHeaders outPutFile, "SubID", "Block", "Trial", "Letter", "Tone", _
    "Letter Reponse", "Tone Response", "Letter Accuracy", "Tone Accuracy", _
    "Letter RT", "Tone RT"

End Sub

Private Function putInNextID() As Long
    
'This procedure finds the next available number if the
'subject ID is already taken that was entered
    
    Dim str() As Variant
    Dim newID As Integer
    Dim currentID As Integer
    newID = subID + 1
    Dim filenum As Integer
    filenum = FreeFile
    Open sDir & "CurrentSubjects.txt" For Input As filenum
    While (Not EOF(filenum))
        str = ReadLine(filenum, 2)
        If (str(1) = newID) Then
            newID = newID + 1
        End If
    Wend
    Close #filenum
    subID = newID
    putInNextID = newID
End Function

Public Function ReadLine(file As Integer, Optional lineLength As Integer) As Variant
    Dim r As Integer, line As String, z As Integer, y As Integer
    Dim data() As Variant, ch As String
    Dim reply As Integer
    
' =======================added on 8/24======================
    If EOF(file) Then
        Exit Function
    End If
    
    Line Input #file, line
    line = Trim(line)
    If Left(line, 1) = "#" Or line = " " Then
        ReadLine = ReadLine(file, lineLength)
        Exit Function
    End If
    ReDim data(Len(line) + 1)
    z = 1
    y = 1
    r = 1
    While r <= Len(line) + 1
        ch = Mid$(line, r, 1)
        If ch = "" Then 'Then end of the line
            data(y) = Trim(Mid(line, z, r - z))
        ElseIf ch = " " Or ch = "   " Or ch = Chr(9) Then '9 is equal to the tab key
            While ch = " " Or ch = "    " Or ch = Chr(9) 'Remove blanke spaces
                r = r + 1
                ch = Mid(line, r, 1)
            Wend
            data(y) = Trim(Mid(line, z, r - z)) 'Read whole word into array
            y = y + 1
            z = r
        End If
        r = r + 1
    Wend
    lineLength = y
    ReadLine = data
End Function




