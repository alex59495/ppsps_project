FactoryBot.define do
  factory :demining do
    name { Faker::Name.name}
    address { Faker::Address.street_address}
    phone { Faker::PhoneNumber.cell_phone_in_e164  }
    company

    factory :demining_update do
      name { 'Name updated'}
      address { 'Address updated'}
      phone { '0328282828' }
      company
    end
  end
end