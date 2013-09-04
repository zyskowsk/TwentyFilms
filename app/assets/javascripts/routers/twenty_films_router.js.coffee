class TwentyFilms.Routers.Router extends Backbone.Router

  initialize: ($filmList, $search, films) ->
    @$list = $filmList
    @$search = $search
    @films = films

  routes:
    '': 'home'

  home: -> 
    searchView = new TwentyFilms.Views.Search()
    listView = new TwentyFilms.Views.List(collection: @films)
    console.log("hi")
    @$list.html listView.render().$el
    @$search.html searchView.render().$el