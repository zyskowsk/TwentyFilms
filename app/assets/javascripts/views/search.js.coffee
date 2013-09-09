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
    @currentFilmResults = []
    $('#results').hide()

  hideResults: ->
    $('#results').slideUp('slow')

  preventDefault: (event) ->
    event.preventDefault()

  render: ->
    @$el.html @template()
    this

  _apiSuccessCallback: (response, data) ->
    if response.Search
      for result in response.Search
        clensedResult = TwentyFilms.Search.clenseResult(result)
        film = new TwentyFilms.Models.Film(clensedResult) 
        @currentFilmResults.push(film) unless @_isDuplicate(film)
    $('#results').html('')
    @_handleResults(data)

  _appendFilmResults: ->
    @_filterResults()
    filmResults = new TwentyFilms.Views.ResultsFilms
        collection: @collection,
        currentFilmResults: @currentFilmResults 

    $('#results').append filmResults.render().$el
    @currentFilmResults = []

  _appendNoFilmResults: (response) ->
    emptyCollection = new TwentyFilms.Collections.Films
    noFilmResultsView = new TwentyFilms.Views.ResultsFilms
        collection: emptyCollection
        currentFilmResults: emptyCollection 

    $('#results').append noFilmResultsView.render().$el

  _appendUserResults: ->
    userResults = new TwentyFilms.Views.ResultsUsers
        collection: @_userSearchResults()
    $('#results').append userResults.render().$el

  _dbSuccessCallback: (response, callback) ->
    for result in response
      film = new TwentyFilms.Models.Film(result) 
      @currentFilmResults.push(film)
    callback()
 
  _filterResults: ->
    @currentFilmResults = _(@currentFilmResults).reject (film) =>
      film.Type == 'movie'

  _getSearchData: ->
    $('#search-bar').serializeJSON().film.title

  _handleResults: (data) ->
    $('#wait').animate {width: 0}, 'fast', =>
      $('#wait').spin(false)
    
    @_appendUserResults() if @_userSearchResults().length > 0 && data !=  ''

    if @currentFilmResults.length > 0 && data != ''
      @_appendFilmResults()
    else if @currentFilmResults.length == 0
      @_appendNoFilmResults()

    $('#results').slideDown('fast')
    
  #TODO: Fix
  _isDuplicate: (film) ->
    title = film.get('title')
    year = parseInt(film.get('year'))
    count = 0
    for currentFilm in @currentFilmResults
      sameTitle = (title == currentFilm.get('title'))
      sameYear = (year == currentFilm.get('year'))
      count++ if (sameTitle && sameYear)

    count != 0

  _userSearchResults:() ->
    new TwentyFilms.Collections.Users TwentyFilms.Store.users.searchUsers(
      @_getSearchData()
    )

  _sendApiRequest: ->
    data =  @_getSearchData()
    $.ajax
      type: 'GET'
      url: 'http://www.omdbapi.com'
      dataType: 'json'
      data: {s: "#{@_getSearchData()}*"}
      success: (response) =>
        @_apiSuccessCallback(response, data)      

  _sendDbRequest: (callback) ->
    data =  @_getSearchData()
    $('#results').html('') if data == ''
    $.ajax
      type: 'GET'
      url: "/films"
      dataType: 'json'
      data: {search: data}
      success: (response) =>
        @_dbSuccessCallback(response, callback)

  _sendRequest: ->
    unless @_getSearchData() == ''
      $('#wait').animate(width: 20, 100, =>
          $('#wait').spin 
              radius: 3,
              length: 4,
              width: 1
        )
    @_sendDbRequest =>
      @_sendApiRequest()