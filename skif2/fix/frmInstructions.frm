VERSION 5.00
Begin VB.Form frmInstructions 
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   10440
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   12810
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   ScaleHeight     =   10440
   ScaleWidth      =   12810
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.PictureBox picBack 
      BorderStyle     =   0  'None
      Height          =   9855
      Left            =   360
      ScaleHeight     =   9855
      ScaleWidth      =   11775
      TabIndex        =   0
      Top             =   240
      Width           =   11775
      Begin VB.Label cueLabel2 
         Alignment       =   2  'Center
         Caption         =   "X"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   24
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   2640
         TabIndex        =   8
         Top             =   6120
         Width           =   855
      End
      Begin VB.Label cueLabel3 
         Alignment       =   2  'Center
         Caption         =   "N"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   24
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   4200
         TabIndex        =   7
         Top             =   5760
         Width           =   855
      End
      Begin VB.Label cueLabel4 
         Alignment       =   2  'Center
         Caption         =   "M"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   24
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   6480
         TabIndex        =   6
         Top             =   5880
         Width           =   495
      End
      Begin VB.Label cueLabel1 
         Alignment       =   2  'Center
         Caption         =   "Z"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   24
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   840
         TabIndex        =   5
         Top             =   6000
         Width           =   855
      End
      Begin VB.Image cuePic1 
         Height          =   1320
         Left            =   720
         Stretch         =   -1  'True
         Top             =   6720
         Width           =   1080
      End
      Begin VB.Image cuePic2 
         Height          =   1320
         Left            =   2400
         Stretch         =   -1  'True
         Top             =   6720
         Width           =   1080
      End
      Begin VB.Image cuePic3 
         Height          =   1320
         Left            =   4080
         Stretch         =   -1  'True
         Top             =   6480
         Width           =   1080
      End
      Begin VB.Image cuePic4 
         Height          =   1320
         Left            =   6480
         Stretch         =   -1  'True
         Top             =   6480
         Width           =   1080
      End
      Begin VB.Label Label4 
         Alignment       =   2  'Center
         Caption         =   "Press the spacebar to begin"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   18
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   615
         Left            =   2400
         TabIndex        =   4
         Top             =   9240
         Width           =   6615
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Please Read Instructions Carefully"
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
         Left            =   4260
         TabIndex        =   2
         Top             =   615
         Width           =   2940
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Instructions"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   24
            Charset         =   0
            Weight          =   700
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   555
         Left            =   4380
         TabIndex        =   1
         Top             =   0
         Width           =   2655
      End
      Begin VB.Label lblInstruct 
         BackStyle       =   0  'Transparent
         Caption         =   $"frmInstructions.frx":0000
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   15.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   7695
         Left            =   360
         TabIndex        =   3
         Top             =   1080
         Width           =   11055
      End
   End
End
Attribute VB_Name = "frmInstructions"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim picPath As String
Dim expNum As Integer    'Which experiment is next
Dim Page As Integer      'Current page in instructions
Dim endPage As Integer   'Last page of instructions
Dim instruct(1 To 5) As String


Private Sub Form_Activate()
iBlockNum = iBlockNum + 1

If sOrder(iBlockNum) = "T" And iBlockNum = 1 Then
    set_Instructions1
ElseIf sOrder(iBlockNum) = "T" Then
    set_Instructions2
ElseIf sOrder(iBlockNum) = "I" Then
    set_Instructions3
ElseIf sOrder(iBlockNum) = "S" Then
    set_Instructions4
ElseIf sOrder(iBlockNum) = "P" Then
    set_Instructions6
ElseIf sOrder(iBlockNum) = "E" Then
    set_Instructions5
End If
    
lblInstruct = instruct(1)
Page = 1

End Sub


Private Sub Form_KeyPress(KeyAscii As Integer)
If KeyAscii = vbKeyEscape Then
    EndProgram
ElseIf KeyAscii = Asc(" ") Then

Page = Page + 1

If Page > endPage Then
    iTrialNum = 0
    iWrong = 0
    iCorrect = 0
    totalRT = 0

    'Start Block
    If expNum = 1 Then
        iTrialNum = 0
        frmDisplay.Visible = True
        Unload Me
    ElseIf expNum = 2 Then
        iTrialNum = 0
        frmInference.Visible = True
        Unload Me
    ElseIf expNum = 3 Then
        iTrialNum = 0
        frmSkill.Visible = True
        Unload Me
    ElseIf expNum = 5 Then
        iTrialNum = 0
        frmWait.Visible = True
        Unload Me
    ElseIf expNum = 4 Then
        End
    End If
    
    Exit Sub
End If

lblInstruct = instruct(Page)
lblInstruct.Visible = True

showResponse

End If

End Sub

Private Sub Form_Resize()

picPath = "\images\images\"

picBack.Top = (Me.Height - picBack.Height) / 2
picBack.Left = (Me.Width - picBack.Width) / 2

cuePic1.Height = 0.1 * picBack.Width
cuePic1.Width = 0.1 * picBack.Width
cuePic1.Left = 0 * (picBack.Width / 4) + ((picBack.Width / 4) - cuePic1.Width) / 2
cuePic1.Top = picBack.Height - cuePic1.Height * 1.5 - Label4.Height
cuePic1.Picture = LoadPicture(App.path & picPath & "Icon1.bmp")

cuePic2.Height = 0.1 * picBack.Width
cuePic2.Width = 0.1 * picBack.Width
cuePic2.Left = 1 * (picBack.Width / 4) + ((picBack.Width / 4) - cuePic2.Width) / 2
cuePic2.Top = picBack.Height - cuePic2.Height * 1.5 - Label4.Height
cuePic2.Picture = LoadPicture(App.path & picPath & "Icon2.bmp")

