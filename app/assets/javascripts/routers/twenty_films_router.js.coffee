class TwentyFilms.Routers.Router extends Backbone.Router

  currentViews: {}
  elements: {}

  viewConstructors:
    search: TwentyFilms.Views.Search
    list: TwentyFilms.Views.List
    newForm: TwentyFilms.Views.NewFilm

  routes:
    '': 'home'
    'film/new': 'filmNew'

  initialize: ($filmList, $search, $newForm, films) ->
    @elements['list'] = $filmList
    @elements['search'] = $search
    @elements['newForm'] = $newForm
    @films = films

  home: -> 
    @_renderView('search')
    @_renderView('list')

  filmNew: -> 
    @_renderView('newForm')
    @elements['newForm'].slideDown('slow')

  _renderView: (type) ->
    newView = new @viewConstructors[type](collection: @films)
    @_swapView(newView, type)
    @elements[type].html newView.render().$el

  _swapView: (view, type) ->
    @currentViews[type].remove() if @currentViews[type]
    @currentViews[type] = view

  ##
  # Old Code
  ##

  # _renderSearchView: ->
  #   searchView = new TwentyFilms.Views.Search(collection: @films)
  #   @currentSearch = searchView
  #   @$search.html searchView.render().$el

  # _renderListView: ->
  #   listView = new TwentyFilms.Views.List(collection: @films)
  #   @currentListView = listView
  #   @$list.html listView.render().$el

  # _renderNewFormView: ->
  #   newFormView = new TwentyFilms.Views.NewFilm(collection: @films)
  #   @$newForm.html newFormView.render().$el

  # _removeCurrentViews: ->
  #   @currentListView.remove() if @currentListView
  #   @currentSearchView.remove() if @currentSearchView


