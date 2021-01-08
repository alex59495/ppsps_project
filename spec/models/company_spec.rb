require 'rails_helper'

RSpec.describe Company, type: :model do
  it 'create 1 company' do
    company = build(:company)
    expect(company).to be_kind_of(Company)
  end

  it { should validate_presence_of(:name) }

  it { should have_many(:users) }
end
