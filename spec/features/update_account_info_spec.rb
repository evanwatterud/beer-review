require 'rails_helper'

feature 'update account details' do
  background do
    user = FactoryGirl.create(:user)
    visit root_path
    sign_in(user.email, user.password)

    click_link 'Update Account Info'
  end

  scenario 'user updates account details with correct information and password' do
    fill_in 'First Name', with: 'Evan'
    fill_in 'Last Name', with: 'Watterud'
    fill_in 'Email', with: 'different@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    fill_in 'Current Password', with: 'alucard'
    click_button 'Update'

    updated_user_values = User.first.attributes.values
    expect(page).to have_content("Your account has been updated successfully.")
    expect(updated_user_values[0..3]).to include('Evan', 'Watterud', 'different@example.com')
    expect(current_path).to eq(root_path)

    click_link 'Sign Out'
    sign_in('different@example.com', 'password')
    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'user decides to go back' do
    click_link 'Back'

    expect(current_path).to eq(root_path)
  end

  scenario 'user tries to supply invalid information' do
    fill_in 'First Name', with: ""
    fill_in 'Current Password', with: 'alucard'
    click_button 'Update'

    expect(page).to have_content("can't be blank")
    expect(page).to have_button('Update')
  end

  scenario 'signed out user tries to access update info page' do
    click_link 'Sign Out'
    visit edit_user_registration_path

    expect(page).to have_content("You must be logged in to do that.")
  end

  def sign_in(email, password)
    click_link 'Sign In'
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log In'
  end
end
