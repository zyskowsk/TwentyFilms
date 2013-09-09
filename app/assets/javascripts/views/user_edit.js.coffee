class TwentyFilms.Views.UserEdit extends Backbone.View 
  template: JST['user_edit']

  render: ->
    @$el.html @template(currentUser: @model)
    this