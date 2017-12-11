module UserMacros

  def register(user)
    visit root_path
    click_link "Sign Up"
    fill_in "Name", with: user.name 
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    click_button "Sign up"
  end

  def log_in(user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

  def log_out(user)
    visit user_path(user)
    click_link "Log Out"
  end

  def send_friend_request(sending_friend, receiving_friend)
    log_in(sending_friend)
    visit(user_profile_path(receiving_friend))
    click_link "Send Friend Request"
    log_out sending_friend
  end

  def create_friendship(user, friend) 
    send_friend_request(user, friend)
    log_in(friend)
    visit friend_requests_path
    click_link "Accept"
    log_out(friend)
  end


end
