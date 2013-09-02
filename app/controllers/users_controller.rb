class UsersController < ActionController::Base

  def create
    @user = User.new(params[:user])

    if @user.save
      login(@user)

      render :authenticated_root
    else
      render :welcome_root
    end
  end

  def update

  end

  def destroy

  end

end