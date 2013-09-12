class UsersController < ApplicationController

  def create
    @user = User.new(params[:user])

    if @user.save
      login!(@user)
      redirect_to root_url
    else
      now_notices.push(*@user.errors.full_messages)
      render 'root/welcome_root'
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      render :json => @user
    else
      render :json => @user.errors.full_messages, :status => 422
    end
  end

  def destroy

  end

  def show
    @user = User.find(params[:id])

    render :json => @user, :status => 200
  end

end