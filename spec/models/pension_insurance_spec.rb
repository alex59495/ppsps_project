require 'rails_helper'

RSpec.describe PensionInsurance, type: :model do
  it 'create 1 pension_insurance' do
    pension_insurance = create(:pension_insurance)
    expect(pension_insurance).to be_kind_of(PensionInsurance)
  end

  it { should validate_presence_of(:address)}
  it { should validate_presence_of(:phone)}
  it { should validate_presence_of(:fax)}
  it { should allow_value(true, false).for(:is_destroyed) }

  it { should have_many(:ppsps)}

  it { should belong_to(:company) }
end
