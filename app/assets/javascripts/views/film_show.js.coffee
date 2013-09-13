class TwentyFilms.Views.FilmShow extends Backbone.View

  template: JST['film/show']

  events: 
    'click .toggle-trailer': 'toggleTrailer'
    'click .add-to-list': 'addToList'

  initialize: ->
    @trailerOpen = false

  addToList: ->
    @model.addFilmTo @collection, =>
      Backbone.history.navigate('', trigger: true)

  render: ->
    @$el.html @template
        film: @model
        trailerOpen: @trailerOpen
        alreadyInList: @model.alreadyInList(@collection)
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

