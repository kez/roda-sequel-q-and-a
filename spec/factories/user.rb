FactoryBot.define do
  factory :user do
    sequence(:id)
    handle { Faker::Internet.username }
    email  { Faker::Internet.email }
  end
end
