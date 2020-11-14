FactoryBot.define do
  factory :project_information do
    reference { 'AAE40B' }
    responsible { Faker::Name.name }
    phone { '0300000000' }
    email { Faker::Internet.email }
    team_manager
    site_manager
  end
end