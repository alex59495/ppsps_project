FactoryBot.define do
  factory :hospital do
    name { Faker::Name.name}
    address { Faker::Address.street_address}
    phone { Faker::PhoneNumber.phone_number }
  end
end