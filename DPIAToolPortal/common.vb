Public Class CCommon
#Region "JSON"
    Public Shared Function DataTableToJSON(ByVal dt As DataTable) As String
        Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer()
        serializer.MaxJsonLength = 1024000
        Dim rows As New List(Of Dictionary(Of String, Object))()
        Dim row As Dictionary(Of String, Object)
        For Each dr As DataRow In dt.Rows
            row = New Dictionary(Of String, Object)()
            For Each col As DataColumn In dt.Columns
                row.Add(col.ColumnName, dr(col))
            Next
            rows.Add(row)
        Next
        Return serializer.Serialize(rows)
    End Function
#End Region
#Region "ERROR LOGGING"
	''' <summary>
	''' Log exception error to email
	''' </summary>
	''' <param name="exp">Exception to log</param>
	''' <remarks>Doesn't use the database</remarks>
	Public Shared Sub LogErrorToEmail(ByVal exp As Exception)
		'
		' Decide whether an error message should be sent.
		' Default is Yes.
		'
		Dim bLogError As Boolean = True

		Try
			bLogError = Boolean.Parse(ConfigurationManager.AppSettings("EnableErrorLogEmail"))
		Catch ex As Exception
		End Try

		If Not bLogError Then
			Return															' error email logging is turned off
		End If
		'
		' Decide who it should be sent to. Default values are set here
		' in case the values are not in web.config.
		'
		Dim sTo As String = "kevin.whittaker@mbhci.nhs.uk"
		Dim sCC As String = ""

		Try
			Dim sTestTo As String
            sTestTo = My.Settings("ErrorLogEmailTo")
            If Not sTestTo Is Nothing Then
				sTo = sTestTo
			End If
		Catch ex As Exception
		End Try
		Try
			Dim sTestCC As String
            sTestCC = My.Settings("ErrorLogEmailCC")
            If Not sTestCC Is Nothing Then
				sCC = sTestCC
			End If
		Catch ex As Exception
		End Try
		'
		' Have addressing information, proceed with getting the error message and sending it.
		' Any unexpected exceptions causes the error message to be truncated. We send what we can
		'
		Dim errorMessage As New Text.StringBuilder
		Try
			'
			' Build the error message
			'
			Dim context As System.Web.HttpContext = System.Web.HttpContext.Current

            errorMessage.Append("<b>Data Protection Impact Assessment Tool Error Report</b> generated on " + DateTime.Now.ToString("dd MMMM yyyy HH:mm:ss"))
            errorMessage.Append("<br/><br/><b>Message:</b> " + exp.Message)
			errorMessage.Append("<br/><br/><b>Page location:</b> " + context.Request.RawUrl)
			errorMessage.Append("<br/><br/><b>Source:</b> " + context.Request.ServerVariables("SERVER_NAME").ToLower())
			errorMessage.Append("<br/><br/><b>Client Details:</b>")
			errorMessage.Append("<br/><div style='margin-left:50px;'><b>IP:</b> " + GetClientIP())
			If Not context.Session("UserID") Is Nothing Then
				errorMessage.Append("<br/><b>Organisation:</b> " + context.Session("UserOrganisationName"))
				errorMessage.Append("<br/><b>Organisation ID:</b> " + context.Session("UserOrganisationID").ToString)
				errorMessage.Append("<br/><b>User:</b> " + context.Session("UserOrgUserName"))
				errorMessage.Append("<br/><b>Email:</b> " + context.Session("UserEmail"))
			Else
				errorMessage.Append("<br/>User not logged in.")
			End If
			errorMessage.Append("</div>")

			Try
				errorMessage.Append("<br/><br/><b>More details:</b> <br/><br/>" + exp.InnerException.Message)
			Catch ex As Exception
			End Try

			errorMessage.Append("<br/><br/><b>Request:</b><br/><div style='margin-left:50px;'>" + GetRequestString() + "</div>")
			errorMessage.Append("<br/><b>Method:</b> " + exp.TargetSite.ToString)
			errorMessage.Append("<br/><br/><b>Stack trace:</b><br/><div style='margin-left:50px;'>" + exp.StackTrace.Replace(vbCrLf, "<br/>") + "</div>")
		Finally
		End Try
		'
		' OK, send what we've got
		'
		Try
            '
            ' Send the error message
            '
            Utility.SendEmail(sTo, "Data Protection Impact Assessment Tool Error Report", errorMessage.ToString, True, sCC:=sCC)
        Catch ex As Exception
		End Try
	End Sub
	''' <summary>
	''' Get request string as POST etc.
	''' </summary>
	''' <returns></returns>
	''' <remarks></remarks>
	Protected Shared Function GetRequestString() As String
		Dim Request As System.Web.HttpRequest = System.Web.HttpContext.Current.Request
		'
		' Get the request string including request type and requested to
		'
		Dim sbRequest As New StringBuilder("")

		sbRequest.AppendLine(Request.RequestType())
		sbRequest.AppendLine(Request.RawUrl())
		Dim reader As System.IO.StreamReader = New System.IO.StreamReader(Request.InputStream)
		While (Not reader.EndOfStream)
			sbRequest.AppendLine(reader.ReadLine())
		End While
		'
		' Reset the input stream so other error handlers can use it
		'
		If Request.InputStream.CanSeek Then
			Request.InputStream.Seek(0, IO.SeekOrigin.Begin)
		End If

		Return sbRequest.ToString()
	End Function

	''' <summary>
	''' Get the IP address for this request
	''' </summary>
	''' <returns></returns>
	''' <remarks></remarks>
	Protected Shared Function GetClientIP() As String
		Dim Request As System.Web.HttpRequest = System.Web.HttpContext.Current.Request

		Dim sClientIPAddress As String = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
		If sClientIPAddress Is Nothing Then
			'
			' No proxies so use simple remote_addr
			'
			sClientIPAddress = Request.ServerVariables("REMOTE_ADDR")
		Else
			'
			' Could have been forwarded by multiple proxies so split on comma and find last entry
			'
			Dim lsParts As String() = sClientIPAddress.Split(","c)
			sClientIPAddress = lsParts.Last()
		End If

		Return sClientIPAddress
	End Function
#End Region
End Class
