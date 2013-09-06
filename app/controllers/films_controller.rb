class FilmsController < ApplicationController

  def create
    if not (params[:film].nil? || params[:film].empty?)
      @new_film = Film.new(params[:film])

      if @new_film.save
        render :json => @new_film
      else
        render :json => @new_film.errors, :status => 422
      end
    else
      add_film_on_search(params)
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

    render :json => [], :status => 200
  end

  private
    def add_film_on_search(params)
      title = params[:Title]
      @film = Film.find_by_title(title)

      if @film
        puts @film.id
        FilmChoice.create(
          :film_id => @film.id, 
          :user_id => current_user.id
        )

        render :json => @film, :status => 200
      else
        Film.add_film_and_choice(params, current_user)

        render :json => @new_film, :status => 200
      end
    end
end