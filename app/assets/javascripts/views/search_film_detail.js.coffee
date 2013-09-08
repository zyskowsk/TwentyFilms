class TwentyFilms.Views.SearchFilmDetail extends Backbone.View
  tagName: 'li'
  
  template: JST['search/film_detail']

  events:
    'click .add' : 'addFilm'
    'click .new-film': 'clear'

  addFilm: (event) ->
    $('#wait').animate {width: 20}, 100, =>
        $('#wait').spin 
            radius: 3,
            length: 4,
            width: 1
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
    unless @_alreadyInList(newFilm)
      @collection.create newFilm, 
        success: =>
          $('#wait').spin(false)
          $('#wait').animate(width: 0, 'fast')
          @clear()



      