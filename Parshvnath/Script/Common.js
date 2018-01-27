
       function EditDialog(index) {
           var pages = '<%=Session["Path"]%>' + "Hoarding.aspx?HoardingHistoryID=" + index;

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



function showDialog(index) {
    var pages = '<%=Session["Path"]%>' + "Hoarding.aspx?ID=" + index;

    //var pages = "/Parshva/Hoarding.aspx?ID=" + index;
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
var availableTags = [];
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
            console.log(ui.item.label);
            console.log(ui.item.value);
            $("#hdnHoardingSize").val(ui.item.value);
        },
        change: function (event, ui) {
            if (ui.item == null || ui.item == undefined) {
                $("#txtHoardingSize").val("");
                $("#txtHoardingSize").attr("disabled", false);
                $("#hdnHoardingSize").val("");
                $("#hdnHoardingSize").attr("disabled", false);
            } else {

                $("#txtHoardingSize").attr("disabled", false);
                $("#hdnHoardingSize").attr("disabled", false);

            }
        }
    });

    $("#txtCompany").autocomplete({
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
        $("#txtUser").val("");
        $("#txtUser").attr("disabled", false);
        $("#hdnParty").val("");
        $("#hdnParty").attr("disabled", false);
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
        $("#txtArea").val("");
        $("#txtArea").attr("disabled", false);
        $("#hdnArea").val("");
        $("#hdnArea").attr("disabled", false);
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
        $("#city").val("");
        $("#city").attr("disabled", false);
        $("#hdnCity").val("");
        $("#hdnCity").attr("disabled", false);
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
                        $("#cityAll").val("");
                        $("#cityAll").attr("disabled", false);
                        $("#hdnCityAll").val("");
                        $("#hdnCityAll").attr("disabled", false);
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
        $("#txtArea").val("");
        $("#txtArea").attr("disabled", false);
        $("#hdnArea").val("");
        $("#hdnArea").attr("disabled", false);
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
        $("#areaAll").val("");
        $("#areaAll").attr("disabled", false);
        $("#hdnAreaAll").val("");
        $("#hdnAreaAll").attr("disabled", false);
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
        $("#txtSubArea").val("");
        $("#txtSubArea").attr("disabled", false);
        $("#hdnSubArea").val("");
        $("#hdnSubArea").attr("disabled", false);
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
        height: 300,
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

    $(".normal td:first-child").css({ "text-align": "right", "width": "150px", "font-size": "50px", "font-weight": "normal" })
    $(".active-row td:first-child").css({ "text-align": "right", "width": "150px", "font-size": "50px", "font-weight": "normal" })
    $(".inactive-row td:first-child").css({ "text-align": "right", "width": "150px", "font-size": "50px", "font-weight": "normal" })

    $(".alternate td:first-child").css({ "text-align": "right", "width": "150px", "font-size": "50px", "font-weight": "normal" });
    $("#gvHoardingMaster td[colspan='8']").css({ "text-align": "left", "width": "auto", "font-size": "24px", "font-weight": "normal" });

    InitializeAutocomplete();
    InitializeDialog();
    InitializeFormValidation();



});

/*
Here I have remove code for add/edit area , subarea,city
*/
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
    var toDate, fromDate;

    if ((rdo == null || rdo.length <= 0) && moment(fromDate).isValid()) {
        alert("Please select Day or Month");
    } else {
        //console.log(rdo);
        if (moment(fromDate).isValid()) {


            if (rdo == "day" && !isNaN(DayOrMonth) && DayOrMonth.length > 0) {
                var toDate = moment($("#txtFromDate").val(), "DD-MM-YY").add(DayOrMonth, "days");
                $("#txtToDate").val(toDate.format("DD-MM-YY"));
                //console.log(toDate);



            } else if (rdo == "month" && !isNaN(DayOrMonth) && DayOrMonth.length > 0) {
                var toDate = moment($("#txtFromDate").val(), "DD-MM-YY").add(DayOrMonth, "months");
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
                //  $("#dialog-hoarding-master").dialog("close");
                window.location.href = window.location.href;
                //  location.href = location.protocol+"//"+location.hostname+"/ViewArea.aspx";
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
    $("#btnSaveHoarding").show();
}

function EditHoardingMaster(ID) {
    console.log("Record Edited");
}

function DeleteHoardingMaster(ID) {
    console.log("Record Deleted");
}
