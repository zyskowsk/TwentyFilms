class TwentyFilms.Views.FilmShow extends Backbone.View
  template: JST['film/show']

  events: 
    'click .toggle-trailer': 'toggleTrailer'
    'click .add-to-list': 'addToList'

  initialize: ->
    @trailerOpen = false

  addToList: ->
    mixpanel.track 'Add Film',
      year: @model.get 'year'
      genre: @model.get 'genre'
      director: @model.get 'director'
      title: @model.get 'title'
      from: 'Show Page'

    @model.addFilmTo @collection, =>
      Backbone.history.navigate('', trigger: true)

  render: ->
    mixpanel.track 'Film Show Page',
      year: @model.get 'year'
      genre: @model.get 'genre'
      director: @model.get 'director'
      title: @model.get 'title'

    @$el.html @template
        film: @model
        trailerOpen: @trailerOpen
        alreadyInList: @model.alreadyInList(@collection)
    this

  toggleTrailer: ->
    mixpanel.track 'Trailer Opened',
      year: @model.get 'year'
      genre: @model.get 'genre'
      director: @model.get 'director'
      title: @model.get 'title'

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

