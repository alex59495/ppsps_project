FactoryBot.define do
  factory :machine_category do
    name { MachineCategory::MACHINE_CATEGORIES.sample }
  end
end
