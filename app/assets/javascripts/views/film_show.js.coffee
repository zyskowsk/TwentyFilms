class TwentyFilms.Views.FilmShow extends Backbone.View
  template: JST['film/show']

  render: ->
    @$el.html @template(model: @film)
    this