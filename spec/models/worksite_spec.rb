require 'rails_helper'

RSpec.describe Worksite, type: :model do
  it 'create 1 worksite' do
    worksite = create(:worksite)
    expect(worksite).to be_kind_of(Worksite)
    expect(worksite.latitude).not_to be_nil
    expect(worksite.longitude).not_to be_nil
  end

  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:nature) }
  it { should validate_presence_of(:num_responsible) }
  it { should validate_presence_of(:num_conductor) }
  it { should validate_presence_of(:num_worker) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
  it { should validate_presence_of(:timetable_start) }
  it { should validate_presence_of(:timetable_end) }

  it { should have_many(:ppsps) }
end
