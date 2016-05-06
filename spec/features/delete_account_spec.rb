require 'rails_helper'

feature 'user deletes account' do
  scenario 'signed in user deletes account' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    click_link 'Delete Account'

    expect(page).to have_content('Account deleted successfully.')
    expect(current_path).to eq(root_path)
    expect(page).to_not have_content('Sign Out')

    users = User.all
    expect(users).to eq([])
  end

  scenario 'user not signed in tries to delete account' do
    user = FactoryGirl.create(:user)
    visit root_path

    expect(page).to_not have_content('Delete Account')
  end
end
