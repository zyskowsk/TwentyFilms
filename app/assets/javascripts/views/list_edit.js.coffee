class TwentyFilms.Views.ListEdit extends Backbone.View
  initialize: -> 
    @model.remove = false
    
  tagName: 'li'
  template: JST['list/edit']

  events:
    'click .toggle-film': 'toggleRemoveButton'

  render: ->
    @$el.html @template(film: @model)
    this

  toggleRemoveButton: (event) ->
    link = $(event.currentTarget)
    currentClass = link.attr('class')
    link.removeClass()

    if currentClass == 'toggle-film save'
      link.addClass('toggle-film delete')
      link.html('✖')
      @model.remove = true
    else
      link.addClass('toggle-film save')
      link.html('✔')
      @model.remove = false
