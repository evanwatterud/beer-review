require 'rails_helper'

feature 'user views beers' do

  scenario 'authenticated user views all beers' do
    log_in
    beers = FactoryGirl.create_list(:beer, 25)
    click_link 'Beers'

    expect_page_to_have('All Beers', beers.first.name, beers.last.name)
  end

  scenario 'unauthenticated user views all beers' do
    log_in
    beers = FactoryGirl.create_list(:beer, 25)
    click_link 'Sign Out'
    click_link 'Beers'

    expect_page_to_have('All Beers', beers.first.name, beers.last.name)
  end

  scenario 'unregistered user views all beers' do
    log_in
    beers = FactoryGirl.create_list(:beer, 25)
    User.delete_all
    click_link 'Beers'

    expect_page_to_have('All Beers', beers.first.name, beers.last.name)
  end

  def log_in
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'
  end

  def expect_page_to_have(*args)
    args.each do |arg|
      expect(page).to have_content(arg)
    end
  end
end
