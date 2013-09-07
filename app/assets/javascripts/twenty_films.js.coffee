window.TwentyFilms =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Store: {}
  Search: {}
  
  initialize: -> 
    $filmList = $('#film-list')
    $search = $('#search')
    $filmNew = $('#film-new')
    $filmShow = $('#film-show')
    $userShow = $('#user-show')

    usersData = JSON.parse $('#user_bs').html()
    users = new TwentyFilms.Collections.Users(
      usersData, 
      parse: true
    )

    TwentyFilms.Store.users = users

    #Move this somewhere
    TwentyFilms.Search.clenseResult = (result) ->
      newObject = {}
      for key in _(result).keys()
        newObject[key.toLowerCase()] = result[key]

      newObject

    currentUserId = $('#current_user_id').html()
    currentUser = users.get parseInt(currentUserId)
    films = currentUser.get('films')

    new TwentyFilms.Routers.Router(
      $filmList, 
      $search, 
      $filmNew, 
      $filmShow,
      $userShow, 
      films
    )

    Backbone.history.start()

$(document).ready ->
  $('#film-new').hide()
  $('#film-show').hide() 
  TwentyFilms.initialize()
