require 'rails_helper'

RSpec.describe RiskType, type: :model do
  it 'create 1 risk type' do
    risk_type = create(:risk_type)
    expect(risk_type).to be_kind_of(RiskType)
  end

  it { should have_many(:risks) }
end
