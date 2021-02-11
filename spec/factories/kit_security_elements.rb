FactoryBot.define do
  factory :kit_security_element do
    company
    sequence(:name) { |n| "Elemment de secours #{n}" }
    number { rand(0..10) }
  end
end
