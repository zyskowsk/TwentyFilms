class TwentyFilms.Views.UserShow extends Backbone.View

  template: JST['user_show']

  events:
    'click .show.back': 'navigateHome'

  render: ->
    @$el.html @template(user: @model)
    @model.get('films').each (film) =>
      detailView = new TwentyFilms.Views.ListDetail(model: film)
      @$el.find('.list').append detailView.render().el

    this

  navigateHome: ->
    $('#user-show').animate right: -$('#user-show').width(), =>
      $('#user-show').hide()
    Backbone.history.navigate('', trigger: true)