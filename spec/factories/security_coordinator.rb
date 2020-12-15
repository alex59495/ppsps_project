FactoryBot.define do
  factory :security_coordinator do
    name { Faker::Name.name}
    address { Faker::Address.street_address}
    representative { Faker::Name.name }
    phone { '0300000000' }
    email { Faker::Internet.email }
    company

    factory :security_coordinator_update do
      name { 'Name updated'}
      address { 'Address updated'}
      phone { '0328282828' }
      representative { 'Representative updated' }
      email { 'upadte@update.com' }
      company
    end
  end
end