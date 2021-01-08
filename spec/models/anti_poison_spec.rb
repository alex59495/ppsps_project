require 'rails_helper'

RSpec.describe AntiPoison, type: :model do
  it 'create 1 anti_poison' do
    anti_poison = build(:anti_poison)
    expect(anti_poison).to be_kind_of(AntiPoison)
  end

  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:phone) }

  it { should have_many(:ppsps) }
end
