class TwentyFilms.Views.UserDetail extends Backbone.View
  className: 'user-detail'
  template: JST['user_detail']

  events:
    'click #unfollow': 'unfollow'

  render: -> 
    fragment = Backbone.history.fragment
    @$el.html @template 
        user: @model, 
        followed: this.options.followed,
        fragment: fragment
    this

  unfollow: ->
    @model.unfollow()
    @render()
