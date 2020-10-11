require 'rails_helper'

RSpec.describe Moe, type: :model do
  it 'create 1 MOE' do
    moe = create(:moe)
    expect(moe).to be_kind_of(Moe)
  end
end
