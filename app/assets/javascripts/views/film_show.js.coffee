class TwentyFilms.Views.FilmShow extends Backbone.View
  template: JST['film/show']

  events: 
    'click .show.back': 'navigateHome'

  render: ->
    console.log(@model)
    @$el.html @template(film: @model)
    this

  navigateHome: ->
    $('#film-show').animate right: -$('#film-show').width(), =>
      $('#film-show').hide()
    Backbone.history.navigate('', trigger: true)
