FactoryBot.define do
  factory :subcontractor do
    name { Faker::Name.name}
    address { Faker::Address.street_address}
    work { 'Test Work' }
    responsible_name { Faker::Name.name }
    responsible_phone { Faker::PhoneNumber.phone_number }
    responsible_email { Faker::Internet.email }
    ppsp
  end
end