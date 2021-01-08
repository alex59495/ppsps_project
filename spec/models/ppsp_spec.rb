require 'rails_helper'

RSpec.describe Ppsp, type: :model do
  it 'Work if all attributes are completed' do
    ppsp = create(:ppsp)
    expect(ppsp).to be_valid
    ppsp.destroy
  end

  # it "Doesn't work if address isn't completed" do
  #   ppsp = build(:ppsp, address: nil)
  #   ppsp.valid?
  #   expect(ppsp.errors[:address]).to include("doit être rempli(e)")
  # end

  it { should validate_presence_of(:address) }

  # it "Doesn't work if workforce isn't completed" do
  #   ppsp = build(:ppsp, workforce: nil)
  #   ppsp.valid?
  #   expect(ppsp.errors[:workforce]).to include("doit être rempli(e)")
  # end

  it { should validate_presence_of(:workforce) }

  # it "Doesn't work if moe doesn't exist" do
  #   ppsp = build(:ppsp, moe: nil)
  #   ppsp.valid?
  #   expect(ppsp.errors[:moe]).to include("doit exister")
  # end
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

  it "Can work if security_coordinator doesn't exist" do
    ppsp = create(:ppsp, security_coordinator: nil)
    expect(ppsp).to be_valid
    ppsp.destroy
  end
end
