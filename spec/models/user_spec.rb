require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_valid(:first_name).when('Evan', 'Negan') }
  it { should_not have_valid(:first_name).when(nil, '') }

  it { should have_valid(:last_name).when('Smith', 'Watterud') }
  it { should_not have_valid(:last_name).when(nil, '') }

  it { should have_valid(:email).when('blah@gmail.com', 'some.user@example.com') }
  it { should_not have_valid(:email).when(nil, '', 'blah.com', 'sdfs@something', 'evan') }

  it 'has a matching password and password confirmation' do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'differentpassword'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end
end
