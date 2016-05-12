require 'rails_helper'

feature 'admin deletes users' do
  before(:each) do
    @admin = log_in('admin')
  end

  scenario 'admin successfully deletes users through admin section' do
    FactoryGirl.create_list(:user, 2)
    click_link('All Users')
    within(".members") do
      click_button('Delete', match: :first)
    end

    expect(User.all.length).to eq(2)
    expect(page).to have_content('Successfully deleted user.')

    within(".members") do
      click_button('Delete')
    end

    expect(User.all.length).to eq(1)
  end

  scenario 'admin tries to delete another admin' do
    admin2 = FactoryGirl.create(:user, role: 'admin')
    click_link('All Users')
    within(".admins") do
      expect(page).to_not have_button('Delete')
    end

    page.driver.submit :delete, admin_user_path(admin2), {}
    expect(page).to have_content("You can't delete other admins!")
    expect(User.all.length).to eq(2)
  end

  scenario 'admin tries to delete his own account' do
    visit admin_users_path
    page.driver.submit :delete, admin_user_path(@admin), {}
    expect(page).to have_content("You can't delete yourself!")
  end
end
