class TwentyFilms.Routers.Router extends Backbone.Router

  initialize: ($filmList, $search, $newForm, films) ->
    @$list = $filmList
    @$search = $search
    @$newForm = $newForm
    @films = films

  viewConstructors:
    search: TwentyFilms.Views.Search
    list: TwentyFilms.Views.List
    newForm: TwentyFilms.Views.NewFilm

  currentViews:

  routes:
    '': 'home'
    'film/new': 'filmNew'

  home: -> 
    @_removeCurrentViews()
    @_renderView('search')
    @_renderView('list')

  filmNew: -> 
    @_renderVew('newForm')
    @$newForm.slideDown('slow')

  _renderView: (type) ->
    newView = new @viewConstructors[type](collection: @films)
    @currentViews[type] = newView
    @$search.html newView.render().$el

  #TODO: Check for errors, add switch method

  # _renderSearchView: ->
  #   searchView = new TwentyFilms.Views.Search(collection: @films)
  #   @currentSearch = searchView
  #   @$search.html searchView.render().$el

  # _renderListView: ->
  #   listView = new TwentyFilms.Views.List(collection: @films)
  #   @currentListView = listView
  #   @$list.html listView.render().$el

  # _renderNewFormVew: ->
  #   newFormView = new TwentyFilms.Views.NewFilm(collection: @films)
  #   @$newForm.html newFormView.render().$el

  _removeCurrentViews: ->
    @currentListView.remove() if @currentListView
    @currentSearchView.remove() if @currentSearchView
