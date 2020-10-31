require 'rails_helper'

RSpec.describe AntiPoison, type: :model do
  it 'create 1 anti_poison' do
    anti_poison = create(:anti_poison)
    expect(anti_poison).to be_kind_of(AntiPoison)
  end
end
