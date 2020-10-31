require 'rails_helper'

RSpec.describe Subcontractor, type: :model do
  it 'create 1 subcontractor' do
    subcontractor = create(:subcontractor)
    expect(subcontractor).to be_kind_of(Subcontractor)
  end
end
