require 'rails_helper'

RSpec.describe Subcontractor, type: :model do
  it 'create 1 subcontractor' do
    subcontractor = create(:subcontractor)
    expect(subcontractor).to be_kind_of(Subcontractor)
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:work) }
  it { should validate_presence_of(:responsible_name) }
  it { should validate_presence_of(:responsible_phone) }
  it { should validate_presence_of(:responsible_email) }

  it { should have_many(:selected_subcontractors) }
  it { should belong_to(:company) }
end
