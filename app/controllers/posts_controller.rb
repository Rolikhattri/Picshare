class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = current_user.posts.build
  end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def dashboard
    @user = current_user
    @user = User.find(params[:user_id]) if !params[:user_id].nil?
    @posts = @user.posts.order(created_at: :desc)
  end

  def following
    @user = current_user
    @posts = @user.following.includes(:posts).collect{|u| u.posts}.flatten.sort_by(&:created_at).reverse
  end

  def explore
    @posts = Post.all.order(created_at: :desc)
  end

  def create
    @post = current_user.posts.build(permit_post)

    respond_to do |format|
      if @post.save
        @posts = current_user.posts.order(created_at: :desc)
        format.js
      else
        flash[:error] = @post.errors.full_messages
        redirect_to new_post_path
      end
    end
  end

  private
    def permit_post
        params.require(:post).permit(:image, :title, :user_id)
    end 
end
