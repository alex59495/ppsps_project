FactoryBot.define do
  factory :worksite do
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
  end
end
