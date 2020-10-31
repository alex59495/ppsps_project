require 'rails_helper'

RSpec.describe RegionalCommittee, type: :model do
  it 'create 1 regional_committee' do
    regional_committee = create(:regional_committee)
    expect(regional_committee).to be_kind_of(RegionalCommittee)
  end
end
