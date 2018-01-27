<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewArea.aspx.cs" Inherits="Parshvnath.ViewArea" %>

<!DOCTYPE html>

<html>
<head>
    <title>View Area </title>

    <link href="Css/jquery-ui.css" rel="stylesheet" />
    <link href="Css/Site.css" rel="stylesheet" />
    <link href="Css/ParswaCommon.css" rel="stylesheet" />
    <script src="Script/jquery.min.js"></script>
    <script src="Script/jquery-ui.min.js"></script>

    <script src="Script/jquery.validate.js"></script>
    <script src="Script/additional-methods.js"></script>
    <script>

        $(function () {

            //BindCity();

            $("#city").autocomplete({
                appendTo: "#dialog-area",
                // source: availableTags
                source: function (request, response) {
                    console.log(request.term);
                    $.ajax({
                        type: "POST",
                        //url: "/parshva/ParshvaService.asmx/GetCity",
                        url: "<%=Session["Path"]%>" + "ParshvaService.asmx/GetCity",
                        data: "{'City':'" + $('#city').val() + "'}",
                        contentType: "application/json",
                        dataType: "json",
                        success: function (result) {

                            if (result.d.length > 0) {

                                response($.map(result.d, function (item) {
                                    //        console.log(item);
                                    return {
                                        label: item.CityName,
                                        val: item.ID
                                    }
                                }));
                            } else {
                                //handle if no city found
                                console.log("No City Found");
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
                    $("#city").val(ui.item.value);
                    console.log(ui.item.label);
                    console.log(ui.item.value);
                    $("#hdnCity").val(ui.item.val);
                }, change: function (event, ui) {
                    if (ui.item == null || ui.item == undefined) {
                        //this condition for edit mode
                        if ($("#hdnCity").trim().val().length == 0) {
                            $("#city").val("");
                            $("#city").attr("disabled", false);
                            $("#hdnCity").val("");
                            $("#hdnCity").attr("disabled", false);
                        }
                    } else {

                        $("#txtArea").attr("disabled", false);
                        $("#hdnCity").attr("disabled", false);

                    }
                }
            });
            $("#dialog-area").dialog({
                autoOpen: false,
                modal: true,
                width: 400,
                resizable: false,
                draggable: false
            });

            $("#frmArea").validate({
                rules: {
                    txtAreaName: {
                        required: true
                    },
                    city: {
                        required: true
                    }
                }, messages: {
                    txtAreaName: {
                        required: " *"
                    },
                    city: {
                        required: "Select City"
                    }

                }
            });

            $("#frmArea").submit(function () {

                var city = $("#hdnCity").val(),
                    area = $("#txtAreaName").val(),
                    AreaID = $("#hdnID").val();

                if (AreaID.length > 0) {
                    var isFormValid = $("#frmArea").valid();

                    if (isFormValid) {
                        AddArea(city, area, "edit", AreaID);
                        return false;
                    } else {
                        return false;
                    }
                } else {

                    var isFormValid = $("#frmArea").valid();

                    if (isFormValid) {
                        AddArea(city, area, "add", "0");
                        return false;
                    } else {
                        return false;
                    }
                }
            });

        });

        function BindCity() {
        }



        function AddArea(cityID, areaName, operation, AreaID) {
            $.ajax({
                type: "POST",
                //url: "/parshva/ParshvaService.asmx/AddArea",
                url: "<%=Session["Path"]%>" + "ParshvaService.asmx/AddArea",
                data: "{'CityID': '" + cityID + "','AreaName':'" + areaName + "','Operation':'" + operation + "','ID':'" + AreaID + "' }",
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    if (operation == "add") {


                        if (result.d == "1") {

                            $("#dialog-area").dialog("close");
                            // alert("Area added successfully");

                            window.location.href = window.location.href;
                            //location.href = "../ViewArea.aspx";
                        } else if (result.d == "2") {
                            alert("Area already exist");
                        }
                        else if (result.d == "0") {
                            alert("Area not added");
                        } else if (result.d == "-1") {
                            alert("Some internal problem");
                        }
                        console.log(result);

                    } else {
                        if (result.d == "1") {
                            $("#dialog-area").dialog("close");
                            //alert("Area updated successfully");
                            window.location.href = window.location.href;
                            //location.href = "../ViewArea.aspx";
                        } else if (result.d == "2") {
                            alert("Area already exist");
                        }
                        else if (result.d == "0") {
                            alert("Area not updated");
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

        function ShowArea() {

            console.log("Show Area");
            $("#txtAreaName").val('');
            $("#city").val('');
            $("#hdnCity").val('');
            $("#hdnID").val('');
            $("#btnUpdateArea").hide();
            $("#btnAddArea").show();
            var validator = $("#frmArea").validate();
            //validator.resetForm();
            $('#frmArea').removeClass('error');
            $("#dialog-area").dialog("open");

        }

        function EditArea(ID) {

            $.ajax({
                type: "POST",
                //url: "/parshva/ParshvaService.asmx/EditArea",
                url: "<%=Session["Path"]%>" + "ParshvaService.asmx/EditArea",
                data: "{'ID': '" + ID + "'}",
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    var area = $.parseJSON(result.d);

                    if (area == "3") {
                        alert("Area not found");
                    }
                    else if (area == "-1") {
                        alert("Some internal problem");
                    } else {

                        var validator = $("#frmArea").validate();
                        validator.resetForm();
                        $('#frmArea').removeClass('error');

                        $("#dialog-area").dialog("open");
                        $("#btnAddArea").hide();
                        $("#btnUpdateArea").show();

                        $("#txtAreaName").val(area.AreaName);
                        $("#city").val(area.CityName);
                        $("#hdnCity").val(area.CityID);
                        $("#hdnID").val(area.ID);
                        console.log(result);
                    }
                }, error: function (xhr) {
                    console.log("Error:" + xhr.statusText);
                }
            });
        }

        function DeleteArea(ID) {
            $.ajax({
                type: "POST",
                //url: "/parshva/ParshvaService.asmx/DeleteArea",
                url: "<%=Session["Path"]%>" + "ParshvaService.asmx/DeleteArea",
                data: "{'ID': '" + ID + "'}",
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    if (result.d == "1") {
                        $("#dialog-area").dialog("close");
                        alert("Area deleted successfully.");
                        window.location.href = window.location.href;
                    } else if (result.d == "0") {
                        alert("Area not deleted.");
                    } else if (result.d == "-1") {
                        alert("Some internal problem.");
                    } else if (result.d == "3") {
                        alert("Area doesn't Exsist");
                    }
                    else if (result.d == "4") {
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
    <div id="dialog-area" title="Add/Edit Area">

        <form id="frmArea">
            <input type="hidden" id="hdnCity" name="hdnCity" />
            <input type="hidden" id="hdnID" name="hdnID" />
            <table>
                <tr>
                    <td>Select City :</td>

                    <td>
                        <input type="text" id="city" name="city" />
                    </td>
                </tr>
                <tr>
                    <td>Enter Area Name :</td>
                    <td>
                        <textarea id="txtAreaName" name="txtAreaName"></textarea></td>
                </tr>
                <tr>

                    <td colspan="2">
                        <input type="submit" id="btnAddArea" name="btnAddArea" value="Add Area" />
                        <input type="submit" id="btnUpdateArea" name="btnUpdateAddArea" value="Update Area" style="display: none" />
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
                            <li><a href="ViewArea.aspx" class="active">View Area</a></li>
                            <li><a href="ViewSubArea.aspx">View Sub Area</a></li>

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
                        <h1>View Area</h1>



                        <input type="button" id="btnAdd" value="Add Area" onclick="ShowArea();" />
                        <form id="form1" runat="server">
                            <asp:ScriptManager ID="sm" runat="server">
                            </asp:ScriptManager>
                            <asp:UpdatePanel ID="up" runat="server">
                                <ContentTemplate>

                                    <div>


                                        <asp:GridView ID="grdArea" DataKeyNames="ID" runat="server" AutoGenerateColumns="false" CssClass="custom-grid">
                                            <FooterStyle CssClass="footer" />
                                            <RowStyle CssClass="normal" />

                                            <PagerStyle CssClass="pager" />
                                            <AlternatingRowStyle CssClass="alternate" />
                                            <HeaderStyle CssClass="header" />


                                            <Columns>
                                                <asp:TemplateField HeaderText="City Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCityName" runat="server" Text='<%# Eval("CityName")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Area Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblArea" runat="server" Text='<%# Eval("AreaName")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Action">
                                                    <ItemTemplate>
                                                        <a href="javascript:void(0)" onclick="EditArea('<%# Eval("ID")%>');">Edit</a> &nbsp;|&nbsp; 
                            <a href="javascript:void(0)" onclick="if(confirm('Are you sure want to delete record ?')){DeleteArea('<%# Eval("ID")%>');}">Delete</a>

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
