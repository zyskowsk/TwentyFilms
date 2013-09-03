class TwentyFilms.Views.ListNew extends Backbone.View 
  template: JST['list/new']

  events: 
    'submit': 'findFilm'

  render: ->
    @$el.html @template()
    this

  findFilm: (event) ->
    event.preventDefault()
    data = $('#new-film-form').serializeJSON()
    TwentyFilms.Store.currentUser.get('films').create data, 
      success: =>
        @render()
    