function getGeoCode() {
    var pcstring = document.getElementById("tbAddress").value;
    if (pcstring.length == 0)
    {
        alert('Map location not found - no address given.\n\nMake sure your organisation postcode forms the last line of the address.');
        return true;
    }
    else {
        pcstring = pcstring.replace(/^(?=\n)$|^\s*|\s*$|\n\n+/gm, "")
        pcstring = pcstring.substr(pcstring.lastIndexOf("\n") + 1);
    var address = pcstring + ", UK";
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
}
function geoCoded(e) {
    var data = eval('(' + e.d + ')');
    if (data.status == "OK") {
        var resultLat = data.results[0].geometry.location.lat;
        document.getElementById("hfLattitude").value = parseFloat(resultLat);
        var resultLng = data.results[0].geometry.location.lng;
        document.getElementById("hfLongitude").value = parseFloat(resultLng);
        data.results[0].address_components.forEach(function (element, index) {
            if (element.types[0] === "administrative_area_level_2") {
                var scounty = element.long_name;
                document.getElementById("hfCounty").value = scounty;
            }
        }
        );
        //alert('map location found based on postcode.');
        return true;
    }
    else {
        alert('Map location not found - postcode error.\n\nMake sure your organisation postcode forms the last line of the address.');
        return true;
    }
}
function geoFailed() {
    alert('map location not found - web service error.');
}