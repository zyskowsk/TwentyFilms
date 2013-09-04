require 'addressable/uri'
require 'rest-client'
class Film < ActiveRecord::Base
  attr_accessible :director, :release_year, :title

  TMDB_API_KEY = "5c7ad0d82517d3ccbec62a77fb1269ca"

  validates :title, :release_year, :director, :presence => true
  validates :release_year, :inclusion => { :in => (1840..Date.today.year) }

  def self.omdb_search(title)
    url = self.build_omdb_url('/', {'t' => "#{title.titleize}" })
    result = JSON.parse(RestClient.get url)
  end

  def self.get_trailer_source(title)
    id = self.get_tmdb_id(title)
    url = self.build_tmdb_url(
      "3/movie/#{id}/trailers"
    )

    JSON.parse(RestClient.get url)['youtube'][0]['source']
  end

  def self.get_tmdb_id(title)
    url = self.build_tmdb_url(
      '/3/search/movie', 
      {'query' => "#{title.titleize}"} 
    )

    JSON.parse(RestClient.get url)['results'][0]['id']
  end

  def self.build_omdb_url(path, query_values = {})
    Addressable::URI.new(
      :scheme => 'http',
      :host => 'www.omdbapi.com',
      :path => path,
      :query_values => query_values
    ).to_s
  end

  def self.build_tmdb_url(path, query_values = {})
    Addressable::URI.new(
      :scheme => 'http',
      :host => 'api.themoviedb.org',
      :path => path,
      :query_values => query_values.merge({'api_key' => TMDB_API_KEY})
    ).to_s
  end
end
