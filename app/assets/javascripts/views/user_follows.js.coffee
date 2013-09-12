class TwentyFilms.Views.UserFollows extends Backbone.View

  className: 'user-follows'

  template: JST['user_follows']

  initialize: ->
    currentFollowedUsers = TwentyFilms.Store.currentUser.get('followed_users')
    @listenTo(currentFollowedUsers, 'add remove', @render)
    @listenTo(TwentyFilms.Store.currentUser, 'update', @render)

  render: -> 
    followers = @model.get('followers')
    followed_users = @model.get('followed_users')
    @$el.html @template()

    for user in followers.models
      followerView = new TwentyFilms.Views.UserDetail
          model: user
      @$el.find('#followers').append followerView.render().$el

    for user in followed_users.models
      followedUserView = new TwentyFilms.Views.UserDetail
          model: user, 
          followed: true
      @$el.find('#followed_users').append followedUserView.render().$el   

    this