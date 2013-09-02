class SessionsController < ActionController::Base

  def create
    @user = User.find_by_credentials(
      params[:session][:login],
      params[:session][:password]
    )

    if @user
      login!(user)

      render :authenticated_root
    else
      render :welcome_root
    end
  end

  def destroy
    logout!(current_user)
  end
end