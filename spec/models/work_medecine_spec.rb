require 'rails_helper'

RSpec.describe WorkMedecine, type: :model do
  it 'create 1 work_medecine' do
    work_medecine = create(:work_medecine)
    expect(work_medecine).to be_kind_of(WorkMedecine)
  end
end
