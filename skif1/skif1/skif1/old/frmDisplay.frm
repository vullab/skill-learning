VERSION 5.00
Begin VB.Form frmDisplay 
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   5655
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6270
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   ScaleHeight     =   5655
   ScaleWidth      =   6270
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
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
      Left            =   2160
      TabIndex        =   0
      Top             =   1800
      Visible         =   0   'False
      Width           =   1500
   End
End
Attribute VB_Name = "frmDisplay"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'Voice recognition variables
Dim WithEvents rc As SpSharedRecoContext
Attribute rc.VB_VarHelpID = -1
Dim Grammar As ISpeechRecoGrammar

Dim sLetter(1 To 4) As String           'The Letters to show
Dim sTone(1 To 2) As String             'The tones to play

Dim iLetter As Integer                  'Which letter to show
Dim iTone As Integer                    'Which tone to play

Dim bLetter As Boolean                  'If done showing tone
Dim bTone As Boolean                    'If done playing tone

Dim iReLetter As Integer                'Response to letter task
Dim iReTone As Integer                  'Response to tone task

Dim bKey(1 To 4) As Boolean             'Check if key is held down

Private Sub startExperiment()
iTrialNum = iTrialNum + 1
iReTone = 0
iReLetter = 0
RTs = 0
RT2 = 0

If iTrialNum > iBlockSize Then
    frmInstructions.Visible = True
    Unload Me
    Exit Sub
End If

'Pick a letter and tone
iLetter = Int(Rnd * 4) + 1
iTone = Int(Rnd * 2) + 1

lblDisplay = sLetter(iLetter)

'Do letter task
StartTimer (1)
bLetter = True
lblDisplay.Visible = True
Me.Refresh

PauseMil (200)

'Do Tone task
StartTimer (2)
bTone = True

If iTone = 1 Then
    playLow
Else
    playHigh
End If

End Sub

Private Sub writeData()
Dim sAccuracyLetter As String           'The accuracy of letter task
Dim sAccuracyTone As String             'The accuracy of tone task

'Check accuracy of letter
If iReLetter = iLetter Then
    sAccuracyLetter = "C"
    iCorrect = iCorrect + 1
Else
    sAccuracyLetter = "I"
    iWrong = iWrong + 1
End If

'Check accuracy of tone
If iReTone = iTone Then
    sAccuracyTone = "C"
Else
    sAccuracyTone = "I"
End If

'Add up RT
totalRT = totalRT + RTs

'Open file and save data
Dim filedata As Integer
filedata = OpenAppend(outPutFile)

'"SubID", "Block", "Trial", "Letter", "Tone", _
    "Letter Reponse", "Tone Response", "Letter Accuracy", "Tone Accuracy", _
    "Letter RT", "Tone RT"

PrintToFile filedata, subID, iBlockNum, iTrialNum, sLetter(iLetter), sTone(iTone), _
        sLetter(iReLetter), sTone(iReTone), sAccuracyLetter, sAccuracyTone, _
        Int(RTs), Int(RT2), vbCrLf

Close #filedata
    
PauseMil (1000)
startExperiment
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

If bLetter Then
    If KeyCode = vbKeyV Then
        bLetter = False
        RTs = ReadTimer(1)
        lblDisplay.Visible = False
        bKey(1) = True
    ElseIf KeyCode = vbKeyB Then
        bLetter = False
        RTs = ReadTimer(1)
        lblDisplay.Visible = False
        bKey(2) = True
    ElseIf KeyCode = vbKeyN Then
        bLetter = False
        RTs = ReadTimer(1)
        lblDisplay.Visible = False
        bKey(3) = True
    ElseIf KeyCode = vbKeyM Then
        bLetter = False
        RTs = ReadTimer(1)
        lblDisplay.Visible = False
        bKey(4) = True
    End If
End If

End Sub

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)

If KeyCode = vbKeyV And bKey(1) Then
    bKey(1) = False
    iReLetter = 1
    'write data if subject responded to both task
    If iReTone <> 0 And iReLetter <> 0 Then
        writeData
    End If
ElseIf KeyCode = vbKeyB And bKey(2) Then
    bKey(2) = False
    iReLetter = 2
    'write data if subject responded to both task
    If iReTone <> 0 And iReLetter <> 0 Then
        writeData
    End If
ElseIf KeyCode = vbKeyN And bKey(3) Then
    bKey(3) = False
    iReLetter = 3
    'write data if subject responded to both task
    If iReTone <> 0 And iReLetter <> 0 Then
        writeData
    End If
