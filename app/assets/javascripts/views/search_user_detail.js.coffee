class TwentyFilms.Views.SearchUserDetail extends Backbone.View

  template: JST['search/user_detail']

  events: 
    'click #follow': 'follow'
    'click #unfollow': 'unfollow'

  render: ->
    @$el.html @template(user: @model)
    this 

  follow: ->
    @model.follow()
    @render()

  unfollow: ->
    @model.unfollow()
    @render()