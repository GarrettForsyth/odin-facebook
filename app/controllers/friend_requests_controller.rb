class FriendRequestsController < ApplicationController
  before_action :set_friend_request, except: [:create, :index]

  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend)

    if @friend_request.save
      create_notification(friend.id, "friend request")
      flash[:notice] = "Friend request sent!"
      redirect_to root_path
    else
      flash[:error] = "Unable to send request."
      render json: @friend_request.errors, status: :unprocessable_entity
    end
  end

  def index
    @incoming = FriendRequest.where(friend: current_user)
    @outgoing = current_user.friend_requests
  end

  def destroy
    @friend_request.destroy
    create_notification(@friend_request.user_id, "declined friend request")
    flash[:notice] = "Friend request removed."
    head :no_content
  end

  def update
    @friend_request.accept
    create_notification(@friend_request.user_id, "accepted friend request")
    flash[:notice] = "Friend request accepted."
    head :no_content
  end

private
  
  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end

  def create_notification(user_id,action)
    Notification.create(user_id: user_id,
                        notified_by_id: current_user.id,
                        notice_type: action)
  end

end
