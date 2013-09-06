class TwentyFilms.Views.FilmShow extends Backbone.View
  template: JST['film/show']

  render: ->
    console.log(@model)
    @$el.html @template(film: @model)
    this
