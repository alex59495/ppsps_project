FactoryBot.define do
  factory :worker do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    conductor { [true, false].sample }
    lifesaver { [true, false].sample }
    company

    factory :worker_update do
      first_name { 'First name updated' }
      last_name { 'Last name updated' }
    end
  end
end
