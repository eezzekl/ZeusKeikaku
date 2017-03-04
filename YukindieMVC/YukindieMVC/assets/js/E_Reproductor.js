var audio;

//Hide Pause Initially
$('#pause').hide();

//Initializer - Play First Song
initAudio($('#playlist li:first-child'));

function initAudio(element) {
    var song = element.attr('song');
    var title = element.text();
    var cover = element.attr('cover');
    var artist = element.attr('artist');

    //Create a New Audio Object
    audio = new Audio('music/' + song);

    if (!audio.currentTime) {
        $('#duration').html('0.00');
    }

    //$('#audio-player .title').text(title);
    //$('#audio-player .artist').text(artist);

    //ponemos la duracion total a una variable pendiente

    //var s = parseInt(audio.duration % 60);
    //var m = parseInt((audio.duration / 60) % 60);
    ////Add 0 if seconds less than 10
    //if (s < 10) {
    //    s = '0' + s;
    //}
    //$('#durationTotal').html(m + ':' + s);

    $('#audio-info .title').text(title);
    $('#audio-info .artist').text(artist);

    //Insert Cover Image
    $('img.cover').attr('src', 'images/covers/' + cover);

    $('#playlist li').removeClass('active');
    element.addClass('active');
}


//Play Button
$('#play').click(function () {
    audio.play();
    $('#play').hide();
    $('#pause').show();
    $('#duration').fadeIn(400);
    showDuration();
    totalDuration();
    return false;
});

//Pause Button
$('#pause').click(function () {
    audio.pause();
    $('#pause').hide();
    $('#play').show();
    return false;
});

//Stop Button
$('#stop').click(function () {
    audio.pause();
    audio.currentTime = 0;
    $('#pause').hide();
    $('#play').show();
    $('#duration').fadeOut(400);
    return false;
});

//Next Button
$('#next').click(function () {
    audio.pause();
    var next = $('#playlist li.active').next();
    if (next.length == 0) {
        next = $('#playlist li:first-child');
    }
    initAudio(next);
    audio.play();
    showDuration();
    totalDuration();
    return false;
});

//Prev Button
$('#prev').click(function () {
    audio.pause();
    var prev = $('#playlist li.active').prev();
    if (prev.length == 0) {
        prev = $('#playlist li:last-child');
    }
    initAudio(prev);
    audio.play();
    showDuration();
    totalDuration();
    return false;
});

function totalDuration() {
    audio.ondurationchange = function () {
        var s = parseInt(audio.duration % 60);
        var m = parseInt((audio.duration / 60) % 60);
        //Add 0 if seconds less than 10
        if (s < 10) {
            s = '0' + s;
        }
        $('#durationTotal').html(m + ':' + s);

        //para el rango
        $('#volume').attr('min', 0);
        $('#volume').attr('max', audio.duration);
        $('#volume').attr('value', 0);
    };
};

//Playlist Song Click
$('#playlist li').click(function () {
    audio.pause();
    initAudio($(this));
    $('#play').hide();
    $('#pause').show();
    $('#duration').fadeIn(400);
    audio.play();
    showDuration();
    totalDuration();
    $('#playlist li').removeClass('active');
    $(this).addClass('active');
});

$("#volume").bind("change", function () {
    debugger;
    audio.currentTime = $(this).val();
    audio.play();
});

//$("#volume").bind("focusin", function () {
//    debugger;
//    audio.currentTime = $(this).val();
//});

//$("#volume").bind("focusout", function () {
//    debugger;
//    audio.currentTime = $(this).val();
//});

//$("#volume").bind("change", function () {
//    debugger;
//    audio.currentTime = $(this).val();
//});

//$(audio).bind('seeking', function () {
//    debugger;
//    audio.currentTime = $(this).val();
//});

//Volume Control
//$('#volume').change(function () {
//    audio.volume = parseFloat(this.value / 10);
//});

//Time Duration
function showDuration() {
    $(audio).bind('timeupdate', function () {
        //Get hours and minutes
        var s = parseInt(audio.currentTime % 60);
        var m = parseInt((audio.currentTime / 60) % 60);
        //Add 0 if seconds less than 10
        if (s < 10) {
            s = '0' + s;
        }
        $('#duration').html(m + ':' + s);
        //var value = 0;
        //if (audio.currentTime > 0) {
        //    value = Math.floor((100 / audio.duration) * audio.currentTime);
        //}
        //$('#progress').css({ 'width': progress * 2 })

        var track_length = audio.duration;
        var secs = audio.currentTime;
        var progress = (secs / track_length) * 100;

        
        $('#volume').val(progress * 2.1);
    });
}