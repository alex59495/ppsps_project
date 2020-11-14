FactoryBot.define do
  factory :sos_hand do
    name { Faker::Name.name}
    address { Faker::Address.street_address}
    phone { '0300000000' }

    factory :sos_hand_update do
      name { 'Name updated'}
      address { 'Address updated'}
      phone { '0328282828' }
    end
  end
end