Imports Microsoft.AspNet.Membership.OpenAuth
Imports Recaptcha.Web
Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls

Public Class Register
    Inherits Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        RegisterUser.ContinueDestinationPageUrl = Request.QueryString("ReturnUrl")
        'check if a hash code (pwdr) has been passed and set up form if so
        If Not Page.Request.Item("pwdr") Is Nothing Then
            Dim guidHash As New Guid(Page.Request.Item("pwdr"))
            Dim tbUN As TextBox = TryCast(RegisterUserWizardStep.ContentTemplateContainer.FindControl("UserName"), TextBox)
            Dim taOrgUsers As New isporgusersTableAdapters.isp_OrganisationUsersTableAdapter
            Dim tUsers As New isporgusers.isp_OrganisationUsersDataTable
            tUsers = taOrgUsers.GetByHashID(guidHash)
            If tUsers.Count > 0 Then
                Dim pnl As Panel = TryCast(RegisterUserWizardStep.ContentTemplateContainer.FindControl("pnlRegOrgUser"), Panel)
                pnl.Visible = True
                tbUN.Text = tUsers.First.OrganisationUserEmail
                tbUN.Enabled = False
            End If
        End If

        'If Not Page.IsPostBack Then
        'Recaptcha1.
        'ctrlGoogleReCaptcha

        'ctrlGoogleReCaptcha.PublicKey = System.Configuration.ConfigurationManager.AppSettings["recaptchaPublicKey"].ToString();
        'ctrlGoogleReCaptcha.PrivateKey = System.Configuration.ConfigurationManager.AppSettings["recaptchaPrivateKey"].ToString();
        'End If

    End Sub

    Protected Sub RegisterUser_CreatedUser(ByVal sender As Object, ByVal e As EventArgs) Handles RegisterUser.CreatedUser

        Dim continueUrl As String = RegisterUser.ContinueDestinationPageUrl
        If Not Page.Request.Item("user") Is Nothing Then
            continueUrl = "~/account/login.aspx?view=vSelectRole"
            Dim tbUN As TextBox = TryCast(RegisterUserWizardStep.ContentTemplateContainer.FindControl("UserName"), TextBox)
            FormsAuthentication.SetAuthCookie(tbUN.Text, createPersistentCookie:=False)
            Dim userID As New Guid(Membership.GetUser(tbUN.Text).ProviderUserKey.ToString())
            'Dim taq As New InTrayTableAdapters.QueriesTableAdapter
            'Dim nUserID As Integer = CInt(Page.Request.Item("user"))
            'taq.VerifyRegistration(Page.Request.Item("pwdr"), userID)
        Else
            FormsAuthentication.SetAuthCookie(RegisterUser.UserName, createPersistentCookie:=False)
        End If

        If Not OpenAuth.IsLocalUrl(continueUrl) Then
            continueUrl = "~/"
        End If

        Response.Redirect(continueUrl)
    End Sub

    Private Sub RegisterUser_CreateUserError(sender As Object, e As CreateUserErrorEventArgs) Handles RegisterUser.CreateUserError
        Dim Label1 As Label = DirectCast(RegisterUserWizardStep.ContentTemplateContainer.FindControl("lblCreateUserError"), Label)
        Select Case (e.CreateUserError)

            Case MembershipCreateStatus.DuplicateUserName
                Label1.Text = "Username already exists. Please enter a different user name."


            Case MembershipCreateStatus.DuplicateEmail
                Label1.Text = "A username for that e-mail address already exists. Please enter a different e-mail address."


            Case MembershipCreateStatus.InvalidPassword
                Label1.Text = "The password provided is invalid. Please enter a valid password value."


            Case MembershipCreateStatus.InvalidEmail
                Label1.Text = "The e-mail address provided is invalid. Please check the value and try again."


            Case MembershipCreateStatus.InvalidAnswer
                Label1.Text = "The password retrieval answer provided is invalid. Please check the value and try again."


            Case MembershipCreateStatus.InvalidQuestion
                Label1.Text = "The password retrieval question provided is invalid. Please check the value and try again."


            Case MembershipCreateStatus.InvalidUserName
                Label1.Text = "The user name provided is invalid. Please check the value and try again."


            Case MembershipCreateStatus.ProviderError
                Label1.Text = "The authentication provider returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator."


            Case MembershipCreateStatus.UserRejected
                Label1.Text = "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator."

            Case Else
                Label1.Text = "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator."

        End Select
        Label1.Visible = True
    End Sub
   
    Protected Sub RegisterUser_CreatingUser(sender As Object, e As LoginCancelEventArgs) Handles RegisterUser.CreatingUser
        Dim Captcha As GoogleReCaptcha.GoogleReCaptcha = DirectCast(RegisterUserWizardStep.ContentTemplateContainer.FindControl("ctrlGoogleReCaptcha"), GoogleReCaptcha.GoogleReCaptcha)
        Dim CaptchaErrorLabel As Label = DirectCast(RegisterUserWizardStep.ContentTemplateContainer.FindControl("CaptchaErrorLabel"), Label)
        'If Captcha.ToString() = "" Then
        '    CaptchaErrorLabel.Visible = True
        '    CaptchaErrorLabel.Text = "Captcha cannot be empty."
        '    e.Cancel = True
        'Else
        'Dim result As RecaptchaVerificationResult = Captcha.Verify()

        If Captcha.Validate() Then

            'Dim taq As New InTrayTableAdapters.QueriesTableAdapter
            'Dim tbUN As TextBox = TryCast(RegisterUserWizardStep.ContentTemplateContainer.FindControl("UserName"), TextBox)
            'taq.UpdateOrInsertTOUSignedDate(tbUN.Text)

            CaptchaErrorLabel.Visible = False
            CaptchaErrorLabel.Text = ""
        Else
            CaptchaErrorLabel.Visible = True
            CaptchaErrorLabel.Text = "Incorrect captcha response."
            e.Cancel = True

        End If
        'End If
    End Sub
	Protected Sub CheckBoxRequired_ServerValidate(sender As Object, e As ServerValidateEventArgs)
		Dim cbConfirm As CheckBox = DirectCast(RegisterUserWizardStep.ContentTemplateContainer.FindControl("cbConfirm"), CheckBox)
		e.IsValid = cbConfirm.Checked
	End Sub
End Class