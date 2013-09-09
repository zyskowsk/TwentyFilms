class TwentyFilms.Views.UserDetail extends Backbone.View
  template: JST['user_detail']

  render: -> 
    @$el.html @template(user: @model)
    this
