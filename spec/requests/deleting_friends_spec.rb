require 'rails_helper'

describe "DeletingFriends", type: :request do
  context "two users are friends and one deletes the other" do
    
    before(:each) do
      @user =  FactoryBot.create(:user)
      @friend = FactoryBot.create(:user) 
      create_friendship(@user, @friend)
      @friendship = Friendship.find_by(user: @user, friend: @friend)
      log_in @user
      within('.friends') do
        click_link "remove"
      end
      log_out @user
    end

    it "removes the friendship between users" do
      expect(@user.friends).not_to include(@friend)
      expect(@friend.friends).not_to include(@user)
      expect(Friendship.all).not_to include(@friendship)
    end

    it "should allow a new friend request to be sent to the deleted user" do
      create_friendship(@user, @friend)
      new_friendship = Friendship.find_by(user: @user, friend: @friend)
      expect(Friendship.all).to include(new_friendship)
      expect(@user.friends).to include(@friend)
      expect(@friend.friends).to include(@user)
    end

  end
end
