require 'rails_helper'

RSpec.describe "UserRequestFriends", type: :request do

  context "a user sends a friend request to a new friend" do
    let(:user) { FactoryBot.create(:user) }
    let(:new_friend) { FactoryBot.create(:user) }

    it "adds a new friend request associated with both users" do
      send_friend_request(user, new_friend)

      expect(user.friend_requests.last.user).to eq(user) 
      expect(user.friend_requests.last.friend).to eq(new_friend) 
      expect(user.pending_friends.last).to eq(new_friend) 

      log_in new_friend
      within ('.notifications') do
        expect(page).to have_content "#{user.name} wants to be friends!"
      end

    end

    it "deletes the friend request if the user declines." do
      send_friend_request(user, new_friend)
      log_in(new_friend)
      visit friend_requests_path
      click_link "Decline"

      expect(user.friend_requests.empty?).to eq(true)
      expect(user.pending_friends.last).to be_nil 
      
      log_out new_friend
      log_in user

      within ('.notifications') do
        expect(page).to have_content "#{new_friend.name} has  declined your friend request."
      end
    end

    it "creates a friendship if the friend accepts." do
      create_friendship(user, new_friend)

      expect(user.friend_requests.empty?).to eq(true)
      expect(user.pending_friends.last).to be_nil 

      expect(user.friends).to include(new_friend)
      expect(new_friend.friends).to include(user)

      log_in user

      within ('.notifications') do
        expect(page).to have_content "#{new_friend.name} has accepted your friend request."
      end
    end

  end
end
