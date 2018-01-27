<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewHoarding.aspx.cs" Inherits="Parshvnath.ViewHoarding" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Hording Entry</title>

    <link href="Css/jquery-ui.css" rel="stylesheet" />
    <link href="Script/Plugin/uploadify/uploadify.css" rel="stylesheet" />
    <link href="Css/Site.css" rel="stylesheet" />
    <link href="Css/ParswaCommon.css" rel="stylesheet" />
    <script src="Script/jquery.min.js"></script>
    <script src="Script/jquery-ui.min.js"></script>
    <script src="Script/jquery.validate.js"></script>
    <script src="Script/additional-methods.js"></script>
    <script src="Script/Plugin/uploadify/jquery.uploadify.js"></script>
    <script src="Script/moment.js"></script>

    <style>
        .frm table {
            font-size: 16px;
            font-weight: bold;
        }
    </style>
    <script>
        function EditDialog(index) {
            var pages = "<%=Session["Path"]%>" + "Hoarding.aspx?HoardingHistoryID=" + index;

            //var pages = "/Parshva/Hoarding.aspx?HoardingHistoryID=" + index;
            $("#response").html('');
            var htmlLoading = '<div id="loadingMessage" style="height: auto; width: auto; background-color: #fff;">Loading...</div>';
            var htmlIframe = '<iframe class="frame" src="" width="100%" height="100%"></iframe>';
            $("#response").append(htmlLoading);
            $("#response").append(htmlIframe);

            $(".frame").attr("src", pages);
            $('#loadingMessage').show();
            setTimeout(function () { $('#loadingMessage').hide() }, 500);

            $('#response').dialog({ width: 630, height: 500, draggable: true, closeOnEscape: false, modal: true, autoOpen: false, resizable: true }).dialog("open");
        }


        $(window).load(
            function () {

                $("#hoardingFile").uploadify({

                    'swf': 'script/plugin/uploadify/uploadify.swf',
                    'uploader': 'FileUploader.ashx',
                    'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
                    'onUploadSuccess': function (file, data, response) {
                        //    alert('The file ' + file.name + ' was successfully uploaded with a response of ' + response + ':' + data);
                        $("#hdnFile").val(data);
                        $("#imgBanner").attr("src", "<%=Session["Path"]%>" + "Images/HoardingImage/" + data).show();

                        //alert('The File' + file.name + "was successfully uploaded with a response :" + data);
                    }

                });

            }
);
            $(function () {

                $("#dialog-city").dialog({
                    autoOpen: false,
                    modal: true,
                    width: 300,
                    resizable: false,
                    draggable: false
                });
                $("#dialog-area").dialog({
                    autoOpen: false,
                    modal: true,
                    width: 500,
                    height: 350,
                    resizable: false,
                    draggable: false
                });
                $("#dialog-hoarding").dialog({
                    autoOpen: false,
                    modal: true,
                    width: 550,
                    height: 500,
                    resizable: false,
                    draggable: false
                });



                $("#frmHoarding").validate({
                    rules: {
                        txtHoardingNo: {
                            required: true
                        },
                        txtMonthlyAmount: {
                            required: true,
                            number: true
                        },
                        txtDayOrMonth: {
                            required: true,
                            number: true
                        },

                        txtFromDate: {
                            required: true
                        },

                        txtToDate: {
                            required: true
                        },
                        ddlCity: {
                            required: true
                        },
                        ddlArea: {
                            required: true,
                            validateArea: true
                        },
                        fileHoardingImage: {
                            accept: "image/jpeg,image/pjpeg,image/jpg,image/png,image/gif"

                        }
                    },
                    messages: {
                        txtHoardingNo: {
                            required: "Enter Hoarding Number"
                        },
                        txtMonthlyAmount: {
                            required: "Enter Amount",
                            number: "Enter Valid Amount"
                        },
                        txtFromDate: {
                            required: "Enter From Date"
                        },
                        txtDayOrMonth: {
                            required: "Enter No Of Month Or Day"
                        },

                        txtToDate: {
                            required: "Enter To Date"
                        },
                        ddlCity: {
                            required: "Select One City"
                        },
                        ddlArea: {
                            required: "Select One Area"
                        },
                        fileHoardingImage: {
                            accept: "Enter valid file format"

                        }
                    }
                });

                $("#frmHoarding").submit(function () {
                    var isFormValid = $("#frmHoarding").valid();

                    if (isFormValid) {

                        var option = {
                            ID: $("#hdnID").val()
                            , HoardingNo: $("#txtHoardingNo").val()
                            , User: $("#ddlCity").val()
                            , Area: $("#ddlArea").val()
                            , City: $("#ddlCity").val()
                            , FromDate: $("#txtFromDate").val()
                            , ToDate: $("#txtToDate").val()
                            , Amount: $("#txtMonthlyAmount").val()
                            , FileName: $("#hdnFile").val()
                        }
                        UpdateHoarding(option)
                        return false;
                    } else {
                        return false;
                    }
                });




                $.validator.addMethod("validateArea", function (value, element) {
                    if (value == "-1") {
                        return false;
                    } else {
                        return true;
                    }
                }, "No area selected");


            });

            function UpdateHoarding(param) {


                $.ajax({
                    type: "POST",
                    url: "ViewHoarding.aspx/UpdateHoarding",
                    data: "{'ID':'" + param.ID + "', 'HoardingNo':'" + param.HoardingNo + "','User':'" + param.User + "','Area':'" + param.Area + "','City':'" + param.City + "','FromDate':'" + param.FromDate + "','ToDate':'" + param.ToDate + "','Amount':'" + param.Amount + "','FileName':'" + param.FileName + "'}",
                    contentType: "application/json",
                    dataType: "json",
                    success: function (result) {
                        if (result.d == "1") {
                            alert("Hoarding Detail Updated successfully");
                            // location.href = "../CityDetails.aspx";
                        } else if (result.d == "0") {
                            alert("Hoarding Detail not added");
                        } else if (result.d == "-1") {
                            alert("Some internal problem");
                        } else {
                            alert("Hoarding Detail Doesn't exsist");
                        }

                    }, error: function (xhr) {
                        console.log("Error:" + xhr.statusText);
                    }
                });


            }
       
         
            function DayChange() {
                console.log("Day changed");
                DayOrMonthChange();
            }
            function MonthChange() {
                console.log("Month Changed");
                DayOrMonthChange();
            }

            function DayOrMonthChange() {
                var rdo = $("input[name='rdoDayOrMonth']:checked").val();

                console.log(rdo);
                var DayOrMonth = $("#txtDayOrMonth").val();
                var from = $("#txtFromDate").val();
                var toDate, fromDate;

                if ((rdo == null || rdo.length <= 0) && moment(fromDate).isValid()) {
                    alert("Please select Day or Month");
                } else {
                    console.log(rdo);
                    if (moment(fromDate).isValid()) {


                        if (rdo == "day" && !isNaN(DayOrMonth) && DayOrMonth.length > 0) {
                            var toDate = moment($("#txtFromDate").val(), "DD/MM/YYYY").add(DayOrMonth, "days");
                            $("#txtToDate").val(toDate.format("DD/MM/YYYY"));
                            console.log(toDate);



                        } else if (rdo == "month" && !isNaN(DayOrMonth) && DayOrMonth.length > 0) {
                            var toDate = moment($("#txtFromDate").val(), "DD/MM/YYYY").add(DayOrMonth, "months");
                            $("#txtToDate").val(toDate.format("DD/MM/YYYY"));
                            console.log(toDate);

                        }
                    } else {
                        alert("Enter valid date");
                    }
                }
            }

            function EditHoarding(HoardingID) {

                $.ajax({
                    type: "POST",
                    url: "ViewHoarding.aspx/EditHoarding",
                    data: "{'ID': '" + HoardingID + "'}",
                    contentType: "application/json",
                    dataType: "json",
                    success: function (result) {
                        var hoarding = $.parseJSON(result.d);
                        if (hoarding == "-1") {
                            alert("Some internal problem.");
                        } else if (hoarding == "3") {
                            alert("Hoarding doesn't Exist");
                        } else {
                            console.log(hoarding);
                            var fromDate = moment(hoarding.FromDate),
                                toDate = moment(hoarding.toDate);
                            var daysOrMonth = toDate.diff(fromDate, 'days') + 1;
                            if (daysOrMonth <= 31) {
                                $("#txtDayOrMonth").val(daysOrMonth);
                                $("#rdoDay").attr("checked", true);

                            } else {
                                $("#txtDayOrMonth").val(daysOrMonth);
                                $("#rdoMonth").attr("checked", true);


                            }

                            $("#imgBanner").attr("src", "/Images/HoardingImage/" + hoarding.HoardingBanner);

                            $("#hdnID").val(hoarding.ID);
                            $("#txtFromDate").val(fromDate.format("DD/MM/YYYY"));
                            $("#txtToDate").val(toDate.format("DD/MM/YYYY"));

                            $("#txtMonthlyAmount").val(hoarding.Amount);
                            $("#ddlCity").val(hoarding.CityID);
                            $("#ddlArea").val(hoarding.AreaID);
                            $("#ddlUser").val(hoarding.UserID);
                            //   alert(hoarding.UserID);
                            $("#txtHoardingNo").val(hoarding.HoardingNo);
                            $("#dialog-hoarding").dialog('open');
                        }
                    }, error: function (xhr) {
                        console.log("Error:" + xhr.statusText);
                    }
                });
            }

            //Total number of day without weekendDay
            function days_between(startDate, endDate) {
                // console.log(startDate);
                //  console.log(endDate);
                // The number of milliseconds in one day
                var ONE_DAY = 1000 * 60 * 60 * 24

                // Convert both dates to milliseconds
                var startDate_ms = startDate.getTime()
                var endDate_ms = endDate.getTime()

                // Calculate the difference in milliseconds
                var difference_ms = Math.abs(startDate_ms - endDate_ms)
                // var weekendDay = NoOfWeekendDay(startDate, endDate);
                // Convert back to days and return
                // $("#txtWeek").val(weekendDay);
                var totalDay = Math.round(difference_ms / ONE_DAY) + 1;
                // $("#txtDay").val(totalDay);
                return totalDay;

            }

            function DeleteHoarding(HoardingID) {
                //alert("Hoarding Deleted Successfully:" + HoardingID);
                $.ajax({
                    type: "POST",
                    url: "ViewHoarding.aspx/DeleteHoarding",
                    data: "{'ID': '" + HoardingID + "'}",
                    contentType: "application/json",
                    dataType: "json",
                    success: function (result) {
                        if (result.d == "1") {
                            alert("Hoarding deleted successfully.");
                        } else if (result.d == "0") {
                            alert("Hoarding not deleted.");
                        } else if (result.d == "-1") {
                            alert("Some internal problem.");
                        } else if (result.d == "3") {
                            alert("Hoarding doesn't Exsist");
                        }
                        console.log(result);
                    }, error: function (xhr) {
                        console.log("Error:" + xhr.statusText);
                    }
                });

            }

            function RenewHoarding(ID) {
                alert("Hoarding:" + ID + " ,Renewed successfully");
            }

    </script>

