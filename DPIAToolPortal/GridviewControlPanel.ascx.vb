Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Generic
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports DevExpress.Web
Imports DevExpress.Web.Bootstrap

Partial Public Class GridViewControlPanel
    Inherits System.Web.UI.UserControl
    Private grid As BootstrapGridView
    Private gridID_Renamed As String

    Public Property GridID() As String
        Get
            Return Me.gridID_Renamed
        End Get
        Set(ByVal value As String)
            Me.gridID_Renamed = value
        End Set
    End Property
    Public Property HeaderText() As String
        Get
            Return Me.bsPopupGVCustomise.HeaderText
        End Get
        Set(ByVal value As String)
            Me.bsPopupGVCustomise.HeaderText = value
        End Set
    End Property
    Public Property LinkText() As String
        Get
            Return Me.hlPopupGVCustomise.Text
        End Get
        Set(ByVal value As String)
            Me.hlPopupGVCustomise.Text = value
        End Set
    End Property
    Protected Sub PopupGVCustomise_Init(ByVal sender As Object, ByVal e As EventArgs)
        Dim hyperLink As ASPxHyperLink = CType(sender, ASPxHyperLink)
        hyperLink.ClientSideEvents.Click = String.Format("function(s, e) {{ ShowHidePopUpControl({0}); }}", bsPopupGVCustomise.ClientID)
    End Sub

    Private Sub CreateControlCheckBoxes()

        If String.IsNullOrEmpty(Me.GridID) Then
            Throw New NullReferenceException("GridID property is null.")
        End If
        grid = TryCast(Me.Parent.FindControl(GridID), ASPxGridView)
        If grid Is Nothing Then
            Throw New InvalidOperationException("ASPxGridView control was not found in NamingContainer.")
        End If

        For Each column As GridViewDataColumn In Me.grid.Columns
            'If Not column.FieldName = String.Empty Then
            Dim columnCheckBox As New ASPxCheckBox()
            If Not column.FieldName = "" Then
                columnCheckBox.ID = "chb" & column.FieldName
            Else
                columnCheckBox.ID = "chb" & column.Name
            End If
            bsPopupGVCustomise.Controls.Add(columnCheckBox)
            columnCheckBox.AutoPostBack = True
            If Not column.Name = "" Then
                columnCheckBox.Text = column.Name
            Else
                columnCheckBox.Text = column.FieldName
            End If
            columnCheckBox.Checked = column.Visible
            AddHandler columnCheckBox.CheckedChanged, AddressOf columnCheckBox_CheckedChanged
            'End If
        Next column
    End Sub
    Private Sub columnCheckBox_CheckedChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim columnCheckBox As ASPxCheckBox = CType(sender, ASPxCheckBox)
        Me.grid.Columns(columnCheckBox.Text).Visible = columnCheckBox.Checked
    End Sub

    Private Sub GridViewControlPanel_Load(sender As Object, e As EventArgs) Handles Me.Load
        CreateControlCheckBoxes()
    End Sub
End Class