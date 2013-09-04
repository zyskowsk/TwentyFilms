class TwentyFilms.Views.Search extends Backbone.View 

  initialize: ->
    @listenTo(@collection, 'add', @render)
    @currentResults = []

  template: JST['search/search']

  events: 
    'keyup': 'findFilm'

  render: ->
    @$el.html @template()
    this

  findFilm: (event) ->
    data = $('#new-film-form').serializeJSON().film.title
    $.ajax
      type: 'GET'
      url: 'http://www.omdbapi.com'
      dataType: 'json'
      data: {s: "#{data}*"}
      success: (response) =>
        $('#results').html('')
        if response.Search
          @appendResults(@filteredResults(response))
        else if response.Error == 'Movie not found!'
          @appendNoResults()


  appendNoResults: ->
    message = "<li><a>No Results</a></li>"
    $('#results').append(message)

  appendResults: (results) ->
    @removeCurrentResults()
    for result in results
      film = new TwentyFilms.Models.Film(result)
      resultView = new TwentyFilms.Views.SearchDetail(model: film)
      @currentResults.push(resultView)

      $('#results').append(resultView.render().$el)
      
  filteredResults: (response) ->
    _(response.Search).reject (film) ->
            film.Type != 'movie'

  # needed?
  removeCurrentResults: ->
    for view in @currentResults
      view.remove()

    @currentResults = []
