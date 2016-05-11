require 'rails_helper'

feature 'user votes on a review' do
  before(:each) do
    @user = log_in
    @beer = FactoryGirl.create(:beer)
    @review = FactoryGirl.create(:review, beer: @beer, user: @user)
  end

  scenario 'authenticated user upvotes a review' do
    visit beer_path(@beer)
    within('.review_votes') do
      expect(page).to have_content(0)
    end

    click_link 'Upvote'

    within('.review_votes') do
      expect(page).to have_content(1)
    end
  end

  scenario 'authenticated user downvotes a review' do
    visit beer_path(@beer)

    click_link 'Downvote'

    within('.review_votes') do
      expect(page).to have_content(-1)
    end
  end

  scenario 'authenticated user changes their vote' do
    visit beer_path(@beer)

    click_link 'Downvote'

    within('.review_votes') do
      expect(page).to have_content(-1)
    end

    click_link 'Upvote'

    within('.review_votes') do
      expect(page).to have_content(1)
    end
  end

  scenario 'authenticated user deletes their review' do
    visit beer_path(@beer)

    click_link 'Downvote'
    click_link 'Downvote'

    within('.review_votes') do
      expect(page).to have_content(0)
    end
  end

  scenario 'unauthenticated user tries to vote on a review' do
    click_link 'Sign Out'
    visit beer_path(@beer)

    click_link 'Upvote'

    expect(current_path).to eq('/users/sign_in')
    expect(page).to have_content('You must be logged in to do that.')

    visit root_path
    page.driver.submit :post, upvote_review_path(@review), {}

    expect(current_path).to eq('/users/sign_in')
    expect(page).to have_content('You must be logged in to do that.')
  end
end
