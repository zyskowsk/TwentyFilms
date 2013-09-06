class TwentyFilms.Views.SearchDetail extends Backbone.View
  tagName: 'li'
  
  template: JST['search/detail']

  events:
    'click .add' : 'addFilm'
    'click .new-film': 'clear'

  render: ->
    @$el.html @template 
      film: @model, 
      notFound: this.options.notFound,
      alreadyInList: @_alreadyInList(@model),
      hasTwenty: @collection.length == 20
      
    this

  addFilm: (event) ->
    if @model.get('imdbID')
      $.ajax
        type: 'GET'
        url: 'http://www.omdbapi.com'
        dataType: 'json'
        data: {i: @model.get('imdbID')}
        success: (response) =>
          @_persistFilm(response)
    else
      $.ajax
        type: 'POST'
        url: '/films'
        data: {Title: @model.get('title')}
        success: (response) =>
          @collection.add(@model)
          @clear()

  clear: ->
    $('#results').html('')

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



      