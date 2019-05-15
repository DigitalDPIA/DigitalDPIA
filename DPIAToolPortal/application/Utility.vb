Imports System.Net
Imports System.Net.Mail
Imports HiQPdf
Imports System.Drawing
Imports System.IO
Imports System.Threading
Imports System.Drawing.Imaging

Public Class Utility
    Protected Function FixCrLf(value As String) As String
        If String.IsNullOrEmpty(value) Then Return String.Empty
        value = value.Replace(vbCr & vbLf, "<br />")
        value = value.Replace(vbLf, "<br />")
        Return value.Replace(Environment.NewLine, "<br />")
    End Function
#Region "EMail"
    Public Shared Function SendEmail(ByVal sToAddress As String,
      ByVal sSubject As String,
      ByVal sBody As String,
      ByVal bIsHTML As Boolean,
      Optional ByVal sFromAddress As String = "",
      Optional ByVal sCC As String = "",
      Optional ByVal sBCC As String = "") As Boolean
        Dim taEmail As New adminTableAdapters.isp_EmailServersTableAdapter
        Dim tEmail As New admin.isp_EmailServersDataTable
        tEmail = taEmail.GetActive()
        If sFromAddress = "" Then
            sFromAddress = tEmail.First.FromAddress
        End If
        Dim sIPAddress As String = tEmail.First.IPAddress
        Dim sUsername As String = tEmail.First.Uname
        Dim sPassword As String = tEmail.First.PW
        Dim IsDelivered As Boolean = False
        If Not System.Web.HttpContext.Current.Session("SuppressEmails") Then
            Dim taUnsub As New ispusersTableAdapters.isp_UnsubscribeListTableAdapter

            If taUnsub.CheckIfEmailInList(sToAddress) > 0 Then
                IsDelivered = True
                Return IsDelivered
                Exit Function
            End If
            Dim Msg As New MailMessage()
            '
            ' Set up addresses
            ' Note that From address is fixed as only emails sent from nhselite.org will get through
            ' the NHS mail spam filter.
            '
            Msg.From = New MailAddress(sFromAddress)
            Msg.To.Add(New MailAddress(sToAddress))
            If Not sCC Is String.Empty Then
                Msg.CC.Add(New MailAddress(sCC))
            End If
            If Not sBCC Is String.Empty Then
                Msg.Bcc.Add(New MailAddress(sBCC))
            End If
            '
            ' Set up content etc.
            '

            Dim sServerName As String = HttpContext.Current.Request.ServerVariables("SERVER_NAME").ToLower()
            If sServerName.Contains("sandpit") Or sServerName.Contains("localhost") Then
                sSubject = "DPIA SANDPIT MESSAGE: " & sSubject
                sBody = sBody & "<p><b>THIS MESSAGE WAS SENT FROM THE DPIA SANDPIT AND DOES NOT RELATE TO LIVE DPIA BUSINESS PROCESSES.</b></p>"
            End If
            Msg.Subject = sSubject
            Msg.IsBodyHtml = bIsHTML
            Msg.Priority = MailPriority.Normal
            If bIsHTML Then
                '
                ' Set up proper HTML content
                '
                'Msg.Body = sBody								' non-HTML message - they might be able to get something out of this!
                Dim plainText As String = System.Text.RegularExpressions.Regex.Replace(sBody, "<[^>]*>", String.Empty)
                plainText = plainText.Replace("&nbsp;", " ")
                Dim avPlain As AlternateView = AlternateView.CreateAlternateViewFromString(plainText, System.Text.Encoding.GetEncoding(28591),
                  "text/plain")
                sBody = Utility.ApplyEmailStandardTemplate(sBody, sToAddress)
                Dim avHTML As AlternateView = AlternateView.CreateAlternateViewFromString(sBody, System.Text.Encoding.Default,
                  System.Net.Mime.MediaTypeNames.Text.Html)
                Msg.AlternateViews.Add(avPlain)
                Msg.AlternateViews.Add(avHTML)
            Else
                Dim plainText As String = System.Text.RegularExpressions.Regex.Replace(sBody, "<[^>]*>", String.Empty)
                plainText = plainText.Replace("&nbsp;", " ")
                Msg.Body = plainText                                ' not HTML content, just put it in
            End If
            '
            ' Open up the email client. Have to use the correct address
            '
            Dim client As SmtpClient
            Dim myIPs As System.Net.IPHostEntry = System.Net.Dns.GetHostEntry("")
            Dim myIP As System.Net.IPAddress = myIPs.AddressList.First()
            '
            ' Decide whether to use local IP address or not.
            ' NHS network runs on the 10.x.x.x addresses.
            ' The first IP address from the Bytehouse server is an IP6 address, so 
            ' assume that if it isn't local, use the Bytehouse hosting IP address.
            '
            'If myIP.ToString.StartsWith("10.") Then
            '    client = New SmtpClient(myIP.ToString(), 25)
            'Else
            client = New SmtpClient(sIPAddress, 25)
            'End If

            client.DeliveryMethod = SmtpDeliveryMethod.Network
            client.Credentials = New NetworkCredential(sUsername, sPassword)
            'client.UseDefaultCredentials = False
            client.Timeout = 5000
            '
            ' Send the email
            '
            Try
                Dim sHost = HttpContext.Current.Request.Url.Host
                If Not sHost.Contains("informationsharing") And Not sHost.Contains("localhost") Then
                    IsDelivered = True
                Else
                    client.Send(Msg)
                    IsDelivered = True
                End If
            Catch ex As Exception
                '
                ' Don't retry as probably it won't work, and we don't want to hold up the application too much
                '
                Throw
            Finally
                Msg = Nothing
            End Try
        End If
        Return IsDelivered
    End Function
    Public Shared Function SendVerificationEmail(ByVal ToAddress As String) As Boolean
        Dim taVBE As New isporgusersTableAdapters.VerifyByEmailTableTableAdapter
        Dim tVBE As New isporgusers.VerifyByEmailTableDataTable
        tVBE = taVBE.GetData(ToAddress)
        Dim sbBody As New StringBuilder
        'Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath
        Dim sPageName As String = HttpContext.Current.Request.UrlReferrer.GetLeftPart(UriPartial.Authority) & HttpContext.Current.Request.ApplicationPath _
                                 & "account/verify.aspx?action=verifyuser&pwdr=" & tVBE.First.ConfirmationHash.ToString() & "&uid=" & tVBE.First.UserId.ToString()
        sbBody.Append("<p>Dear " & Replace(StrConv(tVBE.First.OrganisationUserName, VbStrConv.ProperCase), "Nhs", "NHS") & ",</p>")
        sbBody.Append("<p>You have been registered as an Data Protection Impact Assessment Tool user at " & StrConv(tVBE.First.OrganisationName, VbStrConv.ProperCase) & ".</p>")
        sbBody.Append("<p style='font-size:150%;'>Please verify your registration for the Data Protection Impact Assessment Tool by <b><a href='" & sPageName & "'>following this link</a>.</p></b>")
        sbBody.Append("<p>You only need to verify your e-mail address once. If you have already verified it, please ignore this message.</p><p>If you do not know why you have received this e-mail, please e-mail isg@mbhci.nhs.uk and ask them to investigate.</p>")
        Dim bSent As Boolean = Utility.SendEmail(ToAddress, "Verify Your Data Protection Impact Assessment Tool Registration", sbBody.ToString(), True)
        Return bSent
    End Function
    Public Shared Function ApplyEmailStandardTemplate(ByVal BodyText As String, ByVal ToAddress As String) As String
        Dim sPrefix As String
        Dim sSuffix As String
        sPrefix = "<html><head><style>body{font-family: sans-serif; font-size:12px;}hr{margin-top: 20px;margin-bottom: 20px;border: 0;border-top: 1px solid #eee;}.small {font-size:75%;color:#777;text-align:center;}</style></head><body>"
        Dim sServerName As String = HttpContext.Current.Request.ServerVariables("SERVER_NAME").ToLower()
        If Not sServerName = "www.info-sharing-system.org.uk" And Not sServerName = "www.dpiatool.org.uk" Then
            sSuffix = "<p>Thank you</p><p>Data Protection Impact Assessment Tool Support</p><hr/><p class='small'>This e-mail has been automatically generated by the <b>Information Sharing Sandpit</b>, please do not reply. <b>The Information Sharing Sandpit is a demonstration / testing system and is not used for recording actual information sharing business, please act on this message accordingly.</b> Use the <a href='http://" & sServerName & "/Contact'>Contact tab</a> in the system to submit queries.</p>"
            sSuffix = sSuffix & "<p class='small'>You are receiving this e-mail because you have have been identified as an Information Sharing Sandpit user, if you don't want to receive any further e-mails from the Data Protection Impact Assessment Tool, click <a href='http://" & sServerName & "/Unsubscribe.aspx?emailid=" & ToAddress & "'>Unsubscribe</a></b>.</p><table style='width: 100%; border-collapse: collapse;' cellspacing='0' cellpadding='3'><tbody><tr><td style='border-color: #ffffff; width: 50%;'><img alt='NWISS Logo' src='http://" & sServerName & "/Images/logo_nwiss.png' /></td><td style='border-color: #ffffff; width: 50%; text-align: right;'><img align='right' alt='NWISS IG Logo' src='http://" & sServerName & "/Images/logo_ig_lg.png' /></td></tr></tbody></table></body></html>"
        Else
            sSuffix = "<p>Thank you</p><p>Data Protection Impact Assessment Tool Support</p><hr/><p class='small'>This e-mail has been automatically generated by the Data Protection Impact Assessment Tool, please do not reply. Use the <a href='http://" & sServerName & "/Contact'>Contact tab</a> in the system to submit queries.</p>"
            sSuffix = sSuffix & "<p class='small'>You are receiving this e-mail because you have have been identified as an Data Protection Impact Assessment Tool user, if you don't want to receive any further e-mails from the Data Protection Impact Assessment Tool, click <a href='http://" & sServerName & "/Unsubscribe.aspx?emailid=" & ToAddress & "'>Unsubscribe</a></b>.</p><table style='width: 100%; border-collapse: collapse;' cellspacing='0' cellpadding='3'><tbody><tr><td style='border-color: #ffffff; width: 50%;'><img alt='NWISS Logo' src='http://" & sServerName & "/Images/logo_nwiss.png' /></td><td style='border-color: #ffffff; width: 50%; text-align: right;'><img align='right' alt='NWISS IG Logo' src='http://" & sServerName & "/Images/logo_ig_lg.png' /></td></tr></tbody></table></body></html>"
        End If
        Dim sReturn As String = sPrefix & BodyText & sSuffix
        Return sReturn
    End Function

