FactoryBot.define do
  factory :regional_committee do
    name { Faker::Name.name}
    address { Faker::Address.street_address}
    phone { Faker::PhoneNumber.phone_number }
    fax { Faker::PhoneNumber.phone_number  }
  end
end