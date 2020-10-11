FactoryBot.define do
  factory :pension_insurance do
    address { Faker::Address.street_address}
    phone { Faker::PhoneNumber.phone_number }
    fax { Faker::PhoneNumber.phone_number  }
  end
end