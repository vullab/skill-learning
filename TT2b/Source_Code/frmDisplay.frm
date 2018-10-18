VERSION 5.00
Begin VB.Form frmDisplay 
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   5700
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   8100
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   ScaleHeight     =   5700
   ScaleWidth      =   8100
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.PictureBox picLeft 
      Appearance      =   0  'Flat
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   1000
      Left            =   0
      ScaleHeight     =   1005
      ScaleWidth      =   4500
      TabIndex        =   2
      Top             =   2400
      Visible         =   0   'False
      Width           =   4500
      Begin VB.Shape sBox 
         BackStyle       =   1  'Opaque
         Height          =   1000
         Index           =   1
         Left            =   0
         Top             =   0
         Width           =   1000
      End
      Begin VB.Shape sBox 
         BackStyle       =   1  'Opaque
         Height          =   1000
         Index           =   2
         Left            =   1750
         Top             =   0
         Width           =   1000
      End
      Begin VB.Shape sBox 
         BackStyle       =   1  'Opaque
         Height          =   1005
         Index           =   3
         Left            =   3480
         Top             =   0
         Width           =   1000
      End
   End
   Begin VB.PictureBox picRight 
      Appearance      =   0  'Flat
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   1000
      Left            =   0
      ScaleHeight     =   1005
      ScaleWidth      =   4500
      TabIndex        =   1
      Top             =   3480
      Visible         =   0   'False
      Width           =   4500
      Begin VB.Shape sBox 
         BackStyle       =   1  'Opaque
         Height          =   1000
         Index           =   6
         Left            =   3480
         Top             =   0
         Width           =   1000
      End
      Begin VB.Shape sBox 
         BackStyle       =   1  'Opaque
         Height          =   1000
         Index           =   5
         Left            =   1740
         Top             =   0
         Width           =   1000
      End
      Begin VB.Shape sBox 
         BackStyle       =   1  'Opaque
         Height          =   1000
         Index           =   4
         Left            =   0
         Top             =   0
         Width           =   1000
      End
   End
   Begin VB.Label lblCross 
      Alignment       =   2  'Center
      Caption         =   "+"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   72
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1755
      Left            =   4920
      TabIndex        =   3
      Top             =   120
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Shape sDisplay 
      BackStyle       =   1  'Opaque
      Height          =   2000
      Left            =   4920
      Top             =   2520
      Visible         =   0   'False
      Width           =   2000
   End
   Begin VB.Label lblMessage 
      Alignment       =   2  'Center
      Caption         =   "Prepare to make Response"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1395
      Left            =   120
      TabIndex        =   0
      Top             =   600
      Visible         =   0   'False
      Width           =   4095
   End
End
Attribute VB_Name = "frmDisplay"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Note letter = color

Option Explicit

Private iLetter As Integer              'The Letter/color pick
Private iResponse As Integer            'The Response made
Private iPrevLetter As Integer          'Previous letter/color used

Private bDone As Boolean                'Done showing letter/color

Private bKey(1 To 6) As Boolean         'Which key was held down


Private Sub Form_Activate()
'Reset variables
iLetter = 0
iResponse = 0
iPrevLetter = 0
bDone = False

For iLoop = 1 To 6
    bKey(iLoop) = False
Next iLoop

'Set colors to the boxs
For iLoop = 1 To UBound(lColors)
    sBox(iLoop).BackColor = lColors(iLoop)
Next iLoop

sDisplay.Visible = False
picLeft.Visible = False
picRight.Visible = False


'Load up condition 3 message
If iCondition = 3 And iBlockNum <= 16 Then
    lblMessage = "Please keep all six response fingers rested on the keys throughout this block; we will only be training on one letter"
    lblMessage.Visible = True
    Me.Refresh
    Pause (5)
    lblMessage.Visible = False
    Me.Refresh
End If

'Display '+' and blank screen
Me.Refresh
PauseMil (1500)
lblCross.Visible = True
Me.Refresh
Pause (1)
lblCross.Visible = False
Me.Refresh
PauseMil (500)

startExperiment
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

If bDone And KeyCode = vbKeyZ Then
    bDone = False
    RTs = ReadTimer(1)
    iResponse = 1
    bKey(iResponse) = True
ElseIf bDone And KeyCode = vbKeyX Then
    bDone = False
    RTs = ReadTimer(1)
    iResponse = 2
    bKey(iResponse) = True
ElseIf bDone And KeyCode = vbKeyC Then
    bDone = False
    RTs = ReadTimer(1)
    iResponse = 3
    bKey(iResponse) = True
ElseIf bDone And KeyCode = 188 Then '188 = , key
    bDone = False
    RTs = ReadTimer(1)
    iResponse = 4
    bKey(iResponse) = True
ElseIf bDone And KeyCode = 190 Then '190 = . key
    bDone = False
    RTs = ReadTimer(1)
    iResponse = 5
    bKey(iResponse) = True
ElseIf bDone And KeyCode = 191 Then '191 = / key
    bDone = False
    RTs = ReadTimer(1)
    iResponse = 6
    bKey(iResponse) = True
