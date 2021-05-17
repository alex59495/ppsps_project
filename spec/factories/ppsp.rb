FactoryBot.define do
  factory :ppsp do
    reference { 'AAE40B' }
    name { Faker::Lorem.sentence(word_count: 6) }
    association :responsible
    association :site_manager
    association :team_manager
    security_coordinator
    moa
    moe
    direcct
    regional_committee
    pension_insurance
    work_medecine
    hospital
    sos_hand
    anti_poison
    user
    demining
    address { "New York, NY" }
    start_date { '2020-09-25' }
    end_date { '2022-09-25' }
    nature { 'Test de nature' }
    num_worker { rand(0..10) }
    num_responsible { rand(0..10) }
    num_conductor { rand(0..10) }
    timetable_summer { true }
    timetable_winter { true }
    timetable_summer_start { "8h" }
    timetable_summer_end { "16h30" }
    timetable_summer_start_friday { "8h" }
    timetable_summer_end_friday { "16h" }
    timetable_winter_start { "8h" }
    timetable_winter_end { "16h30" }
    timetable_winter_start_friday { "8h" }
    timetable_winter_end_friday { "16h" }
    plan { false }
    electrical_site { [true, false].sample }
    water_site { [true, false].sample }

    trait :company_uber do
      user { association(:user_uber) }
    end

    trait :company_google do
      user { association(:user_google) }
    end

    trait :ppsp_designation do
      security_coordinator { nil }
      moa { nil }
      moe { nil }
      direcct { nil }
      regional_committee { nil }
      pension_insurance { nil }
      work_medecine { nil }
      hospital { nil }
      sos_hand { nil }
      anti_poison { nil }
      demining { nil }
      address { nil }
      start_date { nil }
      end_date { nil }
      nature { nil }
      num_worker { nil }
      num_responsible { nil }
      num_conductor { nil }
      timetable_summer { nil }
      timetable_winter { nil }
      timetable_summer_start { nil }
      timetable_summer_end { nil }
      timetable_summer_start_friday { nil }
      timetable_summer_end_friday { nil }
      timetable_winter_start { nil }
      timetable_winter_end { nil }
      timetable_winter_start_friday { nil }
      timetable_winter_end_friday { nil }
      plan { nil }
      electrical_site { nil }
      water_site { nil }
      form_step { :ppsp_designation }
    end

    trait :ppsp_master do
      security_coordinator { nil }
      direcct { nil }
      regional_committee { nil }
      pension_insurance { nil }
      work_medecine { nil }
      hospital { nil }
      sos_hand { nil }
      anti_poison { nil }
      demining { nil }
      address { nil }
      start_date { nil }
      end_date { nil }
      nature { nil }
      num_worker { nil }
      num_responsible { nil }
      num_conductor { nil }
      timetable_summer { nil }
      timetable_winter { nil }
      timetable_summer_start { nil }
      timetable_summer_end { nil }
      timetable_summer_start_friday { nil }
      timetable_summer_end_friday { nil }
      timetable_winter_start { nil }
      timetable_winter_end { nil }
      timetable_winter_start_friday { nil }
      timetable_winter_end_friday { nil }
      plan { nil }
      electrical_site { nil }
      water_site { nil }
      form_step { :ppsp_master }
    end

    trait :ppsp_prevention do
      hospital { nil }
      sos_hand { nil }
      anti_poison { nil }
      demining { nil }
      address { nil }
      start_date { nil }
      end_date { nil }
      nature { nil }
      num_worker { nil }
      num_responsible { nil }
      num_conductor { nil }
      timetable_summer { nil }
      timetable_winter { nil }
      timetable_summer_start { nil }
      timetable_summer_end { nil }
      timetable_summer_start_friday { nil }
      timetable_summer_end_friday { nil }
      timetable_winter_start { nil }
      timetable_winter_end { nil }
      timetable_winter_start_friday { nil }
      timetable_winter_end_friday { nil }
      plan { nil }
      electrical_site { nil }
      water_site { nil }
      form_step { :ppsp_prevention }
    end

    trait :ppsp_worksite do
      hospital { nil }
      sos_hand { nil }
      anti_poison { nil }
      demining { nil }
      num_worker { nil }
      num_responsible { nil }
      num_conductor { nil }
      timetable_summer { nil }
      timetable_winter { nil }
      timetable_summer_start { nil }
      timetable_summer_end { nil }
      timetable_summer_start_friday { nil }
      timetable_summer_end_friday { nil }
      timetable_winter_start { nil }
      timetable_winter_end { nil }
      timetable_winter_start_friday { nil }
      timetable_winter_end_friday { nil }
      plan { nil }
      electrical_site { nil }
      water_site { nil }
      form_step { :ppsp_worksite }
    end

    trait :ppsp_time_table do
      hospital { nil }
      sos_hand { nil }
      anti_poison { nil }
      demining { nil }
      num_worker { nil }
      num_responsible { nil }
      num_conductor { nil }
      plan { nil }
      electrical_site { nil }
      water_site { nil }
      form_step { :ppsp_time_table }
    end

    trait :ppsp_team_number do
      hospital { nil }
      sos_hand { nil }
      anti_poison { nil }
      demining { nil }
      plan { nil }
      electrical_site { nil }
      water_site { nil }
      form_step { :ppsp_team_number }
    end

    trait :ppsp_installation do
      hospital { nil }
      sos_hand { nil }
      anti_poison { nil }
      demining { nil }
      form_step { :ppsp_installation }
    end

    trait :ppsp_security do
      form_step { :ppsp_security }
    end

    factory :ppsp_uber, traits: [:company_uber]
    factory :ppsp_google, traits: [:company_google]
    factory :ppsp_designation, traits: [:ppsp_designation]
    factory :ppsp_master, traits: [:ppsp_master]
    factory :ppsp_prevention, traits: [:ppsp_prevention]
    factory :ppsp_worksite, traits: [:ppsp_worksite]
    factory :ppsp_time_table, traits: [:ppsp_time_table]
    factory :ppsp_team_number, traits: [:ppsp_team_number]
    factory :ppsp_installation, traits: [:ppsp_installation]
    factory :ppsp_security, traits: [:ppsp_security]
  end
end
