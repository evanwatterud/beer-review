require 'rails_helper'

feature 'user adds beer' do
  background do
    visit root_path
  end

  scenario 'authenticated user adds a beer not already in database' do
    user = FactoryGirl.create(:user)
    sign_in(user.email, user.password)
    click_link 'Add Beer'
    add_beer

    expect(page).to have_content("Successfully added Some Beer.")
    beer = Beer.all.first
    expect(beer.name).to eq('Some Beer')
    expect(current_path).to eq(beer_path(beer.id))

    expect_page_to_have('Some Beer', 'Some Beer', 'Beer Brewer', 'Dark', 'Brewing Country', '3.4%')
  end

  scenario 'authenticated user tries to add a beer that is already in database' do
    user = FactoryGirl.create(:user)
    sign_in(user.email, user.password)
    click_link 'Add Beer'
    add_beer
    click_link 'Add Beer'
    add_beer

    expect_page_to_have('A beer with that name has already been added!')
    expect(page).to have_button('Add Beer')
  end

  scenario 'authenticated user tries to add beer with incomplete information' do
    user = FactoryGirl.create(:user)
    sign_in(user.email, user.password)
    click_link 'Add Beer'
    fill_in 'Alcohol by Volume', with: 120.3
    click_button 'Add Beer'

    expect_page_to_have("can't be blank", 'New Beer', "can't be greater than 100%!")
    expect(page).to have_content("can't be blank")
    expect(page).to have_content("New Beer")
    expect(Beer.all).to eq([])

    click_link 'Add Beer'
    fill_in 'Alcohol by Volume', with: -3.4
    click_button 'Add Beer'

    expect(page).to have_content("can't be less than 0%!")
  end

  scenario 'unauthenticated user tries to add a beer' do
    user = FactoryGirl.create(:user)
    click_link 'Add Beer'

    expect_page_to_have('Log In', 'You must be logged in to do that.')
  end

  scenario 'unregistered user tries to add a beer' do
    click_link 'Add Beer'

    expect_page_to_have('Log In', 'You must be logged in to do that.')
  end

  def expect_page_to_have(*args)
    args.each do |arg|
      expect(page).to have_content(arg)
    end
  end

  def add_beer
    fill_in 'Beer Name', with: 'Some Beer'
    fill_in 'Brewer', with: 'Beer Brewer'
    fill_in 'Style', with: 'Dark'
    select 'Norway', from: 'Brewing Country'
    fill_in 'Alcohol by Volume', with: 3.4
    click_button 'Add Beer'
  end

  def sign_in(email, password)
    click_link 'Sign In'
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log In'
  end
end
