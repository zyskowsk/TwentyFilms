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

    currentUserId = $('#current_user_id').html()
    usersData = JSON.parse $('#user_bs').html()
    users = new TwentyFilms.Collections.Users(
      usersData, 
      parse: true
    )

    #Move this somewhere
    TwentyFilms.Search.clenseResult = (result) ->
      newObject = {}
      for key in _(result).keys()
        newObject[key.toLowerCase()] = result[key]

      newObject

    currentUser = users.get parseInt(currentUserId)
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
      films,
      currentUser
    )

    TwentyFilms.Store.users = users
    TwentyFilms.Store.currentUser = currentUser

    Backbone.history.start()

$(document).ready ->
  $('#film-new').hide()
  $('#film-show').hide() 
  TwentyFilms.initialize()
