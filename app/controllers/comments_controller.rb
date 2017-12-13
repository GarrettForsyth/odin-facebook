class CommentsController < ApplicationController

  before_action :comment_params, only: :create

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:succes] = "Comment created!"
      redirect_to posts_path
    else
      flash[:error] = "Invalid parameters."
      render 'new'
    end
  end


  def like
    c = Comment.find(vote_params[:comment_id])
    unless current_user == User.find(c.author_id) 
      c.liked_by User.find(vote_params[:user_id])
      redirect_back(fallback_location: root_path)
    end
  end

  def unlike
    c = Comment.find(vote_params[:comment_id])
    unless current_user == User.find(c.author_id) 
      c.unvote_by User.find(vote_params[:user_id])
      redirect_back(fallback_location: root_path)
    end
  end

  def dislike
    c = Comment.find(vote_params[:comment_id])
    unless current_user == User.find(c.author_id) 
      c.disliked_by User.find(vote_params[:user_id])
      redirect_back(fallback_location: root_path)
    end
  end

  def undislike
    c = Comment.find(vote_params[:comment_id])
    unless current_user == User.find(c.author_id) 
      c.unvote_by User.find(vote_params[:user_id])
      redirect_back(fallback_location: root_path)
    end
  end

private

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end

  def vote_params
    params.require(:vote).permit(:comment_id, :user_id)
  end

  def comment_params
    params.require(:comment).permit(:comment_id, :author_id, :content)
  end

end
