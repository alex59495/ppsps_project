FactoryBot.define do
  factory :moe do
    name { Faker::Name.name}
    address { Faker::Address.street_address}
    representative { Faker::Name.name }
    phone { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
  end
end