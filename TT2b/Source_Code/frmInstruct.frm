VERSION 5.00
Begin VB.Form frmInstruct 
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   5490
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   9825
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   ScaleHeight     =   5490
   ScaleWidth      =   9825
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.PictureBox picBox2 
      Appearance      =   0  'Flat
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   1000
      Left            =   3120
      ScaleHeight     =   1005
      ScaleWidth      =   4500
      TabIndex        =   6
      Top             =   3480
      Visible         =   0   'False
      Width           =   4500
      Begin VB.Shape sBox 
         BackStyle       =   1  'Opaque
         Height          =   1000
         Index           =   4
         Left            =   0
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
         Index           =   6
         Left            =   3480
         Top             =   0
         Width           =   1000
      End
   End
   Begin VB.PictureBox picBox1 
      Appearance      =   0  'Flat
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   1000
      Left            =   3120
      ScaleHeight     =   1005
      ScaleWidth      =   4500
      TabIndex        =   5
      Top             =   2400
      Visible         =   0   'False
      Width           =   4500
      Begin VB.Shape sBox 
         BackStyle       =   1  'Opaque
         Height          =   1005
         Index           =   3
         Left            =   3480
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
         Height          =   1000
         Index           =   1
         Left            =   0
         Top             =   0
         Width           =   1000
      End
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   10000
      Left            =   8400
      Top             =   360
   End
   Begin VB.ListBox List1 
      BackColor       =   &H8000000F&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2055
      Left            =   240
      TabIndex        =   4
      Top             =   2400
      Visible         =   0   'False
      Width           =   2535
   End
   Begin VB.Shape s2 
      BackStyle       =   1  'Opaque
      Height          =   1005
      Left            =   7680
      Top             =   1080
      Visible         =   0   'False
      Width           =   1005
   End
   Begin VB.Shape s1 
      BackStyle       =   1  'Opaque
      Height          =   1005
      Left            =   6360
      Top             =   1080
      Visible         =   0   'False
      Width           =   1005
   End
   Begin VB.Label lblHeader 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      Caption         =   "Instructions"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   26.25
         Charset         =   0
         Weight          =   700
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   240
      TabIndex        =   3
      Top             =   1080
      Width           =   2925
   End
   Begin VB.Label lblHeader2 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      Caption         =   "Please Read Instructions Carefully"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   240
      Left            =   120
      TabIndex        =   2
      Top             =   1800
      Width           =   3600
   End
   Begin VB.Label lblInstruct 
      Caption         =   "Instructions Will Go Here"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   17.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   525
      Left            =   0
      TabIndex        =   1
      Top             =   600
      Width           =   5985
   End
   Begin VB.Label lblSpace 
      Alignment       =   2  'Center
      Caption         =   "Press The Spacebar To Begin"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   21.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   120
      Width           =   7995
   End
End
Attribute VB_Name = "frmInstruct"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Page As Integer      'Current page in instructions
Dim endPage As Integer   'Last page of instructions
Dim expNum As Integer
Dim instruct(1 To 5) As String

Dim bDone As Boolean


Private Sub Form_Activate()
iBlockNum = iBlockNum + 1

If iBlockNum = 1 Then
    bDone = True
    set_Instructions1
ElseIf iBlockNum <= 16 And bDebug Then
    set_Instructions2
ElseIf iBlockNum <= 32 And Not bDebug Then
'ElseIf iBlockNum <= 32 Then
    set_Instructions2
Else
    bDone = True
    set_End
End If

lblInstruct = instruct(1)
Page = 1

End Sub


Private Sub Form_KeyPress(KeyAscii As Integer)

If KeyAscii = vbKeyEscape Then
    EndProgram
End If

If Not bDone Then
    Exit Sub
End If

If KeyAscii = Asc(" ") Then

Page = Page + 1

If Page > endPage Then
    iTrialNum = 0
    iWrong = 0
    iCorrect = 0
    dTotalRTs = 0
    
    If expNum = 1 Then
        
        If bDebug Then
            BLOCK_SIZE = 5
        Else
            BLOCK_SIZE = 20
        End If
        frmDisplay.Visible = True
    Else
        EndProgram
        Exit Sub
    End If
    
    Unload Me
    Exit Sub
End If

lblInstruct = instruct(Page)

End If

End Sub

Private Sub Form_Load()

Timer1.Enabled = False
bDone = False

If bDebug Then
    Timer1.Interval = 1000
End If

'Set colors to the boxs
For iLoop = 1 To UBound(lColors)
    sBox(iLoop).BackColor = lColors(iLoop)
Next iLoop

s1.BackColor = lColors(1)
s2.BackColor = lColors(5)

List1.Visible = False
picBox1.Visible = False
picBox2.Visible = False
s1.Visible = False
s2.Visible = False

lblInstruct.Alignment = 0
lblSpace = "Press The Spacebar To Begin"

End Sub

'Setup position of objects
Private Sub Form_Resize()

lblHeader.Left = (Me.Width - lblHeader.Width) / 2
lblHeader.Top = 250

lblHeader2.Left = (Me.Width - lblHeader2.Width) / 2
lblHeader2.Top = lblHeader.Top + lblHeader.Height

