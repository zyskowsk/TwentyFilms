class TwentyFilms.Views.List extends Backbone.View
  template: JST['list']

  render: ->
    @$el.html @template()
    @collection.each (film) =>
      @addDetail(film)

    this

  addDetail: (film) ->
    detail = new TwentyFilms.Views.ListDetail(model: film)
    @$el.find('#film-list').append detail.render().$el