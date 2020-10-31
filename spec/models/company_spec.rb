require 'rails_helper'

RSpec.describe Company, type: :model do
  it 'create 1 company' do
    company = create(:company)
    expect(company).to be_kind_of(Company)
  end
end
