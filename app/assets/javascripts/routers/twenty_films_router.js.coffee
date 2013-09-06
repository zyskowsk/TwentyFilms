class TwentyFilms.Routers.Router extends Backbone.Router

  currentViews: {}
  elements: {}

  viewConstructors:
    search: TwentyFilms.Views.Search
    list: TwentyFilms.Views.List
    filmNew: TwentyFilms.Views.FilmNew
    filmShow: TwentyFilms.Views.FilmShow

  routes:
    '': 'home'
    'film/new': 'filmNew'
    'film/:id': 'filmShow'

  initialize: ($filmList, $search, $filmNew, $filmShow, films) ->
    @elements['list'] = $filmList
    @elements['search'] = $search
    @elements['filmNew'] = $filmNew
    @elements['filmShow'] = $filmShow
    @films = films

  home: -> 
    @_renderView('search', collection: @films)
    @_renderView('list', collection: @films)

  filmNew: -> 
    @_renderView('filmNew', collection: @films)
    @elements['filmNew'].slideDown('slow')

  filmShow: (id) ->
    TwentyFilms.Models.Film.getByRawId id, (film) =>
      @_renderView('filmShow', model: film)

  _renderView: (type, options) ->
    newView = new @viewConstructors[type](options)
    @_swapView(newView, type)
    @elements[type].html newView.render().$el

  _swapView: (view, type) ->
    @currentViews[type].remove() if @currentViews[type]
    @currentViews[type] = view



