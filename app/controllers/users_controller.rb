class UsersController < ApplicationController

  def create
    @user = User.new(params[:user])
    @sign_up  = true

    if @user.save
      login!(@user)
      puts "logged in"
      puts current_user
      redirect_to root_url
    else
      now_notices.push(*@user.errors.full_messages)
      render 'root/welcome_root'
    end
  end

  def update
    @user = User.find(params[:id])

    if params[:password_reset]
      if not (@user.is_correct_password?(params[:password_reset][:old_password]))
        render :json => ["password not correct"], :status => 422
      elsif params[:password_reset][:new_password] != params[:password_reset][:confirmation]
        render :json => ["passwords don't match"], :status => 422
      else
        @user.save_new_password!(params[:password_reset][:new_password])
        render :json => @user
      end
    else
      if @user.update_attributes(params[:user])
        render :json => @user
      else
        render :json => @user.errors.full_messages, :status => 422
      end
    end
  end

  def destroy

  end

  def show
    @user = User.find(params[:id])

    render :json => @user, :status => 200
  end

end
