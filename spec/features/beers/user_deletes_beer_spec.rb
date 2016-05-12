require 'rails_helper'

feature 'user deletes beer' do
  scenario 'authenticated user deletes beer they created' do
    user = log_in
    beer = FactoryGirl.create(:beer, user: user)
    click_link 'Your Beers'

    within ".show-#{beer.name}" do
      click_button 'Delete'
    end

    expect(page).to have_content('Successfully deleted beer.')
    expect(current_path).to eq(user_beers_path(user.id))
    expect(page).to_not have_content(beer.name)
    expect(Beer.all).to eq([])
  end

  scenario 'authenticated user tries to delete beer they did not create' do
    user = log_in
    beer = FactoryGirl.create(:beer)
    page.driver.submit :delete, beer_path(beer), {}

    expect(current_path).to eq(root_path)
    expect(Beer.all.length).to eq(1)
  end

  scenario 'admin deletes a beer' do
    admin = log_in('admin')
    beer = FactoryGirl.create(:beer)
    click_link 'Beers'

    click_button 'Delete'

    expect(page).to have_content('Successfully deleted beer.')
    expect(page).to_not have_content(beer.name)
    expect(Beer.all).to eq([])
  end
end
