<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HoardingEntery.aspx.cs" Inherits="Parshvnath.HoardingEntery" Culture="hi-IN" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Entry </title>
    <link href="Css/jquery-ui.css" rel="stylesheet" />
    <link href="Css/Site.css" rel="stylesheet" />
    <link href="Css/ParswaCommon.css" rel="stylesheet" />
    <script src="Script/jquery.min.js"></script>
    <script src="Script/jquery-ui.min.js"></script>
    <script src="Script/jquery.validate.js"></script>
    <script src="Script/additional-methods.js"></script>
    <script src="Script/moment.js"></script>
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
        var availableTags = [
"ActionScript",
"AppleScript",
"Asp",
"BASIC",
"C",
"C++",
"Clojure",
"COBOL",
"ColdFusion",
"Erlang",
"Fortran",
"Groovy",
"Haskell",
"Java",
"JavaScript",
"Lisp",
"Perl",
"PHP",
"Python",
"Ruby",
"Scala",
"Scheme"
        ];

        //        $(window).load(
        //          function () {

        //              $("#hoardingFile").uploadify({

        //                  'swf': 'script/plugin/uploadify/uploadify.swf',
        //                  'uploader': 'FileUploader.ashx',
        //                  'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
        //                  'onUploadSuccess': function (file, data, response) {
        //                          alert('The file ' + file.name + ' was successfully uploaded with a response of ' + response + ':' + data);
        //                      $("#hdnFile").val(data);
        //                      $("#imgBanner").attr("src", "/Images/HoardingImage/" + data).show();

        //                      alert('The File' + file.name + "was successfully uploaded with a response :" + data);
        //                  }

        //              });

        //          }
        //);
        $(function () {

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
                    console.log(ui.item.label);
                    console.log(ui.item.value);
                    $("#hdnParty").val(ui.item.val);
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
                    console.log(ui.item.label);
                    console.log(ui.item.value);
                    $("#hdnArea").val(ui.item.val);
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
                    console.log(ui.item.label);
                    console.log(ui.item.value);
                    $("#hdnCity").val(ui.item.val);
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
            });

            $("#txtArea").autocomplete({
                // source: availableTags
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
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
                }
            });

            $("#areaAll").autocomplete({
                appendTo: "#dialog-sub-area",
                // source: availableTags
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
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
                    console.log(ui.item.label);
                    console.log(ui.item.value);
                    $("#hdnAreaAll").val(ui.item.val);
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
                resizable: false,
                draggable: false
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
            $("#aspNetForm").validate({
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



            $("#frmParty").submit(function () {
                var isFormValid = $("#frmParty").valid();
                var isPhoneExist = $("#hdnIsPhoneExist").val();
                var isCompanyExist = $("#hdnIsCompanyExist").val();
                var name = $("#txtCompanyName").val(),
                  phone = $("#txtPhone").val(),
                   address = $("#txtCompanyAddress").val(),
               email = $("#txtEmail").val(),
               personName = $("#txtPerson").val(),
                              city = $("#txtCity").val();

                alert(isCompanyExist + isPhoneExist + city);




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









        function AddCity(cityName) {
            $.ajax({
                type: "POST",
                //url: "/parshva/ParshvaService.asmx/AddCity",
                url: "<%=Session["Path"]%>" + "ParshvaService.asmx/AddCity",
                data: "{'CityName': '" + cityName + "' }",
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    if (result.d == "1") {
                        $("#dialog-city").dialog("close");
                        alert("City added successfully");

                    } else if (result.d == "0") {
                        alert("City not added");
                    } else if (result.d == "2") {
                        alert("City already exist");
                    }
                    else if (result.d == "-1") {
                        alert("Some internal problem");
                    }
                }, error: function (xhr) {
                    console.log("Error:" + xhr.statusText);
                }
            });
        }

        function AddArea(cityID, areaName) {
            $.ajax({
                type: "POST",
                url: "<%=Session["Path"]%>" + "ParshvaService.asmx/AddArea",
                data: "{'CityID': '" + cityID + "','AreaName':'" + areaName + "' }",
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    if (result.d == "1") {
                        $("#dialog-area").dialog("close");
                        alert("Area added successfully");
                        BindArea(cityID);
                    } else if (result.d == "0") {
                        alert("Area not added");
                    } else if (result.d == "-1") {
                        alert("Some internal problem");
                    }
                    console.log(result);
                }, error: function (xhr) {
                    console.log("Error:" + xhr.statusText);
                }
            });
        }




        function ShowCity() {
            console.log("Show City");
            $("#txtCityName").val('');

            $("#dialog-city").dialog("open");

        }


        function ShowArea() {
            console.log("Show Area");
            $("#txtAreaName").val('');
            $("#dialog-area").dialog("open");

        }


        function ShowSubArea() {
            console.log("Show SubArea");
            $("#txtSubAreaName").val('');
            $("#dialog-sub-area").dialog("open");

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
            var from = $("#txtFromDate").val();

            if (rdo == null || rdo.length <= 0) {
                alert("Please select Day or Month");
            } else {
                //console.log(rdo);
                if (moment(from).isValid()) {


                    if (rdo == "day" && !isNaN(DayOrMonth) && DayOrMonth.length > 0) {
                        var toDate = moment($("#txtFromDate").val(), "DD/MM/YYYY").add(DayOrMonth, "days");
                        $("#txtToDate").val(toDate.format("DD/MM/YY"));
                        //console.log(toDate);



                    } else if (rdo == "month" && !isNaN(DayOrMonth) && DayOrMonth.length > 0) {
                        var toDate = moment($("#txtFromDate").val(), "DD/MM/YYYY").add(DayOrMonth, "months");
                        $("#txtToDate").val(toDate.format("DD/MM/YY"));
                        //console.log(toDate);

                    }
                } else {
                    alert("Enter valid date");
                }
            }
        }


        function AddSubArea(AreaID, subAreaName, operation, subAreaID) {

            $.ajax({
                type: "POST",
                //url: "/parshva/ViewSubArea.aspx/AddSubArea",
                url: "ViewSubArea.aspx/AddSubArea",
                data: "{'SubAreaID': '" + subAreaID + "','SubAreaName':'" + subAreaName + "','Operation':'" + operation + "','AreaID':'" + AreaID + "' }",
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    if (operation == "add") {

                        if (result.d == "2") {
                            alert("Sub Area already exsist");
                        } else if (result.d == "1") {
                            alert("Sub Area added successfully");
                            $("#dialog-sub-area").dialog("close");
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
                            alert("Sub Area updated successfully");
                            $("#dialog-sub-area").dialog("close");
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
            $("#txtSubAreaName").val('');
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
                //url: "ViewSubArea.aspx/EditSubArea",
                url: "<%=Session["Path"]%>" + "/ViewSubArea.aspx/EditSubArea",
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

                        $("#txtSubAreaName").val(area.AreaName);
                        $("#ddlAreaName").val(area.CityID);
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
                //url: "/parshva/ViewSubArea.aspx/DeleteSubArea",
                url: "ViewSubArea.aspx/DeleteSubArea",
                data: "{'ID': '" + ID + "'}",
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    if (result.d == "1") {
                        alert("Area deleted successfully.");
                    } else if (result.d == "0") {
                        alert("Area not deleted.");
                    } else if (result.d == "-1") {
                        alert("Some internal problem.");
                    } else if (result.d == "3") {
                        alert("Area doesn't Exsist");
                    }
                    console.log(result);
                }, error: function (xhr) {
                    console.log("Error:" + xhr.statusText);
                }
            });
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
        function ValidateCompany() {
            if ($("#txtCompanyName").val().length > 0) {

                $.ajax({
                    type: "POST",
                    //url: "/parshva/ParshvaService.asmx/isCompanyExist",
                    url: "<%=Session["Path"]%>" + "ParshvaService.asmx/isCompanyExist",
                    data: "{'CompanyName': '" + $("#txtCompanyName").val() + "'}",
                    contentType: "application/json",
                    dataType: "json",
                    success: function (result) {
                        if (result.d === true) {
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
        function AddUser(Name, Phone, Address, Email, Operation, ID, PersonName, City) {
            //  alert("add user:" + City);
            $.ajax({
                type: "POST",
                //url: "ParshvaService.asmx/AddUser",
                url: "<%=Session["Path"]%>" + "ParshvaService.asmx/AddUser",
                data: "{'Name': '" + Name + "','Phone':'" + Phone + "' ,'Address':'" + Address + "' ,'Email':'" + Email + "','Operation':'" + Operation + "','ID':'" + ID + "','PersonName':'" + PersonName + "','City':'" + City + "'  }",
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    if (Operation == "add") {
                        if (result.d == "1") {
                            alert("Party added successfully");
                            // BindUser();
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
                            alert("Party updated successfully");
                            //   BindUser();
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


        }
        function ShowParty() {
            var validator = $("#frmParty").validate();

            validator.resetForm();


            $('#frmParty *').removeClass('error');
            $("#txtCompanyName").val('');
            $("#txtPhone").val('');
            $("#txtCompanyAddress").val('');
            $("#txtEmail").val('');
            $("#txtCity").val('');
            $("#txtPerson").val('');
            $("#dialog-party").dialog("open");
            $("#btnAddParty").show();


        }

    </script>

</head>
<body>


    <div id="dialog-sub-area" title="Add Area" style="display: block;">
        <form id="frmSubArea" method="post" enctype="multipart/form-data">
            <input type="hidden" id="hdnID" value="" />
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

            <input type="hidden" id="hdnIsCompanyExist" value="Available" />
            <input type="hidden" id="hdnIsPhoneExist" value="Available" />
            <table>
                <tr>
                    <td>Company Name : </td>
                    <td>

                        <input type="text" id="txtCompanyName" name="txtCompanyName" onblur="ValidateCompany();" />
                    </td>

                </tr>
                <tr>
                    <td>Company Address : </td>
                    <td>
                        <input type="text" id="txtCompanyAddress" name="txtCompanyAddress" />
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

                        <input type="text" id="txtPhone" name="txtPhone" maxlength="10" onblur="ValidatePhone();" />
                    </td>
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
                    </td>

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
                            <li><a href="ViewUser.aspx">View Party</a></li>
                            <li><a href="ViewHoarding.aspx" class="active">View Hoarding</a></li>
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
                        <h1>Form  Entery</h1>

                        <form id="aspNetForm" runat="server">
                            <asp:HiddenField ID="hdnFile" runat="server" />
                            <asp:HiddenField ID="hdnCity" runat="server" />
                            <asp:HiddenField ID="hdnCityAll" runat="server" />

                            <asp:HiddenField ID="hdnParty" runat="server" />

                            <asp:HiddenField ID="hdnArea" runat="server" />

                            <asp:HiddenField ID="hdnAreaAll" runat="server" />

                            <asp:HiddenField ID="hdnSubArea" runat="server" />
                            <asp:HiddenField ID="hdnHoardingMasterID" runat="server" />
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
                                            <%--     <select id="ddlUser" name="ddlUser"></select>
                                            <input type="text" id="txtCompany" />--%>
                                            <input type="button" id="btnNewParty" name="btnNewParty" value="+" onclick="ShowParty();" />
                                        </td>
                                    </tr>


                                    <tr>
                                        <td>Account Type : </td>
                                        <td>
                                            <select id="ddlAccountType" name="ddlAccountType">
                                                <option value="Permanent" selected="selected">Permanent</option>
                                                <option value="Temporary">Temporary</option>
                                            </select>

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
                                             <asp:TextBox ID="txtSubArea" runat="server" />
                                            <%-- <input type="text" id="txtSubArea" />
                                            <input type="button" id="btnNewSubArea" name="btnNewSubArea" value="+" onclick="ShowSubArea();" />--%>

                                        </td>


                                    </tr>
                                    <tr>
                                        <td>Hoarding No : </td>
                                        <td>
                                            <asp:TextBox ID="txtHoardingNo" runat="server" /></td>
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
                                            <asp:TextBox ID="txtToDate" runat="server" onkeypress="return false;" /></td>
                                    </tr>

                                    <tr>
                                        <td>Hoarding Image: </td>
                                        <td>
                                            <asp:FileUpload ID="fileHoardingImage" runat="server" onchange="showimagepreview(this)" />
                                            <br />
                                            <img src="" style="display: none" height="200" width="200" id="imgHoarding" alt="Hoarding Image" />

                                        </td>

                                    </tr>

                                    <tr>
                                        <td colspan="2">
                                            <asp:Button ID="btnHoardingEntry" runat="server" Text="Hoarding Entry" OnClick="btnHoardingEntry_Click" />
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
