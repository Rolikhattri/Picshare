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
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc)
    render :index
  end

  def create
    @post = current_user.posts.build(permit_post)
    if @post.save
        redirect_to post_path(@post)
    else
        flash[:error] = @post.errors.full_messages
        redirect_to new_post_path
    end
  end

  private
    def permit_post
        params.require(:post).permit(:image, :title, :user_id)
    end 
end
