<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FullReport.aspx.cs" Inherits="Parshvnath.FullReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Full Report</title>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        $("[src*=plus]").live("click", function () {
            $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $(this).next().html() + "</td></tr>")
            $(this).attr("src", "images/minus.png");
        });
        $("[src*=minus]").live("click", function () {
            $(this).attr("src", "images/plus.png");
            $(this).closest("tr").next().remove();
        });
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h4>Nested Gridview</h4>

            <asp:GridView ID="gvReport" runat="server" OnRowDataBound="gvReport_RowDataBound" AutoGenerateColumns="false" DataKeyNames="UserID">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnUserID" runat="server" Value='<%# Eval("UserID") %>' />

                            <img alt="" style="cursor: pointer" src="images/plus.png" />
                            <asp:Panel ID="pnlYears" runat="server" Style="display: none">
                                <asp:GridView ID="gvYears" Width="100%" runat="server" AutoGenerateColumns="false" DataKeyNames="Year" OnRowDataBound="gvYears_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnYear" runat="server" Value='<%# Eval("Year") %>' />
                                                <img alt="" style="cursor: pointer" src="images/plus.png" />

                                                <asp:Panel ID="pnlMonths" runat="server" Style="display: none">
                                                    <asp:GridView ID="gvMonths" DataKeyNames="MonthID" runat="server" AutoGenerateColumns="false" CssClass="ChildGrid" OnRowDataBound="gvMonths_RowDataBound">
                                                        <Columns>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <img alt="" style="cursor: pointer" src="images/plus.png" />
                                                                    <asp:Panel ID="pnlHoardings" runat="server" Style="display: none">
                                                                        <asp:GridView ID="gvHoardings" runat="server" AutoGenerateColumns="true" CssClass="ChildGrid">
                                                                            <EmptyDataTemplate>
                                                                                No Record Found
                                                                            </EmptyDataTemplate>
                                                                        </asp:GridView>
                                                                    </asp:Panel>
                                                                </ItemTemplate>

                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="Month" HeaderText="Month" />
                                                        </Columns>

                                                        <EmptyDataTemplate>
                                                            No Record Found
                                                        </EmptyDataTemplate>
                                                    </asp:GridView>
                                                </asp:Panel>

                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Year" HeaderText="Year" />
                                    </Columns>
                                    <EmptyDataTemplate>
                                        No Data Found
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </asp:Panel>
                        </ItemTemplate>

                    </asp:TemplateField>
                    <asp:BoundField ItemStyle-Width="150px" DataField="PersonName" HeaderText="Party Name" />
                </Columns>

                <EmptyDataTemplate>
                    No Record Found
                </EmptyDataTemplate>
            </asp:GridView>

        </div>
    </form>
</body>
</html>
