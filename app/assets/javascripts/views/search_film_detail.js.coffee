class TwentyFilms.Views.SearchFilmDetail extends Backbone.View
  
  template: JST['search/film_detail']

  events:
    'click .add' : 'addFilm'
    'click .new-film': 'clear'

  addFilm: ->
    @model.addFilmTo(@collection)

  render: ->
    @$el.html @template 
      film: @model, 
      notFound: this.options.notFound,
      alreadyInList: @model._alreadyInList(@collection),
      hasTwenty: @collection.length == 20
      
    this


      