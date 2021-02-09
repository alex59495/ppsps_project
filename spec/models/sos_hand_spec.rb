require 'rails_helper'

RSpec.describe SosHand, type: :model do
  it 'create 1 sos_hand' do
    sos_hand = create(:sos_hand)
    expect(sos_hand).to be_kind_of(SosHand)
  end

  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:phone) }
  it { should allow_value(true, false).for(:is_destroyed) }

  it { should have_many(:ppsps) }

  it { should belong_to(:company) }
end
