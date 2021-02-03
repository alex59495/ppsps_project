require 'rails_helper'

RSpec.describe Ppsp, type: :model do
  it 'Work if all attributes are completed' do
    ppsp = create(:ppsp)
    expect(ppsp).to be_valid
    expect(ppsp.latitude).not_to be_nil
    expect(ppsp.longitude).not_to be_nil
  end

  # it "Doesn't work if address isn't completed" do
  #   ppsp = build(:ppsp, address: nil)
  #   ppsp.valid?
  #   expect(ppsp.errors[:address]).to include("doit être rempli(e)")
  # end

  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:workforce) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
  it { should validate_presence_of(:nature) }
  it { should validate_presence_of(:agglomeration) }
  it { should validate_presence_of(:street_impact) }
  it { should validate_presence_of(:river_guidance) }

  it { should belong_to(:moe) }
  it { should belong_to(:moa) }
  it { should belong_to(:hospital) }
  it { should belong_to(:direcct) }
  it { should belong_to(:demining) }
  it { should belong_to(:anti_poison) }
  it { should belong_to(:pension_insurance) }
  it { should belong_to(:project_information) }
  it { should belong_to(:regional_committee) }
  it { should belong_to(:sos_hand) }
  it { should belong_to(:user) }
  it { should belong_to(:work_medecine) }

  it { should have_many(:selected_subcontractors) }

  it "Can work if security_coordinator doesn't exist" do
    ppsp = create(:ppsp, security_coordinator: nil)
    expect(ppsp).to be_valid
  end
end
