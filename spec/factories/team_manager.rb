FactoryBot.define do
  factory :team_manager do
    name { Faker::Name.name}
    phone { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
  end
end