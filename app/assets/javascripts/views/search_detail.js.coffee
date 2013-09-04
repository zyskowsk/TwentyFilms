class TwentyFilms.Views.SearchDetail extends Backbone.View
  tagName: 'li'
  template: JST['search/detail']

  events: {
    'click' : 'addFilm'
  }

  render: ->
    @$el.html @template(film: @model)
    this

  addFilm: (event) ->
    currentFilms = TwentyFilms.Store.currentUser.get('films')
    $.ajax
      type: 'GET'
      url: 'http://www.omdbapi.com'
      dataType: 'json'
      data: {i: @model.get('imdbID')}
      success: (response) ->
        film = new TwentyFilms.Models.Film(response)
        currentFilms.create(film,
          success: ->
            $('#results').html('')
            $(document).ready ->
              $( ".sortable" ).sortable()
          )

