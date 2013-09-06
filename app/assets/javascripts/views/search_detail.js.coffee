class TwentyFilms.Views.SearchDetail extends Backbone.View
  tagName: 'li'
  
  template: JST['search/detail']

  events:
    'click .add' : 'addFilm'
    'click .new-film': 'clear'


  addFilm: (event) ->
    if @model.get('imdbID')
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
      data: {i: @model.get('imdbID')}
      success: (response) =>
        @_persistFilm(response)

  _addDbFilm: ->
    $.ajax
      type: 'POST'
      url: '/films'
      data: {Title: @model.get('title')}
      success: (response) =>
        @collection.add(@model)
        @clear()

  _alreadyInList: (newFilm)->
    titleList = @collection.map (film) =>
      film.get('title')

    (titleList.indexOf(newFilm.get('Title')) != -1) if newFilm

  _persistFilm: (response) ->
    newFilm = new TwentyFilms.Models.Film(response)
    unless @_alreadyInList(newFilm)
      @collection.create newFilm, 
        success: =>
          @clear()



      