End If


End Sub

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)

If bKey(1) And KeyCode = vbKeyZ Then
    bKey(1) = False
    writeData
ElseIf bKey(2) And KeyCode = vbKeyX Then
    bKey(2) = False
    writeData
ElseIf bKey(3) And KeyCode = vbKeyC Then
    bKey(3) = False
    writeData
ElseIf bKey(4) And KeyCode = 188 Then '188 = , key
    bKey(4) = False
    writeData
ElseIf bKey(5) And KeyCode = 190 Then '190 = . key
    bKey(5) = False
    writeData
ElseIf bKey(6) And KeyCode = 191 Then '191 = / key
    bKey(6) = False
    writeData
End If

End Sub


Private Sub writeData()
Dim iInterPause As Integer
Dim sAccuracy As String

'Hide everything
lblMessage.Visible = False
sDisplay.Visible = False
picLeft.Visible = False
picRight.Visible = False
Me.Refresh

'Pick the Intertrial_Interval_After_Response
iInterPause = Int(Rnd * 1001) + 1000

'check if subject responded correctly
If iLetter = iResponse Then
    sAccuracy = "C"
    iCorrect = iCorrect + 1
    lblMessage = "Correct"
Else
    sAccuracy = "I"
    iWrong = iWrong + 1
    lblMessage = "Wrong. Should Have Made Response " & iLetter
End If

lblMessage.Visible = True
Me.Refresh

If bDebug Then
    PauseMil (200)
Else
    Pause (1)
End If

lblMessage.Visible = False
Me.Refresh

'Sum up total Rts
dTotalRTs = dTotalRTs + RTs

'"SubID", "Block", "Trial", "Condition", _
    "Display", "Response", "Correct_Response", "Accuracy", _
    "RT", "Intertrial_Interval_After_Response"

SaveToFile outPutFile, subID, iBlockNum, iTrialNum, iCondition, _
    sColors(iLetter), sResponse(iResponse), sResponse(iLetter), sAccuracy, _
    Int(RTs), iInterPause, vbCrLf

If bDebug Then
    PauseMil (500)
Else
    PauseMil (iInterPause)
End If

startExperiment

End Sub


Private Sub Form_KeyPress(KeyAscii As Integer)
If KeyAscii = vbKeyEscape Then
    EndProgram
End If

End Sub


'Move labels to right locations
Private Sub Form_Resize()
sDisplay.Left = (Me.Width - sDisplay.Width) / 2
sDisplay.Top = (Me.Height - sDisplay.Height) / 2

picLeft.Left = picLeft.Width * 0.5
picLeft.Top = (Me.Height - picLeft.Height) - picLeft.Height * 0.5

picRight.Left = Me.Width - picRight.Width - picRight.Width * 0.5
picRight.Top = (Me.Height - picRight.Height) - picRight.Height * 0.5

lblCross.Left = (Me.Width - lblCross.Width) / 2
lblCross.Top = (Me.Height - lblCross.Height) / 2

lblMessage.Width = Me.Width * 0.8
lblMessage.Height = 1400

lblMessage.Top = (Me.Height - lblMessage.Height) / 2
lblMessage.Left = (Me.Width - lblMessage.Width) / 2

End Sub

Private Sub startExperiment()

iTrialNum = iTrialNum + 1

If iTrialNum > BLOCK_SIZE Then
    frmInstruct.Visible = True
    Unload Me
    Exit Sub
End If

'Select letter based on conditions
If iCondition = 1 Or iCondition = 4 Then
    iLetter = Int(Rnd * UBound(lColors)) + 1
    
ElseIf iCondition = 2 Then
    'Check if first trial
    If iTrialNum = 1 Or iBlockNum > 16 Then
        iLetter = Int(Rnd * UBound(lColors)) + 1
        iPrevLetter = iLetter
    Else
        '15% chance of change from previous letter
        If Int(Rnd * 100) + 1 > 85 Then
            Do
                iLetter = Int(Rnd * UBound(lColors)) + 1
            Loop While iLetter = iPrevLetter
            
            'Set the new previous letter
            iPrevLetter = iLetter
        End If
    End If

ElseIf iCondition = 3 Then
    If iBlockNum <= 16 Then
        iLetter = iCondition3(iBlockNum)
    Else
        iLetter = Int(Rnd * UBound(lColors)) + 1
    End If
End If

'Set color
'lblLetter = sLetter(iLetter)
sDisplay.BackColor = lColors(iLetter)

'Display conditon 4 message
If iCondition = 4 And iBlockNum <= 16 Then
    lblMessage = "Prepare To Make Response " & iLetter
    lblMessage.Visible = True
    Me.Refresh
    
    If bDebug Then
        PauseMil (500)
    Else
        PauseMil (1500)
    End If
    lblMessage.Visible = False
End If

sDisplay.Visible = True
picLeft.Visible = True
picRight.Visible = True

StartTimer (1)
Me.Refresh
bDone = True

End Sub
