require 'mixpanel-ruby'

class SessionsController < ApplicationController

  tracker = Mixpanel::Tracker.new('2ad84fbab81bdf0e328eed1369a979a7')

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      login!(@user)
      tracker.track(@user.id, 'Sign_in', {
        'login' => 'normal'
      })

      redirect_to root_url
    else
      now_notices << "Incorrect login or password"
      render 'root/welcome_root'
    end
  end

  def facebook_create
    @user = User.from_omniauth(env["omniauth.auth"])
    tracker.track(@user.id, "Sign in", {
      'login' => 'facebook'
    });

    session[:user_id] = @user.id
    redirect_to root_url
  end

  def destroy
    logout!(current_user)

    redirect_to root_url
  end
end
