FactoryBot.define do
  factory :pension_insurance do
    address { Faker::Address.street_address}
    phone { Faker::PhoneNumber.cell_phone_in_e164  }
    fax { Faker::PhoneNumber.phone_number }
    company

    factory :pension_insurance_update do
      fax { 'Fax updated'}
      address { 'Address updated'}
      phone { '0328282828' }
      company
    end
  end
end