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
    $followings = $('#followings')

    usersData = JSON.parse $('#user_bs').html()
    debugger
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
    debugger
    films = currentUser.get('films')

    new TwentyFilms.Routers.Router(
      { 
        list: $filmList, 
        search: $search, 
        filmNew: $filmNew, 
        filmShow: $filmShow,
        userShow: $userShow,
        followings: $followings 
      },
      films
    )

    Backbone.history.start()

$(document).ready ->
  $('#film-new').hide()
  $('#film-show').hide() 
  TwentyFilms.initialize()
