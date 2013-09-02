class Film < ActiveRecord::Base
  attr_accessible :director, :release_year, :title

  validates :title, :release_year, :director, :presence => true
  validates :year, :inclusion => { :in => (1840..Date.today.year) }

  
end
