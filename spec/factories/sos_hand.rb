FactoryBot.define do
  factory :sos_hand do
    name { Faker::Name.name}
    address { Faker::Address.street_address}
    phone { Faker::PhoneNumber.phone_number }
  end
end