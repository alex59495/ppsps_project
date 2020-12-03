FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name}
    last_name { Faker::Name.last_name}
    email { Faker::Internet.email }
    password { '@leX1s' }
    admin { false }
    company

    trait :admin do
      admin { true }
    end

    trait :company_uber do
      company { association(:company_uber) }
    end

    trait :company_google do
      company { association(:company_google) }
    end

    factory :user_admin, traits: [:admin]
    factory :user_admin_uber, traits: [:admin, :company_uber]
    factory :user_uber, traits: [:company_uber]
    factory :user_google, traits: [:company_google]
  end
end