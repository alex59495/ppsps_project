require 'rails_helper'

RSpec.describe Moa, type: :model do
  it 'create 1 MOA' do
    moa = build(:moa)
    expect(moa).to be_kind_of(Moa)
  end

  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:address)}
  it { should validate_presence_of(:representative)}
  it { should validate_presence_of(:phone)}
  it { should validate_presence_of(:email)}

  it { should have_many(:ppsps)}
end
