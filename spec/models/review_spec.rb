require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should have_valid(:body).when('something', '23fsfsdf more text') }
  it { should_not have_valid(:body).when(nil, '') }

  it { should have_valid(:user_id).when(1) }
  it { should_not have_valid(:user_id).when(nil, '', 'text') }

  it { should have_valid(:beer_id).when(1) }
  it { should_not have_valid(:beer_id).when(nil, '', 'text') }
end
