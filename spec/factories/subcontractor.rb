FactoryBot.define do
  factory :subcontractor do
    name { Faker::Name.name }
    address { Faker::Address.street_address }
    work { 'Test Work' }
    responsible_name { Faker::Name.name }
    responsible_phone { Faker::PhoneNumber.cell_phone_in_e164 }
    responsible_email { Faker::Internet.email }
    company

    factory :subcontractor_update do
      name { 'Update Name' }
      address { 'Update Adress' }
      work { 'Update Work' }
      responsible_name { 'Responsible Update' }
      responsible_phone { '0300000010' }
      responsible_email { 'responsible_update@gmail.com' }
    end
  end
end
