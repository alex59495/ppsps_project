require 'rails_helper'

RSpec.describe User, type: :model do
  it 'create 1 user' do
    user = create(:user)
    expect(user).to be_kind_of(User)
  end
end
