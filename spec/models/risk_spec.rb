require 'rails_helper'

RSpec.describe Risk, type: :model do
  it 'create 1 risk type' do
    risk = create(:risk)
    expect(risk).to be_kind_of(Risk)
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:risk_type) }
  it { should validate_presence_of(:file) }

  it { should belong_to(:risk_type) }
end
