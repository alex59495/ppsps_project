FactoryBot.define do
  factory :worker do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    conductor { [true, false].sample }
    lifesaver { [true, false].sample }
    role { Worker::ROLE.sample }
    company

    factory :worker_update do
      first_name { 'First name updated' }
      last_name { 'Last name updated' }
    end

    trait :responsible do
      role { 'Conducteur de travaux' }
    end

    trait :site_manager do
      role { 'Chef de chantier' }
    end

    trait :team_manager do
      role { "Chef d'équi[e" }
    end

    factory :responsible, traits: [:responsible]
    factory :site_manager, traits: [:site_manager]
    factory :team_manager, traits: [:team_manager]
  end
end
