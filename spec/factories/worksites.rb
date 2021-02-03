FactoryBot.define do
  factory :worksite do
    start_date { "2021-02-03" }
    end_date { "2021-02-03" }
    nature { "MyString" }
    workforce { "MyString" }
    address { "MyString" }
    timetable_start { "MyString" }
    timetable_end { "MyString" }
    electrical { false }
  end
end
