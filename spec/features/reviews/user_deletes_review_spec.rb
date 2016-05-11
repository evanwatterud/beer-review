require 'rails_helper'

feature 'user deletes a review' do
  before(:each) do
    @user = log_in
    @beer = FactoryGirl.create(:beer)
    @review = FactoryGirl.create(:review, beer: @beer, user: @user)
  end

  scenario 'authenticated user deletes a review they created' do
    visit beer_path(@beer)

    within '.review_links' do
      click_link 'Delete'
    end

    expect(current_path).to eq(beer_path(@beer))
    expect(page).to_not have_css('.user_review')
    expect(page).to have_content('Successfully deleted review.')
  end

  scenario 'authenticated user cannot delete reviews they did not create' do
    click_link 'Sign Out'
    user = log_in
    visit beer_path(@beer)

    within '.user_review' do
      expect(page).to_not have_link('Delete')
    end

    page.driver.submit :delete, beer_review_path(@beer, @review), {}
    expect(current_path).to eq(root_path)
  end

  scenario 'unauthenticated user cannot delete reviews' do
    click_link 'Sign Out'
    visit beer_path(@beer)

    within '.user_review' do
      expect(page).to_not have_link('Delete')
    end

    page.driver.submit :delete, beer_review_path(@beer, @review), {}
    expect(current_path).to eq('/users/sign_in')
    expect(page).to have_content('You must be logged in to do that.')
  end
end
