require 'rails_helper'

RSpec.describe Machine, type: :model do
  it 'create 1 machine' do
    machine = create(:machine)
    expect(machine).to be_kind_of(Machine)
  end

  it { should validate_presence_of(:machine_category) }
  it { should validate_presence_of(:caces) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:image) }

  it { should have_many(:conductors) }

  it { should belong_to(:machine_category) }
end
