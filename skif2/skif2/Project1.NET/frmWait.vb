Option Strict Off
Option Explicit On
Friend Class frmWait
	Inherits System.Windows.Forms.Form
	
	Private Sub startExperiment()
		PauseMil((6000))
		frmInstructions.Visible = True
		Me.Close()
		Exit Sub
	End Sub
	
	
	Private Sub frmWait_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles MyBase.KeyPress
		Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
		
		'Quit if user presses the Escape button
		If KeyAscii = System.Windows.Forms.Keys.Escape Then EndProgram()
		
		eventArgs.KeyChar = Chr(KeyAscii)
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
	End Sub
	'UPGRADE_WARNING: Form event frmWait.Activate has a new behavior. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6BA9B8D2-2A32-4B6E-8D36-44949974A5B4"'
	Private Sub frmWait_Activated(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Activated
		startExperiment()
	End Sub
End Class