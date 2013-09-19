class FilmsController < ApplicationController

  def create
    if not params[:response] || params[:title]
      @new_film = Film.new(params[:film])

      if @new_film.save
        render :json => @new_film
      else
        render :json => @new_film.errors.full_messages, :status => 422
      end
    else
      add_film_on_search
    end
  end

  def bacon_number
    render :json => Film.get_bacon_number, :status => 200
  end

  def destroy
    @film_choice = FilmChoice.find_by_user_id_and_film_id(
      current_user.id,
      params[:id]
    )

    @film_choice.destroy
    render :json => @film_choice
  end

  def search
    search_string = params[:search].downcase
    films = Film.all
    reg_exp = Regexp.new(".*#{search_string}.*")

    results = films.select do |film|
      !!film.title.downcase.match(reg_exp)
    end

    render :json => results.to_json, :status => 200
  end

  def update
    film_choices = current_user.film_choices

    params[:newIds].each_with_index do |id, idx|
      film_choice = film_choices.select do |film_choice|
        film_choice.film_id == id.to_i
      end.first
  
      film_choice.update_attributes(:ord => idx) unless film_choice.ord == idx
    end

    render :json => [], :status => 200
  end

  def show
    @film = Film.find(params[:id])

    render :json => @film, :status => 200
  end

  private
    def add_film_on_search
      @film = Film.find_by_title(params[:title])

      if @film
        FilmChoice.create(
          :film_id => @film.id, 
          :user_id => current_user.id
        )

        render :json => @film, :status => 200
      else
        @new_film = Film.add_film_and_choice(params, current_user)

        render :json => @new_film, :status => 200
      end
    end
end