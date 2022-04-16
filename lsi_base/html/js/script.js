var notifs = {};
var cancelledTimer = null;
var radioshowed = false;

$('document').ready(function() {
    MythicProgBar = {};

    MythicProgBar.Progress = function(data) {
        clearTimeout(cancelledTimer);
        $("#progress-label").text(data.label);

        $(".progress-container").fadeIn('fast', function() {
            $("#progress-bar").stop().css({"width": 0, "background-color": "rgba(0, 0, 0, 0.75)"}).animate({
              width: '100%'
            }, {
              duration: parseInt(data.duration),
              complete: function() {
                $(".progress-container").fadeOut('fast', function() {
                    $('#progress-bar').removeClass('cancellable');
                    $("#progress-bar").css("width", 0);
                    $.post('https://lsi_base/actionFinish', JSON.stringify({
                        })
                    );
                })
              }
            });
        });
    };

    MythicProgBar.ProgressCancel = function() {
        $("#progress-label").text("CANCELLED");
        $("#progress-bar").stop().css( {"width": "100%", "background-color": "rgba(71, 0, 0, 0.8)"});
        $('#progress-bar').removeClass('cancellable');

        cancelledTimer = setTimeout(function () {
            $(".progress-container").fadeOut('fast', function() {
                $("#progress-bar").css("width", 0);
                $.post('https://lsi_base/actionCancel', JSON.stringify({
                    })
                );
            });
        }, 1000);
    };

    MythicProgBar.CloseUI = function() {
        $('.main-container').fadeOut('fast');
    };

    window.addEventListener('message', function(event) {
        if (event.data.action == "mythic_progress") {
            MythicProgBar.Progress(event.data);
        } else if (event.data.action == "SendAlert") {
            ShowNotif(event.data);
        } else if (event.data.action == "SendAlert") {
            MythicProgBar.ProgressCancel();
        } else if (event.data.type == "enableui") {
            $('#radio').css("display", event.data.enable ? "block" : "none");
        }
    });
});

document.onkeyup = function (data) {
    if (data.which == 27) { // Escape key
        $.post('https://lsi_base/closeradio', JSON.stringify({}));
    }
};

$("#login-form").submit(function(e) {
    e.preventDefault(); // Prevent form from submitting

    $.post('https://lsi_base/joinRadio', JSON.stringify({
        channel: $("#channel").val()
    }));
});

$("#onoff").submit(function(e) {
    e.preventDefault(); // Prevent form from submitting

    $.post('https://lsi_base/leaveRadio', JSON.stringify({

    }));
});

function CreateNotification(data) {
    let $notification = $(document.createElement('div'));
    $notification.addClass('notification').addClass(data.type);
    $notification.html(data.text);
    $notification.fadeIn();
    if (data.style !== undefined) {
        Object.keys(data.style).forEach(function(css) {
            $notification.css(css, data.style[css])
        });
    }

    return $notification;
}

function UpdateNotification(data) {
    let $notification = $(notifs[data.id])
    $notification.addClass('notification').addClass(data.type);
    $notification.html(data.text);

    if (data.style !== undefined) {
        Object.keys(data.style).forEach(function(css) {
            $notification.css(css, data.style[css])
        });
    }
}

function ShowNotif(data) {
    if (data.persist != null) {
        if (data.persist.toUpperCase() == 'START') {
            if (notifs[data.id] === undefined) {
                let $notification = CreateNotification(data);
                $('.notif-container').append($notification);
                notifs[data.id] = {
                    notif: $notification  
                };
            } else {
                UpdateNotification(data);
            }
        } else if (data.persist.toUpperCase() == 'END') {
            if (notifs[data.id] != null) {
                let $notification = $(notifs[data.id].notif);
                $.when($notification.fadeOut()).done(function() {
                    $notification.remove();
                    delete notifs[data.id];
                });
            }
        }
    } else {
        if (data.id != null) {
            if (notifs[data.id] === undefined) {
                let $notification = CreateNotification(data);
                $('.notif-container').append($notification);
                notifs[data.id] = {
                    notif: $notification,
                    timer: setTimeout(function() {
                        let $notification = notifs[data.id].notif;
                        $.when($notification.fadeOut()).done(function() {
                            $notification.remove();
                            clearTimeout(notifs[data.id].timer);
                            delete notifs[data.id];
                        });
                    }, data.length != null ? data.length : 2500)
                };
            } else {
                clearTimeout(notifs[data.id].timer);
                UpdateNotification(data);

                notifs[data.id].timer = setTimeout(function() {
                    let $notification = notifs[data.id].notif;
                    $.when($notification.fadeOut()).done(function() {
                        $notification.remove();
                        clearTimeout(notifs[data.id].timer);
                        delete notifs[data.id];
                    });
                }, data.length != null ? data.length : 2500)
            }
        } else {
            let $notification = CreateNotification(data);
            $('.notif-container').append($notification);
            setTimeout(function() {
                $.when($notification.fadeOut()).done(function() {
                    $notification.remove()
                });
            }, data.length != null ? data.length : 2500);
        }
    }
}