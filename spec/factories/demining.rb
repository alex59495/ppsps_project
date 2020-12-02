FactoryBot.define do
  factory :demining do
    name { Faker::Name.name}
    address { Faker::Address.street_address}
    phone { '0300000000' }
    company

    factory :demining_update do
      name { 'Name updated'}
      address { 'Address updated'}
      phone { '0328282828' }
      company
    end
  end
end