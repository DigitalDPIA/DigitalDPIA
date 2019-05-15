/*DRAW THE MAP*/
var orgid = document.getElementById("hfOrgID").value;
var regionid = document.getElementById("hfRegionID").value;
var map;
$(document).ready(function () {


    $.ajax({
        type: "POST",
        url: "geo.asmx/GetMapData",
        data: "{'org': '" + orgid + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        hrFields: { withCredentials: true },
        success: function (data) {
            drawmap(data);
        },
        error: function (XHR, errStatus, errorThrown) {
            var err = JSON.parse(XHR.responseText);
            errorMessage = err.Message;
            alert(errorMessage);
        }
    });
});
function drawmap(data) {
    var mapData = $.parseJSON(data.d);
    var minBulletSize = 8;
    var maxBulletSize = 22;
    var min = Infinity;
    var max = -Infinity;


    // get min and max values
    for (var i = 0; i < mapData.length; i++) {
        var value = mapData[i].value;
        if (value < min) {
            min = value;
        }
        if (value > max) {
            max = value;
        }
    }

    AmCharts.theme = AmCharts.themes.dark;
    map = new AmCharts.AmMap();
    map.pathToImages = "ammap/images/";
    map.imagesSettings.balloonText = "<span style='font-size:14px;'><b>[[title]]</b>: [[value]]</span>";
    //map.balloon.color = "#000000";

    var dataProvider = {
        mapVar: AmCharts.maps.unitedKingdomLow,
        getAreasFromMap: true,
        images: []
    };
    // create circle for each country


    // it's better to use circle square to show difference between values, not a radius
    var maxSquare = maxBulletSize * maxBulletSize * 2 * Math.PI;
    var minSquare = minBulletSize * minBulletSize * 2 * Math.PI;

    // create circle for each country
    for (var i = 0; i < mapData.length; i++) {
        var dataItem = mapData[i];
        var value = dataItem.value;
        // calculate size of a bubble
        var square = (value - min) / (max - min) * (maxSquare - minSquare) + minSquare;
        if (square < minSquare) {
            square = minSquare;
        }
        var size = Math.sqrt(square / (Math.PI * 2));
        var id = dataItem.code;

        dataProvider.images.push({
            id: dataItem.code,
            type: "circle",
            width: size,
            height: size,
            color: dataItem.color,
            longitude: dataItem.longitude,
            latitude: dataItem.latitude,
            title: dataItem.name,
            value: value,
            selectable: dataItem.selectable,
            outlineColor: "#fa13ad",
            outlineAlpha: dataItem.outlineAlpha,
            outlineThickness: 2
        });

    }
    map.backgroundZoomsToTop = true;
    map.mouseWheelZoomEnabled = true;
    map.dataProvider = dataProvider;
    map.export = {
        enabled: true
    }
    map.imagesSettings = {
        
        //rollOverColor: "#089282",
        rollOverScale: 1.5,
        selectedScale: 2
        //selectedColor: "#089282"
    };
   

    map.areasSettings = {
        unlistedAreasColor: "#000000",
        unlistedAreasAlpha: 0.1,
        color: "#ababab",
        selectedColor: "#555555",
        rollOverColor: "#6a6a6a",
        autoZoom: true
    };
    map.smallMap = new AmCharts.SmallMap();
    //map.addListener("selectedObjectChanged", function (event) {
    //    console.log(map.selectedObject.objectType);
    //    if (map.selectedObject.objectType == "MapImage") {
    //        resetAreaColors();
    //        id = map.selectedObject.id;
    //        arr = id.split(",");
    //        setcentre(arr[0], arr[1]);
    //    };
    //    if (map.selectedObject.objectType == "MapArea") {
    //        resetAreaColors();
    //        id = map.selectedObject.id;
    //        setObjectColor(id, "#bbff00");
    //        setregion(id);
    //    };
    //    if (map.selectedObject.objectType == "MapData") {
    //        id = map.selectedObject.id;
    //        setregion(0);
    //    };
    //});
    map.addListener("selectedObjectChanged", function (event) {
        console.log(map.selectedObject.objectType);
        if (map.selectedObject.objectType == "MapImage") {
            resetAreaColors();
            id = map.selectedObject.id;
            setcentre(id);
        };
        if (map.selectedObject.objectType == "MapArea") {
            resetAreaColors();
            id = map.selectedObject.id;
            setObjectColor(id, "#555555");
        };
    });
    map.write("mapdiv");
    
    map.getObjectById("IE").color = "#000000";
    map.getObjectById("IE").selectable = false;
    if (parseInt(regionid) > 0 && parseInt(regionid) != 20)
    {
        map.clickMapObject(map.getObjectById('' + regionid +''));
    }
    
}
/*Show centre info when centre clicked on map*/
function setcentre(centre) {
    var e = document.getElementById("hfMapOrgID");
    e.value = parseInt(centre);
    showCentreInfo(centre);
};
//Set area color:
function setObjectColor(id, color) {
    var area = map.getObjectById(id);
    area.color = color;
    area.colorReal = area.color;
    map.returnInitialColor(area);
};
function resetAreaColors() {
    setObjectColor(1, "#ababab");
    setObjectColor(2, "#ababab");
    setObjectColor(3, "#ababab");
    setObjectColor(4, "#ababab");
    setObjectColor(5, "#ababab");
    setObjectColor(7, "#ababab");
    setObjectColor(8, "#ababab");
    setObjectColor(9, "#ababab");
    setObjectColor(11, "#ababab");
    setObjectColor(12, "#ababab");
    setObjectColor(14, "#ababab");
};
/*GET CENTRE INFO*/
function showCentreInfo(centre) {
    var btn = document.getElementById('btnGetOrgInfo');
    btn.click();
    //__doPostBack('btnGetOrgInfo', '');
}