cuePic3.Height = 0.1 * picBack.Width
cuePic3.Width = 0.1 * picBack.Width
cuePic3.Left = 2 * (picBack.Width / 4) + ((picBack.Width / 4) - cuePic3.Width) / 2
cuePic3.Top = picBack.Height - cuePic3.Height * 1.5 - Label4.Height
cuePic3.Picture = LoadPicture(App.path & picPath & "Icon3.bmp")

cuePic4.Height = 0.1 * picBack.Width
cuePic4.Width = 0.1 * picBack.Width
cuePic4.Left = 3 * (picBack.Width / 4) + ((picBack.Width / 4) - cuePic4.Width) / 2
cuePic4.Top = picBack.Height - cuePic4.Height * 1.5 - Label4.Height
cuePic4.Picture = LoadPicture(App.path & picPath & "Icon4.bmp")


cueLabel1.Left = 0 * (picBack.Width / 4) + ((picBack.Width / 4) - cueLabel1.Width) / 2
cueLabel1.Top = picBack.Height - cuePic1.Height * 0.5 - Label4.Height

cueLabel2.Left = 1 * (picBack.Width / 4) + ((picBack.Width / 4) - cueLabel2.Width) / 2
cueLabel2.Top = picBack.Height - cuePic2.Height * 0.5 - Label4.Height

cueLabel3.Left = 2 * (picBack.Width / 4) + ((picBack.Width / 4) - cueLabel3.Width) / 2
cueLabel3.Top = picBack.Height - cuePic3.Height * 0.5 - Label4.Height

cueLabel4.Left = 3 * (picBack.Width / 4) + ((picBack.Width / 4) - cueLabel4.Width) / 2
cueLabel4.Top = picBack.Height - cuePic4.Height * 0.5 - Label4.Height

Label4.Top = picBack.Height - Label4.Height


showResponse


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

'1st set of instructions
Public Sub set_Instructions1()
instruct(1) = "You will see one of four symbols on each trial, shown below. "
instruct(1) = instruct(1) & NextLine
instruct(1) = instruct(1) & "We want you to respond by pressing one of the four keys on the bottom row of the keyboard. "
instruct(1) = instruct(1) & "Each key (Z, X, N, M) corresponds to one of the symbols, as shown below. "
instruct(1) = instruct(1) & "So if you see a smiley face, press the 'Z' key. And so on."
instruct(1) = instruct(1) & "Throughout the experiment, please keep your fingers on the keyboard. "
instruct(1) = instruct(1) & "Use your left middle and index fingers for the leftmost response keys (Z and X), "
instruct(1) = instruct(1) & "and your right index and middle fingers for the rightmost keys (N and M). "
instruct(1) = instruct(1) & NextLine & NextLine
instruct(1) = instruct(1) & "The symbols will be presented on an irrelevant background; you can ignore the background shape and color."
instruct(1) = instruct(1) & NextLine & NextLine
instruct(1) = instruct(1) & "We siply want you to respond extremely rapidly to the symbol.  "
instruct(1) = instruct(1) & "Try to be accurate, but the machine will insist that you respond so quickly to the letter that you will make many errors. "
instruct(1) = instruct(1) & "Every few minutes there will be a break in the experiment.  During the break, the computer will tell you how you're doing."


expNum = 1
endPage = 1

End Sub

'Between block instructions
Public Sub set_Instructions2()

Dim averageRT As Integer
Dim iPError As Integer

averageRT = Int(totalRT / nTrainingBlockTrials)
iPError = Int(iWrong / (iWrong + iCorrect) * 100)

instruct(1) = "Your average RT is " & averageRT & "." & NextLine & NextLine

If iPError < 10 Then
    instruct(1) = instruct(1) & "You are not going fast enough!   Please try to respond faster on the next block!"
ElseIf iPError < 20 Then
    instruct(1) = instruct(1) & "You are going fast.  Keep up the good work!"
Else
    instruct(1) = instruct(1) & "We appreciate your going fast, but try to be a bit more accurate on the next block - very fast but accurate!"
End If

expNum = 1
endPage = 1

End Sub
'Between block instructions
'1st set of instructions
Public Sub set_Instructions3()
instruct(1) = "You will now be presented with just the background colors you saw in the previous blocks. "
instruct(1) = instruct(1) & "On each trial, please indicate which symbol you think is most likely to be presented with this color by pressing one of the four corresponding keys."
instruct(1) = instruct(1) & "You may be presented with a given background color multiple times: you do not need to make consistent responses for a particular background color if you do not want to."

Label4 = "Press Space To Begin"

expNum = 2
endPage = 1

End Sub

'End
Public Sub set_Instructions4()
instruct(1) = "Great, you will now be presented with more trials where your objective is to identify the symbol as quickly as possible. "
instruct(1) = instruct(1) & "Again, you can ignore the background colors, simply try to press the key associated with the symbol as soon as it appears. "
instruct(1) = instruct(1) & "And again, please try to respond as quickly and accurately as possible. "

Label4 = "Press Space To Begin"

expNum = 3
endPage = 1

End Sub


Public Sub set_Instructions5()
instruct(1) = "You have completed the experiment. Thank you for your participation."

Label4 = "Press Space To End"

expNum = 4
endPage = 1

End Sub

Public Sub set_Instructions6()
instruct(1) = "The experiment requires a 6 minute pause before we continue, please press the spacebar to continue on to the waiting interval ."

expNum = 5
endPage = 1

End Sub

