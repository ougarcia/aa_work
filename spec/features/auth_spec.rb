require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      fill_in 'username', :with => "testing_username"
      fill_in 'password', :with => "password123"
      click_on "Create User"
      expect(page).to have_content ("testing_username")
    end

  end

end

feature "logging in" do

  it "has a login page" do
    visit new_session_url
    expect(page).to have_content "Log In"
  end

  it "shows username on the homepage after login" do
    fill_in 'username', :with => "testing_username"
    fill_in 'password', :with => "password123"
    click_on "Log In"
    expect(page).to have_content ("testing_username")
  end
end

feature "logging out" do

  it "begins with logged out state" do
    visit goals_url
    expect(page).to have_content ("Log In")
  end

  it "doesn't show username on the homepage after logout" do
    visit root_url
    user = create(:user)
    log_in(user)
    click_on "Sign Out"
    expect(page).to_not have_content(user.username)
  end
end
