class FriendRequestsController < ApplicationController
  before_action :set_friend_request, except: [:create, :index]

  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend)

    if @friend_request.save
      flash[:success] = "Friend request sent!"
    else
      render json: @friend_request.errors, status: :unprocessable_entity
    end
  end

  def index
    @incoming = FriendRequest.where(friend: current_user)
    @outgoing = current.user.friend_requests
  end

  def destroy
    @friend_request.destroy
    head :no_content
  end

  def update
    @friend_request.accept
    head :no_content
  end

  # adds each user to the other's friends (inverse relationship)
  # and destroys the pending request
  def accept
    user.friends << friend
    destroy
  end

private
  
  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end

end
