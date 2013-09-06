class TwentyFilms.Models.User extends Backbone.Model
  
  parse: (data) ->
    data.films = new TwentyFilms.Collections.Films(data.films)
    data
