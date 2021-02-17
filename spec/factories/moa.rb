FactoryBot.define do
  factory :moa do
    name { Faker::Name.name }
    address { Faker::Address.street_address }
    representative { Faker::Name.name }
    phone { Faker::PhoneNumber.cell_phone_in_e164 }
    email { Faker::Internet.email }
    company

    factory :moa_update do
      name { 'Name updated' }
      address { 'Address updated' }
      representative { 'Representative updated' }
      phone { '0328282828' }
      email { 'test@gmail.com' }
      company
    end
  end
end
