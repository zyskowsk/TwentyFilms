class TwentyFilms.Views.UserEdit extends Backbone.View 
  template: JST['user_edit']

  events: 
    'click .home': 'navigateHome'

  render: ->
    @$el.html @template(currentUser: @model)
    this

  navigateHome: ->
    Backbone.history.navigate('', trigger: true)