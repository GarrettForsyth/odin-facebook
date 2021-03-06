class FriendRequestsController < ApplicationController
  before_action :set_friend_request, except: [:create, :index]

  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend)

    if @friend_request.save
      create_notification(friend.id, "friend request")
      flash[:notice] = "Friend request sent!"
      redirect_back(fallback_location: profile_path)
    else
      flash[:error] = "Unable to send request."
      render json: @friend_request.errors, status: :unprocessable_entity
    end
  end

  def index
    @incoming = FriendRequest.where(friend: current_user).
      paginate(page: params[:incoming_page])
    @outgoing = current_user.friend_requests.
      paginate(page: params[:outgoing_page])
  end

  def destroy
    @friend_request.destroy
    create_notification(@friend_request.user_id, "declined friend request")
    redirect_back(fallback_location: friend_requests_path)
  end

  def update
    @friend_request.accept
    create_notification(@friend_request.user_id, "accepted friend request")
    redirect_back(fallback_location: friend_requests_path)
    flash[:notice] = "Friend request accepted."
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
