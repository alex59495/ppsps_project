FactoryBot.define do
  factory :anti_poison do
    name { Faker::Name.name}
    address { Faker::Address.street_address}
    phone { Faker::PhoneNumber.phone_number }

    factory :anti_poison_update do
      name { 'Name updated'}
      address { 'Address updated'}
      phone { 'Phone updated' }
    end
  end
end
