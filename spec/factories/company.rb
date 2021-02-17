FactoryBot.define do
  factory :company do
    name { Faker::Name.name}
    address { Faker::Address.street_address}
    phone { Faker::PhoneNumber.cell_phone_in_e164  }
    representative { Faker::Name.name }

    trait :uber do
      name { 'Uber' }
    end

    trait :google do
      name { 'Google' }
    end

    factory :company_uber, traits: [:uber]
    factory :company_google, traits: [:google]
  end
end