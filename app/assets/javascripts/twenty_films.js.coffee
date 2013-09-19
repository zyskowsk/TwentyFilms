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
    $rootEl = $('#root')

    div = $('<div></div>')
    div.html $('#users_bootstrap').text()
    usersData = JSON.parse div.text()
    users = new TwentyFilms.Collections.Users(
      usersData, 
      parse: true
    )

    currentUserId = $('#current_user_id_bootstrap').text()

    currentUser = users.get parseInt(currentUserId)
    TwentyFilms.Store.currentUser = currentUser
    films = currentUser.get('films')


    new TwentyFilms.Routers.Router(
      { 
        search: $search, 
        filmNew: $filmNew, 
        filmShow: $rootEl,
        userShow: $rootEl,
        userEdit: $rootEl,
        home: $rootEl 
      },
      films,
      users,
      currentUserId
    )

    # Find out where this goes 
    TwentyFilms.Search.clenseResult = (result) ->
      newObject = {}
      for key in _(result).keys()
        newObject[key.toLowerCase()] = result[key]

      newObject

    TwentyFilms.Store.users = users
    TwentyFilms.Store.TMDB_API_KEY = $('#tmdb_api_key_bootstrap').text().trim()
    TwentyFilms.Store.addSpinner = ->
      $('body').spin(
        lines: 11,
        length: 0,
        width: 22,
        radius: 39,
        corners: 1.0,
        rotate: 50,
        trail: 60,
        speed: 1.0,
        direction: 1,
        shadow: on
      )

    Backbone.history.start()

