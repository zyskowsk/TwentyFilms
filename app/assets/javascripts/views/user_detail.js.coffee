class TwentyFilms.Views.UserDetail extends Backbone.View
  className: 'user-detail'
  template: JST['user_detail']

  events:
    'click #unfollow': 'unfollow'

  render: -> 
    @$el.html @template(user: @model, followed: this.options.followed)
    this

  unfollow: ->
    @model.unfollow()
    TwentyFilms.Store.currentUser.get('followed_users').remove(@model)
    @render()
