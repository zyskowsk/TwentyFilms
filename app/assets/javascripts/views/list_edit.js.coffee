class TwentyFilms.Views.ListEdit extends Backbone.View
  template: JST['list/edit']
  
  tagName: 'li'
  className: 'edit-detail'
  
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
