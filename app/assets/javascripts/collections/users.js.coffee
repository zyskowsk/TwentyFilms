class TwentyFilms.Collections.Users extends Backbone.Collection

  model: TwentyFilms.Models.User

  searchUsers: (searchString) ->
    regExp = RegExp(".*#{searchString.toLowerCase()}.*" )
    return [] if searchString == ''
    this.models.filter (user) =>
      !!user.get('name').match(regExp) || !!user.get('email').match(regExp) &&
        user.get('id') != TwentyFilms.Store.currentUser.get('id')

