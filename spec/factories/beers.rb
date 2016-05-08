FactoryGirl.define do
  factory :beer do
    user_id 1
    sequence(:name) { |n| "#{n}beer" }
    brewer "Some brewer"
    style "Some style"
    brewing_country "Norway"
    abv 4.5
  end
end
