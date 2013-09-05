class TwentyFilms.Views.ListEdit extends Backbone.View
  tagName: 'li'

  template: JST['list/edit']

  events:
    'click .save': 'removeFilm'

  render: ->
    @$el.html @template(film: @model)
    this

  removeFilm: (event) ->
    link = $(event.currentTarget)
    link.removeClass('save')
    link.addClass('delete')
    link.html('✖')

    @model.destroy()