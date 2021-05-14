require 'rails_helper'

RSpec.describe Ppsp, type: :model do
  it 'Work if all attributes are completed' do
    ppsp = create(:ppsp)
    expect(ppsp).to be_valid
  end

  # it "Doesn't work if address isn't completed" do
  #   ppsp = build(:ppsp, address: nil)
  #   ppsp.valid?
  #   expect(ppsp.errors[:address]).to include("doit être rempli(e)")
  # end
  it { should validate_presence_of(:reference) }
  it { should validate_presence_of(:name) }

  it { should belong_to(:team_manager) }
  it { should belong_to(:site_manager) }
  it { should belong_to(:responsible) }

  it { is_expected.to validate_size_of(:annexes).less_than(500.kilobytes) }
  it { is_expected.to validate_size_of(:logo_client).less_than(500.kilobytes) }

  it { should belong_to(:moe) }
  it { should belong_to(:moa) }
  it { should belong_to(:hospital) }
  it { should belong_to(:direcct) }
  it { should belong_to(:demining) }
  it { should belong_to(:anti_poison) }
  it { should belong_to(:pension_insurance) }
  it { should belong_to(:regional_committee) }
  it { should belong_to(:sos_hand) }
  it { should belong_to(:user) }
  it { should belong_to(:work_medecine) }

  it { should have_many(:selected_subcontractors) }

  it "Can work if security_coordinator doesn't exist" do
    ppsp = create(:ppsp, security_coordinator: nil)
    expect(ppsp).to be_valid
  end

  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:nature) }
  it { should validate_presence_of(:num_responsible) }
  it { should validate_presence_of(:num_conductor) }
  it { should validate_presence_of(:num_worker) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
  it { should allow_value(true, false).for(:water_site) }
  it { should allow_value(true, false).for(:electrical_site) }
  it { should allow_value(true, false).for(:plan) }
  it { should allow_value(true, false).for(:infirmary) }

  context "if summer timetable" do
    before { allow(subject).to receive(:infirmary?).and_return(true) }
    it { should validate_presence_of(:infirmary_text) }
  end

  context 'Verify size of plan_installation if plan is true' do
    before { allow(subject).to receive(:has_a_plan?).and_return(true) }
    it { is_expected.to validate_size_of(:plan_installation).less_than(300.kilobytes) }
  end

  context "if summer timetable" do
    before { allow(subject).to receive(:summer?).and_return(true) }
    it { should validate_presence_of(:timetable_summer_start) }
    it { should validate_presence_of(:timetable_summer_end) }
    it { should validate_presence_of(:timetable_summer_start_friday) }
    it { should validate_presence_of(:timetable_summer_end_friday) }
  end

  context "if winter timetable" do
    before { allow(subject).to receive(:winter?).and_return(true) }
    it { should validate_presence_of(:timetable_winter_start) }
    it { should validate_presence_of(:timetable_winter_end) }
    it { should validate_presence_of(:timetable_winter_start_friday) }
    it { should validate_presence_of(:timetable_winter_end_friday) }
  end

  context "if not summer timetable" do
    before { allow(subject).to receive(:summer?).and_return(false) }
    it { should validate_absence_of(:timetable_summer_start) }
    it { should validate_absence_of(:timetable_summer_end) }
    it { should validate_absence_of(:timetable_summer_start_friday) }
    it { should validate_absence_of(:timetable_summer_end_friday) }
  end

  context "if not winter timetable" do
    before { allow(subject).to receive(:winter?).and_return(false) }
    it { should validate_absence_of(:timetable_winter_start) }
    it { should validate_absence_of(:timetable_winter_end) }
    it { should validate_absence_of(:timetable_winter_start_friday) }
    it { should validate_absence_of(:timetable_winter_end_friday) }
  end

  context "if plan installtion" do
    before { allow(subject).to receive(:has_a_plan?).and_return(true) }
    it { should validate_presence_of(:plan_installation) }
  end

  context "if no plan installtion" do
    before { allow(subject).to receive(:has_a_plan?).and_return(false) }
    it { should_not validate_presence_of(:plan_installation) }
  end
end
