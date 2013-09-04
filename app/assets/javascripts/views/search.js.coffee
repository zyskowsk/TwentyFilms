class TwentyFilms.Views.Search extends Backbone.View 
  template: JST['search']

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
        $(document).ready ->
          $( ".sortable" ).sortable()
    