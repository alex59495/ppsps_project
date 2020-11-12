FactoryBot.define do
  factory :moa do
    name { Faker::Name.name}
    address { Faker::Address.street_address}
    representative { Faker::Name.name }
    phone { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }

    factory :moa_update do
      name { 'Name updated' }
      address { 'Address updated'}
      representative { 'Representative updated' }
      phone { 'Phone updated' }
      email { 'Email updated' }
    end
  end
end