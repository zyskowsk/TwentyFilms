window.TwentyFilms =
  _DbBaseUrl: 'http://twentyFilms.herokuapp.com'
  # _DbBaseUrl: 'http://localhost:3000'
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
    films = currentUser.get('films')

    new TwentyFilms.Routers.Router($filmList, $search, films)
    Backbone.history.start()

$(document).ready ->
  TwentyFilms.initialize()
  $( ".sortable" ).sortable()
