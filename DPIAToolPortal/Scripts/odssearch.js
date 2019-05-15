var odscode;
var icocode;
var odspop = false;
var odsexists = false;
var icoexists = false;
$(document).ready(function () {
    $('#ODSSearchModal').on('shown.bs.modal', function () {
        $('#tbODSSearch').focus();
    });
    $('#btnSearchODS').click(function () {
        var sSearch = $('#tbODSSearch').val();
        $('#modalLabel').text("");
        if (sSearch.length === 0) {
            //alert('ODS code not found - no search term give.');
            $('#tbODSSearch').focus();
            return true;
        }
        $('#tbICOSearch').val(sSearch);



        var sSearchFixed = sSearch.split(' ').join('+');

        //Depricated(outdated service) var sUrl = "https://api.openods.co.uk/api/organisations?q=" + sSearchFixed + "&recordClass=HSCOrg&legallyActive=True";        
        //var sUrl = 'https://cors-anywhere.herokuapp.com/https://directory.spineservices.nhs.uk/ORD/2-0-0/organisations?Name=' + sSearchFixed + '&Limit=500&Status=Active';
        //Direct url request but no header returned and therefore rejected var sUrl = 'https://directory.spineservices.nhs.uk/ORD/2-0-0/organisations?Name=' + sSearchFixed + '&Limit=5&Status=Active';        
        // As the response header in https://directory.spineservices.nhs.uk/ORD/2-0-0 does not support CORS, it is nescessary to use a proxy server in order to include
        // "Access-Control-Allow-Headers	origin, x - requested -with, accept" within the response header.
        // Two options were considered https://cors-anywhere.herokuapp.com and www.apigee.com. Apigee was selected as it gives a degree of control/configurability over the reponse headers and is owned by google
        //
        // Note jsonp is not supported by spineservices and therefore this approach had to be discounted.
        //
        var sUrl = 'https://informationsharinggateway-eval-prod.apigee.net/spineods/organisations?Name=' + sSearchFixed + '&Limit=1000&Status=Active';
        $.ajax({            
            type: "GET",            
            dataType: "json",
            url: sUrl,
            success: odsResultsReturned,
            error: odsFailed
        });

    });

    $('#btnCheckODS').click(function () {
        odscode = $('#tbODSCode').val();
        var sSearch = odscode;
        if (sSearch.length === 0) {
            alert('ODS code not found - no search term given.');
            $('#odscheckgroup').removeClass('has-success').addClass('has-error');
            $('#odsicon').removeClass('glyphicon-ok').removeClass('hidden').addClass('glyphicon-remove');
            return true;
        }
        getODSData(sSearch);
    });
    $('#btnCheckICO').click(function () {
        icocode = $('#tbICONumber').val();
        var sSearch = icocode;
        if (sSearch.length === 0) {
            alert('ICO code not found - no search term given.');
            $('#icocheckgroup').removeClass('has-success').addClass('has-error');
            $('#icoicon').removeClass('glyphicon-ok').removeClass('hidden').addClass('glyphicon-remove');
            return true;
        }
        getICOData();
    });
    $('#btnSearchICO').click(function () {
        var sSearch = $('#tbICOSearch').val();
        if (sSearch.length === 0) {
            //alert('ODS code not found - no search term give.');
            $('#tbICOSearch').focus();
            return true;
        }
        var sSearchFixed = sSearch.split(' ').join('%');
        $.ajax({
            type: "POST",
            url: "geo.asmx/GetICOSearchMatches",
            data: "{'searchstr': '" + sSearchFixed + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                icoResultsReturned(data);
            },
            error: icoFailed
        });
    });
});
function getODSData() {
    $.ajax({
        type: "POST",
        url: "geo.asmx/CheckODSRegistered",
        data: "{'odscode': '" + odscode + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "text",
        success: odsExistsChecked,
        error: odsMatchFailed
    });
}
function odsExistsChecked(e) {
    var data = $.parseJSON(e);
    if (data.d > 0) {
        odsexists = true;
    }
    else
    {
        odsexists = false;
    }
    getODSDataChecked();
}
function getODSDataChecked() {
    //var sUrl = "https://api.openods.co.uk/api/organisations/" + odscode;
    //var sUrl = "https://directory.spineservices.nhs.uk/ORD/2-0-0/organisations/" + odscode;
    var sUrl = 'https://informationsharinggateway-eval-prod.apigee.net/spineods/organisations/' + odscode;
    $.ajax({
        type: "GET",
        url: sUrl,
        dataType: "json",
        success: odsMatched,
        error: odsMatchFailed
    });
}

