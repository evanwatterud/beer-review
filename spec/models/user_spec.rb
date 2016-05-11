require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_valid(:first_name).when('Evan', 'Negan') }
  it { should_not have_valid(:first_name).when(nil, '') }

  it { should have_valid(:last_name).when('Smith', 'Watterud') }
  it { should_not have_valid(:last_name).when(nil, '') }

  it { should have_valid(:email).when('blah@gmail.com', 'some.user@example.com') }
  it { should_not have_valid(:email).when(nil, '', 'blah.com', 'evan') }

  it { should have_valid(:role).when('admin', 'member') }
  it { should_not have_valid(:role).when(nil, '', 'something', 23)}

  it 'has a matching password and password confirmation' do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'differentpassword'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end

  describe "#admin?" do
    it 'returns false when the role is not admin' do
      user = FactoryGirl.create(:user)
      expect(user.admin?).to eq(false)
    end

    it 'returns true when the role is admin' do
      user = FactoryGirl.create(:user, role: 'admin')
      expect(user.admin?).to eq(true)
    end
  end
end
