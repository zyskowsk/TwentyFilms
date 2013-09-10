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
    data = 
      api_key: '5c7ad0d82517d3ccbec62a77fb1269ca', 
      append_to_response: 'trailers'

    unless this.get('trailer')
      $.ajax
        type: 'GET'
        url: "http://api.themoviedb.org/3/movie/#{this.get('imdbid')}?"
        dataType: 'json'
        data: data
        success: (response) =>
          this.set('trailer', response['trailers']['youtube'][0]['source'])
          this.set('poster', response['poster_path'])
          callback(this)


    
