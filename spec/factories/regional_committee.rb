FactoryBot.define do
  factory :regional_committee do
    name { Faker::Name.name}
    address { Faker::Address.street_address}
    phone { Faker::PhoneNumber.cell_phone_in_e164  }
    fax { Faker::PhoneNumber.phone_number }
    company

    factory :regional_committee_update do
      name { 'Name updated'}
      address { 'Address updated'}
      phone { '0328282828' }
      fax { 'Fax updated' }
      company
    end
  end
end