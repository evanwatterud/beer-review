require 'rails_helper'

feature 'admin views list of users' do
  scenario 'admin views all users page' do
    admin = log_in('admin')
    users = FactoryGirl.create_list(:user, 2)
    click_link 'All Users'

    expect(page).to have_content('All Users')
    within(".members") do
      expect_page_to_have(users.first.first_name, users.first.last_name, users.last.last_name, users.last.first_name)
    end
    within(".admins") do
      expect_page_to_have(admin.first_name, admin.last_name)
    end
  end

  scenario 'authenticated user that is not an admin tries to view list of users' do
    user = log_in
    expect(page).to_not have_link('All Users')

    expect{ visit admin_users_path }.to raise_error(ActionController::RoutingError)
  end

  scenario 'unauthenticated user tries to view list of users' do
    visit root_path
    expect(page).to_not have_link('All Users')

    expect{ visit admin_users_path }.to raise_error(ActionController::RoutingError)
  end
end
