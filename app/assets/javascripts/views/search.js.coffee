class TwentyFilms.Views.Search extends Backbone.View 
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
            console.log(film)
            resultView = new TwentyFilms.Views.SearchDetail(model: film)
            $('#results').append(resultView.render().$el)

    # TwentyFilms.Store.currentUser.get('films').create data, 
    #   success: =>
    #     @render()
    #     $(document).ready ->
    #       $( ".sortable" ).sortable()
    # 