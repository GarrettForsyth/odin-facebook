class CommentsController < ApplicationController

  before_action :comment_params, only: :create

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      Notification.create(user_id: @comment.post.author_id,
                          notified_by_id: @comment.author_id,
                          post_id: @comment.post_id,
                          notice_type: "comment on post")
      flash[:success] = "Comment created!"
      if params[:url].present?
        redirection = params[:url].to_s
        redirect_to redirection
      else
        redirect_back fallback_location: posts_path
      end
    else
      flash.now[:error] = "Invalid parameters."
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
    params.require(:comment).permit(:post_id, :author_id, :content)
  end

end
