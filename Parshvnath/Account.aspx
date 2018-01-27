﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Account.aspx.cs" Inherits="Parshvnath.Account" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>View  Account </title>


    <link href="Css/jquery-ui.css" rel="stylesheet" />
    <link href="Script/Plugin/uploadify/uploadify.css" rel="stylesheet" />
    <link href="Css/Site.css" rel="stylesheet" />
    <link href="Css/style-parshva.css" rel="stylesheet" />
    <script src="Script/jquery.min.js"></script>
    <script src="Script/jquery-ui.min.js"></script>
    <script src="Script/jquery.validate.js"></script>
    <script src="Script/additional-methods.js"></script>
    <script src="Script/Plugin/uploadify/jquery.uploadify.js"></script>
    <script src="Script/moment.js"></script>
</head>
<body>
    <!--start wapper part-->
    <div class="Page_Container">
        <!-- start herder part-->
        <div id="Herder_Container">
            <div class="Left_Part">
                <div class="Logo">
                    <a href="#">
                        <img src="images/logo.jpg" alt="Parshva Designer" title="Parshva Designer - Banner Printing and hoarding" /></a>
                </div>
            </div>
            <div class="Right_Part">
                <!-- start menu part-->
                <div id="Nav">
                    <div class="Nav_Left">&nbsp;</div>
                    <div class="Nav_Center">
                        <ul class="main_nav">
                            <li><a href="ViewUser.aspx">View Party</a></li>
                            <li><a href="ViewHoarding.aspx">View Hoarding</a></li>
                            <li><a href="ViewCity.aspx">View City</a></li>
                            <li><a href="ViewArea.aspx">View Area</a></li>
                            <li><a href="ViewReport.aspx" >Report</a></li>
                            <li><a href="Account.aspx" class="active">Account</a></li>
                            <li><a href="#">Backup</a></li>
                            <%--<li class="none"><a href="#">Contact Us</a></li>--%>
                        </ul>
                    </div>
                    <div class="Nav_Right">&nbsp;</div>
                </div>
                <!-- end menu part-->
            </div>
        </div>
        <!-- end herder part-->
        <!-- start banner part-->
        <div id="Banner">
            <img src="images/banner.png" alt="" title="" width="1000" height="275" />
        </div>
        <!-- end banner part-->
        <!-- start main conten part-->
        <div id="Body_Container">
            <div class="Inner_Part">
                <div class="Welcome_Topbg">&nbsp;</div>
                <div class="Welcome_Centbg">
                    <div class="Container_Inner">
                        <h1>User Account</h1>

                        <form id="aspNetForm" runat="server">
                            <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
                            <input type="hidden" id="hdnFile" runat="server" />
                            <p>
                                Search By
        <asp:DropDownList ID="ddlSearchType" runat="server">
            <asp:ListItem Value="0">All</asp:ListItem>
            <asp:ListItem Value="1">Party</asp:ListItem>
            <asp:ListItem Value="2">City</asp:ListItem>
            <%--            <asp:ListItem Value="3">Phone</asp:ListItem>--%>
        </asp:DropDownList>
                                <asp:TextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"></asp:TextBox>
                                <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" />
                            </p>
                            <div>

                                <asp:GridView ID="grdHoarding" CssClass="custom-grid" runat="server" AutoGenerateColumns="False" AllowSorting="true" OnSorting="Sorting" AllowPaging="true" PageSize="10" OnPageIndexChanging="ChangePage">
                                    <FooterStyle CssClass="footer" />
                                    <RowStyle CssClass="normal" />

                                    <PagerStyle CssClass="pager" />
                                    <AlternatingRowStyle CssClass="alternate" />
                                    <HeaderStyle CssClass="header" />

                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="imgHoarding" ImageUrl='<%# "~/Images/HoardingImage/"+Eval("HoardingBanner") %>' runat="server" Width="50" Height="50" />
                                                <%--                            <asp:Label ID="lblHoardingNo" runat="server" Text='<%# Eval("HoardingNo")%>' />--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Party Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPartyName" runat="server" Text='<%# Eval("Username")%>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="HoardingNo" SortExpression="HoardingNo">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHoardingNo" runat="server" Text='<%# Eval("HoardingNo")%>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="City">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCity" runat="server" Text='<%# Eval("CityName")%>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Area" SortExpression="Area">
                                            <ItemTemplate>
                                                <asp:Label ID="lblArea" runat="server" Text='<%# Eval("AreaName")%>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Expire Date" SortExpression="ToDate">
                                            <ItemTemplate>

                                                <asp:Label ID="lblToDate" runat="server" Text='<%# Eval("ToDate","{0:dd/MM/yyyy}")%>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("Amount")%>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>


                                    </Columns>

                                </asp:GridView>
                            </div>
                        </form>

                    </div>
                </div>
                <div class="Welcome_Botbg">&nbsp;</div>
            </div>

        </div>
        <!-- end main conten part-->
    </div>
    <!--end wapper part-->


</body>
</html>
