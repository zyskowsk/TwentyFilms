class TwentyFilms.Views.Search extends Backbone.View 

  template: JST['search/search']

  events: 
    'submit': 'preventDefault'
    'keyup': 'findFilm'

  initialize: ->
    @listenTo(@collection, 'add', @render)
    @currentResults = []

  findFilm: (event) ->
    _.debounce(@_sendRequest(event), 200)

  preventDefault: (event) ->
    event.preventDefault()

  render: ->
    @$el.html @template()
    this

  _appendResults: ->
    @_filterResults()
    for film in @currentResults[0..5]
      resultView = new TwentyFilms.Views.SearchDetail 
        model: film, 
        collection: @collection
      $('#results').append(resultView.render().$el)
    @currentResults = []

  _appendNoResults: ->
    emptyCollection = new TwentyFilms.Collections.Films
    noResultsView = new TwentyFilms.Views.SearchDetail
      collection: emptyCollection, 
      notFound: true
    $('#results').append(noResultsView.render().$el)
 
  _filterResults: ->
    @currentResults = _(@currentResults).reject (film) =>
      film.Type == 'movie'

  _handleResults: (data) ->
    if @currentResults.length > 0 && data != ''
      @_appendResults()
    else if @currentResults.length == 0
      @_appendNoResults()

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

  _sendApiRequest: (event) ->
    data = $('#search-bar').serializeJSON().film.title
    $.ajax
      type: 'GET'
      url: 'http://www.omdbapi.com'
      dataType: 'json'
      data: {s: "#{data}*"}
      success: (response) =>
        if response.Search
          for result in response.Search
            film = new TwentyFilms.Models.Film(result) 
            @currentResults.push(film) unless @_isDuplicate(film)
        $('#results').html('')
        @_handleResults(data)

  _sendDbRequest: (event, successCallback) ->
    data = $('#search-bar').serializeJSON().film.title
    $('#results').html('') if data == ''
    $.ajax
      type: 'GET'
      url: "/films"
      dataType: 'json'
      data: {search: data}
      success: (response) =>
        for result in response
          film = new TwentyFilms.Models.Film(result) 
          @currentResults.push(film)
        successCallback()

  _sendRequest: (event) ->
    event.preventDefault()
    @_sendDbRequest event, =>
      @_sendApiRequest event


