VERSION 5.00
Begin VB.Form frmWait 
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
   Begin VB.Label Label1 
      BackColor       =   &H80000009&
      Caption         =   "Please wait, the experiment will resume shortly."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3615
      Left            =   1560
      TabIndex        =   0
      Top             =   1680
      Width           =   5175
   End
End
Attribute VB_Name = "frmWait"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub startExperiment()
PauseMil (6000)
frmInstructions.Visible = True
Unload Me
Exit Sub
End Sub


Private Sub Form_KeyPress(KeyAscii As Integer)

'Quit if user presses the Escape button
If KeyAscii = vbKeyEscape Then EndProgram
    
End Sub
Private Sub Form_Activate()
startExperiment
End Sub

