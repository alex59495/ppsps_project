require 'rails_helper'

RSpec.describe Hospital, type: :model do
  it 'create 1 hospital' do
    hospital = create(:hospital)
    expect(hospital).to be_kind_of(Hospital)
  end
end
