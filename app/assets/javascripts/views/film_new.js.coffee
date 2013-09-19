class TwentyFilms.Views.FilmNew extends Backbone.View  
  template: JST['film/new']

  currentErrors: []

  events:
    'click .close': 'close'
    'submit' : 'addFilm'
    
  addFilm: (event) ->
    event.preventDefault()

    formData = $(event.target).serializeJSON()
    newFilm = new TwentyFilms.Models.Film

    newFilm.save formData,
      success: (response) =>
        $('#film-new').slideUp('slow')
        Backbone.history.navigate('', trigger: true)
      error: (nul, response) =>
        @_removeCurrentErrors()
        @_appendNewErrors(response)

  close: ->
    $('#film-new').slideUp('slow')

  render: ->
    @$el.html @template()
    this

  _appendNewErrors: (response) ->
    errors = JSON.parse(response.responseText)
    for error in errors
      errorView = new TwentyFilms.Views.ErrorMessage(text: error)
      @currentErrors.push(errorView)
      $('#film-new').append errorView.render().$el

    $('.error-message h5').fadeIn('slow');

  _removeCurrentErrors: ->
    for error in @currentErrors
          error.remove()
