class TwentyFilms.Views.ResultsFilms extends Backbone.View
  template: JST['search/results_films']

  render: ->
    @$el.html @template()
    if this.options.currentFilmResults.length == 0
      noResultsView = new TwentyFilms.Views.SearchFilmDetail
          collection: @collection, 
          notFound: true
      @$el.find('#film-details').append noResultsView.render().$el

    for film in this.options.currentFilmResults
      filmDetailView = new TwentyFilms.Views.SearchFilmDetail
          model: film,
          collection: @collection
      
      @$el.find('#film-details').append filmDetailView.render().$el
    this

    