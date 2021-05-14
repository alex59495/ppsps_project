require 'rails_helper'

RSpec.describe Company, type: :model do
  it 'create 1 company' do
    company = create(:company)
    expect(company).to be_kind_of(Company)
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:representative) }
  it { should validate_presence_of(:phone) }

  it { should have_many(:users) }
  it { should have_many(:moas) }

  it "should have many moes" do
    # We can't use Shoulda Matcher for this one becasue it will look for Mo Model (which doesn't exist)
    c = Company.reflect_on_association(:moes)
    expect(c.macro).to eq(:has_many)
  end

  it { should have_many(:hospitals) }
  it { should have_many(:anti_poisons) }
  it { should have_many(:pension_insurances) }
  it { should have_many(:regional_committees) }
  it { should have_many(:direccts) }
  it { should have_many(:kit_security_elements) }
  it { should have_many(:work_medecines) }
  it { should have_many(:deminings) }
  it { should have_many(:sos_hands) }
  it { should have_many(:workers) }
  it { should have_many(:security_coordinators) }
end
