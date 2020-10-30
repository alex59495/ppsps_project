require 'rails_helper'

RSpec.describe Moa, type: :model do
  it 'create 1 MOA' do
    moa = create(:moa)
    expect(moa).to be_kind_of(Moa)
  end
end
