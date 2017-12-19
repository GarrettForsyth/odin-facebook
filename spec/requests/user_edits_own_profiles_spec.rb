require 'rails_helper'

describe "UserEditsOwnProfiles", type: :request do

  let(:user) { create :user }

  context "the user visit's his profile page" do

    before(:each) do
      log_in user
    end

    it "directs you to the profile page on log in" do
      expect(current_path).to eq(profile_path)
    end

    it "contains a div for contact information" do
     
      expect(page).to have_xpath(
        "//div[contains(.,'Address: #{user.profile.address}')]") 

      expect(page).to have_xpath(
        "//div[contains(.,'Phone: #{user.profile.phone}')]") 

    end


    it "contains a div for the  about me section" do
      expect(page).to have_xpath(
        "//div[contains(.,'#{user.profile.about_me}')]") 
    end

    it "contains a link to edit the page" do
      click_link "Edit My Profile"
      expect(current_path).to eq(edit_profile_path)
    end

    it "contains a gravatar image for the user" do
    end

    it "contains the user's name" do 
      expect(page).to have_xpath(
        "//div[contains(.,'#{user.name}')]") 
    end

    it "should display the users friends" do
      log_out user
      friend = create :user
      create_friendship(user, friend)
      log_in user
      within('.my_friends') do
        expect(page).to have_content(friend.name)
      end

    end
  end
end
