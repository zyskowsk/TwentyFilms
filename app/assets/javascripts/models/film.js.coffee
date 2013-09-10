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
          result = TwentyFilms.Search.clenseResult(response)
          @film = new TwentyFilms.Models.Film(result)
          @film.getTrailer =>
            callback(@film)
    else
      @film = new TwentyFilms.Models.Film(id: id)
      @film.fetch
        success: (response) =>
          callback(response)

  getTrailer: (callback) ->
    unless this.get('trailer')
      $.ajax
        type: 'GET'
        url: "http://api.themoviedb.org/3/movie/#{this.get('imdbid')}/trailers?"
        dataType: 'json'
        data: {api_key: '5c7ad0d82517d3ccbec62a77fb1269ca'}
        success: (response) =>
          this.set('trailer', response['youtube'][0]['source'])
          callback(this)


    
