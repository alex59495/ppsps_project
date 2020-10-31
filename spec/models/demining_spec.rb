require 'rails_helper'

RSpec.describe Demining, type: :model do
  it 'create 1 demining' do
    demining = create(:demining)
    expect(demining).to be_kind_of(Demining)
  end
end