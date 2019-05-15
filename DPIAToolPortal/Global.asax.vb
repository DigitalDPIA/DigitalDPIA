Imports System.Web.Optimization
Imports System.Security.Cryptography
Imports InformationSharingPortal.CookieDetector
Public Class Global_asax
	Inherits HttpApplication
	Private cookieDetect As CookieDetector.cookiedetector
	Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
		' Fires when the application is started
		BundleConfig.RegisterBundles(BundleTable.Bundles)
		AuthConfig.RegisterOpenAuth()
        RouteConfig.RegisterRoutes(RouteTable.Routes)
	End Sub

	Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)
		'' Fires at the beginning of each request
		''Check If it is a new session or not , if not then do the further checks
		'If Request.Cookies("ASP.NET_SessionId") IsNot Nothing AndAlso Request.Cookies("ASP.NET_SessionId").Value IsNot Nothing Then
		'	Dim newSessionID As String = Request.Cookies("ASP.NET_SessionID").Value
		'	'Check the valid length of your Generated Session ID
		'	If newSessionID.Length <= 24 Then
		'		'Log the attack details here

		'	End If

		'	'Genrate Hash key for this User,Browser and machine and match with the Entered NewSessionID
		'	If Not newSessionID.Contains(GenerateHashKey()) Then
		'		'Log the attack details here
		'		Utility.Logout()
		'	End If

		'	'Use the default one so application will work as usual//ASP.NET_SessionId
		'	Request.Cookies("ASP.NET_SessionId").Value = Request.Cookies("ASP.NET_SessionId").Value.Substring(0, 24)
		'End If
		'cookieDetect = New CookieDetector.cookiedetector()
		'' creates a new instance of the private variable for every application request
		'cookieDetect.ProcessRequest(Context)
		'' ensures that it is scoped to only the current request at all times
	End Sub
	Protected Sub Application_EndRequest(sender As Object, e As EventArgs)
		''Pass the custom Session ID to the browser.
		'If Response.Cookies("ASP.NET_SessionId") IsNot Nothing Then
		'	Response.Cookies("ASP.NET_SessionId").Value = Request.Cookies("ASP.NET_SessionId").Value + GenerateHashKey()
		'End If

	End Sub
	Private Function GenerateHashKey() As String
		Dim myStr As New StringBuilder()
		myStr.Append(Request.Browser.Browser)
		myStr.Append(Request.Browser.Platform)
		myStr.Append(Request.Browser.MajorVersion)
		myStr.Append(Request.Browser.MinorVersion)
		'myStr.Append(Request.LogonUserIdentity.User.Value);
		Dim sha As SHA1 = New SHA1CryptoServiceProvider()
		Dim hashdata As Byte() = sha.ComputeHash(Encoding.UTF8.GetBytes(myStr.ToString()))
		Return Convert.ToBase64String(hashdata)
	End Function
	Sub Application_AuthenticateRequest(ByVal sender As Object, ByVal e As EventArgs)
		' Fires upon attempting to authenticate the use
	End Sub

	Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
		Try
			'
			' Send an error email first as that has a good chance of working
			'
			Dim exp As System.Exception = Server.GetLastError
			'
			' Check if the exception has been packaged in another one
			'
			If TypeOf HttpContext.Current.Error Is HttpUnhandledException Then
				exp = exp.GetBaseException		' grab the original exception
			End If
			'
			' Throw away any "remote host closed the connection" errors.
			' We're not concerned about those.
			'
			If exp.Message().Contains("0x800704CD") Or exp.Message().Contains("0x80070057") Then
				Return
			End If
			'
			' Send the error email
			'
			CCommon.LogErrorToEmail(exp)
			'
			' Also log to the database. This might not work if the database isn't functioning,
			' so do it second.
			'
			'CCommon.LogErrorToDatabase(2, 0, exp.ToString, HttpContext.Current.Request)
		Catch ex As Exception

		End Try
	End Sub

	Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
		' Fires when the application ends
	End Sub
End Class