FactoryBot.define do
  factory :machine do
    name { Machine::MACHINES.sample }
  end
end
