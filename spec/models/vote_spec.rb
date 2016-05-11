require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should have_valid(:value).when(1, -1) }
  it { should_not have_valid(:value).when(nil, '', 'text', 0.3, 0, 32, -34) }

  it { should have_valid(:user_id).when(1) }
  it { should_not have_valid(:user_id).when(nil, '', 'text') }

  it { should have_valid(:review_id).when(1) }
  it { should_not have_valid(:review_id).when(nil, '', 'text') }

  describe 'user/review pairs' do
    vote1 = FactoryGirl.build(:vote)
    vote2 = FactoryGirl.build(:vote)
    it 'should be unique' do
      expect(vote2).to_not be_valid
    end
  end
end
