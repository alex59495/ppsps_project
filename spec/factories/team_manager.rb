FactoryBot.define do
  factory :team_manager do
    name { Faker::Name.name}
    phone { '0300000000' }
    email { Faker::Internet.email }
  end
end