App.YoutubeEmbeds =
  initialize: ->
    $(".custom-page").find('iframe').attr( "allowFullscreen", "true" )
    $(".custom-page").find('iframe').wrap( "<div class='youtube-video-wrapper'></div>" );
