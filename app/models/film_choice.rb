class FilmChoice < ActiveRecord::Base
  attr_accessible :film_id, :user_id

  belongs_to :user
  belongs_to :film
end
