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
          @film.getTrailerAndPoster =>
            callback(@film)
    else
      @film = new TwentyFilms.Models.Film(id: id)
      @film.fetch
        success: (response) =>
          callback(response)

  getTrailerAndPoster: (callback) ->
    data = 
      api_key: TwentyFilms.Store.TMDB_API_KEY, 
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
        error: (response) =>
          console.log('error occurred fetching trailer and poster')
          console.log('film:')
          console.log(this)
          callback(this)


    
