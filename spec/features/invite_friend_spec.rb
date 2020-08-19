require 'rails_helper'

  describe "the signin process", :type => :feature do
    before :each do
      User.create(email: 'user1@gmail.com', password: 'password', name: 'User1')
      visit '/users/sign_in'
      fill_in 'Email', :with => 'user1@gmail.com'
      fill_in 'Password', :with => 'password'
      click_button 'Log in'
    end
  
    it "signs @user in" do
        visit users_path
        expect(page).to have_text('User1') 
        expect(page).to have_link('See Profile')
    end

    it "does not sign in with wrong info" do
        visit '/users/sign_in'
        fill_in 'Email', :with => 'user1@gmail.com'
        fill_in 'Password', :with => 'mypassword'
        click_button 'Log in'
        expect(page).to have_text('Invalid Email or password.')
    end

  end