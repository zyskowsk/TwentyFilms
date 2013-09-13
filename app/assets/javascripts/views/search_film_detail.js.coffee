class TwentyFilms.Views.SearchFilmDetail extends Backbone.View
  
  template: JST['search/film_detail']

  events:
    'click .add' : 'addFilm'
    'click .new-film': 'clear'

  addFilm: ->
    @model.addFilmTo(@collection)

  render: ->
    alreadyInList = @model.alreadyInList(@collection) if @model
    @$el.html @template 
      film: @model, 
      notFound: this.options.notFound,
      alreadyInList: alreadyInList,
      hasTwenty: @collection.length == 20
      
    this


      