class SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(
      params[:session][:login],
      params[:session][:password]
    )

    if @user
      login!(@user)

      redirect_to root_url
    else
      now_notices << "Incorrect login or password"
      render 'root/welcome_root'
    end
  end

  def destroy
    logout!(current_user)

    redirect_to root_url
  end
end