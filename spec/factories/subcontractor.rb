FactoryBot.define do
  factory :subcontractor do
    name { Faker::Name.name }
    address { Faker::Address.street_address }
    work { 'Test Work' }
    responsible_name { Faker::Name.name }
    responsible_phone { '0300000000' }
    responsible_email { Faker::Internet.email }
  end
end
