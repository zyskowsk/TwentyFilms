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
    $filmForm = $('#film-form')
    films = currentUser.get('films')
    $('.sortable').sortable()

    new TwentyFilms.Routers.Router($filmList, $filmForm, films)
    Backbone.history.start()

$(document).ready ->
  TwentyFilms.initialize()
  $( ".sortable" ).sortable();
