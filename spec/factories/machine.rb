FactoryBot.define do
  factory :machine do
    machine = Machine::MACHINES.sample
    association(:machine_category)
    caces { machine[:caces] }
    description { machine[:description] }
    image { machine[:image] }
  end
end
