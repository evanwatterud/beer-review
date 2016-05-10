require 'rails_helper'

feature 'user updates a review' do
  before(:each) do
    @user = log_in
    @beer = FactoryGirl.create(:beer)
  end

  scenario 'authenticated user updates a review they created' do
    review = FactoryGirl.create(:review, beer: @beer, user: @user)
    visit beer_path(@beer)

    within('.user_review') do
      click_link 'Edit'
    end
    fill_in 'review_body', with: 'Updated review'
    click_button 'Save Edits'

    expect(current_path).to eq(beer_path(@beer))
    within('.user_review') do
      expect(page).to have_content('Updated review')
    end
  end

  scenario 'authenticated user can not update reviews they did not create' do
    user = FactoryGirl.create(:user)
    review = FactoryGirl.create(:review, beer: @beer, user: user)
    visit beer_path(@beer)

    within('.user_review') do
      expect(page).to_not have_link('Edit')
    end

    page.driver.submit :patch, beer_review_path(@beer, review), {}
    expect(current_path).to eq(root_path)

    visit edit_beer_review_path(@beer, review)
    expect(current_path).to eq(root_path)
  end

  scenario 'unathenticated user can not update reviews' do
    review = FactoryGirl.create(:review, beer: @beer, user: @user)
    click_link 'Sign Out'
    visit beer_path(@beer)

    within('.user_review') do
      expect(page).to_not have_link('Edit')
    end

    page.driver.submit :patch, beer_review_path(@beer, review), {}
    expect(current_path).to eq('/users/sign_in')
    expect(page).to have_content('You must be logged in to do that.')

    visit edit_beer_review_path(@beer, review)
    expect(current_path).to eq('/users/sign_in')
    expect(page).to have_content('You must be logged in to do that.')
  end
end
