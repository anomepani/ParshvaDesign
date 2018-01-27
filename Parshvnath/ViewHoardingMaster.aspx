<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewHoardingMaster.aspx.cs" Inherits="Parshvnath.ViewHoardingMaster" %>


<!DOCTYPE html>

<html>
<head>
    <title>View Hoarding Master </title>

    <link href="Css/jquery-ui.css" rel="stylesheet" />
    <link href="Css/Site.css" rel="stylesheet" />
    <link href="Css/ParswaCommon.css" rel="stylesheet" />
    <script src="Script/jquery.min.js"></script>
    <script src="Script/jquery-ui.min.js"></script>

    <script src="Script/jquery.validate.js"></script>
    <script src="Script/additional-methods.js"></script>
    <script>
        var hoardingSizeCollection = [{ value: "10 X 20", label: "10 X 20" }, { value: "10 X 40", label: "10 X 40" }];
        function InitializeAutocomplete() {
            $("#txtHoardingSize").autocomplete({
                appendTo: "#dialog-hoarding-master",
                source: hoardingSizeCollection,
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
                    $("#txtHoardingSize").val(ui.item.label);
                    //console.log(ui.item.label);
                    // console.log(ui.item.value);
                    $("#hdnHoardingSize").val(ui.item.value);
                },
                change: function (event, ui) {
                    if (ui.item == null || ui.item == undefined) {
                        if ($("#hdnHoardingSize").val().trim().length == 0) {
                            $("#txtHoardingSize").val("");
                            $("#txtHoardingSize").attr("disabled", false);
                            $("#hdnHoardingSize").val("");
                            $("#hdnHoardingSize").attr("disabled", false);
                        }
                    } else {

                        $("#txtHoardingSize").attr("disabled", false);
                        $("#hdnHoardingSize").attr("disabled", false);

                    }
                }
            });

            $("#txtCompany").autocomplete(
                {
                    appendTo: "#dialog-hoarding-master",
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
                    }, change: function (event, ui) {
                        if (ui.item == null || ui.item == undefined) {
                            if ($("#hdnParty").val().trim().length == 0) {
                                $("#txtUser").val("");
                                $("#txtUser").attr("disabled", false);
                                $("#hdnParty").val("");
                                $("#hdnParty").attr("disabled", false);
                            }
                        } else {

                            $("#txtHoardingSize").attr("disabled", false);
                            $("#hdnParty").attr("disabled", false);

                        }
                    }
                });

                $("#txtArea").autocomplete({
                    appendTo: "#dialog-hoarding-master",
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
                appendTo: "#dialog-hoarding-master",
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
                appendTo: "#dialog-hoarding-master",
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
                },
                change: function (event, ui) {
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
                    console.log(ui.item.label);
                    console.log(ui.item.value);
                    $("#hdnAreaAll").val(ui.item.val);
                }
                ,
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

            $("#txtSubArea").autocomplete({
                appendTo: "#dialog-hoarding-master",
                // source: availableTags
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        //url: "/parshva/ParshvaService.asmx/GetSubArea",
                        url: "<%=Session["Path"]%>" + "ParshvaService.asmx/GetSubArea",
                        data: "{'AreaID':'" + $("#hdnArea").val() + "','SubArea':'" + $("#txtSubArea").val() + "'}",
                        contentType: "application/json",
                        dataType: "json",
                        success: function (result) {
                            if (result.d.length > 0) {
                                response($.map(result.d, function (item) {
                                    //        console.log(item);
                                    return {
                                        label: item.SubAreaName,
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
                    $("#txtSubArea").val(ui.item.value);
                    console.log(ui.item.label);
                    console.log(ui.item.value);
                    $("#hdnSubArea").val(ui.item.val);
                }
                  ,
                change: function (event, ui) {
                    if (ui.item == null || ui.item == undefined) {
                        if ($("#hdnSubArea").val().trim().length == 0) {
                            $("#txtSubArea").val("");
                            $("#txtSubArea").attr("disabled", false);
                            $("#hdnSubArea").val("");
                            $("#hdnSubArea").attr("disabled", false);
                        }
                    } else {
                        $("#txtSubArea").attr("disabled", false);
                        $("#hdnSubArea").attr("disabled", false);
                    }
                }
            });

        }
        function InitializeDialog() {
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

            $("#dialog-hoarding-master").dialog({
                autoOpen: false,
                modal: true,
                width: 600,
                height: 200,
                resizable: false,
                draggable: false
            });

        }
        function InitializeFormValidation() {
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
                        required: "*"
                    },
                    ddlCityName: {
                        required: "*"
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

                    txtArea: {
                        required: true

                    }
                    , city: {
                        required: true
                    },
                    txtHoardingSize: {
                        required: true
                    }
                },
                messages: {
                    txtHoardingNo: {
                        required: "*"
                    },
                    txtArea: {
                        required: "*"

                    }
                    , city: {
                        required: "*"
                    }
                    , txtHoardingSize: {
                        required: "*"
                    }
                }
            });


            $("#aspNetForm").submit(function () {
                var CityID = $("#hdnCity").val()
                    , AreaID = $("#hdnArea").val()
                    , SubAreaID = $("#hdnSubArea").val()
                    , HoardingNo = $("#txtHoardingNo").val()
                    , HoardingMasterID = $("#hdnHoardingMasterID").val()
                , HoardingSize = $("#txtHoardingSize").val();


                var isFormValid = $("#aspNetForm").valid();

                //  return false;
                if (isFormValid) {
                    if (HoardingMasterID.length > 0) {

                        AddHoardingMaster(CityID, AreaID, SubAreaID, HoardingNo, HoardingMasterID, HoardingSize, 'update');
                        return false;

                    } else {
                        AddHoardingMaster(CityID, AreaID, SubAreaID, HoardingNo, "0", HoardingSize, 'add');
                        return false;

                    }

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

        }
        $(function () {

            InitializeAutocomplete();
            InitializeDialog();
            InitializeFormValidation();

        });


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
                            alert("Area added successfully");

                            window.location.href = window.location.href;
                            // location.href = location.protocol+"//"+location.hostname+"/ViewArea.aspx";
                        } else if (result.d == "0") {
                            alert("Area not added");
                        } else if (result.d == "-1") {
                            alert("Some internal problem");
                        }
                        console.log(result);

                    } else {
                        if (result.d == "1") {
                            $("#dialog-area").dialog("close");
                            alert("Area updated successfully");

                            window.location.href = window.location.href;
                            // location.href = location.protocol+"//"+location.hostname+"/ViewArea.aspx";
                        } else if (result.d == "0") {
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
                url: "<%=Session["Path"]%>" + "ParshvaService.asmx/EditArea",
                data: "{'ID': '" + ID + "'}",
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    var area = $.parseJSON(result.d);

                    if (area == "3") {
                        alert("Area not found");
                    } else if (area == "-1") {
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
                    console.log(result);
                }, error: function (xhr) {
                    console.log("Error:" + xhr.statusText);
                }
            });
        }


        function AddHoardingMaster(CityID, AreaID, SubAreaID, HoardingNo, HoardingMasterID, HoardingSize, Operation) {


            $.ajax({
                type: "POST",
                //url: "/parshva/ParshvaService.asmx/AddHoardingMaster",
                url: "<%=Session["Path"]%>" + "ParshvaService.asmx/AddHoardingMaster",
                data: "{'CityID': '" + CityID + "','AreaID':'" + AreaID + "','SubAreaID': '" + SubAreaID + "','HoardingNo':'" + HoardingNo + "','HoardingMasterID':'" + HoardingMasterID + "','Operation':'" + Operation + "','HoardingSize':'" + HoardingSize + "'}",
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    if (Operation == "add") {

                        if (result.d == "2") {
                            alert("Hoarding Already Assigned");
                        } else if (result.d == "1") {
                            alert("Hoarding added successfully");
                            //  $("#dialog-sub-area").dialog("close");
                            // location.href = ""/ViewArea.aspx";
                            //   window.location.href = window.location.href;
                        } else if (result.d == "0") {
                            alert("Hoarding not added");
                        } else if (result.d == "-1") {
                            alert("Some internal problem");
                        }
                        console.log(result);

                    } else {
                        if (result.d == "2") {
                            alert("Hoarding Already Assigned");
                        } else if (result.d == "1") {
                            alert("Hoarding updated successfully");
                            // $("#dialog-sub-area").dialog("close");
                            window.location.href = window.location.href;
                            // location.href = location.protocol+"//"+location.hostname+"/ViewArea.aspx";
                        } else if (result.d == "0") {
                            alert("Hoarding not updated");
                        } else if (result.d == "-1") {
                            alert("Some internal problem");
                        }
                        console.log(result);


                    }
                }, error: function (xhr) {
                    alert(xhr);

                    console.log("Error:" + xhr.statusText);
                }
            });

        }

        function ShowHoardingMaster() {
            $("#dialog-hoarding-master").dialog("open");

            console.log("Show Hoarding Master");

            $("#hdnCity").val('');
            $("#hdnArea").val('');
            $("#hdnSubArea").val('');
            $("#city").val('');
            $("#txtArea").val('');
            $("#txtSubArea").val('');
            $("#txtHoardingNo").val('');
            $("#hdnHoardingMasterID").val('');
            $("#hdnHoardingSize").val('');
            $("#txtHoardingSize").val('');
            $("#btnUpdateHoarding").hide();

            $("#btnSaveHoarding").show();


        }

        function EditHoardingMaster(ID) {
            if (ID.length > 0) {
                $.ajax({
                    type: "POST",
                    //url: "/parshva/ParshvaService.asmx/EditHoardingMaster",
                    url: "<%=Session["Path"]%>" + "ParshvaService.asmx/EditHoardingMaster",
                    data: "{'ID': '" + ID + "'}",
                    contentType: "application/json",
                    dataType: "json",
                    success: function (result) {
                        var hoarding = $.parseJSON(result.d);

                        if (hoarding == "3") {
                            alert("Hoarding not found");
                        } else if (hoarding == "-1") {
                            alert("Some internal problem");
                        } else {

                            var validator = $("#aspNetForm").validate();
                            validator.resetForm();
                            $('#aspNetForm').removeClass('error');

                            $("#dialog-hoarding-master").dialog("open");
                            $("#btnSaveHoarding").hide();
                            $("#btnUpdateHoarding").show();

                            $("#hdnCity").val(hoarding.CityID);
                            $("#hdnArea").val(hoarding.AreaID);
                            $("#hdnSubArea").val(hoarding.SubAreaID);
                            $("#city").val(hoarding.CityName);
                            $("#txtArea").val(hoarding.Area);
                            $("#txtSubArea").val(hoarding.SubArea);
                            $("#txtHoardingNo").val(hoarding.HoardingNo);
                            $("#hdnHoardingMasterID").val(hoarding.ID);
                            $("#hdnHoardingSize").val(hoarding.HoardingSize);
                            $("#txtHoardingSize").val(hoarding.HoardingSize);

                            //$("#txtAreaName").val(area.AreaName);
                            //$("#city").val(area.CityName);
                            //$("#hdnCity").val(area.CityID);
                            //$("#hdnID").val(area.ID);

                            console.log(result);
                        }
                    }, error: function (xhr) {
                        console.log("Error:" + xhr.statusText);
                    }
                });
            }
        }


        function DeleteHoardingMaster(ID) {
            $.ajax({
                type: "POST",
                //                url: "/parshva/ParshvaService.asmx/DeleteHoardingMaster",
                url: "<%=Session["Path"]%>" + "ParshvaService.asmx/DeleteHoardingMaster",
                data: "{'ID': '" + ID + "'}",
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    if (result.d == "1") {
                        alert("Hoarding deleted successfully.");
                        window.location.href = window.location.href;
                    } else if (result.d == "0") {
                        alert("Hoarding not deleted.");
                    } else if (result.d == "-1") {
                        alert("Some internal problem.");
                    } else if (result.d == "3") {
                        alert("Hoarding doesn't Exsist");
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
    <div id="dialog-hoarding-master" style="display: none" title="Add / Edit Hoarding Master">

        <form id="aspNetForm" method="post">
            <input type="hidden" id="hdnCity" name="hdnCity" />
            <input type="hidden" id="hdnCityAll" name="hdnCityAll" />
            <input type="hidden" id="hdnParty" name="hdnParty" />
            <input type="hidden" id="hdnArea" name="hdnArea" />
            <input type="hidden" id="hdnAreaAll" name="hdnAreaAll" />

            <input type="hidden" id="hdnSubArea" name="hdnSubArea" />
            <input type="hidden" id="hdnHoardingSize" name="hdnHoardingSize" />

            <input type="hidden" id="hdnHoardingMasterID" name="hdnHoardingMasterID" />


            <fieldset>
                <legend>Hoarding Master Form</legend>

                <table>
                    <%--    <tr>
                        <td>ID: </td>
                        <td>
                            <label id="lblID"></label>
                        </td>
                    </tr>--%>


                    <tr>
                        <td>City : </td>
                        <td>
                            <%--<input type="text" id="txtCity" />--%>
                            <input type="text" id="city" name="city" />
                            <%--                        <select id="ddlCity" name="ddlCity" onchange="ChangeAreaByCity();"></select>
                        <input type="button" id="btnNewCity" name="btnNewCity" value="+" onclick="ShowCity();" />--%>
                        </td>
                        <td colspan="2"></td>

                    </tr>
                    <tr>
                        <td>Area : </td>
                        <td>
                            <input type="text" id="txtArea" name="txtArea" />
                            <%--                       <select id="ddlArea" name="ddlArea"></select>
                        <input type="button" id="btnNewArea" name="btnNewArea" value="+" onclick="ShowArea();" />--%>

                        </td>
                        <td>SubArea :                                           
                        </td>
                        <td>
                            <input type="text" id="txtSubArea" name="txtSubArea" />


                        </td>


                    </tr>
                    <tr>
                        <td>Hoarding No : </td>
                        <td>
                            <input type="text" id="txtHoardingNo" name="txtHoardingNo" />
                        </td>
                        <td>Hoarding Size</td>
                        <td>
                            <input type="text" id="txtHoardingSize" name="txtHoardingSize" />


                        </td>
                    </tr>

                    <tr>
                        <td colspan="2">
                            <input id="btnSaveHoarding" type="submit" value="Save Hoarding" />
                            <input id="btnUpdateHoarding" type="submit" value="Update Hoarding" style="display: none;" />

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
                            <li><a href="ViewHoarding.aspx">View Hoarding</a></li>
                            <li><a href="ViewCity.aspx">View City</a></li>
                            <li><a href="ViewArea.aspx">View Area</a></li>
                            <li><a href="ViewSubArea.aspx">View Sub Area</a></li>

                            <li><a href="ViewHoardingMaster.aspx" class="active">Hoarding Master</a></li>


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
        <!-- Commented Long banner which don't look necessary-->
       <%-- <div id="Banner" style="display:none">
            <img src="images/banner.png" alt="" title="" width="1000" height="275" />
        </div>--%>
        <!-- end banner part-->
        <!-- start main conten part-->
        <div id="Body_Container">
            <div class="Inner_Part">
                <div class="Welcome_Topbg">&nbsp;</div>
                <div class="Welcome_Centbg">
                    <div class="Container_Inner">
                        <h1>View Area</h1>



                        <input type="button" id="btnShow" onclick="ShowHoardingMaster();" value="Add Hoarding No" />
                        <form id="form1" runat="server">
                            <asp:ScriptManager ID="sm" runat="server">
                            </asp:ScriptManager>
                            <asp:UpdatePanel ID="up" runat="server">
                                <ContentTemplate>

                                    <div>


                                        <asp:GridView ID="gvHoardingMaster" DataKeyNames="ID" runat="server" AutoGenerateColumns="false" CssClass="custom-grid">
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
                                                        <asp:Label ID="lblArea" runat="server" Text='<%# Eval("Area")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Sub Area Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lnlSubArea" runat="server" Text='<%# Eval("SubArea")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Hoarding No">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblHoardingNo" runat="server" Text='<%# Eval("HoardingNo")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Size">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblHoardingSize" runat="server" Text='<%# Eval("HoardingSize")%>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Action">
                                                    <ItemTemplate>
                                                        <a href="javascript:void(0)" onclick="EditHoardingMaster('<%# Eval("ID")%>');">Edit</a> &nbsp;|&nbsp; 
                            <a href="javascript:void(0)" onclick="if(confirm('Are you sure want to delete record ?')){DeleteHoardingMaster('<%# Eval("ID")%>');}">Delete</a>

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

