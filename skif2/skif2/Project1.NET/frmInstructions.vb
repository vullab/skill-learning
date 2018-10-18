Option Strict Off
Option Explicit On
Friend Class frmInstructions
	Inherits System.Windows.Forms.Form
	Dim picPath As String
	Dim expNum As Short 'Which experiment is next
	Dim Page As Short 'Current page in instructions
	Dim endPage As Short 'Last page of instructions
	'UPGRADE_WARNING: Lower bound of array instruct was changed from 1 to 0. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="0F1C9BE1-AF9D-476E-83B1-17D43BECFF20"'
    Dim instruct(5) As String

	
	'UPGRADE_WARNING: Form event frmInstructions.Activate has a new behavior. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="6BA9B8D2-2A32-4B6E-8D36-44949974A5B4"'
    Private Sub frmInstructions_Activated(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Activated

        iBlockNum = iBlockNum + 1

        'MsgBox(" num = " & iBlockNum)
        'MsgBox("string = " & sOrder(iBlockNum) & " num = " & iBlockNum)


        If sOrder(iBlockNum) = "T" And iBlockNum = 1 Then
            set_Instructions1()
        ElseIf sOrder(iBlockNum) = "T" Then
            set_Instructions2()
        ElseIf sOrder(iBlockNum) = "I" Then
            set_Instructions3()
        ElseIf sOrder(iBlockNum) = "S" Then
            set_Instructions4()
        ElseIf sOrder(iBlockNum) = "P" Then
            set_Instructions6()
        ElseIf sOrder(iBlockNum) = "E" Then
            set_Instructions5()
        End If

        lblInstruct.Text = instruct(1)
        Page = 1


    End Sub


    Private Sub frmInstructions_KeyPress(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles MyBase.KeyPress


        Dim KeyAscii As Short = Asc(eventArgs.KeyChar)
        If KeyAscii = System.Windows.Forms.Keys.Escape Then
            EndProgram()
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
                    Me.Close()
                ElseIf expNum = 2 Then
                    iTrialNum = 0
                    frmInference.Visible = True
                    Me.Close()
                ElseIf expNum = 3 Then
                    iTrialNum = 0
                    frmSkill.Visible = True
                    Me.Close()
                ElseIf expNum = 5 Then
                    iTrialNum = 0
                    frmWait.Visible = True
                    Me.Close()
                ElseIf expNum = 4 Then
                    End
                End If

                GoTo EventExitSub
            End If

            lblInstruct.Text = instruct(Page)
            lblInstruct.Visible = True

            showResponse()

        End If

EventExitSub:
        eventArgs.KeyChar = Chr(KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
    End Sub

    'UPGRADE_WARNING: Event frmInstructions.Resize may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v80/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
    Private Sub frmInstructions_Resize(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Resize

        'MsgBox("We got here 222!")

        picPath = "\images\images\"

        picBack.Top = VB6.TwipsToPixelsY((VB6.PixelsToTwipsY(Me.Height) - VB6.PixelsToTwipsY(picBack.Height)) / 2)
        picBack.Left = VB6.TwipsToPixelsX((VB6.PixelsToTwipsX(Me.Width) - VB6.PixelsToTwipsX(picBack.Width)) / 2)

        cuePic1.Height = VB6.TwipsToPixelsY(0.1 * VB6.PixelsToTwipsX(picBack.Width))
        cuePic1.Width = VB6.TwipsToPixelsX(0.1 * VB6.PixelsToTwipsX(picBack.Width))
        cuePic1.Left = VB6.TwipsToPixelsX(0 * (VB6.PixelsToTwipsX(picBack.Width) / 4) + ((VB6.PixelsToTwipsX(picBack.Width) / 4) - VB6.PixelsToTwipsX(cuePic1.Width)) / 2)
        cuePic1.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(picBack.Height) - VB6.PixelsToTwipsY(cuePic1.Height) * 1.5 - VB6.PixelsToTwipsY(Label4.Height))
        cuePic1.Image = System.Drawing.Image.FromFile(My.Application.Info.DirectoryPath & picPath & "Icon1.bmp")

        cuePic2.Height = VB6.TwipsToPixelsY(0.1 * VB6.PixelsToTwipsX(picBack.Width))
        cuePic2.Width = VB6.TwipsToPixelsX(0.1 * VB6.PixelsToTwipsX(picBack.Width))
        cuePic2.Left = VB6.TwipsToPixelsX(1 * (VB6.PixelsToTwipsX(picBack.Width) / 4) + ((VB6.PixelsToTwipsX(picBack.Width) / 4) - VB6.PixelsToTwipsX(cuePic2.Width)) / 2)
        cuePic2.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(picBack.Height) - VB6.PixelsToTwipsY(cuePic2.Height) * 1.5 - VB6.PixelsToTwipsY(Label4.Height))
        cuePic2.Image = System.Drawing.Image.FromFile(My.Application.Info.DirectoryPath & picPath & "Icon2.bmp")

        cuePic3.Height = VB6.TwipsToPixelsY(0.1 * VB6.PixelsToTwipsX(picBack.Width))
        cuePic3.Width = VB6.TwipsToPixelsX(0.1 * VB6.PixelsToTwipsX(picBack.Width))
        cuePic3.Left = VB6.TwipsToPixelsX(2 * (VB6.PixelsToTwipsX(picBack.Width) / 4) + ((VB6.PixelsToTwipsX(picBack.Width) / 4) - VB6.PixelsToTwipsX(cuePic3.Width)) / 2)
        cuePic3.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(picBack.Height) - VB6.PixelsToTwipsY(cuePic3.Height) * 1.5 - VB6.PixelsToTwipsY(Label4.Height))
        cuePic3.Image = System.Drawing.Image.FromFile(My.Application.Info.DirectoryPath & picPath & "Icon3.bmp")

        cuePic4.Height = VB6.TwipsToPixelsY(0.1 * VB6.PixelsToTwipsX(picBack.Width))
        cuePic4.Width = VB6.TwipsToPixelsX(0.1 * VB6.PixelsToTwipsX(picBack.Width))
        cuePic4.Left = VB6.TwipsToPixelsX(3 * (VB6.PixelsToTwipsX(picBack.Width) / 4) + ((VB6.PixelsToTwipsX(picBack.Width) / 4) - VB6.PixelsToTwipsX(cuePic4.Width)) / 2)
        cuePic4.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(picBack.Height) - VB6.PixelsToTwipsY(cuePic4.Height) * 1.5 - VB6.PixelsToTwipsY(Label4.Height))
        cuePic4.Image = System.Drawing.Image.FromFile(My.Application.Info.DirectoryPath & picPath & "Icon4.bmp")


        cueLabel1.Left = VB6.TwipsToPixelsX(0 * (VB6.PixelsToTwipsX(picBack.Width) / 4) + ((VB6.PixelsToTwipsX(picBack.Width) / 4) - VB6.PixelsToTwipsX(cueLabel1.Width)) / 2)
        cueLabel1.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(picBack.Height) - VB6.PixelsToTwipsY(cuePic1.Height) * 0.5 - VB6.PixelsToTwipsY(Label4.Height))

        cueLabel2.Left = VB6.TwipsToPixelsX(1 * (VB6.PixelsToTwipsX(picBack.Width) / 4) + ((VB6.PixelsToTwipsX(picBack.Width) / 4) - VB6.PixelsToTwipsX(cueLabel2.Width)) / 2)
        cueLabel2.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(picBack.Height) - VB6.PixelsToTwipsY(cuePic2.Height) * 0.5 - VB6.PixelsToTwipsY(Label4.Height))

        cueLabel3.Left = VB6.TwipsToPixelsX(2 * (VB6.PixelsToTwipsX(picBack.Width) / 4) + ((VB6.PixelsToTwipsX(picBack.Width) / 4) - VB6.PixelsToTwipsX(cueLabel3.Width)) / 2)
        cueLabel3.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(picBack.Height) - VB6.PixelsToTwipsY(cuePic3.Height) * 0.5 - VB6.PixelsToTwipsY(Label4.Height))

        cueLabel4.Left = VB6.TwipsToPixelsX(3 * (VB6.PixelsToTwipsX(picBack.Width) / 4) + ((VB6.PixelsToTwipsX(picBack.Width) / 4) - VB6.PixelsToTwipsX(cueLabel4.Width)) / 2)
        cueLabel4.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(picBack.Height) - VB6.PixelsToTwipsY(cuePic4.Height) * 0.5 - VB6.PixelsToTwipsY(Label4.Height))

        Label4.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(picBack.Height) - VB6.PixelsToTwipsY(Label4.Height))


        showResponse()


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

        'MsgBox("We got here 223!")

    End Sub

    '1st set of instructions
    Public Sub set_Instructions1()
        instruct(1) = "You will see one of four symbols on each trial, shown below. "
        instruct(1) = instruct(1) & NextLine()
        instruct(1) = instruct(1) & "We want you to respond by pressing one of the four keys on the bottom row of the keyboard. "
        instruct(1) = instruct(1) & "Each key (Z, X, N, M) corresponds to one of the symbols, as shown below. "
        instruct(1) = instruct(1) & "So if you see a smiley face, press the 'Z' key. And so on."
        instruct(1) = instruct(1) & "Throughout the experiment, please keep your fingers on the keyboard. "
        instruct(1) = instruct(1) & "Use your left middle and index fingers for the leftmost response keys (Z and X), "
        instruct(1) = instruct(1) & "and your right index and middle fingers for the rightmost keys (N and M). "
        instruct(1) = instruct(1) & NextLine() & NextLine()
        instruct(1) = instruct(1) & "The symbols will be presented on an irrelevant background; you can ignore the background shape and color."
        instruct(1) = instruct(1) & NextLine() & NextLine()
        instruct(1) = instruct(1) & "We siply want you to respond extremely rapidly to the symbol.  "
        instruct(1) = instruct(1) & "Try to be accurate, but the machine will insist that you respond so quickly to the letter that you will make many errors. "
        instruct(1) = instruct(1) & "Every few minutes there will be a break in the experiment.  During the break, the computer will tell you how you're doing."

        expNum = 1
        endPage = 1

    End Sub

    'Between block instructions
    Public Sub set_Instructions2()

        Dim averageRT As Short
        Dim iPError As Short

        averageRT = Int(totalRT / nTrainingBlockTrials)
        iPError = Int(iWrong / (iWrong + iCorrect) * 100)

        instruct(1) = "Your average RT is " & averageRT & "." & NextLine() & NextLine()

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

        Label4.Text = "Press Space To Begin"

        expNum = 2
        endPage = 1

    End Sub

    'End
    Public Sub set_Instructions4()
        instruct(1) = "Great, you will now be presented with more trials where your objective is to identify the symbol as quickly as possible. "
        instruct(1) = instruct(1) & "Again, you can ignore the background colors, simply try to press the key associated with the symbol as soon as it appears. "
        instruct(1) = instruct(1) & "And again, please try to respond as quickly and accurately as possible. "

        Label4.Text = "Press Space To Begin"

        expNum = 3
        endPage = 1

    End Sub


    Public Sub set_Instructions5()
        instruct(1) = "You have completed the experiment. Thank you for your participation."

        Label4.Text = "Press Space To End"

        expNum = 4
        endPage = 1

    End Sub

    Public Sub set_Instructions6()
        instruct(1) = "The experiment requires a 6 minute pause before we continue, please press the spacebar to continue on to the waiting interval ."

        expNum = 5
        endPage = 1

    End Sub
End Class