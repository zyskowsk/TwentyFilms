class TwentyFilms.Routers.Router extends Backbone.Router

  initialize: ($filmList, $search, films) ->
    @$list = $filmList
    @$search = $search
    @films = films

  routes:
    '': 'home'

  home: -> 
    @removeCurrentViews()
    @renderSearchView()
    @renderListView()

  renderSearchView: ->
    searchView = new TwentyFilms.Views.Search(collection: @films)
    @currentSearch = searchView
    @$search.html searchView.render().$el

  renderListView: ->
    listView = new TwentyFilms.Views.List(collection: @films)
    @currentListView = listView
    @$list.html listView.render().$el

  removeCurrentViews: ->
    @currentListView.remove() if @currentListView
    @currentSearchView.remove() if @currentSearchView
