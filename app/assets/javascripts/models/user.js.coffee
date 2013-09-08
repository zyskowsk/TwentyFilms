class TwentyFilms.Models.User extends Backbone.Model

  urlRoot: '/users'
  
  parse: (data) ->
    data.films = new TwentyFilms.Collections.Films(data.films)
    data.followers = new TwentyFilms.Collections.Users(data.followers)
    data.followed_users = new TwentyFilms.Collections.Users(data.followed_users)
    data

  @getByRawId: (id, callback) ->
    @user = new TwentyFilms.Models.User(id: id)
    @user.fetch
      success: (response) => 
        callback(response)

