FactoryBot.define do
  factory :ppsp do
    address { Faker::Address.street_address}
    start_date { '2020-09-25' }
    end_date { '2022-09-25' }
    nature { 'Test de nature' }
    workforce { '1 chef de chantier, 3 ouvriers' }
    agglomeration { 'Agglomération' }
    street_impact { 'Hors emprise voirie' }
    river_guidance { "Cours d'eau" }
    security_coordinator
    moa
    moe
    project_information
    direcct
    regional_committee
    pension_insurance
    work_medecine
    hospital
    sos_hand
    anti_poison
    user
    demining

    trait :company_uber do
      user { association(:user_uber) }
    end

    trait :company_google do
      user { association(:user_google) }
    end

    factory :ppsp_uber, traits: [:company_uber]
    factory :ppsp_google, traits: [:company_google]
  end
end
