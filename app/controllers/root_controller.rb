class RootController < ApplicationController

  def root
    if logged_in?
      @users = User.all
      render :authenticated_root 
    else 
      render :welcome_root 
    end
  end

end