class TwentyFilms.Views.Search extends Backbone.View 

  initialize: ->
    @listenTo(@collection, 'add', @render)

  template: JST['search']

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
      data: {s: data}
      success: (response) ->
        $('#results').html('')
        if response.Search
          filmResults = _(response.Search).reject (film) ->
            film.Type != 'movie'

          for result in filmResults
            film = new TwentyFilms.Models.Film(result)
            resultView = new TwentyFilms.Views.SearchDetail(model: film)
            $('#results').append(resultView.render().$el)
