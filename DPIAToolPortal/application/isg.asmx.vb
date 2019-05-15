Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.ComponentModel

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebService(Namespace:="https://www.dpiatool.nhs.uk/")>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<ToolboxItem(False)> _
Public Class isg
    Inherits System.Web.Services.WebService

    <WebMethod()> _
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function
    '<WebMethod()> _
    'Public Function IncrementFAQViewCount(ByVal faqid As Integer) As String
    '    Dim taq As New TicketsTableAdapters.QueriesTableAdapter
    '    Dim nCount As Integer = taq.uspIncrementFAQViewCount(faqid)
    '    Return nCount
    'End Function
End Class