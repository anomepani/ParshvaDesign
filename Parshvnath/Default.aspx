<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Parshvnath.AdminLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Welcome, Parshva Designer</title>

    <!-- Reset Stylesheet -->
    <link rel="stylesheet" href="resources/css/reset.css" type="text/css" media="screen" />

    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="resources/css/style.css" type="text/css" media="screen" />

    <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
    <link rel="stylesheet" href="resources/css/invalid.css" type="text/css" media="screen" />


    <%--    <link href="Css/jquery-ui.css" rel="stylesheet" />
     <link href="Css/Site.css" rel="stylesheet" />
    <link href="Css/ParswaCommon.css" rel="stylesheet" />--%>
    <script src="Script/jquery.min.js"></script>
    <script src="Script/jquery-ui.min.js"></script>
    <script src="Script/jquery.validate.js"></script>
    <script src="Script/additional-methods.js"></script>
    <script>
        $(function () {
            console.log("DOM Is Ready");
            $("#aspNetForm").validate({
                rules: {
                    txtUsername: "required",
                    txtPassword: "required"
                },
                messages: {
                    txtUsername: "Enter Username",
                    txtPassword: "Enter Password"
                }
            });

            $("#aspNetForm").submit(function () {
                var isFormValid = $("#aspNetForm").valid();
                if (isFormValid) {
                    return true;
                } else {
                    return false;
                }
            });


        });
    </script>
    <style>
        #login-content label.error {
            color: red!important;
            margin-left: 90px;
            width: 125px!important;
        }
    </style>
</head>



<body id="login">
    <div id="login-wrapper" class="png_bg">
        <div id="login-top">

            <h1>Parshva Designer</h1>
            <!-- Logo (221px width) -->
            <img id="logo" src="" alt="Parshva Designer logo" />
        </div>
        <!-- End #logn-top -->

        <div id="login-content">

            <form id="aspNetForm" runat="server">

                <p>
                    <label>Username</label>

                    <asp:TextBox ID="txtUsername" runat="server" CssClass="text-input" />

                </p>
                <div class="clear"></div>
                <p>
                    <label>Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="text-input" />


                </p>
                <div class="clear"></div>
                <asp:Label Visible="false" ID="lblStatus" Text="" runat="server"  ForeColor="Red"/>
                <div class="clear"></div>
                <p>
                    <asp:Button ID="btnLogin" runat="server" Text="Sign In" OnClick="btnLogin_Click" CssClass="button" />

                </p>

            </form>
        </div>
        <!-- End #login-content -->

    </div>
    <!-- End #login-wrapper -->

</body>

</html>

