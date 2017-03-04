/// <reference path="jquery-1.11.2.min.js" />

$(document).ready(function () {
    getsongs();
});

var audio = document.getElementById('player'); //reproduce las canciones o las pausa
var music;

function getsongs() {
    //$.ajax({
    //    dataType: "json",
    //    url: "assets/js/app.json",
    //    //data: data,
    //    success: function (data) {
    //        alert("hello");
    //    }
    //    console.lo
    //});

    //$.getJSON("assets/js/app.json", function (mjson) {
    //    music = mjson;
    //    genList(music);
    //}
    //);

  //  var jqxhr = $.getJSON("assets/js/app.json", function () {
  //      console.log("success");
  //  })
  //.done(function () {
  //    console.log("second success");
  //})
  //.fail(function (error) {
  //    alert(error);
  //    console.log(error);
  //})
  //.always(function () {
  //    console.log("complete");
    //});

    $.ajax({
        url: 'assets/js/app.json',
        dataType: 'text', // si pongo json caga el palo
        success: function (mjson) {
            //alert("SUCCESS:  " + data);
                music = mjson;
                genList(music);
        },
        error: function (mjson) {
            //alert("ERROR:  " + JSON.stringify(data));
        }
    });
}

var songs = [{
    "id": 0,
    "name": "Algo Inmoral",
    "artista": "Lulaby",
    "song": "music/Algo Inmoral.mp3",
    "image": "Images/Músicos/lulaby.jpg"
},
            {
                "id": 1,
                "name": "El enigma de tus besos",
                "artista": "Vampiros Leyenda Urbana",
                "song": "music/El enigma.mp3",
                "image": "Images/Músicos/vampiros01.png"
            },
            {
                "id": 2,
                "name": "Fuckaholic",
                "artista": "Commando",
                "song": "music/fuckaholic.mp3",
                "image": "Images/Músicos/commando.jpg"
            },
            {
                "id": 3,
                "name": "Serial Bitch Killer",
                "artista": "Commmando",
                "song": "music/SBK.mp3",
                "image": "Images/Músicos/commando.jpg"
            },
];

function playSong(id) {
    $('#img-album').attr('src', songs[id].image);
    $('#player').attr('src', songs[id].song);
    audio.play();

    scheduleSong(id);
};

function genList(music) {
    debugger;
    //for (var i = 0; i < music.length; i++) {
    //    $('#playlist').append('<li class="list-group-item" id="' + music.songs[i].id + '">' + music.songs[i].name + '</li>');

    //}

    $.each(songs, function (i, song) {
        $('#playlist').append('<li class="list-group-item" id="' + song.id + '"><div class="form-group"><div class="col-md-1"># '+song.id+'</div><div class="col-md-7">'+song.name+'</div><div class="col-md-2" align="right">3:24</div><div class="col-md-2"><div class="form-group"><a class="label dropdown-toggle" data-toggle="dropdown" style="color: black" href="#">Opciones<span class="caret"></span></a><ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu"><li><a tabindex="-1" href="#">Guardar en Tú Música</a><li class="dropdown-submenu"><a tabindex="-1" href="#">Agregar a Playlist</a><ul class="dropdown-menu"><li><a tabindex="-1" href="#">Lord Of Metal</a><li><a tabindex="-1" href="#">God Of Rock</a><li><a tabindex="-1" href="#">Our Dark Past</a></li></ul></li></li></ul></div></div></div></li>');
    });

    $('#playlist li').click(function () {
        debugger;
        var selectedsong = $(this).attr('id');
        playSong(selectedsong);
        
        //$('#playlist li id').addClass('active');

        //var selector = '.nav li';

            $('#playlist li').removeClass('active');
            $(this).addClass('active');

    });
};

function scheduleSong(id) {
    audio.onended = function () {
        playSong(parseInt(id) + 1);
        debugger;

        var selectedsong = parseInt(id) + 1;

        $('#playlist li').removeClass('active');
        
        //var id = $("#playlist li").attr("id");

        //$(id).addClass('active');

        $('#playlist li[id="' + selectedsong + '"]').addClass('active');

    }
};