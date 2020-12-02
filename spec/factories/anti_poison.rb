FactoryBot.define do
  factory :anti_poison do
    name { Faker::Name.name}
    address { Faker::Address.street_address}
    phone { '0300000000' }
    company

    factory :anti_poison_update do
      name { 'Name updated'}
      address { 'Address updated'}
      phone { '0328282828' }
      company
    end
  end
end
