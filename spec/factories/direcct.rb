FactoryBot.define do
  factory :direcct do
    address { Faker::Address.street_address}
    phone { Faker::PhoneNumber.phone_number }
    fax { Faker::PhoneNumber.phone_number  }
    
    factory :direcct_update do
      fax { 'Name updated'}
      address { 'Address updated'}
      phone { 'Phone updated' }
    end
  end
end