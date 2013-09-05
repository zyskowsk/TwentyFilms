class TwentyFilms.Views.NewFilm extends Backbone.View
  template: JST['film/new']

  events:
    'click .back': 'navigateHome'

  render: ->
    @$el.html @template()
    this

  navigateHome: ->
    $('#new-film-form').slideUp('slow')
    Backbone.history.navigate('', trigger: true)