function odsResultsReturned(e) {
    var orgs = e.Organisations;
    if (orgs.length === 0)
    {
        //there are no organisations
        //alert('no matches');
        $('#modalHeading').text("No ODS Match Found");
        $('#modalLabel').append("<div class='alert alert-danger' role='alert'><b>Warning:</b> No active organisation matching the given search criteria were found. Please try searching again or visiting <a href='https://odsportal.hscic.gov.uk/Organisation/Search' target='_blank'>https://odsportal.hscic.gov.uk/Organisation/Search</a> to search manually.</div>");
        $('#ODSSearchModal').modal('show');
    }
    else
    {
        //there is more than one match 
        // alert(orgs.length + ' matches');
        $('#odsresultsheading').empty();
        $('#odsresultsheading').append(String(orgs.length) + ' Matches');
        $('#ods-list-box').empty();
        $.each(orgs, function (i, item) {
             var objstring = "<li class='list-group-item'><button class='btn btn-default' onClick='odscode=\"" + item.OrgId + "\";getODSData(\"" + item.OrgId + "\");$(\"#collapseODSResults\").collapse(\"hide\");' type='button'><i aria-hidden='true' class='glyphicon glyphicon-ok'></i> Select</button> <span>" + item.Name + ", " + item.PostCode + "</span><b><span class='pull-right'>" + item.OrgId + "</span></b></li>";
            $('#ods-list-box').append(objstring);
        });
        $('#collapseODSResults').collapse('show');
    }
    
}
function odsFailed(e) {
    alert('ODS code not found');
}
function odsMatched(e) {
    $('#modalLabel').empty();
    var ods = e.Organisation.OrgId.extension;
    var sOrg = e.Organisation.Name + ', ' + e.Organisation.GeoLoc.Location.PostCode;
    $('#modalLabel').append("<p><b>" + sOrg + "</b></p>");
    if (odsexists === true)

    {
        $('#odscheckgroup').removeClass('has-error').removeClass('has-success').addClass('has-warning');
        $('#odsicon').removeClass('hidden').removeClass('glyphicon-remove').removeClass('glyphicon-ok').addClass('glyphicon-exclamation-sign');
        $('#modalHeading').text("ODS Code Already Exists");
        $('#modalLabel').append("<div class='alert alert-warning' role='alert'><b>Warning:</b> An organisation with this ODS code is already registered in the DPIA. We strongly recommend you don't continue registering this organisation. Please contact <a href='mailto:isg@mbhci.nhs.uk'>isg@mbhci.nhs.uk</a> for assistance.</div>");
    }
    else
    {
        $('#odscheckgroup').removeClass('has-error').removeClass('has-warning').addClass('has-success');
        $('#odsicon').removeClass('hidden').removeClass('glyphicon-remove').removeClass('glyphicon-exclamation-sign').addClass('glyphicon-ok');
        $('#modalHeading').text("ODS Code Matched");
    }
   
    $('#tbODSCode').val(ods);

    $('#tbIdentifiers').val(ods);
    $('#tbODSSearch').val(e.Organisation.Name);
    $('#tbOrgName').val(e.Organisation.Name);
    if ($("#hfTabIndex").length) {
        odspop = true;
        //$('#tbICOSearch').val(e.name);
        var sAddress = e.Organisation.GeoLoc.Location.AddrLn1 + "\n";
        if (e.Organisation.GeoLoc.Location.AddrLn2) {
            sAddress += e.Organisation.GeoLoc.Location.AddrLn2 + "\n";
        }
        sAddress += e.Organisation.GeoLoc.Location.Town + "\n";
        sAddress += e.Organisation.GeoLoc.Location.County + "\n";
        sAddress += e.Organisation.GeoLoc.Location.PostCode;
        $('#tbAddress').val(sAddress);
        var address = e.Organisation.GeoLoc.Location.PostCode + ", UK";
        var addressfixed = address.split(' ').join('+');
        //InformationSharingPortal.geo.GetGeoCode(addressfixed, geoCoded, geoFailed);  
        $.ajax({
            type: "POST",
            url: "geo.asmx/GetGeoCode",
            data: "{'addstr': '" + addressfixed + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: geoCoded,
            error: geoFailed
        });

        $('#ODSSearchModal').modal('show');
    }
}

function odsMatchFailed(e) {
    $('#odscheckgroup').removeClass('has-success').removeClass('has-warning').addClass('has-error');
    $('#odsicon').removeClass('glyphicon-ok').removeClass('glyphicon-exclamation-sign').removeClass('hidden').addClass('glyphicon-remove');
    $('#modalHeading').text("No ODS Match Found");
    $('#modalLabel').empty();
    $('#modalLabel').append("<p>No active organisation matching the given ODS code was found. If you are certain that the code is correct, you can ignore this warning and continue. Otherwise, please try searching for your ODS code instead.</p>");
    $('#ODSSearchModal').modal('show');
    $('#tbODSCode').focus();
}

//ICO Searching and Verifcation //

