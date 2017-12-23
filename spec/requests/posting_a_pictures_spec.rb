require 'rails_helper'

describe "PostingAPictures", type: :request do
  
  let(:user) { create :user }

  it "lets a user post upload a picture" do
    log_in user
    find(:xpath, "//a[@href='/posts/new']").click
    expect(current_path).to eq(new_post_path)

    # Invalid (blank) post
    click_button "Post!"
    expect(page).to have_css("div.alert.alert-error") 

    fill_in "Content", with: "This is a test post!"
    attach_file("post[picture]",'test/fixtures/seven_sisters.jpg')

    click_button "Post!"
    expect(current_path).to eq(posts_path)

  end

  
end
