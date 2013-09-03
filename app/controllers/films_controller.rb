class FlimsController < ApplicationController

  def create
    @film = Film.new(params[:film])

    if @film.save
      render :json => @film, :status => 200
    else
      render :json => @film.errors, :status => 422
    end
  end

end