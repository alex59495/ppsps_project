FactoryBot.define do
  factory :risk do
    name { Risk::RISKS.first }
  end
end