</head>
<body>
    <div id="dialog-hoarding" style="display: none">
        <form id="frmHoarding">
            <input id="hdnID" type="hidden" runat="server" />

            <fieldset>
                <legend>Hoarding Form</legend>
                <table>
                    <tr>
                        <td>Form No : </td>
                        <td>
                            <label id="lblFormNo"></label>

                        </td>
                    </tr>


                    <tr>
                        <td>Party Name   : </td>
                        <td>
                            <select id="ddlUser" name="ddlUser"></select>

                            <%--                                <input type="button" id="btnNewParty" name="btnNewParty" value="+" onclick="ShowParty();" />--%>
                        </td>
                    </tr>
                    <tr>
                        <td>City : </td>
                        <td>

                            <select id="ddlCity" name="ddlCity" onchange="ChangeAreaByCity();"></select>
                            <%--                                <input type="button" id="btnNewCity" name="btnNewCity" value="+" onclick="ShowCity();" />--%>
                        </td>
                    </tr>
                    <tr>
                        <td>Area : </td>
                        <td>
                            <select id="ddlArea" name="ddlArea"></select>

                            <%--                                <input type="button" id="btnNewArea" name="btnNewArea" value="+" onclick="ShowArea();" />--%>
                        </td>


                    </tr>
                    <tr>
                        <td>Hoarding No : </td>
                        <td>
                            <input type="text" id="txtHoardingNo" />
                        </td>
                    </tr>

                    <tr>
                        <td>Monthly Amount : </td>
                        <td>
                            <input type="text" id="txtMonthlyAmount" />
                        </td>
                    </tr>
                    <%--<tr>
                    <td>Total Amount : </td>
                    <td>
                        <asp:TextBox ID="txtTotalAmount" runat="server" />

                    </td>
                </tr>--%>
                    <tr>
                        <td>From Date : </td>
                        <td>
                            <input type="text" id="txtFromDate" /></td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                <input type="radio" id="rdoDay" name="rdoDayOrMonth" onchange="DayOrMonthChange();" value="day" />Day</label>

                            <label>
                                <input type="radio" id="rdoMonth" name="rdoDayOrMonth" onchange="DayOrMonthChange();" value="month" />Month</label>
                        </td>
                        <td>

                            <input type="text" id="txtDayOrMonth" onchange="DayOrMonthChange();" />
                        </td>
                    </tr>

                    <tr>
                        <td>To Date : </td>
                        <td>
                            <input type="text" id="txtToDate" onkeypress="return false" />
                        </td>
                    </tr>

                    <tr>
                        <td>Hoarding Image: </td>
                        <td>

                            <%--<asp:FileUpload ID="fileHoardingImage" runat="server" />--%>
                            <input type="file" name="hoardingFile" id="hoardingFile" />
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <img src="" id="imgBanner" width="150" height="150" /></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>

                            <input type="submit" value="Update Hoarding" />
                            <%--                            <asp:Button ID="btnHoardingEntry" runat="server" Text="Hoarding Entry" OnClick="btnHoardingEntry_Click" />--%>
                        </td>
                    </tr>
                </table>
            </fieldset>

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
                            <li><a href="ViewHoarding.aspx" class="active">View Hoarding</a></li>
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
                        <h1>View Hoarding Entery</h1>

                        <div class="clr">&nbsp;</div>
                        <form id="aspNetForm" runat="server" class="frm">
                            <asp:ScriptManager ID="sm" runat="server">
                            </asp:ScriptManager>
                            <asp:TextBox ID="txtSearch" runat="server" />
                            <asp:Button ID="btnSearch" runat="server" Text="Search By Party" OnClick="btnSearch_Click" />
                            <asp:UpdatePanel ID="up" runat="server">
                                <ContentTemplate>
                                    <input type="hidden" id="hdnFile" runat="server" />
                                    <div>
                                        <br />
                                        <div class="clear">&nbsp;</div>
                                        <asp:GridView ID="grdHoarding" runat="server" AutoGenerateColumns="False" DataKeyNames="HoadingHistoryID" 
                                            CssClass="custom-grid"
                                            AllowSorting="true" OnSorting="Sorting" AllowPaging="true" OnPageIndexChanging="ChangePage"
                                            OnRowDataBound="grdHoarding_RowDataBound" PageSize="25">
                                            <FooterStyle CssClass="footer" />
                                            <RowStyle CssClass="normal" />

                                            <PagerStyle CssClass="pager" />
                                            <AlternatingRowStyle CssClass="alternate" />
                                            <HeaderStyle CssClass="header" />

                                            <Columns>
                                                <asp:TemplateField HeaderText="City" ItemStyle-Width="60" SortExpression="CityName">
                                                    <ItemTemplate>

                                                        <%# Eval("CityName") %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Area" SortExpression="Area">
                                                    <ItemTemplate>

                                                        <%# Eval("Area") %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Sub Area" SortExpression="SubArea">
                                                    <ItemTemplate>

                                                        <%# Eval("SubArea") %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Ho.No" ItemStyle-Width="60" SortExpression="HoardingNo">
                                                    <ItemTemplate>

                                                        <%# Eval("HoardingNo") %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Party Name" SortExpression="CompanyName">
                                                    <ItemTemplate>

                                                        <%# Eval("CompanyName") %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="FromDate" SortExpression="FromDate">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblFromDate" runat="server" Text='<%# Eval("FromDate","{0:dd/MM/yyyy}")%>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="ToDate" SortExpression="ToDate">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblToDate" runat="server" Text='<%# Eval("ToDate","{0:dd/MM/yyyy}")%>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                               
                                                <asp:TemplateField HeaderText="Size" ItemStyle-Width="60">
                                                    <ItemTemplate>

                                                        <%# Eval("HoardingSize") %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Banner">
                                                    <ItemTemplate>
                                                        <asp:Image ID="imgHoarding" ImageUrl='<%# "~/Images/HoardingImage/"+Eval("BannerName") %>' runat="server" Width="100" Height="60" />
                                                        <%--                            <asp:Label ID="lblHoardingNo" runat="server" Text='<%# Eval("HoardingNo")%>' />--%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>


                                                <%--                    <asp:TemplateField HeaderText="IsActive">
                        <ItemTemplate>
                            <%# Eval("HoardingID")%>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                                                <asp:TemplateField HeaderText="Action">
                                                    <ItemTemplate>

                                                        <a href="javascript:void(0)" onclick="EditDialog('<%# Eval("HoadingHistoryID")%>');">Edit</a> &nbsp;|&nbsp; 

                                                     <%--<asp:HyperLink ID="lnkEdit" runat="server" NavigateUrl='<%# "~/UserRegister.aspx?ID="+Eval("UserID")%>'>Edit</asp:HyperLink>--%>
                                                        <a href="javascript:void(0)" onclick="if(confirm('Are you sure want to delete record ?')){DeleteHoarding('<%# Eval("HoadingHistoryID")%>');}">Delete</a>
                                                        <%--<asp:HyperLink NavigateUrl="javascript:void(0)" runat="server" ID="lnkRenew">Renew</asp:HyperLink>--%>

                                                        <%--<asp:LinkButton ID="lnkRenew" runat="server" CommandArgument="<%# Eval("HoadingHistoryID")%>">Renew</asp:LinkButton>--%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                 <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                                                    <ItemTemplate>

                                                        <%# Eval("Amount","{0:0.00}") %>
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





    <div style="display: none" title="Edit Hoarding" id="response">
    </div>
</body>
</html>
