class TwentyFilms.Views.List extends Backbone.View

  initialize: ->
    @listenTo(@collection, 'change sync destroy', @render)
    @editing = false

  events: 
    'click #edit-toggle-button': 'toggleEditView'

  template: JST['list/list']

  render: ->
    @$el.html @template()
    @collection.each (film) =>
      @addDetail(film) if not @editing
      @addEdit(film) if @editing

    this

  addDetail: (film) ->
    detail = new TwentyFilms.Views.ListDetail(model: film)
    @$el.find('#list').append detail.render().$el

  addEdit: (film) ->
    edit = new TwentyFilms.Views.ListEdit(model: film)
    @$el.find('#list').append edit.render().$el

  toggleEditView: ->
    @editing = !@editing
    @render()
    @switchButton()

    if @editing
      $( ".sortable" ).sortable
        stop: =>
          newIds = _($('#list').children()).map (el) =>
            $(el).find('div').data('id')
          @updateOrds(newIds)
          @reorderCollection(newIds)
    else
      @removeFilms()

  updateOrds: (newIds) ->
    $.ajax
      type: 'PUT'
      url: '/films'
      data: newIds: newIds

  reorderCollection: (newIds) ->
    for id in newIds
      film = @collection.findWhere(id: id)
      @collection.remove(film)
      @collection.add(film)

  switchButton: ->
    $('#edit-toggle-button').html('done editing') if @editing
    $('#edit-toggle-button').html('edit your list') if not @editing

  removeFilms: ->
    toRemove= []
    @collection.each (film) =>
      toRemove.push(film) if film.remove

    for film in toRemove
      film.destroy()


