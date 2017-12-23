require 'rails_helper'

describe "UserCreatesPosts", type: :request do

  let(:user) { create :user }

  it "creates a new post object" do
    log_in user
    click_link "Create New Post"
    
    expect(current_path).to eq(new_post_path)
    expect(user.posts.size).to eq(0)


    fill_in "Content", with:  "My first post!"
    click_button "Post!"

    
    expect(current_path).to eq(posts_path)

    expect(Post.last.content).to eq("My first post!")
    expect(Post.last.author_id).to eq(user.id)
    expect(Post.all.size).to eq(1)

  end
end
