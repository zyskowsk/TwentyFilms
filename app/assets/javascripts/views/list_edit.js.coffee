class TwentyFilms.Views.ListEdit extends Backbone.View
  tagName = 'li'
  template: JST['list/edit']

  render: ->
    @$el.html @template(film: @model)
    this