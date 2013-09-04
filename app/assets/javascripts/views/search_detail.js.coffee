class TwentyFilms.Views.SearchDetail extends Backbone.View
  template: JST['detail']

  render: ->
    @$el.html @template(film: @model)
    this