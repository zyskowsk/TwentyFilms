class TwentyFilms.Views.SearchFilmDetail extends Backbone.View
  tagName: 'li'
  
  template: JST['search/film_detail']

  events:
    'click .add' : 'addFilm'
    'click .new-film': 'clear'

  addFilm: (event) ->
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
    console.log('here')
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
    console.log(response)
    newFilm = new TwentyFilms.Models.Film(response)
    unless @_alreadyInList(newFilm)
      @collection.create newFilm, 
        success: =>
          @clear()



      