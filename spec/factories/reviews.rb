FactoryGirl.define do
  factory :review do
    sequence(:body) { |n| "best beer ever #{n}" }
    user_id 1
    beer_id 1
  end
end
