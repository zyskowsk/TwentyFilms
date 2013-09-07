class TwentyFilms.Views.SearchUserDetail extends Backbone.View
  tagName: 'li'
  template: JST['search/user_detail']

  render: ->
    @$el.html @template(user: @model)
    this 