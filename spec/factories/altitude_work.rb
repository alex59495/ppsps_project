FactoryBot.define do
  factory :altitude_work do
    name { AltitudeWork::ALTITUDE_WORKS.sample }

    factory :altitude_work_without_textfield do
      # Create the work altitudes withtin the List without "Autre" option which is handled separatley
      name { AltitudeWork::ALTITUDE_WORKS.select{|x| x != "Autre" }.sample }
    end
  end
end