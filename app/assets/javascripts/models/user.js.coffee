class TwentyFilms.Models.User extends Backbone.Model

  urlRoot: '/users'

  @getByRawId: (id, callback) ->
    @user = new TwentyFilms.Models.User(id: id)
    @user.fetch
      success: (response) => 
        callback(response)
  
  follow: ->
    $.ajax
      type: 'POST'
      url: '/followings'
      dataType: 'json'
      data: @_followData this.get('id')
      success: =>
        console.log('did it!')

  unfollow: ->
    $.ajax
      type: 'DELETE'
      url: '/followings'
      dataType: 'json'
      data: @_followData this.get('id')
      success: =>
        console.log('undid it!')

  isFollowed: ->
    followed_users = TwentyFilms.Store.currentUser.get('followed_users')
    areFollowing = false

    followed_users.each (user) =>
      areFollowing = true if user.get('username') == this.get('username')

    areFollowing

  parse: (data) ->
    data.films = new TwentyFilms.Collections.Films(data.films)
    data.followers = new TwentyFilms.Collections.Users(data.followers)
    data.followed_users = new TwentyFilms.Collections.Users(data.followed_users)
    data

  _followData: (followeeId) ->
      follower_id: TwentyFilms.Store.currentUserId,
      followee_id: followeeId





