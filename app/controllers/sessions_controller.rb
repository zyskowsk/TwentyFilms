class SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      login!(@user)

      redirect_to root_url
    else
      now_notices << "Incorrect login or password"
      render 'root/welcome_root'
    end
  end

  def facebook_create
    @user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = @user.id
    redirect_to root_url
  end

  def destroy
    logout!(current_user)

    redirect_to root_url
  end
end