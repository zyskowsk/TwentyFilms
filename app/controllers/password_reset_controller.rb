class PasswordResetController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_email(params[:password_reset][:email])
    now_notices << 'Email not valid' unless user
    now_notices << 'You have been sent an email to reset your password!' if user
    render :new
  end
end
