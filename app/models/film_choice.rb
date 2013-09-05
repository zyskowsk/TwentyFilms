class FilmChoice < ActiveRecord::Base
  attr_accessible :film_id, :user_id, :ord

  validates :film_id, :uniqueness => { :scope => :user_id }

  belongs_to :user
  belongs_to :film
end
