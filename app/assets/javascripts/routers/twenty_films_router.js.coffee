class TwentyFilms.Routers.Router extends Backbone.Router

  initialize: ($filmList, $filmForm, films) ->
    @$list = $filmList
    @$form = $filmForm
    @films = films

  routes:
    '': 'home'

  home: -> 
    searchView = new TwentyFilms.Views.Search()
    listView = new TwentyFilms.Views.List(collection: @films)
    console.log("hi")
    @$list.html listView.render().$el
    @$form.html searchView.render().$el