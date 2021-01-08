require 'rails_helper'

RSpec.describe Hospital, type: :model do
  it 'create 1 hospital' do
    hospital = build(:hospital)
    expect(hospital).to be_kind_of(Hospital)
  end

  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:address)}
  it { should validate_presence_of(:phone)}

  it { should have_many(:ppsps)}
end
