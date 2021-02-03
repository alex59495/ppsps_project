FactoryBot.define do
  factory :worksite do
    address { Faker::Address.street_address }
    start_date { '2020-09-25' }
    end_date { '2022-09-25' }
    nature { 'Test de nature' }
    workforce { '1 chef de chantier, 3 ouvriers' }
    timetable_start { "MyString" }
    timetable_end { "MyString" }
    electrical { [true, false].sample }
  end
end
