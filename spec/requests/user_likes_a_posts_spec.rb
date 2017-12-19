require 'rails_helper'

describe "UserLikesAPosts", type: :request do

  context "a user creates a post" do


    before(:each) do
      @user = create :user
      @user2 = create :user
      create_friendship(@user, @user2)
      create_post_from @user
    end

    it "lets another user like the post" do
      p = Post.all.last
      expect(p.get_likes.size).to eq(0)
      expect(@user2.friends).to include(@user)
      log_in @user2
      click_link "My Timeline"

      within(".user_post") do
        click_button "like"
      end

      expect(p.get_likes.size).to eq(1)
    end

    # Removed link visibility if current user = post author
    xit "won't let a user like his own posts" do

      p = Post.all.last
      log_in @user
      click_link "My Timeline"
      within(".user_post") do
        click_button "like"
      end

      expect(p.get_likes.size).to eq(0)

    end

    it "allows a user to unlike their like" do

      p = Post.all.last
      log_in @user2
      click_link "My Timeline"

      within(".user_post") do
        click_button "like"
      end

      expect(p.get_likes.size).to eq(1)

      within(".user_post") do
        click_button "unlike"
      end

      expect(p.get_likes.size).to eq(0)

    end

    it "allows a user to dislike posts" do

      p = Post.all.last
      log_in @user2
      click_link "My Timeline"

      within(".user_post") do
        click_button "dislike"
      end

      expect(p.get_dislikes.size).to eq(1)
    end

    it "allows a user to undislike a post" do
        p = Post.all.last
        log_in @user2
        click_link "My Timeline"

        within(".user_post") do
          click_button "dislike"
        end

        expect(p.get_dislikes.size).to eq(1)

        within(".user_post") do
          click_button "undislike"
        end

        expect(p.get_dislikes.size).to eq(0)
    end
  end
end
