require 'rails_helper'

feature 'user views the beers they have added' do
  scenario 'authenticated user views beers they added' do
    user = log_in
    user2 = FactoryGirl.create(:user)

    beer1, beer2, beer3 = FactoryGirl.create(:beer, user_id: user.id), FactoryGirl.create(:beer, user_id: user.id), FactoryGirl.create(:beer, user_id: user2.id)
    pagination_beers = FactoryGirl.create_list(:beer, 2, user_id: user.id)

    click_link 'Your Beers'

    expect_page_to_have(beer1.name, beer2.name, 'Your Beers')
    expect(page).to_not have_content(beer3.name)

    click_link '2', match: :first

    expect(page).to have_content(pagination_beers.last.name)
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

  scenario 'authenticated user tries to view beers that they did not create' do
    user = log_in
    beer = FactoryGirl.create(:beer, user_id: user.id)
    click_link 'Sign Out'
    user2 = log_in

    visit user_beers_path(user.id)
    expect(current_path).to eq(root_path)
  end
end
