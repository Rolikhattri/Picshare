class FollowsController < ApplicationController
  def follow_user
    current_user.follow(params[:user_id])
    redirect_to dashboard_posts_path(:user_id => params[:user_id])
  end

  def unfollow_user
    current_user.unfollow(params[:user_id])
    redirect_to dashboard_posts_path(:user_id => params[:user_id])
  end
end
