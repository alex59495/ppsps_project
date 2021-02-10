FactoryBot.define do
  factory :worksite do
    address { Faker::Address.street_address }
    start_date { '2020-09-25' }
    end_date { '2022-09-25' }
    nature { 'Test de nature' }
    num_worker { rand(0..10) }
    num_responsible { rand(0..10) }
    num_conductor { rand(0..10) }
    timetable_summer { true }
    timetable_winter { true }
    timetable_summer_start { "MyString" }
    timetable_summer_end { "MyString" }
    timetable_winter_start { "MyString" }
    timetable_winter_end { "MyString" }
    plan { false }
    electrical_site { [true, false].sample }
    water_site { [true, false].sample }
  end
end
