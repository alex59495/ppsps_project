require 'rails_helper'

RSpec.describe Machine, type: :model do
  it 'create 1 machine' do
    machine = create(:machine)
    expect(machine).to be_kind_of(Machine)
  end

  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:caces) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:images) }

  it { should have_many(:conductors) }
end
