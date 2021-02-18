FactoryBot.define do
  factory :machine do
    machine = Machine::MACHINES.sample
    machine_category { machine[:mahcine_category] }
    caces { machine[:caces] }
    description { machine[:description] }
    image { machine[:image] }
  end
end
