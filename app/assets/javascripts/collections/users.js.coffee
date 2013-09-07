class TwentyFilms.Collections.Users extends Backbone.Collection

  model: TwentyFilms.Models.User

  searchUsers: (searchString) ->
    searchLen = searchString.length
    return [] if searchString == ''
    this.models.filter (user) =>
      ((user.get('name').slice(0, searchLen) == searchString) ||
        (user.get('email').slice(0, searchLen) == searchString))