FactoryBot.define do
  factory :moa do
    name { Faker::Name.name}
    address { Faker::Address.street_address}
    representative { Faker::Name.name }
    phone { '0300000000' }
    email { Faker::Internet.email }

    factory :moa_update do
      name { 'Name updated' }
      address { 'Address updated'}
      representative { 'Representative updated' }
      phone { '0328282828' }
      email { 'test@gmail.com' }
    end
  end
end