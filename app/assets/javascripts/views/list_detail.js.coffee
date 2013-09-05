class TwentyFilms.Views.ListDetail extends Backbone.View
  tagName: 'li'
  id: "rob"

  template: JST['list/detail']

  render: ->
    @$el.html @template(film: @model)
    this