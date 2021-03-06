require 'rails_helper'

RSpec.describe Moa, type: :model do
  it 'create 1 MOA' do
    moa = create(:moa)
    expect(moa).to be_kind_of(Moa)
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:representative) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:email) }
  it { should allow_value(true, false).for(:is_destroyed) }

  it { should have_many(:ppsps) }

  it { should belong_to(:company) }
end
