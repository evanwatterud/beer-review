require 'rails_helper'

feature 'user signs in' do
  scenario 'user supplies correct information' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    expect(page).to have_content("Signed in successfully.")
    expect(page).to_not have_content("Sign In")
    expect(page).to have_content("Sign Out")
  end

  scenario 'user supplies wrong email and password' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: 'something@nothing.com'
    fill_in 'Password', with: 'doesnotexist'
    click_button 'Log In'

    expect(page).to have_content('Invalid email or password')
    expect(page).to_not have_content('Signed in successfully.')
    expect(page).to have_link('Sign In')
    expect(page).to_not have_link('Sign Out')
  end

  scenario 'user supplies correct email but wrong password' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Log In'

    expect(page).to have_content('Invalid email or password')
    expect(page).to_not have_content('Signed in successfully.')
    expect(page).to have_link('Sign In')
    expect(page).to_not have_link('Sign Out')
  end

  scenario 'already signed in user cannot sign in' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    expect(page).to_not have_content("Sign In")
    expect(page).to have_content("Sign Out")

    visit new_user_session_path

    expect(page).to have_content("You are already signed in.")
    expect(page).to have_content("Welcome")
  end
end
