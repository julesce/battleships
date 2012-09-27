# Need to use 'fire_shot' as a global variable here so that we can call it from our table cell onclick event handler
window.fire_shot = (game_id, x, y) ->
  $.get '/games/' + game_id + '/fire_shot/' + x + '/' + y, (data) ->
    $('#boards_container').html data

# Fire the ajax-loader when we click on the opponent's board
$(document).ready ->
  $('table.opponent').live 'click', ->
    new ajaxLoader this, {classOveride: 'blue-loader', bgColor: '#000'}