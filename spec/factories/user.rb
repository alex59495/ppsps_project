FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name}
    last_name { Faker::Name.last_name}
    email { Faker::Internet.email }
    password { '123456' }
    admin { false }
    company

    trait :admin do
      admin { true }
    end

    factory :user_admin, traits: [:admin]
  end
end