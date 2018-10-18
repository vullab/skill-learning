VERSION 5.00
Begin VB.Form frmSkill 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   9885
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   11595
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   ScaleHeight     =   9885
   ScaleWidth      =   11595
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.Label cueLabel1 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
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
      Left            =   1680
      TabIndex        =   4
      Top             =   7920
      Width           =   855
   End
   Begin VB.Label cueLabel4 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
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
      Left            =   7320
      TabIndex        =   3
      Top             =   7800
      Width           =   495
   End
   Begin VB.Label cueLabel3 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
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
      Left            =   5040
      TabIndex        =   2
      Top             =   7680
      Width           =   855
   End
   Begin VB.Label cueLabel2 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
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
      Left            =   3480
      TabIndex        =   1
      Top             =   8040
      Width           =   855
   End
   Begin VB.Image expImage3 
      Appearance      =   0  'Flat
      Height          =   2280
      Left            =   1440
      Picture         =   "frmSkill.frx":0000
      Stretch         =   -1  'True
      Top             =   0
      Visible         =   0   'False
      Width           =   2040
   End
   Begin VB.Image fixImage 
      Appearance      =   0  'Flat
      Height          =   2280
      Left            =   6480
      Picture         =   "frmSkill.frx":4846
      Stretch         =   -1  'True
      Top             =   1680
      Visible         =   0   'False
      Width           =   2040
   End
   Begin VB.Image cuePic4 
      Height          =   1320
      Left            =   5160
      Picture         =   "frmSkill.frx":16898
      Stretch         =   -1  'True
      Top             =   5520
      Width           =   1080
   End
   Begin VB.Image cuePic3 
      Height          =   1320
      Left            =   3480
      Picture         =   "frmSkill.frx":3A9CA
      Stretch         =   -1  'True
      Top             =   5760
      Width           =   1080
   End
   Begin VB.Image cuePic2 
      Height          =   1320
      Left            =   1800
      Picture         =   "frmSkill.frx":5EAFC
      Stretch         =   -1  'True
      Top             =   5520
      Width           =   1080
   End
   Begin VB.Image cuePic1 
      Height          =   1320
      Left            =   360
      Picture         =   "frmSkill.frx":82C46
      Stretch         =   -1  'True
      Top             =   5640
      Width           =   1080
   End
   Begin VB.Label lblDisplay 
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
      Height          =   1500
      Left            =   2280
      TabIndex        =   0
      Top             =   2160
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.Image expImage2 
      Appearance      =   0  'Flat
      Height          =   2280
      Left            =   3840
      Picture         =   "frmSkill.frx":A6DDC
      Stretch         =   -1  'True
      Top             =   1680
      Width           =   2040
   End
   Begin VB.Image expImage1 
      Appearance      =   0  'Flat
      Height          =   2280
      Left            =   0
      Picture         =   "frmSkill.frx":AB622
      Stretch         =   -1  'True
      Top             =   1680
      Width           =   2040
   End
End
Attribute VB_Name = "frmSkill"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim picPath As String                   'Path to Pictures
Dim sPreCuePic(1 To 4) As String             'The PreCue Pictures to display
Dim sStimPic(1 To 4) As String             'The Stim Pictures to display

Dim iReliable As Integer                  'Reliable trial or not?
Dim iPreCue As Integer                  'Which letter to show
Dim iStim As Integer                    'Which tone to play

Dim bDisplayed As Boolean                  'If done showing tone
Dim bDisplayDone As Boolean                  'If done showing tone

Dim iResponse As Integer                'Response to letter task
Dim bDataNotSaved As Boolean

Dim bKey(1 To 4) As Boolean             'Check if key is held down

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


If iTrialNum > nTrainingBlockTrials Then
    frmInstructions.Visible = True
    Unload Me
    Exit Sub
End If

'Show Fixation Cross...
fixImage.Visible = True
Me.Refresh
PauseMil (500)
fixImage.Visible = False
Me.Refresh
PauseMil (500)

'Pick a letter and tone
iStim = Int(Rnd * 4) + 1

iReliable = 0
Dim temporary As Integer
temporary = Int(Rnd * 4) + 1 ' If not reliable trial, then pick one of other three associations.
iPreCue = sAssociation(temporary)
If (temporary = iStim) Then
    iReliable = 1
End If
    

        
' Construct File Names
Dim sPreCueFilename As String
Dim sStimulusFilename As String
Dim sStimCueFilename As String

sPreCueFilename = sPreCuePic(iPreCue) & "_.bmp"
sStimCueFilename = sPreCuePic(iPreCue) & sStimPic(iStim) & ".bmp"
sStimulusFilename = "_" & sStimPic(iStim) & ".bmp"

    expImage1.Picture = LoadPicture(App.path & picPath & sPreCueFilename)
    expImage2.Picture = LoadPicture(App.path & picPath & sStimCueFilename)
    expImage3.Picture = LoadPicture(App.path & picPath & sStimCueFilename)

'Do letter task
StartTimer (1)
bDisplayed = True
expImage1.Visible = True
Me.Refresh

PauseMil (400)

expImage1.Visible = False
StartTimer (2)
expImage2.Visible = True
Me.Refresh

PauseMil (400)

expImage2.Visible = False
StartTimer (3)
expImage3.Visible = True
bDisplayDone = True
Me.Refresh

PauseMil (600)
While bDataNotSaved = True
PauseMil (100)
Wend
ContinueOn

End Sub

Private Sub writeData()
Dim sAccuracy As String           'The accuracy of letter task

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
Dim filedata As Integer
filedata = OpenAppend(outPutFile_Skill)

'"SubID", "Block", "Trial", "Letter", "Tone", _
    "Letter Reponse", "Tone Response", "Letter Accuracy", "Tone Accuracy", _
    "Letter RT", "Tone RT"

