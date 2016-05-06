require 'rails_helper'

feature 'user signs out' do
  scenario 'user clicks sign out link' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    click_link 'Sign Out'

    expect(page).to have_content('Sign In')
    expect(page).to have_content('Sign Up')
    expect(page).to_not have_content('Sign Out')
    expect(page).to have_content('Welcome')
    expect(page).to have_content('Signed out successfully.')
  end
end
