require 'rails_helper'

RSpec.describe Moe, type: :model do
  it 'create 1 MOE' do
    moe = create(:moe)
    expect(moe).to be_kind_of(Moe)
  end

  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:address)}
  it { should validate_presence_of(:representative)}
  it { should validate_presence_of(:phone)}
  it { should validate_presence_of(:email)}
  it { should allow_value(true, false).for(:is_destroyed) }

  it { should have_many(:ppsps)}

  it { should belong_to(:company) }
end
