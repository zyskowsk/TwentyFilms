class TwentyFilms.Views.FilmTrailer extends Backbone.View
  template: JST['film/trailer']

  render: ->
    @$el.html @template(film: @model)
    this