PrintToFile filedata, _
    subID, iBlockNum, iTrialNum, _
    sAssociation(1), sAssociation(2), sAssociation(3), sAssociation(4), _
    sTraining, sOrdCondition, iStim, iPreCue, iReliable, _
    iResponse, Int(RTs), sAccuracy, vbCrLf
    
Close #filedata
bDataNotSaved = False

End Sub

Private Sub ContinueOn()
    
    expImage3.Visible = False
    startExperiment

End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

If bDisplayed And bDataNotSaved Then
    If KeyCode = vbKeyZ Then
        bDisplayed = False
        RTs = ReadTimer(1) - 400
        bKey(1) = True
    ElseIf KeyCode = vbKeyX Then
        bDisplayed = False
        RTs = ReadTimer(1) - 400
        bKey(2) = True
    ElseIf KeyCode = vbKeyN Then
        bDisplayed = False
        RTs = ReadTimer(1) - 400
        bKey(3) = True
    ElseIf KeyCode = vbKeyM Then
        bDisplayed = False
        RTs = ReadTimer(1) - 400
        bKey(4) = True
    End If
End If

End Sub

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)
If bDataNotSaved Then

    If KeyCode = vbKeyZ And bKey(1) Then
        bKey(1) = False
        iResponse = 1
    ElseIf KeyCode = vbKeyX And bKey(2) Then
        bKey(2) = False
        iResponse = 2
    ElseIf KeyCode = vbKeyN And bKey(3) Then
        bKey(3) = False
        iResponse = 3
    ElseIf KeyCode = vbKeyM And bKey(4) Then
        bKey(4) = False
        iResponse = 4
    End If
    If iResponse <> 0 Then
        writeData
    End If
End If

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

'Quit if user presses the Escape button
If KeyAscii = vbKeyEscape Then EndProgram
    
End Sub

Private Sub Form_Load()
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

Private Sub Form_Activate()
bDisplayed = False
iResponse = 0

'Display the Cross
expImage1.Visible = False
expImage2.Visible = False

showResponse

startExperiment
End Sub

Private Sub Form_Resize()
'Me.
'txtDebug.Text = sDir
'& "\images\images\Icon1.bmp"
'cuePic1.Picture = sDir & "\images\images\Icon1.bmp"

cuePic1.Height = 0.1 * Me.Width
cuePic1.Width = 0.1 * Me.Width
cuePic1.Left = 0 * (Me.Width / 4) + ((Me.Width / 4) - cuePic1.Width) / 2
cuePic1.Top = Me.Height - cuePic1.Height * 1.5
cuePic1.Picture = LoadPicture(App.path & picPath & "Icon1.bmp")

cuePic2.Height = 0.1 * Me.Width
cuePic2.Width = 0.1 * Me.Width
cuePic2.Left = 1 * (Me.Width / 4) + ((Me.Width / 4) - cuePic2.Width) / 2
cuePic2.Top = Me.Height - cuePic2.Height * 1.5
cuePic2.Picture = LoadPicture(App.path & picPath & "Icon2.bmp")

cuePic3.Height = 0.1 * Me.Width
cuePic3.Width = 0.1 * Me.Width
cuePic3.Left = 2 * (Me.Width / 4) + ((Me.Width / 4) - cuePic3.Width) / 2
cuePic3.Top = Me.Height - cuePic3.Height * 1.5
cuePic3.Picture = LoadPicture(App.path & picPath & "Icon3.bmp")

cuePic4.Height = 0.1 * Me.Width
cuePic4.Width = 0.1 * Me.Width
cuePic4.Left = 3 * (Me.Width / 4) + ((Me.Width / 4) - cuePic4.Width) / 2
cuePic4.Top = Me.Height - cuePic4.Height * 1.5
cuePic4.Picture = LoadPicture(App.path & picPath & "Icon4.bmp")

cueLabel1.Left = 0 * (Me.Width / 4) + ((Me.Width / 4) - cueLabel1.Width) / 2
cueLabel1.Top = Me.Height - cuePic1.Height * 0.5

cueLabel2.Left = 1 * (Me.Width / 4) + ((Me.Width / 4) - cueLabel2.Width) / 2
cueLabel2.Top = Me.Height - cuePic2.Height * 0.5

cueLabel3.Left = 2 * (Me.Width / 4) + ((Me.Width / 4) - cueLabel3.Width) / 2
cueLabel3.Top = Me.Height - cuePic3.Height * 0.5

cueLabel4.Left = 3 * (Me.Width / 4) + ((Me.Width / 4) - cueLabel4.Width) / 2
cueLabel4.Top = Me.Height - cuePic4.Height * 0.5


expImage1.Height = 0.25 * Me.Width
expImage1.Width = 0.25 * Me.Width
expImage1.Left = (Me.Width - expImage1.Width) / 2
expImage1.Top = (Me.Height - expImage1.Height) / 2

expImage2.Height = 0.25 * Me.Width
expImage2.Width = 0.25 * Me.Width
expImage2.Left = (Me.Width - expImage2.Width) / 2
expImage2.Top = (Me.Height - expImage2.Height) / 2

expImage3.Height = 0.25 * Me.Width
expImage3.Width = 0.25 * Me.Width
expImage3.Left = (Me.Width - expImage3.Width) / 2
expImage3.Top = (Me.Height - expImage3.Height) / 2

fixImage.Height = 0.25 * Me.Width
fixImage.Width = 0.25 * Me.Width
fixImage.Left = (Me.Width - fixImage.Width) / 2
fixImage.Top = (Me.Height - fixImage.Height) / 2
fixImage.Picture = LoadPicture(App.path & picPath & "fixation.bmp")

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


