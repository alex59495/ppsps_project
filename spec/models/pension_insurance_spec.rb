require 'rails_helper'

RSpec.describe PensionInsurance, type: :model do
  it 'create 1 pension_insurance' do
    pension_insurance = create(:pension_insurance)
    expect(pension_insurance).to be_kind_of(PensionInsurance)
  end
end
