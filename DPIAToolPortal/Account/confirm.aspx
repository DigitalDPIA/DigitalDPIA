<%@ Page Title="Registration Complete" Language="vb" AutoEventWireup="false" MasterPageFile="~/Application.Master" CodeBehind="confirm.aspx.vb" Inherits="InformationSharingPortal.confirm" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <hgroup class="title">
        <h1><%: Title %>. <asp:Label ID="lblSubHeading" runat="server" Text="Validation Required"></asp:Label></h1>
    </hgroup>
<p>Thank you for registering. Please remember your login credentials.</p>
  <asp:Panel ID="pnlReg" runat="server">
    <p>You are not currently associated with any organisation.</p> 
    <p class="alert alert-warning" role="alert">To register your organisation on the system, please click <a  href="../application/organisation_registration.aspx" class="btn btn-default" style="font-size:115%">Register Organisation</a>. </p>
    
    <p>If someone else will be registering your organisation and providing you with access, you will be notified that you can access the system once they do.</p>
    

    </asp:Panel>
    <asp:Panel cssclass="alert alert-danger" ID="pnlDomainInvalid" runat="server">
    <p  role="alert">You have registered to use the Data Protection Impact Assessment Tool using an e-mail address from an unapproved domain. Before you can use the system, your registration must be approved by the DPIA Support Team, please contact them <a href="mailto:isg@mbhci.nhs.uk" font-size:115%">here</a> to request approval. </p>
        <p>Approved domains are:</p>
        
            <ul>
                                           <asp:ObjectDataSource ID="dsDomains" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="InformationSharingPortal.ispregistrationTableAdapters.isp_DomainsTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                                               <SelectParameters>
                                                   <asp:Parameter DefaultValue="True" Name="ShowList" Type="Boolean" />
                                               </SelectParameters>
                                           </asp:ObjectDataSource>  
    <asp:Repeater ID="rptDomains" runat="server" DataSourceID="dsDomains">
        <ItemTemplate>
            <li>
                <asp:Label ID="lblDomain" runat="server" Text='<%# Eval("Domain")%>'></asp:Label></li>
        </ItemTemplate>
    </asp:Repeater>   
                                        </ul>
        <p>If you need to register your organisation and don't have an e-mail address at one of these domains, please contact <a href="mailto:isg@mbhci.nhs.uk" font-size:115%">here</a> to request access.</p>
        
    </asp:Panel>
</asp:Content>
