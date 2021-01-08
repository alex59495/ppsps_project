require 'rails_helper'

RSpec.describe SosHand, type: :model do
  it 'create 1 sos_hand' do
    sos_hand = build(:sos_hand)
    expect(sos_hand).to be_kind_of(SosHand)
  end

  it { should validate_presence_of(:address)}
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:phone)}

  it { should have_many(:ppsps)}
end
