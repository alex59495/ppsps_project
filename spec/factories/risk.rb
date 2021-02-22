FactoryBot.define do
  factory :risk do
    risk = Risk::RISKS.sample
    name { risk[:name] }
    association(:risk_type)
    file { risk[:file] }
  end
end
