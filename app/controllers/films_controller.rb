class FilmsController < ApplicationController

  def create
    @film = Film.find_by_title(params[:film][:title])

     if @film
      FilmChoice.create(
        :film_id => @film.id, 
        :user_id => current_user.id
      )
     else
     end


    render :json => @film
  end

end