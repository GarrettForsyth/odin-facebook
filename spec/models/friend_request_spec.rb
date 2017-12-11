require 'rails_helper'

describe FriendRequest, type: :model do

  let(:friend_request) { FactoryBot.build(:friend_request) }

  it "has a valid factory" do
    expect(friend_request).to be_valid
  end

  it "doesn't allow self requests" do
    user = create :user
    friend_request.user = user
    friend_request.friend = user
    expect(friend_request).not_to be_valid
  end

  it "does not allow duplicate requests." do
    dup = friend_request
    friend_request.save!
    expect(dup).not_to be_valid
  end

  it "does not allow users to send a request if they are already friends" do
    friend_request.user.friends << friend_request.friend
    expect(friend_request).not_to be_valid
  end


end
