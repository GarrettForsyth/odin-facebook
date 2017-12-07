require 'rails_helper'

describe "PasswordResets", type: :request do
  it "emails user when requesting password reset" do
    # try to use build first, since create will save to the test db
    user = create(:user)
    visit new_user_session_path
    click_link "password"
    fill_in "Email", with: user.email
    click_button "reset password"
    
    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content("You will receive an email")
    expect(last_email.to_s).to include(user.email)
  end

  it "does not email invalid user when requesting password reset" do
    visit new_user_session_path
    click_link "password"
    fill_in "Email", with: "invalid@email.com"
    click_button "reset password"
    
    expect(current_path).to eq(user_password_path)
    expect(last_email).to be_nil
  end

end
