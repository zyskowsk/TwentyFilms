class TwentyFilms.Routers.Router extends Backbone.Router

  currentViews: {}
  elements: {}

  viewConstructors:
    home: TwentyFilms.Views.Home
    search: TwentyFilms.Views.Search
    filmNew: TwentyFilms.Views.FilmNew
    filmShow: TwentyFilms.Views.FilmShow
    userShow: TwentyFilms.Views.UserShow
    userEdit: TwentyFilms.Views.UserEdit

  routes:
    '': 'home'
    '_=_' : 'navigateHome'
    'films/new': 'filmNew'
    'films/:id': 'filmShow'
    'users/:id': 'userShow'
    'user/edit': 'userEdit'
    'bacon_number': 'baconNumber'

  initialize: (elements, films, users, currentUserId) ->
    @elements = elements
    @films = films
    @users = users
    @currentUser = TwentyFilms.Store.currentUser
    @currentUserId = currentUserId

  home: -> 
    @_renderView('search', collection: @films)
    @_renderView('home', model: @currentUser, collection: @films)

  baconNumber: ->
    TwentyFilms.Models.Film.getBaconNumber (response) =>
        $('#bacon-number').html(response)
        $('.bacon-container').slideDown('fast')
        Backbone.history.navigate('')

  navigateHome: ->
    Backbone.history.navigate('', trigger: true)

  filmNew: -> 
    @_renderView('filmNew', collection: @films)
    @elements['filmNew'].slideDown('slow')

  filmShow: (id) ->
    $('#results').slideUp('fast')
    TwentyFilms.Store.addSpinner()
    TwentyFilms.Models.Film.getByRawId id, (film) =>
       $('body').spin(false)
       @_filmShowCallback(film)

  userEdit: ->
    @_renderView('userEdit', model: @currentUser, collection: @users)

  userShow: (id) ->
    user = @users.get(id)
    @_userShowCallback(user)

  _filmShowCallback: (film) ->
    @_renderView('search', collection: @films)
    @_renderView('filmShow', model: film, collection: @films)
    $('.film-trailer').hide()

  _renderView: (type, options) ->
    newView = new @viewConstructors[type](options)
    @_swapView(newView, type)
    @elements[type].html newView.render().$el

  _swapView: (view, type) ->
    @currentViews[type].remove() if @currentViews[type]
    @currentViews[type] = view

  _userShowCallback: (user) ->
    @_renderView('search', collection: @films)
    @_renderView('userShow', model: user)





