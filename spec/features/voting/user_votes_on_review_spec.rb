require 'rails_helper'

feature 'user votes on a review' do
  before(:each) do
    @user = log_in
    @beer = FactoryGirl.create(:beer)
    @review = FactoryGirl.create(:review, beer: @beer, user: @user)
  end

  scenario 'authenticated user upvotes a review' do
    visit beer_path(@beer)
    within('.user_review') do
      expect(page).to have_content(0)
    end

    click_link 'Upvote'

    within('.user_review') do
      expect(page).to have_content(1)
    end
  end
  scenario 'authenticated user downvotes a review'
  scenario 'authenticated user changes their vote'
  scenario 'authenticated user tries to vote twice on a review'
  scenario 'unauthenticated user tries to vote on a review'
end
