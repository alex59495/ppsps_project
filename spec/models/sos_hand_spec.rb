require 'rails_helper'

RSpec.describe SosHand, type: :model do
  it 'create 1 sos_hand' do
    sos_hand = create(:sos_hand)
    expect(sos_hand).to be_kind_of(SosHand)
  end
end
