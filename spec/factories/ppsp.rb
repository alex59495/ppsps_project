FactoryBot.define do
  factory :ppsp do
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
    worksite

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
