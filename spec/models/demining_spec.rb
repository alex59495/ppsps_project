require 'rails_helper'

RSpec.describe Demining, type: :model do
  it 'create 1 demining' do
    demining = create(:demining)
    expect(demining).to be_kind_of(Demining)
  end

  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:phone) }
  it { should allow_value(true, false).for(:is_destroyed) }

  it { should have_many(:ppsps) }

  it { should belong_to(:company) }
end
