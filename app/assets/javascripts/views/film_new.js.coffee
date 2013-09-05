class TwentyFilms.Views.NewFilm extends Backbone.View
  template: JST['film/new']

  events:
    'click .back': 'navigateHome'
    
  navigateHome: ->
    $('#new-film-form').slideUp('slow')
    Backbone.history.navigate('', trigger: true)

  render: ->
    @$el.html @template()
    this
