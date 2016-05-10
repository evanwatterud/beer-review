require 'rails_helper'

feature 'user adds a review to a beer' do
  scenario 'authenticated user adds a review to a beer' do
    user = log_in
    beer = FactoryGirl.create(:beer)
    visit beer_path(beer)

    fill_in "review_body", with: 'something'
    click_button 'Add Review'

    expect(current_path).to eq(beer_path(beer))
    expect(page).to have_button('Add Review')
    expect(beer.reviews.length).to eq(1)
  end
end
