VERSION 5.00
Begin VB.Form frmGreet 
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   9165
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   11520
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   9165
   ScaleWidth      =   11520
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.ListBox List1 
      Appearance      =   0  'Flat
      BackColor       =   &H8000000F&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   2190
      ItemData        =   "frmGreet.frx":0000
      Left            =   600
      List            =   "frmGreet.frx":0002
      TabIndex        =   15
      Top             =   6120
      Width           =   3700
   End
   Begin VB.PictureBox picBack 
      BorderStyle     =   0  'None
      Height          =   5625
      Left            =   960
      ScaleHeight     =   5625
      ScaleWidth      =   9825
      TabIndex        =   4
      Top             =   360
      Width           =   9825
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
         IMEMode         =   3  'DISABLE
         Left            =   5010
         MaxLength       =   3
         TabIndex        =   0
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
         TabIndex        =   1
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
         Left            =   4560
         TabIndex        =   2
         Top             =   4800
         Width           =   1215
      End
      Begin VB.Frame fmeCondition 
         Caption         =   "Order Condition"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   765
         Left            =   3120
         TabIndex        =   3
         Top             =   3480
         Width           =   3465
         Begin VB.OptionButton optOC 
            Caption         =   "4"
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
            Index           =   4
            Left            =   2640
            TabIndex        =   14
            Top             =   360
            Width           =   585
         End
         Begin VB.OptionButton optOC 
            Caption         =   "3"
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
            Index           =   3
            Left            =   1880
            TabIndex        =   13
            Top             =   360
            Width           =   585
         End
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
            TabIndex        =   6
            Top             =   360
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
            Left            =   1120
            TabIndex        =   5
            Top             =   360
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
      Caption         =   "Exp Name"
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
      Width           =   1170
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

If txtSubID <> "999" Then
    'Information is all ok, so let's begin!
    iFileNum = FreeFile

    'Add this user to CurrentSubjects.txt
    Open sDir & "CurrentSubjects.txt" For Append As iFileNum
    
    If fmeCondition.Visible = True Then
        PrintToFile iFileNum, txtSubID.Text, txtSubIn.Text, iCondition, vbCrLf
    Else
        PrintToFile iFileNum, txtSubID.Text, txtSubIn.Text, vbCrLf
    End If
    
    Close #iFileNum
End If

'Create the RFile and begin experiment!
SetupRFile  'Create RawData Files & Folders

'Save header info.
PrintHeaders outPutFile, "SubID", "Block", "Trial", "Condition", "Display", "Response", "Correct_Response", "Accuracy", "RT", "Intertrial_Interval_After_Response"

'Move on to the Instructions
frmInstruct.Visible = True

MoveMouseToCorner
Unload Me
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

'Quit if user presses the Escape button
If KeyAscii = vbKeyEscape Then EndProgram
    
End Sub

Private Sub Form_Load()
Label1 = sExpName



List1.AddItem "Response Keys"
List1.AddItem " "
List1.AddItem "Left Half" & Chr(9) & Chr(9) & "Right Half"
List1.AddItem "-------------------------------------------------------"

List1.AddItem "Z  =  Left" & Chr(9) & Chr(9) & ",  =  Left"
List1.AddItem "X  =  Middle" & Chr(9) & ".  =  Middle"
List1.AddItem "C  =  Right" & Chr(9) & "/  =  Right"

End Sub

Private Sub Form_Resize()

'Center the picturebox that contains all controls
picBack.Left = (Me.Width - picBack.Width) / 2
picBack.Top = (Me.Height - picBack.Height) / 2

List1.Height = Me.Height / 2

List1.Left = 500
List1.Top = (Me.Height - List1.Height) / 2

End Sub


Private Sub optOC_Click(Index As Integer)
iCondition = Index
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

Private Sub txtSubID_Validate(Cancel As Boolean)

If txtSubID <> "999" Then
    If FindIDinCurrentSubjects(txtSubID.Text) Then
        txtSubID = putInNextID
        txtSubID_Validate (False)   'check new id
    End If
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

'Create the directory if it doesn't already exist
CreateDir (sDir & "Res_Data")

'Get names for output files
outPutFile = sDir & "Res_Data\" & subID & ".txt"
ExcelFile = sDir & "Res_Data\" & subID & ".xls"

'Sets up the heading for the R-File
PrintHeaders outPutFile, sExpName & "  -  Started: " & Now
End Sub

Private Function putInNextID() As Long
    
'This procedure finds the next available number if the
'subject ID is already taken that was entered
    Dim str() As String
    Dim newID As Integer
    Dim currentID As Integer
    newID = subID + 1
    Dim filenum As Integer
    filenum = FreeFile
    Open sDir & "\CurrentSubjects.txt" For Input As filenum
    While (Not EOF(filenum))
        str = ReadLine(filenum)
        If (str(0) = newID) Then
            newID = newID + 1
        End If
    Wend
    Close #filenum
    subID = newID
    putInNextID = newID
End Function
