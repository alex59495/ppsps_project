FactoryBot.define do
  factory :worker do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    conductor { [true, false].sample }
    lifesaver { [true, false].sample }
    role { Worker::ROLE.sample }
    phone { Faker::PhoneNumber.cell_phone_in_e164 }
    email { Faker::Internet.email }
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
      role { "Chef d'équipe" }
    end

    trait :worker_lifesaver do
      lifesaver { true }
    end

    trait :worker_conductor do
      conductor { true }
    end

    factory :responsible, traits: [:responsible]
    factory :site_manager, traits: [:site_manager]
    factory :team_manager, traits: [:team_manager]
    factory :worker_lifesaver, traits: [:worker_lifesaver]
    factory :worker_conductor, traits: [:worker_conductor]
  end
end
