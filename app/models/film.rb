require 'addressable/uri'
require 'rest-client'
class Film < ActiveRecord::Base
  attr_accessible :director, :year, :title, :runtime, :genre, :writer, 
                  :actors, :plot, :poster, :imdbid, :trailer

  validates :title, :year, :director, :presence => true
  validates :year, :inclusion => { :in => (1840..Date.today.year) }

  def self.build_tmdb_url(path, query_values = {})
    Addressable::URI.new(
      :scheme => 'http',
      :host => 'api.themoviedb.org',
      :path => path,
      :query_values => query_values.merge({'api_key' => ENV["TMDB_API_KEY"]})
    ).to_s
  end

  def self.add_film_and_choice(params, current_user)
    ActiveRecord::Base.transaction do
      @new_film = Film.new(params[:film])
      @new_film.save!

      FilmChoice.create(
        :film_id => @new_film.id,
        :user_id => current_user.id,
        :ord => current_user.films ? current_user.films.length : 0
      )
    end
    begin
      @new_film.get_trailer_source
    rescue
    end
    @new_film.save
    @new_film
  end

  def get_trailer_source
    url = Film.build_tmdb_url(
      "3/movie/#{self.imdbid}/trailers"
    )

    self.trailer = JSON.parse(RestClient.get url)['youtube'][0]['source']
  end


end
