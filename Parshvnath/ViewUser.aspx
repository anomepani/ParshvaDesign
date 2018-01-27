<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewUser.aspx.cs" Inherits="Parshvnath.ViewUser" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Party</title>

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

            $("#dialog-party").dialog({
                autoOpen: false,
                modal: true,
                width: 550,
                height: 300,
                resizable: false,
                draggable: false
            });
            $("#frmParty").validate({
                rules: {
                    txtCompanyName: "required",
                    txtPerson: "required",
                    txtCity: "required",
                    txtPhone: {
                        required: true
                        //,  number: true
                    },
                    txtEmail: {
                        email: true
                    },
                    txtCompanyAddress: "required"
                },
                messages: {
                    txtCompanyName: "Please enter company name",
                    txtPerson: "Please enter person name",

                    txtPhone: {
                        required: "Please enter phone"
                        //, number: "Please enter valid phone"
                    },
                    txtCompanyAddress: "Please enter address"
                },
                txtEmail: {
                    email: "Enter valid email"
                }, txtCity: "Enter City/Village Name"
            });
            $("#frmParty").submit(function () {
                var isFormValid = $("#frmParty").valid();
                var isPhoneExist = $("#hdnIsPhoneExist").val();
                var isCompanyExist = $("#hdnIsCompanyExist").val();
                var name = $("#txtCompanyName").val(),
                  phone = $("#txtPhone").val(),
                   address = $("#txtCompanyAddress").val(),
               email = $("#txtEmail").val(),
               personName = $("#txtPerson").val(),
                              city = $("#txtCity").val(),
                id = $("#hdnID").val();



                if (id.length > 0) {

                    var isFormValid = $("#frmParty").valid();
                    if (isFormValid) {
                        if ((isPhoneExist.length > 0 && isPhoneExist != "Available") || (isCompanyExist.length > 0 && isCompanyExist != "Available")) {
                            return false
                        } else {
                            AddUser(name, phone, address, email, "edit", id, personName, city);
                            return false;

                        }

                    } else {
                        return false;
                    }
                } else {

                    var isFormValid = $("#frmParty").valid();
                    if (isFormValid) {
                        if ((isPhoneExist.length > 0 && isPhoneExist != "Available") || (isCompanyExist.length > 0 && isCompanyExist != "Available")) {
                            return false
                        } else {
                            //company and phone not already exsist
                            AddUser(name, phone, address, email, "add", "0", personName, city);
                            return false;

                        }

                    } else {
                        return false;
                    }

                }
            });
        });

        function EditUser(UserID) {
            $.ajax({
                type: "POST",
                //                url: "/ParshvaService.asmx/EditUser",
                url: "<%=Session["Path"]%>" + "/ParshvaService.asmx/EditUser",
                data: "{'UserID': '" + UserID + "'}",
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    var user = $.parseJSON(result.d);
                    if (user == "-1") {
                        alert("Some internal problem.");
                    } else if (user == "3") {
                        alert("User doesn't Exist");
                    } else {

                        var validator = $("#frmParty").validate();
                        validator.resetForm();
                        $('#frmParty *').removeClass('error');
                        $("#btnAddParty").hide();
                        $("#btnUpdateParty").show();
                        $("#lblPhoneError").val('').hide();
                        $("#lblCompanyError").val('').hide();
                        $('#frmParty').removeClass('error');
                        $("#txtCompanyName").val(user.CompanyName);
                        $("#txtPhone").val(user.Phone);
                        $("#txtCity").val(user.City);
                        $("#txtPerson").val(user.PersonName);
                        $("#txtCompanyAddress").val(user.CompanyAddress);
                        $("#txtEmail").val(user.Email);
                        $("#hdnID").val(user.UserID);
                        console.log(result);
                        console.log(user);

                        $("#dialog-party").dialog('open');
                    }
                }, error: function (xhr) {
                    console.log("Error:" + xhr.statusText);
                }
            });

        }

        function DeleteUser(UserID) {
            $.ajax({
                type: "POST",
                //                url: "ParshvaService.asmx/DeleteUser",
                url: "<%=Session["Path"]%>" + "/ParshvaService.asmx/DeleteUser",
                data: "{'UserID': '" + UserID + "'}",
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    if (result.d == "1") {
                        $("#dialog-party").dialog('close');
                        alert("User deleted successfully.");
                        window.location.href = window.location.href;
                    } else if (result.d == "0") {
                        alert("User not deleted.");
                    } else if (result.d == "-1") {
                        alert("Some internal problem.");
                    } else if (result.d == "3") {
                        alert("User doesn't Exsist");
                    } else if (result.d == "4") {
                        alert("can't be deleted  it is used in hoarding");
                    }
                    console.log(result);
                }, error: function (xhr) {
                    console.log("Error:" + xhr.statusText);
                }
            });

        }

        function AddUser(Name, Phone, Address, Email, Operation, ID, PersonName, City) {
            $.ajax({
                type: "POST",
                //                url: "ParshvaService.asmx/AddUser",
                url: "<%=Session["Path"]%>" + "ParshvaService.asmx/AddUser",
                data: "{'Name': '" + Name + "','Phone':'" + Phone + "' ,'Address':'" + Address + "' ,'Email':'" + Email + "','Operation':'" + Operation + "','ID':'" + ID + "','PersonName':'" + PersonName + "','City':'" + City + "'  }",
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    if (Operation == "add") {
                        if (result.d == "1") {

                           // $("#dialog-party").dialog('close');
                            // alert("Party added successfully");
                            window.location.href = window.location.href;
                        } else if (result.d == "0") {
                            alert("Party not added");
                        } else if (result.d == "-1") {
                            alert("Some internal problem");
                        } else if (result.d == "2") {
                            alert("Party already exist");
                        }
                        console.log(result);
                    } else if (Operation == "edit") {
                        if (result.d == "1") {
                            //$("#dialog-party").dialog('close');
                            alert("Party updated successfully");
                            window.location.href = window.location.href;
                        } else if (result.d == "0") {
                            alert("Party not updated");
                        } else if (result.d == "-1") {
                            alert("Some internal problem");
                        } else if (result.d == "2") {
                            alert("Party already exist");
                        } else if (result.d == "3") {
                            alert("Party doesn't exist");
                        }
                        console.log(result);

                    }
                }, error: function (xhr) {
                    console.log("Error:" + xhr.statusText);
                }
            });
        }

        function ShowUser() {
            var validator = $("#frmParty").validate();

            validator.resetForm();


            $('#frmParty *').removeClass('error');
            $("#txtCompanyName").val('');
            $("#txtPhone").val('');
            $("#txtCompanyAddress").val('');
            $("#txtEmail").val('');
            $("#txtCity").val('');
            $("#lblPhoneError").val('').hide();
            $("#lblCompanyError").val('').hide();
            $('#hdnID').val('');
            $("#txtPerson").val('');
            $("#dialog-party").dialog("open");
            $("#btnAddParty").show();
            $("#btnUpdateParty").hide();

        }

        function ValidatePhone() {


            if ($("#txtPhone").val().length > 0) {

                $.ajax({
                    type: "POST",
                    url: "<%=Session["Path"]%>" + "ParshvaService.asmx/isPhoneExist",
                    // url: "ParshvaService.asmx/isPhoneExist",
                    data: "{'Phone': '" + $("#txtPhone").val() + "','ID': '" + ($("#hdnID").val().length > 0 ? $("#hdnID").val() : 0) + "'}",
                    contentType: "application/json",
                    dataType: "json",
                    success: function (result) {
                        console.log(result);
                        if (result.d === true) {
                            $("#hdnIsPhoneExist").val("Already Exist");
                            $("#lblPhoneError").val("Already Exist");
                            $("#lblPhoneError").show();

                        } else {
                            $("#hdnIsPhoneExist").val("Available");
                            $("#lblPhoneError").val("Available");
                            $("#lblPhoneError").hide();
                        }
                    }, error: function (xhr) {
                        console.log("Error:" + xhr.statusText);
                    }
                });
            }
        }
        function ValidateCompany() {

            if ($("#txtCompanyName").val().length > 0) {

                $.ajax({
                    type: "POST",
                    url: "<%=Session["Path"]%>" + "ParshvaService.asmx/isCompanyExist",
                    //url: "ParshvaService.asmx/isCompanyExist",
                    data: "{'CompanyName': '" + $("#txtCompanyName").val() + "','ID': '" + ($("#hdnID").val().length > 0 ? $("#hdnID").val() : 0) + "'}",
                    contentType: "application/json",
                    dataType: "json",
                    success: function (result) {
                        if (result.d === true) {
                            $("#hdnIsCompanyExist").val("Already Exist");
                            $("#lblCompanyError").val("Already Exist");
                            $("#lblCompanyError").show();
                        } else {
                            $("#hdnIsCompanyExist").val("Available");
                            $("#lblCompanyError").val("Available");
                            $("#lblCompanyError").hide();
                        }
                        console.log(result);
                    }, error: function (xhr) {
                        console.log("Error:" + xhr.statusText);
                    }
                });
            }

        }

    </script>
