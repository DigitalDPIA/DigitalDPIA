Imports System.Web.Routing
Imports Microsoft.AspNet.FriendlyUrls

Public Module RouteConfig
    Sub RegisterRoutes(ByVal routes As RouteCollection)
		routes.EnableFriendlyUrls()
		routes.MapPageRoute("AdminGroup", "AdminGroup/{GroupName}", "~/Default.aspx")
		routes.MapPageRoute("Report", "Report/{ReportName}", "~/application/home_reports.aspx")
    End Sub
End Module
