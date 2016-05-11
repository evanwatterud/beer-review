FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    role 'member'
    first_name 'Alexander'
    last_name 'Anderson'
    password 'alucard'
    password_confirmation 'alucard'
  end
end
