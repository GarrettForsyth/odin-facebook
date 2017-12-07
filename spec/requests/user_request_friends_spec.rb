require 'rails_helper'

RSpec.describe "UserRequestFriends", type: :request do

  it "sends a friend request to another user" do
    user = FactoryBot.create(:user)
    new_friend = FactoryBot.create(:user)
    user.confirm
    new_friend.confirm
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(current_path).to eq(user_profile_path(user))
    visit(user_profile_path(new_friend))
    click_link "Send Friend Request"

    expect(user.friend_requests.last.user).to eq(user) 
    expect(user.friend_requests.last.friend).to eq(new_friend) 
    expect(user.pending_friends.last).to eq(new_friend) 

    expect(new_friend.notifications.last).to have_link(friend_requests(new_friend))

  end

end
