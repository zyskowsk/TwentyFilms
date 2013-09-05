class TwentyFilms.Views.List extends Backbone.View

  initialize: ->
    @listenTo(@collection, 'change', @render)
    @listenTo(@collection, 'sync', @render)
    @editing = false

  events: 
    'click #edit': 'toggleEditView'

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

    if @editing
      $( ".sortable" ).sortable
        stop: =>
          newIds = _($('#list').children()).map (thing) =>
            $(thing).find('div').data('id')
          @updateOrds(newIds)
          @reorderCollection(newIds)

  updateOrds: (newIds) ->
    $.ajax
      type: 'PUT'
      url: '/films'
      data: newIds: newIds

  reorderCollection: (newIds) ->
    for id in newIds
      film = @collection.findWhere(id: id)
      @collection.remove(film)
      console.log(@collection)
      @collection.push(film)


