require 'rails_helper'

feature 'user views beers' do
  before(:each) do
    log_in
    @beers = FactoryGirl.create_list(:beer, 3)
  end

  scenario 'authenticated user views all beers' do
    click_link 'Beers'

    expect_page_to_have('Beers', @beers.first.name, @beers.last.name)
  end

  scenario 'user searches for beers' do
    FactoryGirl.create(:beer, name: 'Bud Light')
    fill_in 'search_query', with: 'Bud Light'
    click_button 'Search'

    expect(page).to have_content('Bud Light')
    expect(page).to_not have_content(@beers.first.name)
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

    expect_page_to_have('Beers', @beers.first.name, @beers.last.name)
  end

  scenario 'unregistered user views all beers' do
    User.delete_all
    click_link 'Beers'

    expect_page_to_have('Beers', @beers.first.name, @beers.last.name)
  end
end
