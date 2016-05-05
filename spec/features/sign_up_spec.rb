require 'spec_helper'

feature 'user signs up' do
  scenario 'user supplies all info correctly' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'First Name', with: 'Evan'
    fill_in 'Last Name', with: 'Watterud'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content("Sign up successful.")
    expect(page).to have_link("Sign Out")
  end

  scenario "user doesn't supply all info correctly" do
    visit root_path
    click_link 'Sign Up'
    click_button 'Sign Up'

    expect(page).to have_content("Can't be blank")
    expect(page).to have_button("Sign Up")
    expect(page).to_not have_content("Sign Out")
  end

  scenario 'password and password confirmation not matching' do
    visit root_path
    click_link 'Sign Up'
    click_button 'Sign Up'

    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'notPassword'

    expect(page).to have_content("Doesn't match")
    expect(page).to have_button("Sign Up")
    expect(page).to_not have_content("Sign Out")
  end
end
