require 'rails_helper'

RSpec.describe SecurityCoordinator, type: :model do
  it 'create 1 security_coordinator' do
    security_coordinator = create(:security_coordinator)
    expect(security_coordinator).to be_kind_of(SecurityCoordinator)
  end
end
