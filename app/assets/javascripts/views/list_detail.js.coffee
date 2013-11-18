class TwentyFilms.Views.ListDetail extends Backbone.View
  template: JST['list/detail']

  tagName: 'li'
  className: 'list-detail'

  events: 
    'click .film-link': 'clickFilm'

  clickFilm: ->
    mixpanel.track 'Click Film',
      from: 'List'

  render: ->
    @$el.html @template(film: @model)
    this

