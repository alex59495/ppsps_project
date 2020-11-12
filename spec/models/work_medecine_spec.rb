require 'rails_helper'

RSpec.describe WorkMedecine, type: :model do
  it 'create 1 work_medecine' do
    work_medecine = create(:work_medecine)
    expect(work_medecine).to be_kind_of(WorkMedecine)
  end

  it { should validate_presence_of(:address)}
  it { should validate_presence_of(:phone)}
  it { should validate_presence_of(:fax)}
  
  it { should have_many(:ppsps)}
end
