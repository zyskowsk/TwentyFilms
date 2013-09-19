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

  addFilmTo: (collection, callback) ->
    $('#results').slideUp('fast')
    TwentyFilms.Store.addSpinner()
    if this.get('imdbid')
      this._addApiFilm(collection, callback)
    else
      this._addDbFilm(collection, callback)

  alreadyInList: (collection) ->
    titleList = collection.map (film) =>
      film.get('title')

    (titleList.indexOf(this.get('title')) != -1) if this

  @getBaconNumber: (callback) ->
    $.ajax
      type: 'GET'
      url:'/bacon_number'
      dataType: 'json'
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
          if (response['trailers']['youtube'].length > 0)
            this.set('trailer', response['trailers']['youtube'][0]['source'])
          if response['poster_path']
            this.set('poster', response['poster_path'])
          callback(this)
        error: (response) =>
          callback(this)
          

  _addApiFilm: (collection, callback) ->
    $.ajax
      type: 'GET'
      url: 'http://www.omdbapi.com'
      dataType: 'json'
      data: {i: this.get('imdbid')}
      success: (response) =>
        clensedResult = TwentyFilms.Search.clenseResult(response)
        newFilm = new TwentyFilms.Models.Film clensedResult
        newFilm._persistFilm(collection, callback)

  _addDbFilm: (collection, callback) ->
    $.ajax
      type: 'POST'
      url: '/films'
      data: {title: this.get('title')}
      success: =>
        collection.add(this)
        $('body').spin(false)
        $('#results').html('')
        callback()

  _persistFilm: (collection, callback) ->
    this.getTrailerAndPoster =>
      unless this.alreadyInList(collection)
        collection.create this, 
          success: =>
            $('body').spin(false)
            $('#results').html('')
            callback()

  

    
