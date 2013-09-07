class RootController < ApplicationController

  def root
    if logged_in?
      @users = User.all
      @current_user = current_user
      render :authenticated_root 
    else 
      render :welcome_root 
    end
  end

end