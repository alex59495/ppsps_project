FactoryBot.define do
  factory :site_manager do
    name { 'Test de chef de chantier' }
    phone { '0300000000' }
    email { Faker::Internet.email }
  end
end