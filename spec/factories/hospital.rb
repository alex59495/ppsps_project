FactoryBot.define do
  factory :hospital do
    name { Faker::Name.name}
    address { Faker::Address.street_address}
    phone { '0300000000' }
    company
    
    factory :hospital_update do
      name { 'Name updated'}
      address { 'Address updated'}
      phone { '0328282828' }
      company
    end
  end
end