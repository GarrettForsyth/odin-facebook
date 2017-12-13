class PostsController < ApplicationController

  before_action :correct_user, only: :destroy
  before_action :vote_params, only: [:like, :dislike, :unlike, :undislike]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to current_user
    else
      render 'new'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post deleted."
  end

  def index
    @time_line = current_user.time_line
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
    params.require(:post).permit(:content)
  end

  def vote_params
    params.require(:vote).permit(:post_id, :user_id)
  end
end
