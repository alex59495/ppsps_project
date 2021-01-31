require 'rails_helper'

RSpec.describe SecurityCoordinator, type: :model do
  it 'create 1 security_coordinator' do
    security_coordinator = create(:security_coordinator)
    expect(security_coordinator).to be_kind_of(SecurityCoordinator)
  end

  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:representative)}
  it { should validate_presence_of(:address)}
  it { should validate_presence_of(:phone)}
  it { should validate_presence_of(:email)}

  it { should have_many(:ppsps) }

  it { should belong_to(:company) }
end
