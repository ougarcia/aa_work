require 'rails_helper'

feature "goals" do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user)}
  let!(:goal) { create(:goal, user_id: user1.id, objective: "write a memoir")}
  let!(:goal2) { create(:goal, user_id: user2.id, objective: "User Two's goal!") }

  feature "creating a goal" do

    before(:each) do
      login(user1)
      visit new_goal_url
    end

    it "has a new goal page" do
      expect(page).to have_content("New Goal")
    end

    it "shows up on user show page" do
      fill_in 'objective', with: "write another memoir"
      click_button 'Add Goal'
      expect(page).to have_content("write another memoir")
    end

  end

  feature "viewing a goal" do
    it "shows the goal show page" do
      login(user1)
      visit goal_url(goal)
      expect(page).to have_content("write a memoir")
    end
  end

  feature "user profile" do
    before(:each) do
      login(user1)
      visit user_url(user1)
    end

    it "displays user's goals" do
      expect(page).to have_content("write a memoir")
    end

    it "does not display other users' goals" do
      expect(page).to_not have_content("User Two's goal!")
    end

    it "has link to create new goal" do
      expect(page).to have_content("New Goal")
    end
  end


  feature "completing a goal" do
    it "shows updated goal on user show page" do
      login(user1)
      visit goal_url(goal)
      click_button "Mark Completed"
      expect(page).to have_content("Completed")
    end
  end

  feature "switching between public/private" do
    before(:each) do
      login(user1)
      visit goal_url(goal)
    end

    it "goes from public to private" do
      choose("Make Private")
      click_button "Update Privacy"
      expect(page).to have_content("Private")
    end

    it "goes from private to public" do
      choose "Make Public"
      click_button "Update Privacy"
      expect(page).to have_content("Public")
    end
  end

  feature "goals index" do
    before(:each) do
      login(user1)
    end

    it "displays multiple users' goals" do
      visit goals_url
      expect(page).to have_content("write a memoir")
      expect(page).to have_content("User Two's goal!")
    end

    it "does not display private goals" do
      goal_private = create(:goal, publicized: false, user_id: user1.id)
      visit goals_url
      expect(page).to_not have_content(goal_private.objective)
    end

    it "redirects if logged out" do
      logout
      visit goals_url
      expect(current_url).to eq(root_url)
    end

  end
end
