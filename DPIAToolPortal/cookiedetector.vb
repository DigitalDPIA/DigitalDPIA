Imports System.Collections.Generic
Imports System.Configuration
Imports System.Linq
Imports System.Text
Imports System.Web

Namespace CookieDetector
	Public Class cookiedetector
		Implements IHttpHandler
		Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
			Get
				Return False
			End Get
		End Property

		Public Sub ProcessRequest(context As HttpContext) Implements IHttpHandler.ProcessRequest
			Dim requestedPath As String = context.Request.AppRelativeCurrentExecutionFilePath
			If requestedPath.Contains(ConfigurationManager.AppSettings("CookieDetectionPage")) OrElse requestedPath.Contains(ConfigurationManager.AppSettings("CookieFailPage")) Then
				Return
			Else
				If Not context.Request.Cookies.AllKeys.Contains("CookieCheck") Then
					Dim cookieCheck As New HttpCookie("CookieCheck", "Detected")
					cookieCheck.Expires = DateTime.Now.AddYears(5)
					context.Response.Cookies.Add(cookieCheck)
					context.Response.Redirect(ConfigurationManager.AppSettings("CookieDetectionPage") + "?ref=" + requestedPath.Remove(0, 2))
				End If
			End If
		End Sub
	End Class
End Namespace
