FactoryBot.define do
  factory :project_information do
    reference { 'AAE40B' }
    responsible { Faker::Name.name }
    phone { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
    team_manager
    site_manager
  end
end