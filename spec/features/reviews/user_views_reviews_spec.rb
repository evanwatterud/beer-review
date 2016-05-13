require 'rails_helper'

feature 'user views reviews for a beer' do
  before(:each) do
    @user = log_in
    @beer = FactoryGirl.create(:beer)
    @reviews = FactoryGirl.create_list(:review, 3, beer: @beer, user: @user)
  end

  scenario 'authenticated user views reviews for a beer' do
    visit beer_path(@beer)

    expect_page_to_have(@user.first_name, @user.last_name)
    @reviews.each do |review|
      expect(page).to have_content(review.body)
    end
  end

  scenario 'authenticated user can navigate reviews with pagination' do
    pagination_review = FactoryGirl.create(:review, beer: @beer, user: @user)
    visit beer_path(@beer)

    click_link '2', match: :first

    expect(page).to have_content(pagination_review.body)
  end

  scenario 'unauthenticated user views reviews for a beer' do
    click_link 'Sign Out'
    visit beer_path(@beer)

    expect_page_to_have(@user.first_name, @user.last_name)
    @reviews.each do |review|
      expect(page).to have_content(review.body)
    end
  end
end
