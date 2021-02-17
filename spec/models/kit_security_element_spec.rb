require 'rails_helper'

RSpec.describe KitSecurityElement, type: :model do
  it 'create 1 MOA' do
    kit = create(:kit_security_element)
    expect(kit).to be_kind_of(KitSecurityElement)
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:company) }

  it { should belong_to(:company) }
end
