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

  context 'Verify size of plan_installation if plan is true' do
    before { allow(subject).to receive(:has_a_plan?).and_return(true) }
    it { is_expected.to validate_size_of(:plan_installation).less_than(300.kilobytes) }
  end

  context "if summer timetable" do
    before { allow(subject).to receive(:summer?).and_return(true) }
    it { should validate_presence_of(:timetable_summer_start) }
    it { should validate_presence_of(:timetable_summer_end) }
  end

  context "if winter timetable" do
    before { allow(subject).to receive(:winter?).and_return(true) }
    it { should validate_presence_of(:timetable_winter_start) }
    it { should validate_presence_of(:timetable_winter_end) }
  end

  context "if not summer timetable" do
    before { allow(subject).to receive(:summer?).and_return(false) }
    it { should validate_absence_of(:timetable_summer_start) }
    it { should validate_absence_of(:timetable_summer_end) }
  end

  context "if not winter timetable" do
    before { allow(subject).to receive(:winter?).and_return(false) }
    it { should validate_absence_of(:timetable_winter_start) }
    it { should validate_absence_of(:timetable_winter_end) }
  end

  context "if plan installtion" do
    before { allow(subject).to receive(:has_a_plan?).and_return(true) }
    it { should validate_presence_of(:plan_installation) }
  end

  context "if no plan installtion" do
    before { allow(subject).to receive(:has_a_plan?).and_return(false) }
    it { should_not validate_presence_of(:plan_installation) }
  end

  it { should have_many(:ppsps) }
end
