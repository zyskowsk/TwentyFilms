class TwentyFilms.Views.UserShow extends Backbone.View

  template: JST['user_show']

  events:
    'click .show.back': 'navigateHome'

  render: ->
    @$el.html @template(user: @model)
    @model.get('films').each (film) =>
      detailView = new TwentyFilms.Views.ListDetail(model: film)
      @$el.find('.list').append detailView.render().$el

    followsView = new TwentyFilms.Views.UserFollows(model: @model)
    @$el.find('.user_show_follows').append followsView.render().$el

    this

  navigateHome: ->
    Backbone.history.navigate('', trigger: true)