lblInstruct.Width = Me.Width * 0.8
lblInstruct.Height = Me.Height * 0.8

lblInstruct.Left = (Me.Width - lblInstruct.Width) / 2
lblInstruct.Top = (Me.Height - lblInstruct.Height) / 2

lblSpace.Width = Me.Width
lblSpace.Left = (Me.Width - lblSpace.Width) / 2
lblSpace.Top = Me.Height - lblSpace.Height - 250

List1.Width = Me.Width * 0.45
List1.Height = Me.Height * 0.67

List1.Left = (Me.Width - List1.Width) / 2
List1.Top = (Me.Height - List1.Height) / 2

picBox1.Left = (Me.Width / 2 - picBox1.Width) / 2
picBox1.Top = 5400

picBox2.Left = Me.Width / 2 + picBox2.Width / 2
picBox2.Top = 5400

s1.Top = 7000
s2.Top = 7000

s1.Left = 4550
s2.Left = 13600

End Sub

'1st set of instructions
Public Sub set_Instructions1()
instruct(1) = "Welcome to our experiment.  We are looking at how fast you can respond to letters by pressing a button.  On every trial, you will see one of six possible letters.   There are six response keys marked on the lower row of the keyboard.  You should rest your index and middle fingers of your left and right hands comfortably on these response keys when the experiment begins.  Please keep them there while the experiment is running."
instruct(1) = instruct(1) & NextLine & NextLine
instruct(1) = instruct(1) & "There are six possible letters.  For each response key, there is one letter corresponding to that response.  The assignment is like this"

instruct(1) = instruct(1) & NextLine & NextLine & NextLine
instruct(1) = instruct(1) & NextLine & NextLine & NextLine
instruct(1) = instruct(1) & NextLine & NextLine
instruct(1) = instruct(1) & "So if you see a               , you would press the leftmost key.  If you see a               , you would press the second key from the right."

instruct(1) = instruct(1) & NextLine & NextLine

instruct(1) = instruct(1) & "We will do 32 blocks of trials.  Each block will last just a little over a minute.  At the end of a block, there will be a rest period.  Take a minute to relax, and then when you're ready to resume, just press one of the response keys and the experiment will begin.  The six letters will sit at the bottom of the screen to help you learn which keys go with which letters.  You can check them if you need to, but please try to keep your eye in the center of the screen (this is where the letters you need to respond to will appear)."
instruct(1) = instruct(1) & NextLine & NextLine
instruct(1) = instruct(1) & "Please try to respond as rapidly and accurately as possible.  If you have any questions, ask the experimenter now.  We appreciate your participation and hope you find this task at least somewhat entertaining.  Just concentrate on trying to do your best and we will be finished before you know it."

picBox1.Visible = True
picBox2.Visible = True
s1.Visible = True
s2.Visible = True


endPage = 1
expNum = 1
End Sub

'Rest period
Public Sub set_Instructions2()
instruct(1) = "REST PERIOD - PLEASE REST AT LEAST 10 SECONDS."

'Keep track of number of wrongs, and avg. rts
iWrongCount(iBlockNum - 1) = iWrong
iAvgRTs(iBlockNum - 1) = dTotalRTs / BLOCK_SIZE

'Add items to the list
lblInstruct.Alignment = 2
List1.Visible = True
List1.Clear
List1.AddItem ("Block Number" & Chr(9) & "Average Response Time" & Chr(9) & "Number of Errors")
List1.AddItem ("---------------------------------------------------------------------------------------------------------------------------")

For iLoop = 1 To iBlockNum - 1
    List1.AddItem (iLoop & Chr(9) & Chr(9) & iAvgRTs(iLoop) & Chr(9) & Chr(9) & Chr(9) & iWrongCount(iLoop))
Next iLoop

lblSpace.Visible = False
lblSpace = "PRESS THE SPACE KEY WHEN YOU ARE READY TO RESUME"
Me.Refresh

'make subject rest 10 secs first
Timer1.Enabled = True

endPage = 1
expNum = 1
End Sub

'End
Public Sub set_End()
instruct(1) = "You have completed the experiment. Thank you for your participation."

'Keep track of number of wrongs, and avg. rts
iWrongCount(iBlockNum - 1) = iWrong
iAvgRTs(iBlockNum - 1) = dTotalRTs / BLOCK_SIZE

'Add items to the list
lblInstruct.Alignment = 2
List1.Visible = True
List1.Clear
List1.AddItem ("Block Number" & Chr(9) & "Average Response Time" & Chr(9) & "Number of Errors")
List1.AddItem ("---------------------------------------------------------------------------------------------------------------------------")

For iLoop = 1 To iBlockNum - 1
    List1.AddItem (iLoop & Chr(9) & Chr(9) & iAvgRTs(iLoop) & Chr(9) & Chr(9) & Chr(9) & iWrongCount(iLoop))
Next iLoop

lblSpace = "Press Space To End"
endPage = 1
expNum = 100

End Sub

Private Sub Timer1_Timer()
bDone = True
lblSpace.Visible = True
Me.Refresh
Timer1.Enabled = False
End Sub
