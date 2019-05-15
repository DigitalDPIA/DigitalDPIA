Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.ComponentModel
Imports System.Globalization
Imports System.Net
Imports System.IO
Imports System.Web.Script.Services

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()> _
<System.Web.Services.WebService(Namespace:="geo")> _
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<ToolboxItem(False)> _
Public Class geo
    Inherits System.Web.Services.WebService
    Private Shared ReadOnly FindGeocodeUrl As String = "https://maps.google.com/maps/api/geocode/json?address={0}&key=AIzaSyBVh65LzY3BecLni585cLPXB6XM88TD9_8"
    <WebMethod()> _
    Public Function GetGeoCode(ByVal addstr As String) As String
        Dim formattedUri As String = [String].Format(CultureInfo.InvariantCulture, FindGeocodeUrl, addstr)
        Dim webRequest As HttpWebRequest = Net.WebRequest.Create(formattedUri)
        Dim response As HttpWebResponse = DirectCast(webRequest.GetResponse(), HttpWebResponse)
        Dim jsonResponse As String = String.Empty
        Using sr As New StreamReader(response.GetResponseStream())
            jsonResponse = sr.ReadToEnd()
        End Using
        Return jsonResponse
    End Function
    '   <WebMethod> _
    '<ScriptMethod(ResponseFormat:=ResponseFormat.Json)> _
    '   Public Function GetMapData(ByVal org As Integer) As String
    '       Dim daresult As [String] = Nothing
    '       Dim taMapData As New dashboardTableAdapters.GenerateMapDataTableAdapter
    '       Dim tMapData As New dashboard.GenerateMapDataDataTable
    '       tMapData = taMapData.GetData(org)
    '       daresult = CCommon.DataTableToJSON(tMapData)
    '       Return daresult
    '   End Function
    '    <WebMethod> _
    '<ScriptMethod(ResponseFormat:=ResponseFormat.Json)> _
    '    Public Function GetAGMapData(ByVal admingroup As Integer) As String
    '        Dim daresult As [String] = Nothing
    '        Dim taMapData As New dashboardTableAdapters.GenerateAGMapDataTableAdapter
    '        Dim tMapData As New dashboard.GenerateAGMapDataDataTable
    '        tMapData = taMapData.GetData(admingroup)
    '        daresult = CCommon.DataTableToJSON(tMapData)
    '        Return daresult
    '    End Function
    <WebMethod> _
        <ScriptMethod(ResponseFormat:=ResponseFormat.Json)> _
    Public Function GetICOSearchMatches(ByVal searchstr As String) As String
        Dim daresult As [String] = Nothing
        searchstr = searchstr.Replace(" ", "%")
        Dim taICO As New isporganisationsTableAdapters.isp_ICO_RegisterTableAdapter
        Dim tICO As New isporganisations.isp_ICO_RegisterDataTable
        tICO = taICO.GetDataByOrgName(searchstr)
        daresult = CCommon.DataTableToJSON(tICO)
        Return daresult
    End Function
    <WebMethod> _
       <ScriptMethod(ResponseFormat:=ResponseFormat.Json)> _
    Public Function GetICOCodeMatch(ByVal icocodestr As String) As String
        Dim daresult As [String] = Nothing
        Dim taICO As New isporganisationsTableAdapters.isp_ICO_RegisterTableAdapter
        Dim tICO As New isporganisations.isp_ICO_RegisterDataTable
        tICO = taICO.GetDataByRegNum(icocodestr)
        daresult = CCommon.DataTableToJSON(tICO)
        Return daresult
    End Function
    <WebMethod> _
    Public Function CheckODSRegistered(ByVal odscode As String) As Integer
        Dim nReturn As Integer = 0
        Dim taq As New isporganisationsTableAdapters.QueriesTableAdapter
        nReturn = CInt(taq.CheckODSExists(odscode))
        Return nReturn
    End Function
    <WebMethod> _
    Public Function CheckICORegistered(ByVal iconum As String) As Integer
        Dim nReturn As Integer = 0
        Dim taq As New isporganisationsTableAdapters.QueriesTableAdapter
        nReturn = CInt(taq.CheckICOExists(iconum))
        Return nReturn
    End Function
End Class