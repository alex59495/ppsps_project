require 'rails_helper'

RSpec.describe AntiPoison, type: :model do
  it 'create 1 anti_poison' do
    anti_poison = create(:anti_poison)
    expect(anti_poison).to be_kind_of(AntiPoison)
  end

  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:phone) }
  it { should allow_value(true, false).for(:is_destroyed) }

  it { should have_many(:ppsps) }

  it { should belong_to(:company) }
end
