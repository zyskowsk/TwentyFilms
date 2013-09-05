window.TwentyFilms =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Store: {}
  initialize: -> 
    data = JSON.parse($('#current_user_bs').html())
    currentUser = new TwentyFilms.Models.User(data, {parse: true})
    TwentyFilms.Store.currentUser = currentUser
    $filmList = $('#film-list')
    $search = $('#search')
    $newForm = $('#new-film-form')
    films = currentUser.get('films')

    new TwentyFilms.Routers.Router($filmList, $search, $newForm, films)
    Backbone.history.start()

$(document).ready ->
  $('#new-film-form').hide()
  TwentyFilms.initialize()
