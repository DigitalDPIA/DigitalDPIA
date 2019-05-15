<%@ Page Title="Home Page" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="InformationSharingPortal._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="PageContent" runat="server">

    <div class="bg-slider-wrapper">
        <div class="flexslider bg-slider">
            <ul class="slides">
                <li class="slide slide-1"></li>
                <li class="slide slide-2"></li>
                <li class="slide slide-3"></li>
            </ul>
        </div>
    </div>
    <!--//bg-slider-wrapper-->

    <section class="promo section section-on-bg">
        <div class="container text-center">
            <h2 class="title">Welcome to the
                <br />
                 <%: Session("SiteTitle") %></h2>
            <p class="intro">
                <asp:Label ID="lblIntro" runat="server" Text="Allowing information governance stakeholders to create<br />data protection impact assessments electronically."></asp:Label>
            </p>
            <p>
                <a class="btn btn-cta btn-default" runat="server" href="~/account/login">Log in</a>

                <a class="btn btn-cta btn-cta-primary" runat="server" href="~/account/register">Register</a>
            </p>
            <%--<button type="button" class="play-trigger btn-link " data-toggle="modal" data-target="#modal-video" ><i class="fa fa-youtube-play"></i> Watch the video</button>--%>
        </div>
        <!--//container-->
    </section>
    <!--//promo-->
    <asp:Panel ID="pnlSandpitOnly" Visible="false" runat="server" CssClass="sections-wrapper">
<section id="gotolive" class="section why">
            <div class="container">
                <h2 class="title text-center">Looking for the Data Protection Impact Assessment live site?</h2>
                 <p class="text-center"><a class="btn btn-cta btn-cta-secondary" href="https://www.dpiatool.org.uk/">Take me to DPIA Live Site</a></p>
            </div>
            <!--//container-->
        </section>
    </asp:Panel>
    <asp:Panel ID="pnlLiveOnly" runat="server" CssClass="sections-wrapper">
<!-- ******Why Section****** -->
        <section id="why" class="section why">
            <div class="container">
                <h2 class="title text-center">How can the Data Protection Impact Assessment Tool help you?</h2>
                <p class="intro text-center">The DPIA takes the pain out of data protection impact assessments. Create, manage, sign and store them easily, online.</p>
            </div>
            <!--//container-->
        </section>
        <!--//why-->

        <section class="section sandpit">
            <div class="feature-lead text-center">
                <h4 class="title">Try all of the features in our "Sandpit" system</h4>
                <p><a class="btn btn-cta btn-cta-secondary" href="http://www.dpiasandpit.org.uk/">Take me to the Sandpit</a></p>
            </div>
        </section>       

        <!--//cta-section-->
        <section class="section news">
            <!-- Main Content -->
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                <asp:ObjectDataSource ID="dsNewsItems" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetTop5forAG" TypeName="InformationSharingPortal.landingdataTableAdapters.isg_pl_NewsItemsTableAdapter">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="0" Name="AdminGroupID" SessionField="plAdminGroupID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:Repeater ID="rptNews" runat="server" DataSourceID="dsNewsItems">
                    <ItemTemplate>
<div class="post-preview">
                    <a runat="server" href='<%# "News?ItemID=" & Eval("NewsItemID").ToString() %>' >
                        <h2 class="post-title">
                            <asp:Label ID="lblNewsTitle" runat="server" Text='<%# Eval("NewsTitle")%>'></asp:Label>
                        </h2>
                        <h3 runat="server"  class="post-subtitle">
                            <asp:Label ID="lblNewsSubtitle" runat="server" Text='<%# Eval("NewsSubtitle")%>'></asp:Label>
                        </h3>
                    </a>
                    <p class="post-meta">Posted by <asp:Label ID="lblPostedBy" runat="server" Text='<%# Eval("PostedByUsername")%>'></asp:Label> on <asp:Label ID="lblPostedDate" runat="server" Text='<%# Eval("PostedDate", "{0:d}")%>'></asp:Label></p>
                </div>
                    </ItemTemplate>
                    <SeparatorTemplate>
<hr>
                    </SeparatorTemplate>
                </asp:Repeater>
              
                
                <!-- Pager -->
                <ul class="pager">
                    <li class="next">
                        <a href="News">More news &rarr;</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
        </section>

        <!-- ******Testimonials Section****** -->
        <section class="section testimonials">
            <div class="container">
                <h2 class="title text-center">What are people saying about the DPIA?</h2>
                <div id="testimonials-carousel" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="dsQuotes">
                            <ItemTemplate>
                                <li data-target="#testimonials-carousel" runat="server" data-slide-to='<%# Eval("OrderByNumber")%>' class='<%# getCarouselButtonItemCSSclass(Eval("OrderByNumber"))%>'></li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ol>
                    <!--//carousel-indicators-->
                    <div class="carousel-inner">
                        <asp:ObjectDataSource ID="dsQuotes" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActiveByAdminGroupID" TypeName="InformationSharingPortal.landingdataTableAdapters.isg_pl_QuotesTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="1" Name="AdminGroupID" SessionField="plAdminGroupID" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:Repeater ID="rptQuotes" runat="server" DataSourceID="dsQuotes">
                            <ItemTemplate>
                                <div runat="server" class='<%# getQuoteItemCSSclass(Eval("OrderByNumber"))%>'>
                                    <figure class="profile">
                                        <img src='<%# Eval("QuoteFaceURL")%>' alt="" /></figure>
                                    <div class="content">
                                        <blockquote>
                                            <i class="fa fa-quote-left"></i>
                                            <p><%# Eval("QuoteText")%></p>
                                        </blockquote>
                                        <p class="source"><%# Eval("QuoteAttribution")%><span runat="server" visible='<%# Eval("QuoteSourceURL").ToString.Length > 0%>'><br />
                                            <a class="links" target="_blank" runat="server" href='<%# Eval("QuoteSourceURL")%>'>more...</a></span></p>
                                    </div>
                                    <!--//content-->
                                </div>
                                <!--//item-->
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <!--//carousel-inner-->

                </div>
                <!--//carousel-->
            </div>
            <!--//container-->
        </section>

    </asp:Panel>
    <script>
        /* ======= Testimonial Bootstrap Carousel ======= */
        /* Ref: http://getbootstrap.com/javascript/#carousel */
        $(document).ready(function () {
            $('#testimonials-carousel').carousel({
                interval: 8000
            });
        }
            );
    </script>
</asp:Content>
