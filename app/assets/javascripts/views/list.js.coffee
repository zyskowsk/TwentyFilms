class TwentyFilms.Views.List extends Backbone.View

  template: JST['list/list']
  
  events: 
    'click #edit-toggle-button': 'toggleEditView'

  initialize: ->
    @listenTo(@collection, 'add sync destroy', @render)
    @editing = false

  render: ->
    @$el.html @template(films: @collection)

    @collection.each (film) =>
      @_addDetail(film) if not @editing
      @_addEdit(film) if @editing

    this

  toggleEditView: ->
    @_toggleEdit()

    if @editing
      mixpanel.track "Edit List"

      @_enabelSort()
    else
      @_removeFilms()

  _addDetail: (film) ->
    detail = new TwentyFilms.Views.ListDetail(model: film)
    @$el.find('#list').append detail.render().$el

  _addEdit: (film) ->
    edit = new TwentyFilms.Views.ListEdit(model: film)
    @$el.find('#list').append edit.render().$el

  _enabelSort: ->
    $( ".sortable" ).sortable
      stop: =>
        newIds = _($('#list').children()).map (el) =>
          $(el).find('div').data('id')
          
        @_updateOrds(newIds)
        @_reorderCollection(newIds)

  _removeFilms: ->
    toRemove= []
    @collection.each (film) =>
      toRemove.push(film) if film.remove

    for film in toRemove
      mixpanel.track "Removed Film",
        title: film.get 'title',
        year: film.get 'year',
        director: film.get 'director',
        genre: film.get 'genre'

      film.destroy()

  _reorderCollection: (newIds) ->
    mixpanel.track "Reorder List"

    models = []
    for id in newIds
      models.push(@collection.get(id))
    @collection.reset(models)

  _switchButton: ->
    $('#edit-toggle-button').html('done editing') if @editing
    $('#edit-toggle-button').html('edit your list') if not @editing

  _toggleEdit: ->
    @editing = !@editing
    @render()
    @_switchButton()

  _updateOrds: (newIds) ->
    $.ajax
      type: 'PUT'
      url: '/films'
      data: newIds: newIds
