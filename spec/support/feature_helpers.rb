module FeatureHelpers
  def log_in
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'
  end

  def expect_page_to_have(*args)
    args.each do |arg|
      expect(page).to have_content(arg)
    end
  end
end

RSpec.configure do |c|
  c.include FeatureHelpers
end
