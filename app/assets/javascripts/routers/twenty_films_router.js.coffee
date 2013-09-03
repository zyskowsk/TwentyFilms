class TwentyFilms.Routers.Router extends Backbone.Router

  initialize: ($list, films) ->
    @$list = $list
    @films = films

  routes:
    "": 'home'

  home: -> 
    listView = new TwentyFilms.Views.List(collection: @films)
    @$list.html listView.render().$el