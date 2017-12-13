require 'rails_helper'

describe "UserCommentsOnAPosts", type: :request do
  context "a user with a friend creates a post" do
    
    before(:each) do
      @user = create :user
      @user2 = create :user
      create_friendship(@user, @user2)
      create_post_from @user
    end

    it "the friend can comment on the post" do
      log_in @user2
      click_link "My Timeline"

      expect(Post.last.comments.size).to eq(0)
      
      within(".user-post") do
        click_button "Comment"
      end

      expect(current_path).to eq(new_comment_path)

      fill_in "Content", with: "This is a comment"
      click_button "Create Comment"

      expect(current_path).to eq(posts_path)

      expect(Post.last.comments.size).to eq(1)
      expect(Post.last.comments.last.content).to eq("This is a comment")
      expect(page).to have_content("This is a comment")

     end
  end
end
