require 'rails_helper'

feature 'user views beer details' do
  scenario 'user views beer details from all beers page' do
    beer = FactoryGirl.create(:beer)

    visit root_path
    click_link 'Beers'
    click_link beer.name

    expect_page_to_have(beer.name, beer.brewer, beer.abv, beer.brewing_country, beer.style)
  end

  scenario 'authenticated user views beer details from their beers page' do
    user = log_in
    beer = FactoryGirl.create(:beer, user_id: user.id)

    click_link 'Your Beers'
    click_link beer.name

    expect_page_to_have(beer.name, beer.brewer, beer.abv, beer.brewing_country, beer.style)
  end
end
