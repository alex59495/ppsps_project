FactoryBot.define do
  factory :risk do
    name { Risk::RISKS.sample }
  end
end