FactoryBot.define do
  factory :work_medecine do
    address { Faker::Address.street_address}
    phone { '0300000000' }
    fax { Faker::PhoneNumber.phone_number  }
    
    factory :work_medecine_update do
      fax { 'Fax updated'}
      address { 'Address updated'}
      phone { '0328282828' }
    end
  end
end