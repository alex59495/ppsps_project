FactoryBot.define do
  factory :worker do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    conductor { [true, false].sample }
    lifesaver { [true, false].sample }
    company
  end
end
