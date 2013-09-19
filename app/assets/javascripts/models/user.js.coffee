class TwentyFilms.Models.User extends Backbone.Model
  urlRoot: '/users'

  @getByRawId: (id, callback) ->
    @user = new TwentyFilms.Models.User(id: id)
    @user.fetch
      success: (response) => 
        callback(response)
  
  follow: (options) ->
    $.ajax
      type: 'POST'
      url: '/followings'
      dataType: 'json'
      data: followee_id: this.get('id')
      success: =>
        TwentyFilms.Store.currentUser.get('followed_users').add(this)
        $('#results').slideUp('fast')

  unfollow: ->
    $.ajax
      type: 'DELETE'
      url: '/followings'
      dataType: 'json'
      data: followee_id: this.get('id')
      success: =>
        TwentyFilms.Store.currentUser.get('followed_users').remove(this)
        $('#results').slideUp('fast')

  isFollowed: ->
    areFollowing = false
    
    followed_users = TwentyFilms.Store.currentUser.get('followed_users')
    followed_users.each (user) =>
      areFollowing = true if user.get('username') == this.get('username')

    areFollowing

  parse: (data) ->
    data.films = new TwentyFilms.Collections.Films(data.films)
    data.followers = new TwentyFilms.Collections.Users(data.followers)
    data.followed_users = new TwentyFilms.Collections.Users(data.followed_users)
    data





