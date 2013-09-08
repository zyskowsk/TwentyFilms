
class TwentyFilms.Routers.Router extends Backbone.Router

  currentViews: {}
  elements: {}

  viewConstructors:
    search: TwentyFilms.Views.Search
    list: TwentyFilms.Views.List
    filmNew: TwentyFilms.Views.FilmNew
    filmShow: TwentyFilms.Views.FilmShow
    userShow: TwentyFilms.Views.UserShow

  routes:
    '': 'home'
    'films/new': 'filmNew'
    'films/:id': 'filmShow'
    'users/:id': 'userShow'

  initialize: ($filmList, $search, $filmNew, $filmShow, $userShow, films) ->
    @elements['list'] = $filmList
    @elements['search'] = $search
    @elements['filmNew'] = $filmNew
    @elements['filmShow'] = $filmShow
    @elements['userShow'] = $userShow
    @films = films

  home: -> 
    @_slideBackIfOpen 'filmShow'
    @_slideBackIfOpen 'userShow'
    @_renderView('search', collection: @films)
    @_renderView('list', collection: @films)

  filmNew: -> 
    @_renderView('filmNew', collection: @films)
    @elements['filmNew'].slideDown('slow')

  filmShow: (id) ->
    if @elements['filmShow'].css('right') == '0px'
      @_slideBackIfOpen 'filmShow', =>
        TwentyFilms.Models.Film.getByRawId id, (film) =>
          @_filmShowCallback(film)
    else if @elements['userShow'].css('right') == '0px'
      @_slideBackIfOpen 'userShow', =>
        console.log('he')
        TwentyFilms.Models.Film.getByRawId id, (film) =>
          @_filmShowCallback(film)
    else
       TwentyFilms.Models.Film.getByRawId id, (film) =>
          @_filmShowCallback(film)

  userShow: (id) ->
    user = TwentyFilms.Store.users.get(id)
    if @elements['userShow'].css('right') == '0px'
      @_slideBackIfOpen 'userShow', =>
        @_userShowCallback(user)
    else if @elements['filmShow'].css('right') == '0px'
      @_slideBackIfOpen 'filmShow', =>
        @_userShowCallback(user)
    else
        @_userShowCallback(user)

  _filmShowCallback: (film) ->
    @_renderView('search', collection: @films)
    @_renderView('filmShow', model: film)
    $('.film-trailer').hide()
    $(document).ready =>
      @elements['filmShow'].show()
      @elements['filmShow'].animate(right: 0, 800)

  _renderView: (type, options) ->
    newView = new @viewConstructors[type](options)
    @_swapView(newView, type)
    @elements[type].html newView.render().$el

  _swapView: (view, type) ->
    @currentViews[type].remove() if @currentViews[type]
    @currentViews[type] = view

  _slideBackIfOpen: (type, callback) ->
      @elements[type].animate 
          right: -@elements[type].width()*1.5, 
          800,
          callback

  _userShowCallback: (user) ->
    @_renderView('search', collection: @films)
    @_renderView('userShow', model: user)
    $(document).ready =>
      @elements['userShow'].show()
      @elements['userShow'].animate(right: 0, 800)




