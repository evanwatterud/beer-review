require 'rails_helper'

feature 'user views the beers they have added' do
  scenario 'authenticated user views beers they added' do
    user = log_in
    user2 = FactoryGirl.create(:user)

    beer1, beer2, beer3 = FactoryGirl.create(:beer, user_id: user.id), FactoryGirl.create(:beer, user_id: user.id), FactoryGirl.create(:beer, user_id: user2.id)

    click_link 'Your Beers'

    expect_page_to_have(beer1.name, beer2.name, 'Your Beers')
    expect(page).to_not have_content(beer3.name)
  end

  scenario 'authenticated user views page when they have not added beers' do
    user = log_in

    click_link 'Your Beers'

    expect(page).to have_content("You haven't added any beers yet!")
  end

  scenario 'unauthenticated user tries to view created beers page' do
    visit root_path

    expect(page).to_not have_content('Your Beers')

    visit user_beers_path(1)

    expect(page).to have_button('Log In')
    expect(page).to have_content('You must be logged in to do that.')
  end

  def expect_page_to_have(*args)
    args.each do |arg|
      expect(page).to have_content(arg)
    end
  end

  def log_in
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'
    return user
  end
end
