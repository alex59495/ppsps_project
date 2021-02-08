FactoryBot.define do
  factory :machine do
    machine = Machine::MACHINES.sample
    category { machine[:category] }
    caces { machine[:caces] }
    description { machine[:description] }
  end
end
