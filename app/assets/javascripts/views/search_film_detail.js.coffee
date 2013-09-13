class TwentyFilms.Views.SearchFilmDetail extends Backbone.View
  
  template: JST['search/film_detail']

  events:
    'click .add' : 'addFilm'
    'click .new-film': 'clear'

  addFilm: (event) ->
    $('#results').slideUp('fast')
    $('body').spin()
    if @model.get('imdbid')
      @_addApiFilm()
    else
      @_addDbFilm()

  clear: ->
    $('#results').html('')

  render: ->
    @$el.html @template 
      film: @model, 
      notFound: this.options.notFound,
      alreadyInList: @_alreadyInList(@model),
      hasTwenty: @collection.length == 20
      
    this

  _addApiFilm: ->
    $.ajax
      type: 'GET'
      url: 'http://www.omdbapi.com'
      dataType: 'json'
      data: {i: @model.get('imdbid')}
      success: (response) =>
        clensedResult = TwentyFilms.Search.clenseResult(response)
        @_persistFilm(clensedResult)

  _addDbFilm: ->
    $.ajax
      type: 'POST'
      url: '/films'
      data: {title: @model.get('title')}
      success: (response) =>
        @collection.add(@model)
        @clear()

  _alreadyInList: (newFilm)->
    titleList = @collection.map (film) =>
      film.get('title')

    (titleList.indexOf(newFilm.get('title')) != -1) if newFilm

  _persistFilm: (response) ->
    newFilm = new TwentyFilms.Models.Film(response)
    newFilm.getTrailerAndPoster =>
      unless @_alreadyInList(newFilm)
        @collection.create newFilm, 
          success: (response) =>
            $('body').spin(false)
            @clear()



      