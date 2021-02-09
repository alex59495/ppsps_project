require 'rails_helper'

RSpec.describe RegionalCommittee, type: :model do
  it 'create 1 regional_committee' do
    regional_committee = create(:regional_committee)
    expect(regional_committee).to be_kind_of(RegionalCommittee)
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:fax) }
  it { should allow_value(true, false).for(:is_destroyed) }

  it { should have_many(:ppsps) }

  it { should belong_to(:company) }
end
