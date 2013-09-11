class TwentyFilms.Views.FilmShow extends Backbone.View

  template: JST['film/show']

  events: 
    'click .show.back': 'navigateHome'
    'click .toggle-trailer': 'toggleTrailer'

  initialize: ->
    @trailerOpen = false

  navigateHome: ->
    Backbone.history.navigate('', trigger: true)

  render: ->
    @$el.html @template
        film: @model
        trailerOpen: @trailerOpen
    this

  toggleTrailer: ->
    @_hideTrailer() if @trailerOpen
    @_showTrailer() if not @trailerOpen
    @trailerOpen = !@trailerOpen
    if @trailerOpen
      $('.toggle-trailer').html('Hide Trailer')
    else
      $('.toggle-trailer').html('Show Trailer') 

  _showTrailer: ->
    trailerView = new TwentyFilms.Views.FilmTrailer(model: @model)
    @currentTrailer = trailerView
    $('.film-plot').slideUp 'slow', ->
      $('.film-trailer').slideDown 'slow', ->
        $('.film-trailer').html trailerView.render().$el

  _hideTrailer: ->
    @currentTrailer.remove() if @currentTrailer
    $('.film-trailer').slideUp 'slow', ->
      $('.film-plot').slideDown 'slow'

