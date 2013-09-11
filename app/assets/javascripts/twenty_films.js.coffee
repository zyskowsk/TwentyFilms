window.TwentyFilms =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Store: {}
  Search: {}
  
  initialize: -> 
    $search = $('#search')
    $filmNew = $('#film-new')
    $userEdit = $('#user-edit')
    $rootEl = $('#root')

    div = $('<div></div>')
    div.html $('#users_bootstrap').text()
    usersData = JSON.parse div.text()
    users = new TwentyFilms.Collections.Users(
      usersData, 
      parse: true
    )

    currentUserId = $('#current_user_id_bootstrap').text()

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
        search: $search, 
        filmNew: $filmNew, 
        filmShow: $rootEl,
        userShow: $rootEl,
        userEdit: $userEdit,
        home: $rootEl 
      },
      films,
      currentUser
    )

    TwentyFilms.Store.users = users
    TwentyFilms.Store.currentUser = currentUser
    TwentyFilms.Store.TMDB_API_KEY = $('#tmdb_api_key_bootstrap').text().trim()

    Backbone.history.start()

