window.TwentyFilms =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  
  initialize: -> 
    $filmList = $('#film-list')
    $search = $('#search')
    $filmNew = $('#film-new')
    $filmShow = $('#film-show')

    data = JSON.parse $('#current_user_bs').html()
    currentUser = new TwentyFilms.Models.User(data, parse: true)
    films = currentUser.get('films')

    new TwentyFilms.Routers.Router(
      $filmList, 
      $search, 
      $filmNew, 
      $filmShow, 
      films
    )

    Backbone.history.start()

$(document).ready ->
  $('#film-new').hide()
  $('#film-show').hide() 
  TwentyFilms.initialize()
