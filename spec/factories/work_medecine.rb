FactoryBot.define do
  factory :work_medecine do
    address { Faker::Address.street_address}
    phone { Faker::PhoneNumber.phone_number }
    fax { Faker::PhoneNumber.phone_number  }
    
    factory :work_medecine_update do
      fax { 'Fax updated'}
      address { 'Address updated'}
      phone { 'Phone updated' }
    end
  end
end