#End Region
#Region "AccessControl"
    Public Shared Function RedirectAuthenticatedUser(Optional returnURL As String = "") As String
        Dim currentUser As MembershipUser
        currentUser = Membership.GetUser()
        If Not currentUser Is Nothing Then

            'Check by e-mail address whether user is associated with an authorised centre
            Dim taVerify As New isporgusersTableAdapters.VerifyByEmailTableTableAdapter
            Dim tVerify As New isporgusers.VerifyByEmailTableDataTable
            tVerify = taVerify.GetData(currentUser.Email)
            If tVerify.Count = 0 Then
                'the user is not registered to a centre so send them to confirm where we thank them for registering and let them set up their centre:
                Return "account/confirm.aspx"
            ElseIf tVerify.First.Confirmed = False Then
                'the user hasn't completed e-mail verification, send them to the verification page:
                Return "account/verify.aspx"
            ElseIf tVerify.First.TotalOrgs > 1 Then
                'user has multiple organisations - ask them to select
                If returnURL = "" Then
                    Return "account/login.aspx?view=vSelectRole"
                Else
                    Return "account/login.aspx?view=vSelectRole&returnURL=" & returnURL
                End If

            Else
                If returnURL = "" Then
                    'user has centre and has completed verification, send them to their intray:
                    Return "application/home_intray.aspx?orgid=" & tVerify.First.OrganisationID.ToString()
                Else
                    Return "application/home_intray.aspx?orgid=" & tVerify.First.OrganisationID.ToString() & "&returnURL=" & returnURL
                End If
            End If
                Else
            Return ""
        End If
    End Function
    Public Shared Sub Logout()
        If Not HttpContext.Current.Session Is Nothing Then
            HttpContext.Current.Session.Clear()
            HttpContext.Current.Session.Abandon()
            HttpContext.Current.User = Nothing
            System.Web.Security.FormsAuthentication.SignOut()
            HttpContext.Current.Session.Abandon()
            FormsAuthentication.SignOut()
        End If
        Dim sLoginURL As String = "~/Default.aspx"
        System.Web.HttpContext.Current.Response.Redirect(sLoginURL)
    End Sub
    Public Shared Function GetProgClass(ByVal pcComp As Integer) As String
        Dim sClass As String = ""
        Select Case pcComp
            Case Is <= 60
                sClass = "progress-bar progress-bar-danger progress-bar-striped"
            Case Is < 100
                sClass = "progress-bar progress-bar-warning progress-bar-striped"
            Case Else
                sClass = "progress-bar progress-bar-success progress-bar-striped"
        End Select
        Return sClass
    End Function
