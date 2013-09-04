class FilmsController < ApplicationController

  def create
    title = params[:film][:title]
    @film = Film.find_by_title(title)
    omdb_film = Film.omdb_search(title)

    if @film
      FilmChoice.create(
        :film_id => @film.id, 
        :user_id => current_user.id
      )

      render :json => @film, :status => 200
    elsif (omdb_film["Response"] == "True")
      ActiveRecord::Base.transaction do
        @new_film = Film.new(
          :title => omdb_film['Title'],
          :director => omdb_film['Director'],
          :release_year => omdb_film['Year']
        )

        @new_film.save!

        FilmChoice.create(
          :film_id => @new_film.id,
          :user_id => current_user.id
        )
      end

      render :json => @new_film, :status => 200
    else
      render :json => "error", :status => 422
    end
  end
end