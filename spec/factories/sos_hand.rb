FactoryBot.define do
  factory :sos_hand do
    name { Faker::Name.name}
    address { Faker::Address.street_address}
    phone { Faker::PhoneNumber.phone_number }

    factory :sos_hand_update do
      name { 'Name updated'}
      address { 'Address updated'}
      phone { 'Phone updated' }
    end
  end
end