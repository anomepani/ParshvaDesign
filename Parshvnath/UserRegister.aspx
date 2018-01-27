<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserRegister.aspx.cs" Inherits="Parshvnath.UserRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registration</title>
    <link href="Css/jquery-ui.css" rel="stylesheet" />
    <link href="Css/Site.css" rel="stylesheet" />
    <link href="Css/ParswaCommon.css" rel="stylesheet" />
    <script src="Script/jquery.min.js"></script>
    <script src="Script/jquery-ui.min.js"></script>

    <script src="Script/jquery.validate.js"></script>
    <script src="Script/additional-methods.js"></script>
    <script>
        $(function () {
            console.log("DOM Is Ready");
            $("#aspNetForm").validate({
                rules: {
                    txtCompanyName: "required",
                    txtPersonName: "required",
                    txtCity: "required",
                    txtPhone: {
                        required: true,
                        number: true
                    },
                    txtEmail: {
                        email: true
                    },
                    txtCompanyAddress: "required"
                },
                messages: {
                    txtCompanyName: "Please enter company name",
                    txtPersonName: "Please enter person name",

                    txtPhone: {
                        required: "Please enter phone",
                        number: "Please enter valid phone"
                    },
                    txtCompanyAddress: "Please enter address"
                },
                txtEmail: {
                    email: "Enter valid email"
                }
                , txtCity: "Enter City/Village Name"
            });

            $("#aspNetForm").submit(function () {
                var isFormValid = $("#aspNetForm").valid();
                var isPhoneExist = $("#hdnIsPhoneExist").val();
                var isCompanyExist = $("#hdnIsCompanyExist").val();

                if (isFormValid) {

                    if ((isPhoneExist.length > 0 && isPhoneExist != "Available") || (isCompanyExist.length > 0 && isCompanyExist != "Available")) {
                        return false;
                    } else {
                        return true;
                    }
                } else {
                    return false;
                }
            });


        });
        function ValidatePhone() {


            if ($("#txtPhone").val().length > 0) {

                $.ajax({
                    type: "POST",
                    url: "UserRegister.aspx/isPhoneExist",
                    data: "{'Phone': '" + $("#txtPhone").val() + "'}",
                    contentType: "application/json",
                    dataType: "json",
                    success: function (result) {
                        console.log(result);
                        if (result === true) {
                            $("#hdnIsPhoneExist").val("Already Exist");
                        } else {
                            $("#hdnIsPhoneExist").val("Available");
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
                    url: "UserRegister.aspx/isCompanyExist",
                    data: "{'companyName': '" + $("#txtCompanyName").val() + "'}",
                    contentType: "application/json",
                    dataType: "json",
                    success: function (result) {
                        if (result === true) {
                            $("#hdnIsCompanyExist").val("Already Exist");
                        } else {
                            $("#hdnIsCompanyExist").val("Available");
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
                            <li><a href="ViewUser.aspx" class="active">View Party</a></li>
                            <li><a href="ViewHoarding.aspx">View Hoarding</a></li>
                            <li><a href="ViewCity.aspx">View City</a></li>
                            <li><a href="ViewArea.aspx">View Area</a></li><li><a href="ViewSubArea.aspx">View Sub Area</a></li>
                            
                            
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
                        <h1>Report</h1>

                        <form id="aspNetForm" runat="server">
                            <input type="hidden" id="hdnIsCompanyExist" value="Available" />
                            <input type="hidden" id="hdnIsPhoneExist" value="Available" />
                            <fieldset>
                                <legend>Party Form</legend>

                                <table>
                                    <tr>
                                        <td>Company Name : </td>
                                        <td>
                                            <asp:TextBox ID="txtCompanyName" runat="server" onblur="ValidateCompany();" /></td>
                                    </tr>
                                    <tr>
                                        <td>Company Address : </td>
                                        <td>

                                            <asp:TextBox ID="txtCompanyAddress" runat="server" />

                                        </td>
                                    </tr>

                                    <tr>
                                        <td>Person Name : </td>
                                        <td>
                                            <asp:TextBox ID="txtPerson" runat="server" /></td>
                                    </tr>
                                    <tr>
                                        <td>Phone : </td>
                                        <td>
                                            <asp:TextBox ID="txtPhone" runat="server" MaxLength="10" onblur="ValidatePhone();" />

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Email : </td>
                                        <td>
                                            <asp:TextBox ID="txtEmail" runat="server" /></td>
                                    </tr>

                                    <tr>
                                        <td>City : </td>
                                        <td>
                                            <asp:TextBox ID="txtCity" runat="server" /></td>
                                    </tr>

                                    <tr>
                                        <td colspan="2">
                                            <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" />
                                        </td>
                                    </tr>
                                </table>

                            </fieldset>
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
