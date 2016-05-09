require 'rails_helper'

feature 'update the information of a beer' do
  scenario 'authenticated user updates beer information with valid information' do
    user = log_in
    beer = FactoryGirl.create(:beer, user_id: user.id)
    click_link 'Your Beers'
    click_button 'Update'
    expect(page).to have_content('Update Beer')

    fill_in 'Beer Name', with: 'Some Beer'
    fill_in 'Brewer', with: 'Beer Brewer'
    fill_in 'Style', with: 'Dark'
    select 'Norway', from: 'Brewing Country'
    fill_in 'Alcohol by Volume', with: 3.4
    click_button 'Update'

    expect(current_path).to eq(user_beers_path(user.id))
    expect_page_to_have('Successfully updated beer.', 'Some Beer')
  end

  scenario 'authenticated user tries to update beer with invalid information' do
    user = log_in
    beer = FactoryGirl.create(:beer, user_id: user.id)
    click_link 'Your Beers'
    click_button 'Update'

    click_button 'Update'

    expect_page_to_have("can't be blank", 'Update')
  end

  scenario 'authenticated user tries to update beer to be the same as existing beer' do
    user = log_in
    beer = FactoryGirl.create(:beer, user_id: user.id)
    other_beer = FactoryGirl.create(:beer)
    click_link 'Your Beers'
    click_button 'Update'

    fill_in 'Beer Name', with: other_beer.name
    fill_in 'Brewer', with: other_beer.brewer
    fill_in 'Style', with: other_beer.style
    select other_beer.brewing_country, from: 'Brewing Country'
    fill_in 'Alcohol by Volume', with: other_beer.abv
    click_button 'Update'

    expect_page_to_have("A beer with that name has already been added!", 'Update')
  end

  scenario 'authenticated user tries to edit beer that they did not create' do
    user = log_in
    beer = FactoryGirl.create(:beer, user_id: user.id)
    click_link 'Sign Out'
    user2 = log_in

    visit edit_beer_path(beer.id)
    expect(current_path).to eq(root_path)
  end
end
