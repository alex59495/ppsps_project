FactoryBot.define do
  factory :risk do
    name { Risk::RISKS.sample }
    risk_type
  end
end
