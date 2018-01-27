<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewSubArea.aspx.cs" Inherits="Parshvnath.ViewSubArea" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Sub Area </title>

    <link href="Css/jquery-ui.css" rel="stylesheet" />
    <link href="Css/site.css" rel="stylesheet" />

    <link href="Css/ParswaCommon.css" rel="stylesheet" />
    <script src="Script/jquery.min.js"></script>
    <script src="Script/jquery-ui.min.js"></script>

    <script src="Script/jquery.validate.js"></script>
    <script src="Script/additional-methods.js"></script>
    <script>

        $(function () {

            $("#txtArea").autocomplete({
                appendTo: "#dialog-sub-area",
                // source: availableTags
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        url: "<%=Session["Path"]%>" + "ParshvaService.asmx/GetAllArea",
                        data: "{'Area':'" + $("#txtArea").val() + "'}",
                        contentType: "application/json",
                        dataType: "json",
                        success: function (result) {
                            if (result.d.length > 0) {
                                response($.map(result.d, function (item) {
                                    //        console.log(item);
                                    return {
                                        label: item.AreaName,
                                        val: item.ID
                                    }
                                }));
                            }
                        }, error: function (xhr) {
                            console.log("Error:" + xhr.statusText);
                        }
                    });

                },
                focus: function (event, ui) {
                    // prevent autocomplete from updating the textbox
                    event.preventDefault();
                    // manually update the textbox
                    $(this).val(ui.item.label);
                },
                select: function (event, ui) {
                    // prevent autocomplete from updating the textbox
                    event.preventDefault();
                    // manually update the textbox and hidden field
                    $(this).val(ui.item.label);
                    $("#txtArea").val(ui.item.value);
                    // console.log(ui.item.label);
                    //  console.log(ui.item.value);
                    $("#hdnArea").val(ui.item.val);
                }, change: function (event, ui) {
                    if (ui.item == null || ui.item == undefined) {
                        if ($("#hdnArea").val().trim().length == 0) {
                            $("#txtArea").val("");
                            $("#txtArea").attr("disabled", false);
                            $("#hdnArea").val("");
                            $("#hdnArea").attr("disabled", false);
                        }
                    } else {

                        $("#txtArea").attr("disabled", false);
                        $("#hdnArea").attr("disabled", false);

                    }
                }
            });

            $("#dialog-sub-area").dialog({
                autoOpen: false,
                modal: true,
                width: 400,
                resizable: false,
                draggable: false
            });

            $("#frmSubArea").validate({
                rules: {
                    txtSubArea: {
                        required: true
                    },
                    txtArea: {
                        required: true
                    }
                }, messages: {
                    txtSubArea: {
                        required: " *"
                    },
                    txtArea: {
                        required: "Select area"
                    }

                }
            });

            $("#frmSubArea").submit(function () {

                var AreaID = $("#hdnArea").val(),
                    SubArea = $("#txtSubArea").val(),
                    SubAreaID = $("#hdnID").val();


                if (SubAreaID.length > 0) {
                    var isFormValid = $("#frmSubArea").valid();

                    if (isFormValid) {
                        AddSubArea(AreaID, SubArea, "edit", SubAreaID);
                        return false;
                    } else {
                        return false;
                    }
                } else {

                    var isFormValid = $("#frmSubArea").valid();

                    if (isFormValid) {
                        AddSubArea(AreaID, SubArea, "add", "0");
                        return false;
                    } else {
                        return false;
                    }
                }
            });

        });

        function AddSubArea(AreaID, subAreaName, operation, subAreaID) {

            $.ajax({
                type: "POST",
                //url: "/parshva/ParshvaService.asmx/AddSubArea",

                url: "<%=Session["Path"]%>" + "ParshvaService.asmx/AddSubArea",
                data: "{'SubAreaID': '" + subAreaID + "','SubAreaName':'" + subAreaName + "','Operation':'" + operation + "','AreaID':'" + AreaID + "' }",
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    if (operation == "add") {

                        if (result.d == "2") {
                            alert("Sub Area already exsist");
                        } else if (result.d == "1") {
                            //$("#dialog-sub-area").dialog("close");
                           // alert("Sub Area added successfully");
                            window.location.href = window.location.href;

                            // location.href = location.protocol+"//"+location.hostname+"/ViewArea.aspx";
                        } else if (result.d == "0") {
                            alert("Sub Area not added");
                        } else if (result.d == "-1") {
                            alert("Some internal problem");
                        }
                        console.log(result);

                    } else {
                        if (result.d == "2") {
                            alert("Sub Area already exsist");
                        } else if (result.d == "1") {
                            //$("#dialog-sub-area").dialog("close");
                            alert("Sub Area updated successfully");
                            window.location.href = window.location.href;

                            // location.href = location.protocol+"//"+location.hostname+"/ViewArea.aspx";
                        } else if (result.d == "0") {
                            alert("Sub Area not updated");
                        } else if (result.d == "-1") {
                            alert("Some internal problem");
                        }
                        console.log(result);

                    }
                }, error: function (xhr) {
                    console.log("Error:" + xhr.statusText);
                }
            });
        }

        function ShowSubArea() {

            console.log("Show Area");
            $("#txtArea").val('');
            $("#txtSubArea").val('');
            $("#hdnID").val('');
            $("#btnUpdateArea").hide();
            $("#btnAddSubArea").show();
            var validator = $("#frmSubArea").validate();
            validator.resetForm();
            $('#frmSubArea').removeClass('error');
            $("#dialog-sub-area").dialog("open");

        }

        function EditSubArea(ID) {

            $.ajax({
                type: "POST",
                //                url: "/parshva/ParshvaService.asmx/EditSubArea",
                url: "<%=Session["Path"]%>" + "ParshvaService.asmx/EditSubArea",
                data: "{'ID': '" + ID + "'}",
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    var area = $.parseJSON(result.d);
                    if (area == "2") {
                        alert("Sub Area already exsist");
                    } else if (area == "3") {
                        alert("Sub Area not found");
                    } else if (area == "-1") {
                        alert("Some internal problem");
                    } else {

                        var validator = $("#frmSubArea").validate();
                        validator.resetForm();
                        $('#frmSubArea').removeClass('error');

                        $("#dialog-sub-area").dialog("open");
                        $("#btnAddSubArea").hide();
                        $("#btnUpdateArea").show();

                        $("#txtSubArea").val(area.SubAreaName);
                        $("#txtArea").val(area.AreaName);

                        $("#hdnArea").val(area.AreaID);

                        $("#hdnID").val(area.ID);
                        console.log(result);
                    }
                }, error: function (xhr) {
                    console.log("Error:" + xhr.statusText);
                }
            });
        }
        function DeleteSubArea(ID) {
            $.ajax({
                type: "POST",
                //url: "/parshva/ParshvaService.asmx/DeleteSubArea",
                url: "<%=Session["Path"]%>" + "ParshvaService.asmx/DeleteSubArea",
                data: "{'ID': '" + ID + "'}",
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    if (result.d == "1") {
                        $("#dialog-sub-area").dialog("close");
                        alert("Sub Area deleted successfully.");
                        window.location.href = window.location.href;


                    } else if (result.d == "0") {
                        alert("Sub Area not deleted.");
                    } else if (result.d == "-1") {
                        alert("Some internal problem.");
                    } else if (result.d == "3") {
                        alert("Sub Area doesn't Exsist");
                    } else if (result.d == "4") {
                        alert("can't be deleted  it is used in hoarding");
                    }
                    console.log(result);
                }, error: function (xhr) {
                    console.log("Error:" + xhr.statusText);
                }
            });
        }
    </script>
    <style>
        .error {
            color: red;
        }
    </style>
