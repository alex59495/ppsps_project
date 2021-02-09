FactoryBot.define do
  factory :direcct do
    address { Faker::Address.street_address}
    phone { Faker::PhoneNumber.cell_phone_in_e164  }
    fax { Faker::PhoneNumber.phone_number  }
    company
    
    factory :direcct_update do
      fax { 'Name updated'}
      address { 'Address updated'}
      phone { '0328282828' }
      company
    end
  end
end