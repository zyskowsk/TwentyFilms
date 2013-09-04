class TwentyFilms.Views.List extends Backbone.View

  initialize: ->
    @listenTo(@collection, 'change', @render)
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
      $( ".sortable" ).sortable()
    else
      $( ".sortable" ).sortable( "destroy" );
