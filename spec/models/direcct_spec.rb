require 'rails_helper'

RSpec.describe Direcct, type: :model do
  it 'create 1 direcct' do
    direcct = create(:direcct)
    expect(direcct).to be_kind_of(Direcct)
  end

  it { should validate_presence_of(:address)}
  it { should validate_presence_of(:fax)}
  it { should validate_presence_of(:phone)}

  it { should have_many(:ppsps)}
end