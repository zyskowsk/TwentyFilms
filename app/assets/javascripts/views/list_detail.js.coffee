class TwentyFilms.Views.ListDetail extends Backbone.View
  tagName: 'li'

  template: JST['list/detail']

  render: ->
    @$el.html @template(film: @model)

    console.log(@$el.html())
    this