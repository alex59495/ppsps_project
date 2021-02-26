require 'rails_helper'

RSpec.describe MachineCategory, type: :model do
  it 'create 1 categorie de machine' do
    category = create(:machine_category)
    expect(category).to be_kind_of(MachineCategory)
  end

  it { should validate_presence_of(:name) }
  it { should have_many(:machines) }
end
