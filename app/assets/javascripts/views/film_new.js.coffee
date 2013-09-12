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
        console.log(response)
        @navigateHome()
      error: (nul, response) =>
        for error in @currentErrors
          error.remove()
        errors = JSON.parse(response.responseText)
        for error in errors
          errorView = new TwentyFilms.Views.ErrorMessage(text: error)
          @currentErrors.push(errorView)
          $('#film-new').append errorView.render().$el
        $('.error-message h5').fadeIn('slow');

  close: ->
    $('#film-new').slideUp('slow')

  render: ->
    @$el.html @template()
    this