FactoryBot.define do
  factory :risk_type do
    name { RiskType::RISK_TYPES.sample }
  end
end
