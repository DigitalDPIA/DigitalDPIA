function viewFAQ(id) {
    faqid = id;
    $.ajax({
        url: "isg.asmx/IncrementFAQViewCount",
        type: "POST",
        data: "faqid=" + faqid,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "text",
        error: function () {
            //alert('fail');
            //console.log("Failed!! call to itspkbservice.asmx/IncrementVideo with parameters tid=" + tutid + "&candidateid=" + canid + " FAILED");
        },
        success: function (data) {
            //alert('success');
            //console.log("Success!! call to itspkbservice.asmx/IncrementVideo with parameters tid=" + tutid + "&candidateid=" + canid + " SUCCEEDED");
            //use the returned data (view count) to update the video stats label
            //$("#vidstats").html("Rated " + videorating.replace(".0", "") + "/5 (" + videorates + " ratings) " + data + " views");
            //console.log(data);
        },
    });
}