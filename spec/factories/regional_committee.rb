FactoryBot.define do
  factory :regional_committee do
    name { Faker::Name.name}
    address { Faker::Address.street_address}
    phone { '0300000000' }
    fax { Faker::PhoneNumber.phone_number  }

    factory :regional_committee_update do
      name { 'Name updated'}
      address { 'Address updated'}
      phone { '0328282828' }
      fax { 'Fax updated' }
    end
  end
end