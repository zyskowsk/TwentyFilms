class FollowingsController < ApplicationController
  def create 
    following = Following.create(
      :follower_id => current_user.id,
      :followee_id => params[:followee_id]
    )

    render :json => following, :status => 200
  end

  def destroy
    following = Following.find_by_follower_id_and_followee_id(
      current_user.id,
      params[:followee_id]
    )

    following.destroy

    render :json => following
  end
end
