FactoryBot.define do
  factory :project_information do
    reference { 'AAE40B' }
    name { Faker::Lorem.sentence(word_count: 6) }
    association :responsible
    association :site_manager
    association :team_manager
    company
  end
end
