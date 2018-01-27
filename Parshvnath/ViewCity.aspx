<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewCity.aspx.cs" Inherits="Parshvnath.ViewCity" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>City Details</title>

    <link href="Css/jquery-ui.css" rel="stylesheet" />
    <link href="Css/Site.css" rel="stylesheet" />
    <link href="Css/ParswaCommon.css" rel="stylesheet" />
    <script src="Script/jquery.min.js"></script>
    <script src="Script/jquery-ui.min.js"></script>

    <script src="Script/jquery.validate.js"></script>
    <script src="Script/additional-methods.js"></script>
    <style>
        .error {
            color: red;
        }
    </style>
    <script>
        $(function () {
            $("#dialog-city").dialog({
                autoOpen: false,
                modal: true,
                width: 400,
                resizable: false,
                draggable: false
            });

            $("#frmCity").validate({
                rules: {
                    txtCityName: {
                        required: true
                    }
                }, messages: {
                    txtCityName: {
                        required: " *"
                    }

                }
            });



            $("#frmCity").submit(function () {

                var city = $("#txtCityName").val();
                var id = $("#hdnID").val();
                if (id.length > 0) {
                    var isFormValid = $("#frmCity").valid();
                    if (isFormValid) {
                        AddCity(city, id, "edit");
                        return false;
                    } else {
                        return false;
                    }
                } else {
                    var isFormValid = $("#frmCity").valid();
                    if (isFormValid) {
                        AddCity(city, "0", "add");
                        return false;
                    } else {
                        return false;
                    }
                }


            });



        });

        function AddCity(cityName, id, operation) {

            $.ajax({
                type: "POST",
                //url: "/parshva/ParshvaService.asmx/AddCity",
                url: "<%=Session["Path"]%>" + "ParshvaService.asmx/AddCity",
                data: "{'CityName': '" + cityName + "' ,'ID': '" + id + "' ,'Operation': '" + operation + "' }",
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    if (operation == "add") {
                        if (result.d == "1") {
                         //   alert("City added successfully");
                            window.location.href = window.location.href;
                           // location.href = "../ViewCity.aspx";
                        } else if (result.d == "0") {
                            alert("City not added");
                        } else if (result.d == "2") {
                            alert("City already exist");
                        }
                        else if (result.d == "-1") {
                            alert("Some internal problem");
                        }
                    } else {
                        if (result.d == "1") {
                            alert("City updated successfully");
                            window.location.href = window.location.href;
                           // location.href = "../ViewCity.aspx";
                        } else if (result.d == "0") {
                            alert("City not updated");
                        } else if (result.d == "2") {
                            alert("City already exist");
                        }
                        else if (result.d == "-1") {
                            alert("Some internal problem");
                        }
                    }
                }, error: function (xhr) {
                    console.log("Error:" + xhr.statusText);
                }
            });
        }


        function ShowCity() {

            $("#txtCityName").val('');

            var validator = $("#frmCity").validate();
            validator.resetForm();
            $('.error').removeClass('error');
            $("#dialog-city").dialog("open");
            $("#btnUpdateCity").hide();
            $("#btnAddCity").show();

            $("#hdnID").val('');

        }

        function EditCity(ID) {
            $.ajax({
                type: "POST",
                //url: "/parshva/ParshvaService.asmx/EditCity",
                url: "<%=Session["Path"]%>" + "ParshvaService.asmx/EditCity",
                data: "{'ID': '" + ID + "'}",
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    if (result.d.length > 2) {
                        var validator = $("#frmCity").validate();
                        validator.resetForm();
                        $('.error').removeClass('error');
                        $("#dialog-city").dialog('open');
                        $("#btnUpdateCity").show();
                        $("#btnAddCity").hide();
                        $("#txtCityName").val(result.d);
                        $("#hdnID").val(ID);
                        console.log(result);
                    } else {
                        alert("No Record found");
                        console.log(result);
                    }
                }, error: function (xhr) {
                    console.log("Error:" + xhr.statusText);
                }
            });

        }

        function DeleteCity(ID) {
            $.ajax({
                type: "POST",
                //url: "/parshva/ParshvaService.asmx/DeleteCity",
                url: "<%=Session["Path"]%>" + "ParshvaService.asmx/DeleteCity",
                data: "{'ID': '" + ID + "'}",
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    if (result.d == "1") {
                        alert("City deleted successfully.");
                        location.href = "../ViewCity.aspx";
                    } else if (result.d == "0") {
                        alert("City not deleted.");
                    } else if (result.d == "-1") {
                        alert("Some internal problem.");
                    } else if (result.d == "3") {
                        alert("City doesn't Exist");
                    } else if (result.d == "4") {
                        alert("City can't be deleted now");
                    }
                    console.log(result);
                }, error: function (xhr) {
                    console.log("Error:" + xhr.statusText);
                }
            });
        }


    </script>
</head>
<body>

    <div id="dialog-city" title="Add /Edit City" style="display: none;">
        <form id="frmCity" method="post" enctype="multipart/form-data">
            <input type="hidden" id="hdnID" name="hdnID" />
            <table>
                <tr>
                    <td>Enter City Name :</td>
                    <td>
                        <input type="text" id="txtCityName" name="txtCityName" maxlength="20" /></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" id="btnAddCity" name="btnAddCity" value="Save" />
                        <input type="submit" id="btnUpdateCity" name="btnUpdateCity" value="Update" style="display: none" />
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
                        <ul class="main_nav">  <li><a href="HoardingMasterDetail.aspx">Home</a></li>
                             <li><a href="AdvanceBooking.aspx" >Advance Booking</a></li>
                            <li><a href="ViewUser.aspx">View Party</a></li>
                            <li><a href="ViewHoarding.aspx">View Hoarding</a></li>
                            <li><a href="ViewCity.aspx" class="active">View City</a></li>
                            <li><a href="ViewArea.aspx">View Area</a></li><li><a href="ViewSubArea.aspx">View Sub Area</a></li>
                            
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
                        <h1>View City</h1>


                        <form id="form1" runat="server">
                            <asp:ScriptManager ID="sm" runat="server">
                            </asp:ScriptManager>
                            <asp:UpdatePanel ID="up" runat="server">
                                <ContentTemplate>

                                    <div>


                                        <input type="button" id="btnAdd" value="Add City" onclick="ShowCity();" />

                                        <asp:GridView ID="grdCity" CssClass="custom-grid" DataKeyNames="ID" runat="server" AutoGenerateColumns="False">
                                            <FooterStyle CssClass="footer" />
                                            <RowStyle CssClass="normal" />

                                            <PagerStyle CssClass="pager" />
                                            <AlternatingRowStyle CssClass="alternate" />
                                            <HeaderStyle CssClass="header" />

                                            <Columns>
                                                <%--               <asp:TemplateField HeaderText="UserID">
                        <ItemTemplate>
                            <asp:Label ID="lblId" runat="server" Text='<%# Eval("UserID")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                                                --%>
                                                <asp:TemplateField HeaderText="City Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCityName" runat="server" Text='<%# Eval("CityName")%>'></asp:Label>
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
                                                        <a href="javascript:void(0)" onclick="EditCity('<%# Eval("ID")%>');">Edit</a> &nbsp;|&nbsp; 
                            <%--<asp:HyperLink ID="lnkEdit" runat="server" NavigateUrl='<%# "~/UserRegister.aspx?ID="+Eval("UserID")%>'>Edit</asp:HyperLink>--%>
                                                        <a href="javascript:void(0)" onclick="if(confirm('Are you sure want to delete record ?')){DeleteCity('<%# Eval("ID")%>');}">Delete</a>

                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                            </Columns>

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
