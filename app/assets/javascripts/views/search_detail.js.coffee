class TwentyFilms.Views.SearchDetail extends Backbone.View
  tagName: 'li'
  
  template: JST['search/detail']

  events:
    'click .add' : 'addFilm'
    'click .new-film': 'clear'

  render: ->
    @$el.html @template(film: @model, notFound: this.options.notFound)
    this

  addFilm: (event) ->
    @currentFilms = TwentyFilms.Store.currentUser.get('films')
    $.ajax
      type: 'GET'
      url: 'http://www.omdbapi.com'
      dataType: 'json'
      data: {i: @model.get('imdbID')}
      success: (response) =>
        @_persistFilm(response)

  clear: ->
    $('#results').html('')

  _persistFilm: (response) ->
    film = new TwentyFilms.Models.Film(response)
    @currentFilms.create film,
      success: =>
        @clear()

      