function icoResultsReturned(data) {
    var orgData = $.parseJSON(data.d);
    if (orgData.length === 0) {
        //there are no organisations
        //alert('no matches');
        $('#modalHeading').text("No ICO Match Found");
        $('#modalLabel').text("No active organisation matching the given search criteria were found. Please try searching again or visiting https://ico.org.uk/esdwebpages/search to seacrh manually.");
        $('#ODSSearchModal').modal('show');
    }
    else {
        //there is more than one match 
        // alert(orgs.length + ' matches');
        $('#icoresultsheading').empty();
        $('#icoresultsheading').append(String(orgData.length) + ' Matches');
        $('#ico-list-box').empty();
        $.each(orgData, function (i, item) {
            var objstring = "<li class='list-group-item'><button class='btn btn-default' onClick='icocode=\"" + item.Registration_number + "\";getICOData(\"" + item.Registration_number + "\");$(\"#collapseICOResults\").collapse(\"hide\");' type='button'><i aria-hidden='true' class='glyphicon glyphicon-ok'></i> Select</button> <span>" + item.Organisation_name + ", " + item.Postcode + "</span><b><span class='pull-right'>" + item.Registration_number + "</span></b></li>";
            $('#ico-list-box').append(objstring);
        });
        $('#collapseICOResults').collapse('show');
    }

}
function icoFailed(e) {
    alert('ICO code not found - web API service error.');
}
function getICOData() {
    $.ajax({
        type: "POST",
        url: "geo.asmx/CheckICORegistered",
        data: "{'iconum': '" + icocode + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "text",
        success: icoExistsChecked,
        error: icoMatchFailed
    });
}
function icoExistsChecked(e) {
    var data = $.parseJSON(e);
    if (data.d > 0) {
        icoexists = true;
    }
    else
    {
        icoexists = false;
    }
    getICODataChecked();
}
function getICODataChecked() {
    $.ajax({
        type: "POST",
        url: "geo.asmx/GetICOCodeMatch",
        data: "{'icocodestr': '" + icocode + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: icoMatched,
        error: icoMatchFailed
    });
}
function icoMatched(data) {
    var orgData = $.parseJSON(data.d);
    var org = orgData["0"];
    var sOrg = org.Organisation_name + ', ' + org.Postcode;
    $('#modalLabel').empty();
    $('#modalLabel').append("<b>" + sOrg + "</b>");
    if (icoexists === true) {
        $('#icocheckgroup').removeClass('has-error').removeClass('has-success').addClass('has-warning');
        $('#icoicon').removeClass('hidden').removeClass('glyphicon-remove').removeClass('glyphicon-ok').addClass('glyphicon-exclamation-sign');
        $('#modalHeading').text("ICO Number Already Exists");
        $('#modalLabel').append("<div class='alert alert-warning' role='alert'><b>Warning:</b> An organisation with this ICO number is already registered in the DPIA. We strongly recommend you don't continue registering this organisation unless you are aware that it shares its ICO registration with others. Please contact <a href='mailto:isg@mbhci.nhs.uk'>isg@mbhci.nhs.uk</a> for assistance.</div>");
    }
    else {
        $('#icocheckgroup').removeClass('has-error').removeClass('has-warning').addClass('has-success');
        $('#icoicon').removeClass('hidden').removeClass('glyphicon-remove').removeClass('glyphicon-exclamation-sign').addClass('glyphicon-ok');
        $('#modalHeading').text("ICO Number Matched");
    }



    var ico = org.Registration_number;
    $('#tbICONumber').val(ico);
    $('#tbICOSearch').val(org.Organisation_name);
    if (odspop === false) {
        $('#tbOrgName').val(org.Organisation_name);
        var sAddress = org.Address1 + "\n";
        sAddress += org.Address2 + "\n";
        sAddress += org.Address3 + "\n";
        sAddress += org.Postcode;
        $('#tbAddress').val(sAddress);
        $('#tbAliases').val(org.Trading_names);


    }
    var address = org.Postcode + ", UK";
    var addressfixed = address.split(' ').join('+');
    //InformationSharingPortal.geo.GetGeoCode(addressfixed, geoCoded, geoFailed);   
    $.ajax({
        type: "POST",
        url: "geo.asmx/GetGeoCode",
        data: "{'addstr': '" + addressfixed + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: geoCoded,
        error: geoFailed
    });
}
        $('#ODSSearchModal').modal('show');
        function icoMatchFailed(e) {
            $('#icocheckgroup').removeClass('has-success').addClass('has-error');
            $('#icoicon').removeClass('glyphicon-ok').removeClass('hidden').addClass('glyphicon-remove');
            $('#modalHeading').text("No ODS Match Found");
            $('#modalLabel').empty();
            $('#modalLabel').append("<p>No active organisation matching the given ODS code was found. If you are certain that the code is correct, you can ignore this warning and continue. Otherwise, please try searching for your ODS code instead.</p>");
            $('#ODSSearchModal').modal('show');
            $('#tbODSCode').focus();
        }