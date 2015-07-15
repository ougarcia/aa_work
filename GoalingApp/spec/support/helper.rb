module Helper
  def login(user)
    visit new_session_url
    fill_in 'username', :with => user.username
    fill_in 'password', :with => user.password
    click_on "Log In"
  end

  def logout
    click_button "Log Out"
  end
end
