class FilmsController < ApplicationController

  def create
    title = params[:Title]
    @film = Film.find_by_title(title)

    if @film
      FilmChoice.create(
        :film_id => @film.id, 
        :user_id => current_user.id
      )

      render :json => @film, :status => 200
    else
      ActiveRecord::Base.transaction do
        @new_film = Film.new(
          :title => params[:Title],
          :director => params[:Director],
          :release_year => params[:Year]
        )

        @new_film.save!

        FilmChoice.create(
          :film_id => @new_film.id,
          :user_id => current_user.id,
          :ord => current_user.films ? current_user.films.length : 0
        )
      end

      render :json => @new_film, :status => 200
    end
  end

  def destroy
    @film_choice = FilmChoice.find_by_user_id_and_film_id(
      current_user.id,
      params[:id]
    )

    @film_choice.destroy
    render :json => @film_choice
  end

  def index
    search_string = params[:search]

    results = Film.where('title LIKE ?', "%#{search_string.titleize}%")

    render :json => results.to_json, :status => 200
  end

  def update
    params[:newIds].each_with_index do |id, idx|
      film = FilmChoice.find_by_user_id_and_film_id(current_user.id, id)
      film.update_attributes(:ord => idx)
    end

    render :status => 200
  end
end