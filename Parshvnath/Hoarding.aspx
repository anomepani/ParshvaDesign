<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Hoarding.aspx.cs" Inherits="Parshvnath.Hoarding1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Entry </title>

    <link href="Css/jquery-ui.css" rel="stylesheet" />
    <%--<link href="Css/Site.css" rel="stylesheet" />--%>
    <link href="Css/ParswaCommon.css" rel="stylesheet" />

    <script src="Script/jquery.min.js"></script>
    <script src="Script/jquery-ui.min.js"></script>

    <script src="Script/jquery.validate.js"></script>
    <script src="Script/additional-methods.js"></script>
    <script src="Script/moment.js"></script>
    <style>
        .error {
            color: red;
        }

        .ui-widget-header {
            background: none repeat scroll 0 0 #548f9c !important;
        }

        body {
            color: #000000;
            font-family: Arial;
            font-size: 12px;
        }
    </style>
    <script>
        function showimagepreview(input) {
            if (input.files && input.files[0]) {
                var filerdr = new FileReader();
                filerdr.onload = function (e) {
                    $('#imgHoarding').attr('src', e.target.result);
                    $('#imgHoarding').show();
                }
                filerdr.readAsDataURL(input.files[0]);
            }
        }
        $(function () {
            console.log("****Error***");
            console.log($("#hdnError").val());
            console.log("****Error***");
            var day = $('#hdnDayOrMonth').val();
            if (day.length > 0 && !isNaN(day)) {
                $("#rdoDay").prop("checked", "checked");


                //if (parseInt(day) < 30) {
                // } else {

                //    $("#rdoDay").prop("checked", "checked");
                //    //$("#txtDayOrMonth").val(parseInt(day));
                //}
            }

            //set checkbox value in edit mode
            var isRenew = $("#hdnIsRenew").val();
            if (isRenew === "true") {
                $("#cbRenew").prop("checked", "checked");
            }

            $("#txtCompany").autocomplete({
                // source: availableTags
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        //url: "/parshva/ParshvaService.asmx/GetParty",
                        url: "<%=Session["Path"]%>" + "ParshvaService.asmx/GetParty",
                        data: "{'Party':'" + request.term + "'}",
                        contentType: "application/json",
                        dataType: "json",
                        success: function (result) {
                            console.log(result.d);
                            response($.map(result.d, function (item) {
                                //        console.log(item);
                                return {
                                    label: item.PartyName,
                                    val: item.ID
                                }
                            }));
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
                    $("#txtUser").val(ui.item.value);

                    $("#hdnParty").val(ui.item.val);
                }, change: function (event, ui) {
                    if (ui.item == null || ui.item == undefined) {
                        if ($("#hdnParty").val().trim().length == 0) {
                            $("#txtUser").val("");
                            $("#txtUser").attr("disabled", false);
                            $("#hdnParty").val("");
                            $("#hdnParty").attr("disabled", false);
                        }
                    } else {

                        $("#txtUser").attr("disabled", false);
                        $("#hdnParty").attr("disabled", false);

                    }
                }
            });

            $("#txtArea").autocomplete({
                // source: availableTags
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        //url: "/parshva/ParshvaService.asmx/GetArea",
                        url: "<%=Session["Path"]%>" + "ParshvaService.asmx/GetArea",
                        data: "{'CityID':'" + cityID + "','Area':'" + $("#txtArea").val() + "'}",
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

            $("#city").autocomplete({
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

                    $("#hdnCity").val(ui.item.val);
                }, change: function (event, ui) {
                    if (ui.item == null || ui.item == undefined) {
                        if ($("#hdnCity").val().trim().length == 0) {
                            $("#city").val("");
                            $("#city").attr("disabled", false);
                            $("#hdnCity").val("");
                            $("#hdnCity").attr("disabled", false);
                        }
                    } else {

                        $("#city").attr("disabled", false);
                        $("#hdnCity").attr("disabled", false);
                    }
                }
            });

            $("#cityAll").autocomplete({
                appendTo: "#dialog-area",
                // source: availableTags
                source: function (request, response) {
                    console.log(request.term);
                    $.ajax({
                        type: "POST",
                        //url: "/parshva/ParshvaService.asmx/GetCity",
                        url: "<%=Session["Path"]%>" + "ParshvaService.asmx/GetCity",
                        data: "{'City':'" + $('#cityAll').val() + "'}",
                        contentType: "application/json",
                        dataType: "json",
                        success: function (result) {

                            if (result.d.length > 0) {

                                response($.map(result.d, function (item) {
                                    console.log(item);
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
                    $("#cityAll").val(ui.item.value);
                    console.log(ui.item.label);
                    console.log(ui.item.value);
                    $("#hdnCityAll").val(ui.item.val);
                }
                , change: function (event, ui) {
                    if (ui.item == null || ui.item == undefined) {
                        if ($("#hdnCityAll").val().trim().length == 0) {
                            $("#cityAll").val("");
                            $("#cityAll").attr("disabled", false);
                            $("#hdnCityAll").val("");
                            $("#hdnCityAll").attr("disabled", false);
                        }
                    } else {

                        $("#cityAll").attr("disabled", false);
                        $("#hdnCityAll").attr("disabled", false);
                    }
                }
            });

            $("#txtArea").autocomplete({
                // source: availableTags
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        //url: "/parshva/ParshvaService.asmx/GetArea",
                        url: "<%=Session["Path"]%>" + "ParshvaService.asmx/GetArea",
                        data: "{'CityID':'" + $("#hdnCity").val() + "','Area':'" + $("#txtArea").val() + "'}",
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
                    console.log(ui.item.label);
                    console.log(ui.item.value);
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

            $("#areaAll").autocomplete({
                appendTo: "#dialog-sub-area",
                // source: availableTags
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        //url: "/parshva/ParshvaService.asmx/GetAllArea",
                        url: "<%=Session["Path"]%>" + "ParshvaService.asmx/GetAllArea",
                        data: "{'Area':'" + $("#areaAll").val() + "'}",
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
                    $("#areaAll").val(ui.item.value);
                    $("#hdnAreaAll").val(ui.item.val);
                },
                change: function (event, ui) {
                    if (ui.item == null || ui.item == undefined) {
                        if ($("#hdnAreaAll").val().trim().length == 0) {
                            $("#areaAll").val("");
                            $("#areaAll").attr("disabled", false);
                            $("#hdnAreaAll").val("");
                            $("#hdnAreaAll").attr("disabled", false);
                        }
                    } else {

                        $("#areaAll").attr("disabled", false);
                        $("#hdnAreaAll").attr("disabled", false);
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
                width: 300,
                resizable: false,
                draggable: false
            });

            $("#dialog-sub-area").dialog({
                autoOpen: false,
                modal: true,
                width: 300,
                resizable: false,
                draggable: false
            });
            $("#dialog-party").dialog({
                autoOpen: false,
                modal: true,
                width: 500,
                height: 300,
                resizable: true,
                draggable: true
            });

            $("#frmArea").validate({
                rules: {
                    txtAreaName: {
                        required: true
                    },
                    ddlCityName: {
                        required: true
                    }
                }, messages: {
                    txtAreaName: {
                        required: "Enter area name"
                    },
                    ddlCityName: {
                        required: "Select City"
                    }

                }
            });

            $("#frmCity").validate({
                rules: {
                    txtCityName: {
                        required: true
                    }
                }, messages: {
                    txtCityName: {
                        required: "Enter city name"
                    }

                }
            });
            $("#frmSubArea").validate({
                rules: {
                    txtSubAreaName: {
                        required: true
                    },
                    ddlAreaName: {
                        required: true
                    }
                }, messages: {
                    txtSubAreaName: {
                        required: "*"
                    },
                    ddlAreaName: {
                        required: "Select Area"
                    }

                }
            });

            $("#frmSubArea").submit(function () {

                var AreaID = $("#hdnArea").val(),
                    SubArea = $("#txtSubAreaNme").val(),
                    SubAreaID = $("#hdnSubAreaID").val();


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
            $("#aspNetForm").validate({
                rules: {
                    txtCompany: {
                        required: true
                    },
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
                        // required: true,
                        accept: "image/jpeg,image/pjpeg,image/jpg,image/png,image/gif"

                    }
                },
                messages: {
                    txtCompany: {
                        required: "Select Party name"
                    },
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
                        required: "Please select hoarding file",
                        accept: "Enter valid file format"

                    }
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
                    txtCompanyName: "  *Required",
                    txtPerson: "  *Required",

                    txtPhone: {
                        required: "  *Required"
                        //, number: "Please enter valid phone"
                    },
                    txtCompanyAddress: "Required",

                    txtEmail: {
                        email: "Enter valid email"
                    }
            , txtCity: {
                required: "  *Required"

            }

                }
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
            $("#frmArea").submit(function () {

                var city = $("#hdnCity").val(),
                    area = $("#txtAreaName").val();
                //if (area.trim().length == 0) {
                //    alert("Enter area name");
                //    return false;
                //} else {

                //    //Call ajax for adding Area 
                //    alert("Process for Adding area....");
                //    AddArea(city, area);
                //    return false;
                //}

                var isFormValid = $("#frmArea").valid();
                //alert("Form Subitted" + isFormValid);
                if (isFormValid) {
                    AddArea(city, area);
                    return false;
                } else {
                    return false;
                }

            });

            $("#frmCity").submit(function () {

                var city = $("#txtCityName").val();
                //if (city.trim().length == 0) {
                //    alert("Enter area name");
                //    return false;
                //} else {

                //    alert("Process for Adding City....");
                //    AddCity(city);

                //    return false;
                //    //Call ajax for adding Area 
                //}

                var isFormValid = $("#frmCity").valid();
                //alert("Form Subitted" + isFormValid);
                if (isFormValid) {
                    AddCity(city);
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
            }, "*");


        });

        function ChangeAreaByCity() {
            console.log("City is changed");
            BindArea($("#hdnCity").val());
        }







        function DayChange() {
            //console.log("Day changed");
            DayOrMonthChange();
        }
        function MonthChange() {
            //console.log("Month Changed");
            DayOrMonthChange();
        }
        function DayOrMonthChange() {
            var rdo = $("input[name='rdoDayOrMonth']:checked").val();

            //console.log(rdo);
            var DayOrMonth = $("#txtDayOrMonth").val();
            var from = moment($("#txtFromDate").val(), "DD/MM/YY");
            //$("#txtFromDate").val();

            if (rdo == null || rdo.length <= 0) {
                alert("Please select Day or Month");
            } else {
                //console.log(rdo);
                if (moment(from).isValid()) {


                    if (rdo == "day" && !isNaN(DayOrMonth) && DayOrMonth.length > 0) {
                        var fromDate = moment($("#txtFromDate").val(), "DD/MM/YY");
                        // console.log(fromDate);
                        $("#hdnFromDate").val(fromDate.format("MM/DD/YY"));
                        var toDate = moment($("#txtFromDate").val(), "DD/MM/YY").add(DayOrMonth, "days");
                        $("#hdnToDate").val(toDate.format("MM/DD/YY"));
                        //  console.log(toDate.format("MM/DD/YY"));
                        $("#txtToDate").val(toDate.format("DD-MM-YY"));

                        //console.log(toDate);


                    } else if (rdo == "month" && !isNaN(DayOrMonth) && DayOrMonth.length > 0) {
                        var fromDate = moment($("#txtFromDate").val(), "DD/MM/YY");
                        $("#hdnFromDate").val(fromDate.format("MM/DD/YY"));
                        var toDate = moment($("#txtFromDate").val(), "DD/MM/YY").add(DayOrMonth, "months").subtract(1, "days");
                        $("#hdnToDate").val(toDate.format("MM/DD/YY"));
                        $("#txtToDate").val(toDate.format("DD-MM-YY"));
                        //console.log(toDate);

                    }
                } else {
                    alert("Enter valid date");
                }
            }
        }



        function ValidatePhone() {


            if ($("#txtPhone").val().length > 0) {

                $.ajax({
                    type: "POST",
                    //url: "/parshva/ParshvaService.asmx/isPhoneExist",
                    url: "<%=Session["Path"]%>" + "ParshvaService.asmx/isPhoneExist",
                    data: "{'Phone': '" + $("#txtPhone").val() + "'}",
                    contentType: "application/json",
                    dataType: "json",
                    success: function (result) {
                        console.log(result);
                        if (result.d === true) {
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

        function AddUser(Name, Phone, Address, Email, Operation, ID, PersonName, City) {
            $.ajax({
                type: "POST",
                //url: "/parshva/ParshvaService.asmx/AddUser",
                url: "<%=Session["Path"]%>" + "ParshvaService.asmx/AddUser",
                data: "{'Name': '" + Name + "','Phone':'" + Phone + "' ,'Address':'" + Address + "' ,'Email':'" + Email + "','Operation':'" + Operation + "','ID':'" + ID + "','PersonName':'" + PersonName + "','City':'" + City + "'  }",
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    if (Operation == "add") {
                        if (result.d == "1") {

                            $("#dialog-party").dialog('close');
                            alert("Party added successfully");
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
                            $("#dialog-party").dialog('close');
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
                    // url: "/parshva/ParshvaService.asmx/isPhoneExist",
                    url: "<%=Session["Path"]%>" + "ParshvaService.asmx/isPhoneExist",
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
                    //url: "/parshva/ParshvaService.asmx/isCompanyExist",
                    url: "<%=Session["Path"]%>" + "ParshvaService.asmx/isCompanyExist",
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

        function chkRenew() {
            var hoardingType = $("#ddlAccountType").val();
            if (hoardingType === "Temporary") {
                //restrict renew for temporary entery
                $("#cbRenew").prop("checked", false);
            } else if (hoardingType === "Permanent") {

                var fromDate = moment($("#txtFromDate").val(), "DD/MM/YY");
                var toDate = moment($("#txtToDate").val(), "DD/MM/YY");
                var daysBetween = toDate.diff(fromDate, "days");
                //restrict renew for days less than 31 days means one month
                if (daysBetween <= 31) {
                    $("#cbRenew").prop("checked", false);
                }

            }
            $("#hdnIsRenew").val($("#cbRenew").prop("checked"));
        }

    </script>

</head>
<body>


    <div id="dialog-sub-area" title="Add Area" style="display: block;">
        <form id="frmSubArea" method="post" enctype="multipart/form-data">
            <input type="hidden" id="hdnSubAreaID" name="hdnSubAreaID" value="" />


            <table>
                <tr>
                    <td>Select Area :</td>
                    <td>
                        <input type="text" id="areaAll" />
                        <select id="ddlAreaName" name="ddlAreaName"></select>
                    </td>

                </tr>
                <tr>
                    <td>Enter Sub Area :</td>
                    <td>
                        <textarea id="txtSubAreaName" name="txtSubAreaName"></textarea></td>

                </tr>

                <tr>

                    <td colspan="2">
                        <input type="submit" id="btnAddSubArea" name="btnAddSubArea" value="Add Area" />
                    </td>

                </tr>
            </table>
        </form>


    </div>
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
                        <textarea id="txtCompanyAddress" name="txtCompanyAddress" rows="3" cols="25"></textarea>


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




    <div id="dialog-city" title="Add City" style="display: none;">
        <form id="frmCity" method="post" enctype="multipart/form-data">
            <table>
                <tr>
                    <td>Enter City Name :</td>
                    <td>
                        <input type="text" id="txtCityName" name="txtCityName" maxlength="20" /></td>

                </tr>
                <tr>

                    <td colspan="2">
                        <input type="submit" id="btnAddCity" name="btnAddCity" value="Add City" /></td>

                </tr>
            </table>
        </form>
    </div>

    <div id="dialog-area" title="Add Area" style="display: none;">
        <form id="frmArea" method="post" enctype="multipart/form-data">
            <table>
                <tr>
                    <td>Select City :</td>
                    <td>
                        <input type="text" id="cityAll" />
                        <select id="ddlCityName" name="ddlCityName"></select>
                    </td>

                </tr>
                <tr>
                    <td>Enter Area Name :</td>
                    <td>
                        <textarea id="txtAreaName" name="txtAreaName"></textarea></td>

                </tr>

                <tr>

                    <td colspan="2">
                        <input type="submit" id="btnAddArea" name="btnAddArea" value="Add Area" /></td>

                </tr>
            </table>
        </form>


    </div>



    <form id="aspNetForm" runat="server">
        <asp:HiddenField ID="hdnHoardingHistoryID" runat="server" />

        <asp:HiddenField ID="hdnFile" runat="server" />
        <asp:HiddenField ID="hdnCity" runat="server" />
        <asp:HiddenField ID="hdnCityAll" runat="server" />

        <asp:HiddenField ID="hdnParty" runat="server" />

        <asp:HiddenField ID="hdnArea" runat="server" />

        <asp:HiddenField ID="hdnAreaAll" runat="server" />

        <asp:HiddenField ID="hdnSubArea" runat="server" />

        <asp:HiddenField ID="hdnHoardingMasterID" runat="server" />
        <asp:HiddenField ID="hdnFromDate" runat="server" Value="" />
        <asp:HiddenField ID="hdnToDate" runat="server" Value="" />
        <asp:HiddenField ID="hdnError" runat="server" />
        <asp:HiddenField ID="hdnAccountType" runat="server" />
        <asp:HiddenField ID="hdnDayOrMonth" runat="server" />
        <asp:HiddenField ID="hdnIsRenew" runat="server" Value="false" />
        <%--                            <input type="hidden" id="hdnCity" name="hdnCity" />
                            <input type="hidden" id="hdnCityAll" name="hdnCityAll" />
                            <input type="hidden" id="hdnParty" name="hdnParty" />
                            <input type="hidden" id="hdnArea" name="hdnArea" />
                            <input type="hidden" id="hdnAreaAll" name="hdnAreaAll" />

                            <input type="hidden" id="hdnSubArea" name="hdnSubArea" />--%>

        <fieldset>
            <legend>Hoarding Form</legend>

            <table>
                <tr>
                    <td>Form No : </td>
                    <td>
                        <asp:Label ID="lblFormNo" runat="server"></asp:Label>
                    </td>
                </tr>


                <tr>
                    <td>Company Name   : </td>
                    <td>
                        <asp:TextBox ID="txtCompany" runat="server" />
                        <%--                                            <select id="ddlUser" name="ddlUser"></select>
                                            <input type="text" id="txtCompany" />--%>
                        <input type="button" id="btnNewParty" name="btnNewParty" value="+" onclick="ShowUser();" />
                    </td>
                </tr>


                <tr>
                    <td>Account Type : </td>
                    <td>
                        <asp:DropDownList ID="ddlAccountType" runat="server">
                            <asp:ListItem Value="Permanent" Selected="True">Permanent</asp:ListItem>
                            <asp:ListItem Value="Temporary">Temporary</asp:ListItem>
                        </asp:DropDownList>

                    </td>
                </tr>

                <tr>
                    <td>City : </td>
                    <td>
                        <asp:TextBox ID="city" runat="server" Enabled="false" />
                        <%--<input type="text" id="txtCity" />--%>
                        <%--    <input type="text" id="city" />
                                            <select id="ddlCity" name="ddlCity" onchange="ChangeAreaByCity();"></select>
                                            <input type="button" id="btnNewCity" name="btnNewCity" value="+" onclick="ShowCity();" />--%>

                    </td>
                </tr>
                <tr>
                    <td>Area : </td>
                    <td>
                        <%--<input type="text" id="txtArea" />
                                            <select id="ddlArea" name="ddlArea"></select>
                                            <input type="button" id="btnNewArea" name="btnNewArea" value="+" onclick="ShowArea();" />--%>
                        <asp:TextBox ID="txtArea" runat="server" Enabled="false" />

                        SubArea :                
                                             <asp:TextBox ID="txtSubArea" runat="server" Enabled="false" />
                        <%-- <input type="text" id="txtSubArea" />
                                            <input type="button" id="btnNewSubArea" name="btnNewSubArea" value="+" onclick="ShowSubArea();" />--%>

                    </td>


                </tr>
                <tr>
                    <td>Hoarding No : </td>
                    <td>
                        <asp:TextBox ID="txtHoardingNo" runat="server" Enabled="false" /></td>
                </tr>

                <tr>
                    <td>Amount : </td>
                    <td>
                        <asp:TextBox ID="txtMonthlyAmount" runat="server" />

                    </td>
                </tr>
                <tr>
                    <td>From Date : </td>
                    <td>
                        <asp:TextBox ID="txtFromDate" runat="server" onchange="DayOrMonthChange();" /></td>
                </tr>
                <tr>
                    <td>
                        <label>
                            <input type="radio" id="rdoDay" name="rdoDayOrMonth" onchange="DayOrMonthChange();" value="day" />Day</label>

                        <label>
                            <input type="radio" id="rdoMonth" name="rdoDayOrMonth" onchange="DayOrMonthChange();" value="month" checked="checked" />Month</label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDayOrMonth" runat="server" onchange="DayOrMonthChange();" /></td>
                </tr>

                <tr>
                    <td>To Date : </td>
                    <td>
                        <asp:TextBox ID="txtToDate" runat="server" onkeypress="return false;" autocomplete="off" /></td>
                </tr>

                <tr>
                    <td><b>For Renew :</b> </td>
                    <td>
                        <input type="checkbox" id="cbRenew" name="cbRenew" onchange="chkRenew();" />
                    </td>
                </tr>

                <tr>
                    <td>Hoarding Image: </td>
                    <td>
                        <asp:FileUpload ID="fileHoardingImage" runat="server" onchange="showimagepreview(this)" />
                        <br />
                        <img src="" style="display: none" height="200" width="200" id="imgHoarding" alt="Hoarding Image" runat="server" />

                    </td>

                </tr>

                <tr>
                    <td colspan="2">
                        <asp:Button ID="btnHoardingEntry" runat="server" Text="Hoarding Entry" OnClick="btnHoardingEntry_Click" />
                        <asp:Button ID="btnUpdateHoarding" runat="server" Text="Update Hoarding" OnClick="btnUpdateHoarding_Click" Visible="false" />
                    </td>
                </tr>
            </table>
        </fieldset>

    </form>

</body>
</html>