</head>
<body>




    <div id="dialog-party" title="Add Party" style="display: none;">
        <form id="frmParty" method="post" enctype="multipart/form-data">
            <input id="hdnID" type="hidden" />

            <input type="hidden" id="hdnIsCompanyExist" value="Available" />
            <input type="hidden" id="hdnIsPhoneExist" value="Available" />
            <table>
                <tr>
                    <td>Company Name : </td>
                    <td>

                        <input type="text" id="txtCompanyName" name="txtCompanyName" onblur="ValidateCompany();" />
                    </td>
                    <td>
                        <label id="lblCompanyError" style="color: red; display: none">Already Exsist</label></td>


                </tr>
                <tr>
                    <td>Company Address : </td>
                    <td>
                        <textarea id="txtCompanyAddress" name="txtCompanyAddress" rows="3" cols="30"></textarea>


                    </td>
                </tr>
                <tr>
                    <td>Person Name: </td>
                    <td>
                        <input type="text" id="txtPerson" name="txtPerson" />
                    </td>

                </tr>

                <tr>
                    <td>Phone : </td>
                    <td>

                        <input type="text" id="txtPhone" name="txtPhone" maxlength="15" onblur="ValidatePhone();" />
                    </td>
                    <td>
                        <label id="lblPhoneError" style="color: red; display: none;">Already Exsist</label></td>
                </tr>
                <tr>
                    <td>Email :</td>
                    <td>
                        <input type="text" id="txtEmail" name="txtEmail" /></td>

                </tr>
                <tr>
                    <td>City/Village :</td>
                    <td>
                        <input type="text" id="txtCity" name="txtCity" /></td>

                </tr>



                <tr>

                    <td colspan="2">
                        <input type="submit" id="btnAddParty" name="btnAddParty" value="Add Party" />
                        <input type="submit" id="btnUpdateParty" name="btnUpdateParty" value="Update Party" /></td>

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
                <%--<div class="ask">
                        <a href="contact_us.html">
                            <img src="images/ask.jpg" alt="" title="" /></a>

                    </div>--%>
                <!-- start menu part-->
                <div id="Nav">
                    <div class="Nav_Left">&nbsp;</div>
                    <div class="Nav_Center">
                        <ul class="main_nav">
                            <li><a href="HoardingMasterDetail.aspx">Home</a></li>
                             <li><a href="AdvanceBooking.aspx" >Advance Booking</a></li>
                            <li><a href="ViewUser.aspx" class="active">View Party</a></li>
                            <li><a href="ViewHoarding.aspx">View Hoarding</a></li>
                            <li><a href="ViewCity.aspx">View City</a></li>
                            <li><a href="ViewArea.aspx">View Area</a></li>
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
                        <h1>View User</h1>
                        <form id="form1" runat="server">
                            <asp:ScriptManager ID="sm" runat="server">
                            </asp:ScriptManager>
                            <asp:UpdatePanel ID="up" runat="server">
                                <ContentTemplate>
                                    <div>

                                        <input type="button" id="btnAdd" value="Add Party" onclick="ShowUser();" />

                                        <asp:GridView ID="grdUser" DataKeyNames="UserID" runat="server" AutoGenerateColumns="False" CssClass="custom-grid">
                                            <FooterStyle CssClass="footer" />
                                            <RowStyle CssClass="normal" />

                                            <PagerStyle CssClass="pager" />
                                            <AlternatingRowStyle CssClass="alternate" />
                                            <HeaderStyle CssClass="header" />


                                            <Columns>
                                                <%--                                                <asp:TemplateField HeaderText="UserID">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblId" runat="server" Text='<%# Eval("UserID")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>--%>
                                                <asp:TemplateField HeaderText="Party Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("CompanyName")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Person Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPersonName" runat="server" Text='<%# Eval("PersonName")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Email">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Address">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("CompanyAddress")%>'></asp:Label>
                                                    </ItemTemplate>

                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Phone Number">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPhoneNo" runat="server" Text='<%# Eval("PhoneNo")%>'></asp:Label>
                                                    </ItemTemplate>

                                                </asp:TemplateField>
                                                <%--<asp:TemplateField HeaderText="City">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCity" runat="server" Text='<%# Eval("City")%>'></asp:Label>
                                                    </ItemTemplate>

                                                </asp:TemplateField>--%>

                                                <%--                                            
        <asp:TemplateField HeaderText="IsActive">
                                                    <ItemTemplate>
                                                        <%# Eval("IsActive")%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>--%>
                                                <asp:TemplateField HeaderText="Action">
                                                    <ItemTemplate>

                                                        <a href="javascript:void(0)" onclick="EditUser('<%# Eval("UserID")%>');">Edit</a> &nbsp;|&nbsp; 
                            <%--<asp:HyperLink ID="lnkEdit" runat="server" NavigateUrl='<%# "~/UserRegister.aspx?ID="+Eval("UserID")%>'>Edit</asp:HyperLink>--%>
                                                        <a href="javascript:void(0)" onclick="if(confirm('Are you sure want to delete record ?')){DeleteUser('<%# Eval("UserID")%>');}">Delete</a>

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
