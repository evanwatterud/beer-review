require 'rails_helper'

feature 'user signs up' do
  scenario 'user supplies all info correctly' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'First Name', with: 'Evan'
    fill_in 'Last Name', with: 'Watterud'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_link("Sign Out")
  end

  scenario "user doesn't supply all info correctly" do
    visit root_path
    click_link 'Sign Up'
    click_button 'Sign Up'

    expect(page).to have_content("can't be blank")
    expect(page).to have_button("Sign Up")
    expect(page).to_not have_content("Sign Out")
  end

  scenario 'password and password confirmation not matching' do
    visit root_path
    click_link 'Sign Up'

    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'notpassword'
    click_button 'Sign Up'

    expect(page).to have_content("doesn't match")
    expect(page).to have_button("Sign Up")
    expect(page).to_not have_content("Sign Out")
  end
end
