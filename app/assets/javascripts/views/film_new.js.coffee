class TwentyFilms.Views.NewFilm extends Backbone.View
  template: JST['film/new']

  events:
    'click .back': 'navigateHome'
    'submit' : 'addFilm'
    
  addFilm: (event) ->
    event.preventDefault()
    formData = $(event.target).serializeJSON()
    newFilm = new TwentyFilms.Models.Film
    newFilm.save formData,
      success: =>
        $('#new-film-form').slideUp('slow')
        Backbone.history.navigate('', trigger: true)

  navigateHome: ->
    $('#new-film-form').slideUp('slow')
    Backbone.history.navigate('', trigger: true)

  render: ->
    @$el.html @template()
    this
