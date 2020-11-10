FactoryBot.define do
  factory :altitude_work do
    name { AltitudeWork::ALTITUDE_WORKS.sample }
  end
end