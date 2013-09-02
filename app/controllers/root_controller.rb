class RootController < ApplicationController

  def root
    if logged_in?
      render :authenticated_root 
    else 
      render :welcome_root 
    end
  end

end