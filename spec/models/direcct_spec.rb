require 'rails_helper'

RSpec.describe Direcct, type: :model do
  it 'create 1 direcct' do
    direcct = create(:direcct)
    expect(direcct).to be_kind_of(Direcct)
  end
end