class TwentyFilms.Views.ListDetail extends Backbone.View
  template: JST['list/detail']

  tagName: 'li'
  className: 'list-detail'

  events: 
    'click #film-link': 'hideIfVisible'

  render: ->
    @$el.html @template(film: @model)
    this

  hideIfVisible: ->
    $('#film-show').animate(right: -10) if $('#film-show').is('visible')