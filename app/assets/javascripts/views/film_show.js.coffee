class TwentyFilms.Views.FilmShow extends Backbone.View

  template: JST['film/show']

  events: 
    'click .show.back': 'navigateHome'
    'click .toggle-trailer': 'toggleTrailer'

  initialize: ->
    @trailerOpen = false

  navigateHome: ->
    $('#film-show').animate {right: -$('#film-show').width()}, =>
      $('#film-show').hide()
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
    $('.toggle-trailer').html('Hide Trailer') if @trailerOpen
    $('.toggle-trailer').html('Show Trailer') if not @trailerOpen

  _showTrailer: ->
    $('.film-plot').slideUp 'slow', ->
      $('.film-trailer').slideDown 'slow'

  _hideTrailer: ->
    $('.film-trailer').slideUp 'slow', ->
      $('.film-plot').slideDown 'slow'

