FactoryBot.define do
  factory :pension_insurance do
    address { Faker::Address.street_address}
    phone { Faker::PhoneNumber.phone_number }
    fax { Faker::PhoneNumber.phone_number  }

    factory :pension_insurance_update do
      fax { 'Fax updated'}
      address { 'Address updated'}
      phone { 'Phone updated' }
    end
  end
end