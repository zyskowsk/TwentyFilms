class TwentyFilms.Models.Film extends Backbone.Model
  
  urlRoot: '/films'

  @getByRawId: (id, callback) ->
    if id.slice(0, 2) == 'tt'
      $.ajax
        type: 'GET'
        url: 'http://www.omdbapi.com'
        dataType: 'json'
        data: {i: id}
        success: (response) =>
          @film = new TwentyFilms.Models.Film(response)
          callback(@film)
    else
      @film = new TwentyFilms.Models.Film(id: id)
      @film.fetch
        success: (response) =>
          console.log(response)
          callback(response)
