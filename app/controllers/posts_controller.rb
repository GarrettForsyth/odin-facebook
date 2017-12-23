class PostsController < ApplicationController

  before_action :correct_user, only: :destroy
  before_action :vote_params, only: [:like, :dislike, :unlike, :undislike]
  before_action :destroy_notifications, only: [:destroy]

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to posts_path
    else
      flash[:error] = @post.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post deleted."
    redirect_back fallback_location: profile_path
  end

  def index
    @posts = current_user.time_line.paginate(page: params[:page])
  end

  def like
    p = Post.find(vote_params[:post_id])
    unless current_user == User.find(p.author_id) 
      p.liked_by User.find(vote_params[:user_id])
      redirect_back(fallback_location: root_path)
    end
  end

  def unlike
    p = Post.find(vote_params[:post_id])
    unless current_user == User.find(p.author_id) 
      p.unvote_by User.find(vote_params[:user_id])
      redirect_back(fallback_location: root_path)
    end
  end

  def dislike
    p = Post.find(vote_params[:post_id])
    unless current_user == User.find(p.author_id) 
      p.disliked_by User.find(vote_params[:user_id])
      redirect_back(fallback_location: root_path)
    end
  end

  def undislike
    p = Post.find(vote_params[:post_id])
    unless current_user == User.find(p.author_id) 
      p.unvote_by User.find(vote_params[:user_id])
      redirect_back(fallback_location: root_path)
    end
  end

private

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end

  def post_params
    params.require(:post).permit(:content, :picture)
  end

  def vote_params
    params.require(:vote).permit(:post_id, :user_id)
  end

  def destroy_notifications
    Notification.delete_all("post_id = #{@post.id}")
  end
end