</head>
<body>
    <div id="dialog-sub-area" title="Add / Edit Sub Area" style="display: block;">
        <form id="frmSubArea" method="post" enctype="multipart/form-data">
            <input type="hidden" id="hdnID" value="" />
            <input type="hidden" id="hdnArea" name="hdnArea" />
            <table>
                <tr>
                    <td>Select Area :</td>
                    <td>

                        <input type="text" id="txtArea" name="txtArea" />
                    </td>

                </tr>
                <tr>
                    <td>Enter Sub Area :</td>
                    <td>
                        <textarea id="txtSubArea" name="txtSubArea"></textarea></td>

                </tr>

                <tr>

                    <td colspan="2">
                        <input type="submit" id="btnAddSubArea" name="btnAddSubArea" value="Add Area" />
                        <input type="submit" id="btnUpdateArea" name="btnUpdateAddSubArea" value="Update Area" style="display: none" />
                    </td>

                </tr>
            </table>
        </form>


    </div>

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
                            <li><a href="HoardingMasterDetail.aspx">Home</a></li>
                             <li><a href="AdvanceBooking.aspx" >Advance Booking</a></li>
                            <li><a href="ViewUser.aspx">View Party</a></li>
                            <li><a href="ViewHoarding.aspx">View Hoarding</a></li>
                            <li><a href="ViewCity.aspx">View City</a></li>
                            <li><a href="ViewArea.aspx">View Area</a></li>
                            <li><a href="ViewSubArea.aspx" class="active">View Sub Area</a></li>
                            <li><a href="ViewHoardingMaster.aspx">Hoarding Master</a></li>

                            <li><a href="Logout.aspx">Log out</a></li>
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
                        <h1>View Sub Area</h1>
                        <div>


                            <input type="button" id="btnAdd" value="Add Sub Area" onclick="ShowSubArea();" />
                        </div>

                        <form id="form2" runat="server">
                            <asp:ScriptManager ID="sm" runat="server">
                            </asp:ScriptManager>
                            <asp:UpdatePanel ID="up" runat="server">
                                <ContentTemplate>

                                    <div>



                                        <asp:GridView ID="grdSubArea" DataKeyNames="ID" runat="server" AutoGenerateColumns="false" CssClass="custom-grid">
                                            <FooterStyle CssClass="footer" />
                                            <RowStyle CssClass="normal" />

                                            <PagerStyle CssClass="pager" />
                                            <AlternatingRowStyle CssClass="alternate" />
                                            <HeaderStyle CssClass="header" />


                                            <Columns>
                                               
                                                <asp:TemplateField HeaderText="ID">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblID" runat="server" Text='<%# Eval("ID")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Area Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblArea" runat="server" Text='<%# Eval("AreaName")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Sub Area">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSubArea" runat="server" Text='<%# Eval("SubAreaName")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <%--                   <asp:TemplateField HeaderText="IsActive">    
                        <ItemTemplate>
                            <%# Eval("IsActive")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                                                --%>
                                                <asp:TemplateField HeaderText="Action">
                                                    <ItemTemplate>
                                                        <a href="javascript:void(0)" onclick="EditSubArea('<%# Eval("ID")%>');">Edit</a> &nbsp;|&nbsp; 
                            <%--<asp:HyperLink ID="lnkEdit" runat="server" NavigateUrl='<%# "~/UserRegister.aspx?ID="+Eval("UserID")%>'>Edit</asp:HyperLink>--%>
                                                        <a href="javascript:void(0)" onclick="if(confirm('Are you sure want to delete record ?')){DeleteSubArea('<%# Eval("ID")%>');}">Delete</a>

                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                
                                            </Columns>
                                             <EmptyDataTemplate>
                                                No Record Found
                                            </EmptyDataTemplate>
                                        </asp:GridView>

                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
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