#End Region
#Region "PDFOutPut"
    Public Shared Function GeneratePDFFromURL(ByVal SUrl As String, ByVal SFname As String, ByVal sDocType As String, Optional bDoDownload As Boolean = True) As Boolean

        Dim htmlToPdfConverter As New HtmlToPdf()
        'if file already exists, just download it:
        If (File.Exists(SFname)) Then
            If bDoDownload Then
                DownloadPDF(SFname)
            End If
            Return True
                Exit Function
            End If


            ' set a demo serial number
            htmlToPdfConverter.SerialNumber = "x4+ulpej-oYuupbWm-tb7w6ffn-9uf05/7+-8uf09un2-9en+/v7+"
        SetHeader(htmlToPdfConverter.Document, sDocType)
        SetFooter(htmlToPdfConverter.Document)
        'htmlToPdfConverter.Document.Footer.Enabled = True

        'Dim pageNumberFont = New Font(New FontFamily("Calibri"), 8, GraphicsUnit.Point)
        '' 1
        'Dim pageNumberText = New PdfText(1, 25, "Page {CrtPage} of {PageCount}", pageNumberFont)
        '' 2
        'htmlToPdfConverter.Document.Footer.Layout(pageNumberText)
        '' 3

        ' convert HTML to PDF
        Dim pdfFile As String = Nothing
        Try

            ' convert URL

            Dim pdfBuffer() As Byte = Nothing
            htmlToPdfConverter.BrowserWidth = 750
            htmlToPdfConverter.Document.Margins.Left = 40
            htmlToPdfConverter.Document.Margins.Right = 40
            htmlToPdfConverter.Document.Margins.Top = 15
            htmlToPdfConverter.Document.Margins.Bottom = 15
            ' htmlToPdfConverter.MediaType = "print"

            'NEW STUFF TO CONVERT TO FILE:
            'Dim csvPath As String = Server.MapPath("~/pdfout/") + Path.GetFileName(fupICOCSV.PostedFile.FileName)
            htmlToPdfConverter.ConvertUrlToFile(SUrl, SFname)
            'now download
            If bDoDownload Then
                DownloadPDF(SFname)
            End If
        Catch ex As Exception
            If Not ex.Message = "Thread was being aborted." Then
                CCommon.LogErrorToEmail(ex)
            End If
            Return False
            Exit Function
            'MessageBox.Show([String].Format("Conversion failed. {0}", ex.Message))

        Finally

            'Cursor = Cursors.Arrow
        End Try
        Return True
    End Function
    Public Shared Sub DownloadPDF(ByVal sFname As String)
        'pdfBuffer = htmlToPdfConverter.ConvertUrlToMemory(SUrl)
        HttpContext.Current.Response.AddHeader("Content-Type", "application/pdf")
        ' let the browser know how to open the PDF document
        Dim openMode As String = "attachment"
        Dim fi As New FileInfo(sFname)
        HttpContext.Current.Response.AddHeader("Content-Disposition", String.Format("{0}; filename=" & Path.GetFileName(sFname) & "; size={1}", openMode, fi.Length.ToString()))

        ' write the PDF buffer to HTTP response
        'HttpContext.Current.Response.BinaryWrite(pdfBuffer)
        HttpContext.Current.Response.WriteFile(sFname)
        ' call End() method of HTTP response 
        ' to stop ASP.NET page processing
        HttpContext.Current.Response.Flush()
        ' File.Delete(SFname)
        HttpContext.Current.Response.End()
    End Sub
    Public Shared Sub SetHeader(ByVal htmlToPdfDocument As PdfDocumentControl, ByVal sDocType As String)
        ' enable header display
        htmlToPdfDocument.Header.Enabled = True

        ' set header height
        htmlToPdfDocument.Header.Height = 30

        Dim pdfPageWidth As Single = htmlToPdfDocument.PageSize.Width

        Dim headerWidth As Single = pdfPageWidth - htmlToPdfDocument.Margins.Left - htmlToPdfDocument.Margins.Right
        Dim headerHeight As Single = htmlToPdfDocument.Header.Height
        ' layout HTML in header
        Dim headerHtml As New PdfHtml(5, 5, "<div style=""text-align:center;""><span style=""color:#AAA; font-family:Calibri; "">" & sDocType & " generated by the <a href=""https://www.info-sharing-system.org.uk"">Data Protection Impact Assessment Tool</a></span></div>", Nothing)
        headerHtml.FitDestHeight = True
        htmlToPdfDocument.Header.Layout(headerHtml)


    End Sub

    Public Shared Sub SetFooter(ByVal htmlToPdfDocument As PdfDocumentControl)
        ' enable footer display
        htmlToPdfDocument.Footer.Enabled = True

        ' set footer height
        htmlToPdfDocument.Footer.Height = 40

        Dim pdfPageWidth As Single = htmlToPdfDocument.PageSize.Width

        Dim footerWidth As Single = pdfPageWidth - htmlToPdfDocument.Margins.Left - htmlToPdfDocument.Margins.Right
        Dim footerHeight As Single = htmlToPdfDocument.Footer.Height

        ' layout HTML in footer
        ' add page numbering in a text element
        'pageNumberingFont.Mea
        Dim pageNumberingText As New PdfHtmlWithPlaceHolders(5, 5,
                    "<div style=""text-align:center;color:#AAA; font-family:Calibri;""><p>This document has been produced from the DPIA for reference purposes and is accurate only on the day it is produced. Please refer to the DPIA for the current, definitive version.</p>Page {CrtPage} of {PageCount} </span></div>", Nothing)
        'pageNumberingText.FitDestHeight = True
        pageNumberingText.ForeColor = Color.DarkGray
        htmlToPdfDocument.Footer.Layout(pageNumberingText)
    End Sub
#End Region
    Public Shared Function GetFileExtension(image As Image) As String
        Dim format As ImageFormat = image.RawFormat
        Dim fileExtension As String = ".jpeg"
        If ImageFormat.Bmp.Equals(format) Then
            fileExtension = ".bmp"
        ElseIf ImageFormat.Gif.Equals(format) Then
            fileExtension = ".gif"
        ElseIf ImageFormat.Png.Equals(format) Then
            fileExtension = ".png"
        End If
        Return fileExtension
    End Function
End Class