ElseIf KeyCode = vbKeyM And bKey(4) Then
    bKey(4) = False
    iReLetter = 4
    'write data if subject responded to both task
    If iReTone <> 0 And iReLetter <> 0 Then
        writeData
    End If
End If



End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

'Quit if user presses the Escape button
If KeyAscii = vbKeyEscape Then EndProgram
    
End Sub

Private Sub Form_Load()

'Load Sounds
LoadWavFileLists

'Start Speech Recogn.
InitSR

sLetter(1) = "Q"
sLetter(2) = "V"
sLetter(3) = "X"
sLetter(4) = "B"

sTone(1) = "low"
sTone(2) = "high"

bTone = False
bLetter = False
iReTone = 0
iReLetter = 0


For iLoop = 1 To 4
    bKey(iLoop) = False
Next iLoop

End Sub

Private Sub Form_Activate()
bTone = False
bLetter = False
iReTone = 0
iReLetter = 0

'Display the Cross
lblDisplay = "+"
lblDisplay.Visible = True
Me.Refresh
PauseMil (500)
lblDisplay.Visible = False
Me.Refresh
PauseMil (500)

startExperiment
End Sub

Private Sub Form_Resize()
lblDisplay.Left = (Me.Width - lblDisplay.Width) / 2
lblDisplay.Top = (Me.Height - lblDisplay.Height) / 2
End Sub

Public Sub playHigh()
HighTone.Play DSBPLAY_DEFAULT
End Sub

Public Sub playLow()
LowTone.Play DSBPLAY_DEFAULT
End Sub

Private Sub LoadWavFileLists()
    Dim bufferDesc As DSBUFFERDESC
    Dim waveFormat As WAVEFORMATEX
    bufferDesc.lFlags = DSBCAPS_CTRLFREQUENCY Or DSBCAPS_CTRLPAN Or DSBCAPS_CTRLVOLUME Or DSBCAPS_STATIC

    waveFormat.nFormatTag = WAVE_FORMAT_PCM
    waveFormat.nChannels = 2    '2 channels
    waveFormat.lSamplesPerSec = 22050 '22 hz (i think), only change this if you understand hertz etc.......
    waveFormat.nBitsPerSample = 16  '16 bit rather than 8 bit (Better Quality)
    waveFormat.nBlockAlign = waveFormat.nBitsPerSample / 8 * waveFormat.nChannels
    waveFormat.lAvgBytesPerSec = waveFormat.lSamplesPerSec * waveFormat.nBlockAlign
    
    Set DS = DirectX.DirectSoundCreate("")

    'This checks for any errors, if there are no
    'errors the user has got DX7 and a functional sound card
    If Err.Number <> 0 Then
        MsgBox "Unable to start DirectSound. Check to see that your sound card is properly installed"
        End
    End If

    ' replace frmMain with your form!
    DS.SetCooperativeLevel frmGreet.hWnd, DSSCL_PRIORITY

    Set HighTone = DS.CreateSoundBufferFromFile(App.path & "\high.wav", bufferDesc, waveFormat)
    Set LowTone = DS.CreateSoundBufferFromFile(App.path & "\low.wav", bufferDesc, waveFormat)
End Sub

' Initialize the speech recognition portion of the program
Private Sub InitSR()
    If (rc Is Nothing) Then
        Set rc = New SpSharedRecoContext
        Set Grammar = rc.CreateGrammar(1)
        Grammar.CmdLoadFromFile App.path & "\CC.xml"
        Grammar.DictationSetState SGDSInactive
        Grammar.CmdSetRuleIdState 0, SGDSActive
    End If
End Sub


' Called whenever a word is recognized
Public Sub RC_Recognition( _
ByVal StreamNumber As Long, _
ByVal StreamPosition As Variant, _
ByVal RecognitionType As SpeechRecognitionType, _
ByVal Result As ISpeechRecoResult)

'HandleVoice Result.PhraseInfo.GetText
If bTone Then
    
    bTone = False
    If Result.PhraseInfo.GetText = "low" Then
        iReTone = 1
    ElseIf Result.PhraseInfo.GetText = "high" Then
        iReTone = 2
    End If
    
    'Write data if subject responded to both task
    If iReLetter <> 0 Then
        writeData
    End If
    
End If

End Sub


Private Sub RC_SoundStart(ByVal StreamNumber As Long, ByVal StreamPosition As Variant)

If bTone Then
    RT2 = ReadTimer(2)
End If

End Sub


