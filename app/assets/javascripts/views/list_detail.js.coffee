class TwentyFilms.Views.ListDetail extends Backbone.View
  tagName = 'li'
  template: JST['list_detail']

  render: ->
    @$el.html @template(film: @model)
    this