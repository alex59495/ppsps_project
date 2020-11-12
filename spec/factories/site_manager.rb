FactoryBot.define do
  factory :site_manager do
    name { 'Test de chef de chantier' }
    phone { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
  end
end