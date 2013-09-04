class TwentyFilms.Views.Search extends Backbone.View 

  initialize: ->
    @listenTo(@collection, 'add', @render)
    @currentResults = []

  template: JST['search/search']

  events: 
    'keyup': 'findFilm'
    'submit': 'preventDefault'

  render: ->
    @$el.html @template()
    this

  findFilm: (event) ->
    _.debounce(@sendRequest(event), 200)

  appendNoResults: ->
    message = "<li><a>No Results</a></li>"
    $('#results').append(message)

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
    data = $('#new-film-form').serializeJSON().film.title
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
        console.log(data)
        @handleResults(data)

  sendDbRequest: (event, successCallback) ->
    data = $('#new-film-form').serializeJSON().film.title
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
        console.log('hello')

