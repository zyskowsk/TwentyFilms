class PasswordResetController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_email(params[:password_reset][:email])
    if user
      now_notices << 'You have been sent an email to reset your password!'
      user.send_password_reset
    else
      now_notices << 'Email not valid'
    end

    render :new
  end
end
