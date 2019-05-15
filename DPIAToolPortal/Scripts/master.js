var sessionTimeoutWarning = 3;
var sessionTimeout = '<%= Session.Timeout %>';
var timeOnPageLoad = new Date();
var sessionWarningTimer = null;
var redirectToWelcomePageTimer = null;
//For warning
var sessionWarningTimer = setTimeout('SessionWarning()', parseInt(sessionTimeoutWarning) * 60 * 1000);
//To redirect to the welcome page
var redirectToWelcomePageTimer = setTimeout('RedirectToWelcomePage()', parseInt(sessionTimeout) * 60 * 1000);
var modalShown = false;
//Session Warning

function SessionWarning() {
    //minutes left for expiry
    var minutesForExpiry = (parseInt(sessionTimeout) - parseInt(sessionTimeoutWarning));
    var message = "Your DPIA session will expire in another " + minutesForExpiry + " minutes due to inactivity. Do you want to extend the session?";
    $('#lblTimeoutMessage').val(message);
    //Confirm the user if he wants to extend the session
    //answer = confirm(message);
    if (!modalShown) {
        $('#modalMessage').modal('show');
        modalShown = true;
    }
    
    //if yes, extend the session.
    if (answer) {
       
    }

    //*************************
    //Even after clicking ok(extending session) or cancel button, 
    //if the session time is over. Then exit the session.
    var currentTime = new Date();
    //time for expiry
    var timeForExpiry = timeOnPageLoad.setMinutes(timeOnPageLoad.getMinutes() + parseInt(sessionTimeout));

    //Current time is greater than the expiry time
    if (Date.parse(currentTime) > timeForExpiry) {
        alert("DPIA Session expired. You will be redirected to welcome page");
        window.location = "../Account/Login.aspx";
    }
    //**************************
}

//Session timeout
function RedirectToWelcomePage() {
    alert("DPIA Session expired. You will be redirected to welcome page");
    window.location = "../Account/Login.aspx";
}

$(function () {
    var f = $("#<%=hfPosition.ClientID%>");
    window.onload = function () {
        var position = parseInt(f.val());
        if (!isNaN(position)) {
            $(window).scrollTop(position);
        }
    };
    window.onscroll = function () {
        var position = $(window).scrollTop();
        f.val(position);
    };
    $('#btnKeepAlive').on('click', function () {
        var img = new Image(1, 1);
        img.src = '../KeepAlive.aspx?date=' + escape(new Date());

        //Clear the RedirectToWelcomePage method
        if (redirectToWelcomePageTimer != null) {
            clearTimeout(redirectToWelcomePageTimer);
        }
        //reset the time on page load
        timeOnPageLoad = new Date();
        sessionWarningTimer = setTimeout('SessionWarning()', parseInt(sessionTimeoutWarning) * 60 * 1000);
        //To redirect to the welcome page
        redirectToWelcomePageTimer = setTimeout('RedirectToWelcomePage()', parseInt(sessionTimeout) * 60 * 1000);
    })
});
(function (e) {
    var $winWidth = e(window).width();
    e(document).on('show.bs.modal', function () {
        if ($winWidth < e(window).width()) {
            e('body.modal-open,.navbar-fixed-top,.navbar-fixed-bottom').css('marginRight', e(window).width() - $winWidth)
        }
    });
    e(document).on('hidden.bs.modal', function () {
        e('body,.navbar-fixed-top,.navbar-fixed-bottom').css('marginRight', 0)
    });
})(jQuery);