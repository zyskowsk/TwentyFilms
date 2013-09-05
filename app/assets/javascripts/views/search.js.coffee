class TwentyFilms.Views.Search extends Backbone.View 

  initialize: ->
    @listenTo(@collection, 'add', @render)
    @currentResults = []

  template: JST['search/search']

  events: 
    'submit': 'preventDefault'
    'keyup': 'findFilm'

  render: ->
    @$el.html @template()
    this

  findFilm: (event) ->
    _.debounce(@sendRequest(event), 600)

  appendNoResults: ->
    noResultsView = new TwentyFilms.Views.SearchDetail(notFound: true)
    $('#results').append(noResultsView.render().$el)

  appendResults: ->
    @filterResults()
    for film in @currentResults[0..5]
      resultView = new TwentyFilms.Views.SearchDetail(model: film)
      $('#results').append(resultView.render().$el)
    @currentResults = []

  preventDefault: (event) ->
    event.preventDefault()

  isDuplicate: (film) ->
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
      
  filterResults: ->
    @currentResults = _(@currentResults).reject (film) =>
      film.Type == 'movie'

  sendRequest: (event) ->
    event.preventDefault()
    @sendDbRequest event, =>
      @sendApiRequest event

  handleResults: (data) ->
    if @currentResults.length > 0 && data != ''
      @appendResults()
    else if @currentResults.length == 0
      @appendNoResults()

  sendApiRequest: (event) ->
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
            @currentResults.push(film) unless @isDuplicate(film)
        $('#results').html('')
        @handleResults(data)

  sendDbRequest: (event, successCallback) ->
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