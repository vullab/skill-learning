<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class frmGreet
#Region "Windows Form Designer generated code "
	<System.Diagnostics.DebuggerNonUserCode()> Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
	End Sub
	'Form overrides dispose to clean up the component list.
	<System.Diagnostics.DebuggerNonUserCode()> Protected Overloads Overrides Sub Dispose(ByVal Disposing As Boolean)
		If Disposing Then
			If Not components Is Nothing Then
				components.Dispose()
			End If
		End If
		MyBase.Dispose(Disposing)
	End Sub
	'Required by the Windows Form Designer
	Private components As System.ComponentModel.IContainer
	Public ToolTip1 As System.Windows.Forms.ToolTip
	Public WithEvents txtSubID As System.Windows.Forms.TextBox
	Public WithEvents txtSubIn As System.Windows.Forms.TextBox
	Public WithEvents cmdStart As System.Windows.Forms.Button
	Public WithEvents _optOC_1 As System.Windows.Forms.RadioButton
	Public WithEvents _optOC_2 As System.Windows.Forms.RadioButton
	Public WithEvents fmeCondition As System.Windows.Forms.GroupBox
	Public WithEvents lblSubID As System.Windows.Forms.Label
	Public WithEvents lblSubInitials As System.Windows.Forms.Label
	Public WithEvents Label2 As System.Windows.Forms.Label
	Public WithEvents lblNumbersOnly As System.Windows.Forms.Label
	Public WithEvents lblLettersOnly As System.Windows.Forms.Label
	Public WithEvents picBack As System.Windows.Forms.Panel
	Public WithEvents Label1 As System.Windows.Forms.Label
	Public WithEvents optOC As Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(frmGreet))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.picBack = New System.Windows.Forms.Panel
		Me.txtSubID = New System.Windows.Forms.TextBox
		Me.txtSubIn = New System.Windows.Forms.TextBox
		Me.cmdStart = New System.Windows.Forms.Button
		Me.fmeCondition = New System.Windows.Forms.GroupBox
		Me._optOC_1 = New System.Windows.Forms.RadioButton
		Me._optOC_2 = New System.Windows.Forms.RadioButton
		Me.lblSubID = New System.Windows.Forms.Label
		Me.lblSubInitials = New System.Windows.Forms.Label
		Me.Label2 = New System.Windows.Forms.Label
		Me.lblNumbersOnly = New System.Windows.Forms.Label
		Me.lblLettersOnly = New System.Windows.Forms.Label
		Me.Label1 = New System.Windows.Forms.Label
		Me.optOC = New Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray(components)
		Me.picBack.SuspendLayout()
		Me.fmeCondition.SuspendLayout()
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		CType(Me.optOC, System.ComponentModel.ISupportInitialize).BeginInit()
		Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
		Me.Text = "Form1"
		Me.ClientSize = New System.Drawing.Size(804, 565)
		Me.Location = New System.Drawing.Point(0, 0)
		Me.KeyPreview = True
		Me.ShowInTaskbar = False
		Me.StartPosition = System.Windows.Forms.FormStartPosition.WindowsDefaultLocation
		Me.WindowState = System.Windows.Forms.FormWindowState.Maximized
		Me.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		Me.BackColor = System.Drawing.SystemColors.Control
		Me.ControlBox = True
		Me.Enabled = True
		Me.MaximizeBox = True
		Me.MinimizeBox = True
		Me.Cursor = System.Windows.Forms.Cursors.Default
		Me.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.HelpButton = False
		Me.Name = "frmGreet"
		Me.picBack.Size = New System.Drawing.Size(663, 439)
		Me.picBack.Location = New System.Drawing.Point(40, 48)
		Me.picBack.TabIndex = 0
		Me.picBack.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.picBack.Dock = System.Windows.Forms.DockStyle.None
		Me.picBack.BackColor = System.Drawing.SystemColors.Control
		Me.picBack.CausesValidation = True
		Me.picBack.Enabled = True
		Me.picBack.ForeColor = System.Drawing.SystemColors.ControlText
		Me.picBack.Cursor = System.Windows.Forms.Cursors.Default
		Me.picBack.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.picBack.TabStop = True
		Me.picBack.Visible = True
		Me.picBack.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.picBack.Name = "picBack"
		Me.txtSubID.AutoSize = False
		Me.txtSubID.Font = New System.Drawing.Font("Arial", 13.5!, System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtSubID.Size = New System.Drawing.Size(79, 33)
		Me.txtSubID.Location = New System.Drawing.Point(334, 136)
		Me.txtSubID.Maxlength = 3
		Me.txtSubID.TabIndex = 6
		Me.txtSubID.AcceptsReturn = True
		Me.txtSubID.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtSubID.BackColor = System.Drawing.SystemColors.Window
		Me.txtSubID.CausesValidation = True
		Me.txtSubID.Enabled = True
		Me.txtSubID.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtSubID.HideSelection = True
		Me.txtSubID.ReadOnly = False
		Me.txtSubID.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtSubID.MultiLine = False
		Me.txtSubID.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtSubID.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtSubID.TabStop = True
		Me.txtSubID.Visible = True
		Me.txtSubID.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtSubID.Name = "txtSubID"
		Me.txtSubIn.AutoSize = False
		Me.txtSubIn.Font = New System.Drawing.Font("Arial", 13.5!, System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.txtSubIn.Size = New System.Drawing.Size(79, 33)
		Me.txtSubIn.Location = New System.Drawing.Point(334, 188)
		Me.txtSubIn.Maxlength = 3
		Me.txtSubIn.TabIndex = 5
		Me.txtSubIn.AcceptsReturn = True
		Me.txtSubIn.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.txtSubIn.BackColor = System.Drawing.SystemColors.Window
		Me.txtSubIn.CausesValidation = True
		Me.txtSubIn.Enabled = True
		Me.txtSubIn.ForeColor = System.Drawing.SystemColors.WindowText
		Me.txtSubIn.HideSelection = True
		Me.txtSubIn.ReadOnly = False
		Me.txtSubIn.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.txtSubIn.MultiLine = False
		Me.txtSubIn.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.txtSubIn.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.txtSubIn.TabStop = True
		Me.txtSubIn.Visible = True
		Me.txtSubIn.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.txtSubIn.Name = "txtSubIn"
		Me.cmdStart.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cmdStart.Text = "Start"
		Me.cmdStart.Enabled = False
		Me.cmdStart.Font = New System.Drawing.Font("Arial", 14.25!, System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmdStart.Size = New System.Drawing.Size(81, 33)
		Me.cmdStart.Location = New System.Drawing.Point(320, 320)
		Me.cmdStart.TabIndex = 4
		Me.cmdStart.BackColor = System.Drawing.SystemColors.Control
		Me.cmdStart.CausesValidation = True
		Me.cmdStart.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cmdStart.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmdStart.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmdStart.TabStop = True
		Me.cmdStart.Name = "cmdStart"
		Me.fmeCondition.Text = "Condition"
		Me.fmeCondition.Font = New System.Drawing.Font("Arial", 14.25!, System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.fmeCondition.Size = New System.Drawing.Size(135, 67)
		Me.fmeCondition.Location = New System.Drawing.Point(296, 232)
		Me.fmeCondition.TabIndex = 1
		Me.fmeCondition.Visible = False
		Me.fmeCondition.BackColor = System.Drawing.SystemColors.Control
		Me.fmeCondition.Enabled = True
		Me.fmeCondition.ForeColor = System.Drawing.SystemColors.ControlText
		Me.fmeCondition.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.fmeCondition.Name = "fmeCondition"
		Me._optOC_1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me._optOC_1.Text = "1"
		Me._optOC_1.Font = New System.Drawing.Font("Arial", 12!, System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._optOC_1.Size = New System.Drawing.Size(39, 23)
		Me._optOC_1.Location = New System.Drawing.Point(24, 32)
		Me._optOC_1.TabIndex = 3
		Me._optOC_1.Checked = True
		Me._optOC_1.CheckAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me._optOC_1.BackColor = System.Drawing.SystemColors.Control
		Me._optOC_1.CausesValidation = True
		Me._optOC_1.Enabled = True
		Me._optOC_1.ForeColor = System.Drawing.SystemColors.ControlText
		Me._optOC_1.Cursor = System.Windows.Forms.Cursors.Default
		Me._optOC_1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._optOC_1.Appearance = System.Windows.Forms.Appearance.Normal
		Me._optOC_1.TabStop = True
		Me._optOC_1.Visible = True
		Me._optOC_1.Name = "_optOC_1"
		Me._optOC_2.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me._optOC_2.Text = "2"
		Me._optOC_2.Font = New System.Drawing.Font("Arial", 12!, System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._optOC_2.Size = New System.Drawing.Size(39, 23)
		Me._optOC_2.Location = New System.Drawing.Point(67, 32)
		Me._optOC_2.TabIndex = 2
		Me._optOC_2.CheckAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me._optOC_2.BackColor = System.Drawing.SystemColors.Control
		Me._optOC_2.CausesValidation = True
		Me._optOC_2.Enabled = True
		Me._optOC_2.ForeColor = System.Drawing.SystemColors.ControlText
		Me._optOC_2.Cursor = System.Windows.Forms.Cursors.Default
		Me._optOC_2.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._optOC_2.Appearance = System.Windows.Forms.Appearance.Normal
		Me._optOC_2.TabStop = True
		Me._optOC_2.Checked = False
		Me._optOC_2.Visible = True
		Me._optOC_2.Name = "_optOC_2"
		Me.lblSubID.TextAlign = System.Drawing.ContentAlignment.TopRight
		Me.lblSubID.Text = "Subject ID"
		Me.lblSubID.Font = New System.Drawing.Font("Arial", 13.5!, System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblSubID.Size = New System.Drawing.Size(137, 33)
		Me.lblSubID.Location = New System.Drawing.Point(182, 140)
		Me.lblSubID.TabIndex = 11
		Me.lblSubID.BackColor = System.Drawing.SystemColors.Control
		Me.lblSubID.Enabled = True
		Me.lblSubID.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblSubID.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblSubID.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblSubID.UseMnemonic = True
		Me.lblSubID.Visible = True
		Me.lblSubID.AutoSize = False
		Me.lblSubID.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblSubID.Name = "lblSubID"
		Me.lblSubInitials.TextAlign = System.Drawing.ContentAlignment.TopRight
		Me.lblSubInitials.Text = "Subject Initials"
		Me.lblSubInitials.Font = New System.Drawing.Font("Arial", 13.5!, System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblSubInitials.Size = New System.Drawing.Size(185, 33)
		Me.lblSubInitials.Location = New System.Drawing.Point(134, 192)
		Me.lblSubInitials.TabIndex = 10
		Me.lblSubInitials.BackColor = System.Drawing.SystemColors.Control
		Me.lblSubInitials.Enabled = True
		Me.lblSubInitials.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblSubInitials.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblSubInitials.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblSubInitials.UseMnemonic = True
		Me.lblSubInitials.Visible = True
		Me.lblSubInitials.AutoSize = False
		Me.lblSubInitials.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblSubInitials.Name = "lblSubInitials"
		Me.Label2.TextAlign = System.Drawing.ContentAlignment.TopCenter
		Me.Label2.BackColor = System.Drawing.Color.Transparent
		Me.Label2.Text = "Welcome  please enter subject information:"
		Me.Label2.Font = New System.Drawing.Font("Arial", 24!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.Label2.Size = New System.Drawing.Size(681, 49)
		Me.Label2.Location = New System.Drawing.Point(-6, 48)
		Me.Label2.TabIndex = 9
		Me.Label2.Enabled = True
		Me.Label2.ForeColor = System.Drawing.SystemColors.ControlText
		Me.Label2.Cursor = System.Windows.Forms.Cursors.Default
		Me.Label2.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.Label2.UseMnemonic = True
		Me.Label2.Visible = True
		Me.Label2.AutoSize = False
		Me.Label2.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.Label2.Name = "Label2"
		Me.lblNumbersOnly.Text = "(Numbers Only!)"
		Me.lblNumbersOnly.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblNumbersOnly.Size = New System.Drawing.Size(91, 13)
		Me.lblNumbersOnly.Location = New System.Drawing.Point(426, 146)
		Me.lblNumbersOnly.TabIndex = 8
		Me.lblNumbersOnly.Visible = False
		Me.lblNumbersOnly.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblNumbersOnly.BackColor = System.Drawing.SystemColors.Control
		Me.lblNumbersOnly.Enabled = True
		Me.lblNumbersOnly.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblNumbersOnly.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblNumbersOnly.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblNumbersOnly.UseMnemonic = True
		Me.lblNumbersOnly.AutoSize = True
		Me.lblNumbersOnly.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblNumbersOnly.Name = "lblNumbersOnly"
		Me.lblLettersOnly.Text = "(Letters Only!)"
		Me.lblLettersOnly.Font = New System.Drawing.Font("Arial", 8.25!, System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblLettersOnly.Size = New System.Drawing.Size(81, 13)
		Me.lblLettersOnly.Location = New System.Drawing.Point(428, 196)
		Me.lblLettersOnly.TabIndex = 7
		Me.lblLettersOnly.Visible = False
		Me.lblLettersOnly.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblLettersOnly.BackColor = System.Drawing.SystemColors.Control
		Me.lblLettersOnly.Enabled = True
		Me.lblLettersOnly.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblLettersOnly.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblLettersOnly.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblLettersOnly.UseMnemonic = True
		Me.lblLettersOnly.AutoSize = True
		Me.lblLettersOnly.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblLettersOnly.Name = "lblLettersOnly"
		Me.Label1.Text = "SkIf1"
		Me.Label1.Font = New System.Drawing.Font("Arial", 12!, System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.Label1.Size = New System.Drawing.Size(38, 19)
		Me.Label1.Location = New System.Drawing.Point(0, 0)
		Me.Label1.TabIndex = 12
		Me.Label1.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.Label1.BackColor = System.Drawing.SystemColors.Control
		Me.Label1.Enabled = True
		Me.Label1.ForeColor = System.Drawing.SystemColors.ControlText
		Me.Label1.Cursor = System.Windows.Forms.Cursors.Default
		Me.Label1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.Label1.UseMnemonic = True
		Me.Label1.Visible = True
		Me.Label1.AutoSize = True
		Me.Label1.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.Label1.Name = "Label1"
		Me.Controls.Add(picBack)
		Me.Controls.Add(Label1)
		Me.picBack.Controls.Add(txtSubID)
		Me.picBack.Controls.Add(txtSubIn)
		Me.picBack.Controls.Add(cmdStart)
		Me.picBack.Controls.Add(fmeCondition)
		Me.picBack.Controls.Add(lblSubID)
		Me.picBack.Controls.Add(lblSubInitials)
		Me.picBack.Controls.Add(Label2)
		Me.picBack.Controls.Add(lblNumbersOnly)
		Me.picBack.Controls.Add(lblLettersOnly)
		Me.fmeCondition.Controls.Add(_optOC_1)
		Me.fmeCondition.Controls.Add(_optOC_2)
		Me.optOC.SetIndex(_optOC_1, CType(1, Short))
		Me.optOC.SetIndex(_optOC_2, CType(2, Short))
		CType(Me.optOC, System.ComponentModel.ISupportInitialize).EndInit()
		Me.picBack.ResumeLayout(False)
		Me.fmeCondition.ResumeLayout(False)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class