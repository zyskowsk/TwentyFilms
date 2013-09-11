class TwentyFilms.Views.ListEdit extends Backbone.View
  
  tagName: 'li'
  className: 'edit-detail'
  
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

    if currentClass == 'toggle-film save right'
      link.addClass('toggle-film delete right')
      link.html('✖')
      @model.remove = true
    else
      link.addClass('toggle-film save right')
      link.html('✚')
      @model.remove = false
