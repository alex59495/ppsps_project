FactoryBot.define do
  factory :security_coordinator do
    name { Faker::Name.name}
    address { Faker::Address.street_address}
    representative { Faker::Name.name }
    phone { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
  end
end