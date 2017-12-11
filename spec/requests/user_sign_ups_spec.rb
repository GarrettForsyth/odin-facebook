require 'rails_helper'

describe "UserSignUps", type: :request do

  it "emails the user when creating a new account" do
    user = build(:user)
    register(user)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("sent to your email address.")
    expect(last_email.to_s).to include(user.email)
  end

  it "does not email an invalid registartion during sign up" do
    user = FactoryBot.create(:user)
    reset_emails
    visit root_path
    click_link "Sign Up"
    fill_in "Name", with: "Foobar"
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(current_path).to eq(user_registration_path)
    expect(page).to have_content("Email has already been taken")
    expect(last_email).to be_nil

  end
  
end
