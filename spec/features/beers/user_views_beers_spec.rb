require 'rails_helper'

feature 'user views beers' do
  before(:each) do
    log_in
    @beers = FactoryGirl.create_list(:beer, 3)
  end

  scenario 'authenticated user views all beers' do
    click_link 'Beers'

    expect_page_to_have('All Beers', @beers.first.name, @beers.last.name)
  end

  scenario 'authenticated user can navigate with pagination' do
    more_beer = FactoryGirl.create(:beer)
    click_link 'Beers'

    click_link '2', match: :first
    expect(page).to have_content(more_beer.name)
  end

  scenario 'unauthenticated user views all beers' do
    click_link 'Sign Out'
    click_link 'Beers'

    expect_page_to_have('All Beers', @beers.first.name, @beers.last.name)
  end

  scenario 'unregistered user views all beers' do
    User.delete_all
    click_link 'Beers'

    expect_page_to_have('All Beers', @beers.first.name, @beers.last.name)
  end
end
