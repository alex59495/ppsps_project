require 'rails_helper'

RSpec.describe User, type: :model do
  it 'create 1 user' do
    user = create(:user)
    expect(user).to be_kind_of(User)
  end

  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:first_name)}
  it { should validate_presence_of(:last_name)}
  it { should validate_presence_of(:password)}
  it { should validate_presence_of(:admin)}

  it { should have_many(:ppsps)}
  it { should belong_to(:company)}
end
