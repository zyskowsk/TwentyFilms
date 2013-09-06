class TwentyFilms.Views.Search extends Backbone.View 

  template: JST['search/search']

  events: 
    'submit': 'preventDefault'
    'keyup': 'findFilmDebounce'
    'keydown': 'hideResults'
 
  findFilmDebounce: _.debounce (->
    @_sendRequest()), 300

  initialize: ->
    @listenTo(@collection, 'add', @render)
    @currentResults = []
    $('#results').hide()

  hideResults: ->
    $('#results').slideUp('fast')

  preventDefault: (event) ->
    event.preventDefault()

  render: ->
    @$el.html @template()
    this

  _apiSuccessCallback: ->
    if response.Search
      for result in response.Search
        film = new TwentyFilms.Models.Film(result) 
        @currentResults.push(film) unless @_isDuplicate(film)
    $('#results').html('')
    @_handleResults(data)

  _appendResults: ->
    @_filterResults()
    for film in @currentResults[0..5]
      resultView = new TwentyFilms.Views.SearchDetail 
        model: film, 
        collection: @collection
      $('#results').append(resultView.render().$el)
    @currentResults = []

  _appendNoResults: (response) ->
    emptyCollection = new TwentyFilms.Collections.Films
    noResultsView = new TwentyFilms.Views.SearchDetail
      collection: emptyCollection, 
      notFound: true
    $('#results').append(noResultsView.render().$el)

  _dbSuccessCallback: (response, callback) ->
    for result in response
      film = new TwentyFilms.Models.Film(result) 
      @currentResults.push(film)
    callback()
 
  _filterResults: ->
    @currentResults = _(@currentResults).reject (film) =>
      film.Type == 'movie'

  _handleResults: (data) ->
    if @currentResults.length > 0 && data != ''
      @_appendResults()
    else if @currentResults.length == 0
      @_appendNoResults()
    $('#results').slideDown('fast')

  #TODO: Fix
  _isDuplicate: (film) ->
    title = film.get('Title')
    year = parseInt(film.get('Year'))
    count = 0
    for currentFilm in @currentResults
      sameTitle = (title == currentFilm.get('title') ||
                    title == currentFilm.get('Title'))
      sameYear = (year == currentFilm.get('release_year') ||
                    year == currentFilm.get('Year'))
      count++ if (sameTitle && sameYear)

    count != 0

  _sendApiRequest: ->
    data = $('#search-bar').serializeJSON().film.title
    $.ajax
      type: 'GET'
      url: 'http://www.omdbapi.com'
      dataType: 'json'
      data: {s: "#{data}*"}
      success: (response) =>
        @_apiSuccessCallback(response)
        

  _sendDbRequest: (callback) ->
    data = $('#search-bar').serializeJSON().film.title
    $('#results').html('') if data == ''
    $.ajax
      type: 'GET'
      url: "/films"
      dataType: 'json'
      data: {search: data}
      success: (response) =>
        @_dbSuccessCallback(response, callback)

  _sendRequest: ->
    @_sendDbRequest =>
      @_sendApiRequest()