FactoryBot.define do
  factory :security_coordinator do
    name { Faker::Name.name}
    address { Faker::Address.street_address}
    representative { Faker::Name.name }
    phone { '0300000000' }
    email { Faker::Internet.email }
  end
end