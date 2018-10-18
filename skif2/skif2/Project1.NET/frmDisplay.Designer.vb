<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class frmDisplay
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
	Public WithEvents cueLabel1 As System.Windows.Forms.Label
	Public WithEvents cueLabel4 As System.Windows.Forms.Label
	Public WithEvents cueLabel3 As System.Windows.Forms.Label
	Public WithEvents cueLabel2 As System.Windows.Forms.Label
	Public WithEvents expImage3 As System.Windows.Forms.PictureBox
	Public WithEvents fixImage As System.Windows.Forms.PictureBox
	Public WithEvents cuePic4 As System.Windows.Forms.PictureBox
	Public WithEvents cuePic3 As System.Windows.Forms.PictureBox
	Public WithEvents cuePic2 As System.Windows.Forms.PictureBox
	Public WithEvents cuePic1 As System.Windows.Forms.PictureBox
	Public WithEvents lblDisplay As System.Windows.Forms.Label
	Public WithEvents expImage2 As System.Windows.Forms.PictureBox
	Public WithEvents expImage1 As System.Windows.Forms.PictureBox
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(frmDisplay))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.cueLabel1 = New System.Windows.Forms.Label
		Me.cueLabel4 = New System.Windows.Forms.Label
		Me.cueLabel3 = New System.Windows.Forms.Label
		Me.cueLabel2 = New System.Windows.Forms.Label
		Me.expImage3 = New System.Windows.Forms.PictureBox
		Me.fixImage = New System.Windows.Forms.PictureBox
		Me.cuePic4 = New System.Windows.Forms.PictureBox
		Me.cuePic3 = New System.Windows.Forms.PictureBox
		Me.cuePic2 = New System.Windows.Forms.PictureBox
		Me.cuePic1 = New System.Windows.Forms.PictureBox
		Me.lblDisplay = New System.Windows.Forms.Label
		Me.expImage2 = New System.Windows.Forms.PictureBox
		Me.expImage1 = New System.Windows.Forms.PictureBox
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		Me.BackColor = System.Drawing.SystemColors.Window
		Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
		Me.Text = "Form1"
		Me.ClientSize = New System.Drawing.Size(773, 659)
		Me.Location = New System.Drawing.Point(0, 0)
		Me.KeyPreview = True
		Me.ShowInTaskbar = False
		Me.StartPosition = System.Windows.Forms.FormStartPosition.WindowsDefaultLocation
		Me.WindowState = System.Windows.Forms.FormWindowState.Maximized
		Me.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		Me.ControlBox = True
		Me.Enabled = True
		Me.MaximizeBox = True
		Me.MinimizeBox = True
		Me.Cursor = System.Windows.Forms.Cursors.Default
		Me.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.HelpButton = False
		Me.Name = "frmDisplay"
		Me.cueLabel1.TextAlign = System.Drawing.ContentAlignment.TopCenter
		Me.cueLabel1.BackColor = System.Drawing.Color.White
		Me.cueLabel1.Text = "Z"
		Me.cueLabel1.Font = New System.Drawing.Font("Arial", 24!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cueLabel1.Size = New System.Drawing.Size(57, 33)
		Me.cueLabel1.Location = New System.Drawing.Point(24, 536)
		Me.cueLabel1.TabIndex = 4
		Me.cueLabel1.Enabled = True
		Me.cueLabel1.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cueLabel1.Cursor = System.Windows.Forms.Cursors.Default
		Me.cueLabel1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cueLabel1.UseMnemonic = True
		Me.cueLabel1.Visible = True
		Me.cueLabel1.AutoSize = False
		Me.cueLabel1.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.cueLabel1.Name = "cueLabel1"
		Me.cueLabel4.TextAlign = System.Drawing.ContentAlignment.TopCenter
		Me.cueLabel4.BackColor = System.Drawing.Color.White
		Me.cueLabel4.Text = "M"
		Me.cueLabel4.Font = New System.Drawing.Font("Arial", 24!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cueLabel4.Size = New System.Drawing.Size(33, 33)
		Me.cueLabel4.Location = New System.Drawing.Point(400, 528)
		Me.cueLabel4.TabIndex = 3
		Me.cueLabel4.Enabled = True
		Me.cueLabel4.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cueLabel4.Cursor = System.Windows.Forms.Cursors.Default
		Me.cueLabel4.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cueLabel4.UseMnemonic = True
		Me.cueLabel4.Visible = True
		Me.cueLabel4.AutoSize = False
		Me.cueLabel4.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.cueLabel4.Name = "cueLabel4"
		Me.cueLabel3.TextAlign = System.Drawing.ContentAlignment.TopCenter
		Me.cueLabel3.BackColor = System.Drawing.Color.White
		Me.cueLabel3.Text = "N"
		Me.cueLabel3.Font = New System.Drawing.Font("Arial", 24!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cueLabel3.Size = New System.Drawing.Size(57, 33)
		Me.cueLabel3.Location = New System.Drawing.Point(248, 520)
		Me.cueLabel3.TabIndex = 2
		Me.cueLabel3.Enabled = True
		Me.cueLabel3.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cueLabel3.Cursor = System.Windows.Forms.Cursors.Default
		Me.cueLabel3.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cueLabel3.UseMnemonic = True
		Me.cueLabel3.Visible = True
		Me.cueLabel3.AutoSize = False
		Me.cueLabel3.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.cueLabel3.Name = "cueLabel3"
		Me.cueLabel2.TextAlign = System.Drawing.ContentAlignment.TopCenter
		Me.cueLabel2.BackColor = System.Drawing.Color.White
		Me.cueLabel2.Text = "X"
		Me.cueLabel2.Font = New System.Drawing.Font("Arial", 24!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cueLabel2.Size = New System.Drawing.Size(57, 33)
		Me.cueLabel2.Location = New System.Drawing.Point(144, 544)
		Me.cueLabel2.TabIndex = 1
		Me.cueLabel2.Enabled = True
		Me.cueLabel2.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cueLabel2.Cursor = System.Windows.Forms.Cursors.Default
		Me.cueLabel2.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cueLabel2.UseMnemonic = True
		Me.cueLabel2.Visible = True
		Me.cueLabel2.AutoSize = False
		Me.cueLabel2.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.cueLabel2.Name = "cueLabel2"
		Me.expImage3.Size = New System.Drawing.Size(136, 152)
		Me.expImage3.Location = New System.Drawing.Point(96, 0)
		Me.expImage3.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage
		Me.expImage3.Visible = False
		Me.expImage3.Enabled = True
		Me.expImage3.Cursor = System.Windows.Forms.Cursors.Default
		Me.expImage3.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.expImage3.Name = "expImage3"
		Me.fixImage.Size = New System.Drawing.Size(136, 152)
		Me.fixImage.Location = New System.Drawing.Point(432, 112)
		Me.fixImage.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage
		Me.fixImage.Visible = False
		Me.fixImage.Enabled = True
		Me.fixImage.Cursor = System.Windows.Forms.Cursors.Default
		Me.fixImage.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.fixImage.Name = "fixImage"
		Me.cuePic4.Size = New System.Drawing.Size(72, 88)
		Me.cuePic4.Location = New System.Drawing.Point(344, 368)
		Me.cuePic4.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage
		Me.cuePic4.Enabled = True
		Me.cuePic4.Cursor = System.Windows.Forms.Cursors.Default
		Me.cuePic4.Visible = True
		Me.cuePic4.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.cuePic4.Name = "cuePic4"
		Me.cuePic3.Size = New System.Drawing.Size(72, 88)
		Me.cuePic3.Location = New System.Drawing.Point(232, 384)
		Me.cuePic3.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage
		Me.cuePic3.Enabled = True
		Me.cuePic3.Cursor = System.Windows.Forms.Cursors.Default
		Me.cuePic3.Visible = True
		Me.cuePic3.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.cuePic3.Name = "cuePic3"
		Me.cuePic2.Size = New System.Drawing.Size(72, 88)
		Me.cuePic2.Location = New System.Drawing.Point(120, 368)
		Me.cuePic2.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage
		Me.cuePic2.Enabled = True
		Me.cuePic2.Cursor = System.Windows.Forms.Cursors.Default
		Me.cuePic2.Visible = True
		Me.cuePic2.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.cuePic2.Name = "cuePic2"
		Me.cuePic1.Size = New System.Drawing.Size(72, 88)
		Me.cuePic1.Location = New System.Drawing.Point(24, 376)
		Me.cuePic1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage
		Me.cuePic1.Enabled = True
		Me.cuePic1.Cursor = System.Windows.Forms.Cursors.Default
		Me.cuePic1.Visible = True
		Me.cuePic1.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.cuePic1.Name = "cuePic1"
		Me.lblDisplay.TextAlign = System.Drawing.ContentAlignment.TopCenter
		Me.lblDisplay.Text = "+"
		Me.lblDisplay.Font = New System.Drawing.Font("Arial", 72!, System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblDisplay.Size = New System.Drawing.Size(100, 100)
		Me.lblDisplay.Location = New System.Drawing.Point(152, 144)
		Me.lblDisplay.TabIndex = 0
		Me.lblDisplay.Visible = False
		Me.lblDisplay.BackColor = System.Drawing.SystemColors.Control
		Me.lblDisplay.Enabled = True
		Me.lblDisplay.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblDisplay.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblDisplay.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblDisplay.UseMnemonic = True
		Me.lblDisplay.AutoSize = False
		Me.lblDisplay.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblDisplay.Name = "lblDisplay"
		Me.expImage2.Size = New System.Drawing.Size(136, 152)
		Me.expImage2.Location = New System.Drawing.Point(256, 112)
		Me.expImage2.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage
		Me.expImage2.Enabled = True
		Me.expImage2.Cursor = System.Windows.Forms.Cursors.Default
		Me.expImage2.Visible = True
		Me.expImage2.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.expImage2.Name = "expImage2"
		Me.expImage1.Size = New System.Drawing.Size(136, 152)
		Me.expImage1.Location = New System.Drawing.Point(0, 112)
		Me.expImage1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage
		Me.expImage1.Enabled = True
		Me.expImage1.Cursor = System.Windows.Forms.Cursors.Default
		Me.expImage1.Visible = True
		Me.expImage1.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.expImage1.Name = "expImage1"
		Me.Controls.Add(cueLabel1)
		Me.Controls.Add(cueLabel4)
		Me.Controls.Add(cueLabel3)
		Me.Controls.Add(cueLabel2)
		Me.Controls.Add(expImage3)
		Me.Controls.Add(fixImage)
		Me.Controls.Add(cuePic4)
		Me.Controls.Add(cuePic3)
		Me.Controls.Add(cuePic2)
		Me.Controls.Add(cuePic1)
		Me.Controls.Add(lblDisplay)
		Me.Controls.Add(expImage2)
		Me.Controls.Add(expImage1)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class