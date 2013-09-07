require 'addressable/uri'
require 'rest-client'
class Film < ActiveRecord::Base
  attr_accessible :director, :year, :title, :runtime, :genre, :writer, 
                  :actors, :plot, :poster, :imdbid

  TMDB_API_KEY = "5c7ad0d82517d3ccbec62a77fb1269ca"

  validates :title, :year, :director, :presence => true
  validates :year, :inclusion => { :in => (1840..Date.today.year) }

  # def self.build_omdb_url(path, query_values = {})
  #   Addressable::URI.new(
  #     :scheme => 'http',
  #     :host => 'www.omdbapi.com',
  #     :path => path,
  #     :query_values => query_values
  #   ).to_s
  # end

  def self.build_tmdb_url(path, query_values = {})
    Addressable::URI.new(
      :scheme => 'http',
      :host => 'api.themoviedb.org',
      :path => path,
      :query_values => query_values.merge({'api_key' => TMDB_API_KEY})
    ).to_s
  end

  def self.add_film_and_choice(params, current_user)
    puts 'in addfilm and choice'
    ActiveRecord::Base.transaction do
      @new_film = Film.new(params[:film])
      @new_film.save!

      FilmChoice.create(
        :film_id => @new_film.id,
        :user_id => current_user.id,
        :ord => current_user.films ? current_user.films.length : 0
      )
    end
    @new_film.get_trailer_source
    @new_film.save
  end

  # def self.omdb_search(title)
  #   url = self.build_omdb_url('/', {'t' => "#{title.titleize}" })
  #   result = JSON.parse(RestClient.get url)
  # end

  def get_trailer_source
    url = Film.build_tmdb_url(
      "3/movie/#{self.imdbid}/trailers"
    )
    puts url 

    self.trailer = JSON.parse(RestClient.get url)['youtube'][0]['source']
  end

  # def self.get_tmdb_id(title)
  #   url = self.build_tmdb_url(
  #     '/3/search/movie', 
  #     {'query' => "#{title.titleize}"} 
  #   )

  #   JSON.parse(RestClient.get url)['results'][0]['id']
  # end

end
