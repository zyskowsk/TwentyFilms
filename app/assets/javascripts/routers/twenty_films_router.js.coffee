class TwentyFilms.Routers.Router extends Backbone.Router

  initialize: ($filmList, $search, $newForm, films) ->
    @$list = $filmList
    @$search = $search
    @$newForm = $newForm
    @films = films

  routes:
    '': 'home'
    'film/new': 'filmNew'

  home: -> 
    @_removeCurrentViews()
    @_renderSearchView()
    @_renderListView()

  filmNew: -> 
    @_renderNewFormVew()
    @$newForm.slideDown('slow')

  _renderSearchView: ->
    searchView = new TwentyFilms.Views.Search(collection: @films)
    @currentSearch = searchView
    @$search.html searchView.render().$el

  _renderListView: ->
    listView = new TwentyFilms.Views.List(collection: @films)
    @currentListView = listView
    @$list.html listView.render().$el

  _renderNewFormVew: ->
    newFormView = new TwentyFilms.Views.NewFilm
    @$newForm.html newFormView.render().$el

  _removeCurrentViews: ->
    @currentListView.remove() if @currentListView
    @currentSearchView.remove() if @currentSearchView
