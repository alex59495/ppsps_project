FactoryBot.define do
  factory :worksite do
    address { Faker::Address.street_address }
    start_date { '2020-09-25' }
    end_date { '2022-09-25' }
    nature { 'Test de nature' }
    num_worker { rand(0..10) }
    num_responsible { rand(0..10) }
    num_conductor { rand(0..10) }
    timetable_start { "MyString" }
    timetable_end { "MyString" }
    plan { [true, false].sample }
    electrical_site { [true, false].sample }
    water_site { [true, false].sample }
  end
end
