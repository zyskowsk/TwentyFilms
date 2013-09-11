class TwentyFilms.Views.Home extends Backbone.View
  template: JST['home']

  render: ->
    @$el.html @template(films: @collection)

    followingsView = new TwentyFilms.Views.UserFollows(model: @model)
    @$el.find('#followings').html followingsView.render().$el

    listView = new TwentyFilms.Views.List(collection: @collection)
    @$el.find('#film-list').html listView.render().$el
    this