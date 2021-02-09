require 'rails_helper'

RSpec.describe Worker, type: :model do
  it 'create 1 wroker' do
    worksite = create(:worksite)
    expect(worksite).to be_kind_of(Worker)
  end

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:role) }
  it { should validate_presence_of(:company) }
  it { should validate_presence_of(:nature) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:email) }
  it { should allow_value(true, false).for(:lifesaver) }
  it { should allow_value(true, false).for(:conductor) }
  it { should allow_value(true, false).for(:is_destroyed) }

end
