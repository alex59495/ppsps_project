FactoryBot.define do
  factory :anti_poison do
    name { Faker::Name.name}
    address { Faker::Address.street_address}
    phone { '0300000000' }

    factory :anti_poison_update do
      name { 'Name updated'}
      address { 'Address updated'}
      phone { '0328282828' }
    end
  end
end
