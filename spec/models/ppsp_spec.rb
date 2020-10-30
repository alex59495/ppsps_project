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

  it { should belong_to(:moe) }

  it "Can work if security_coordinator doesn't exist" do
    ppsp = create(:ppsp, security_coordinator: nil)
    expect(ppsp).to be_valid
  end
end